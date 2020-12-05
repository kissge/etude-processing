[![](https://d32h66pp7fue57.cloudfront.net/artThumb/bv4dick3p9f7gigedbm0.png?v=1606998413)](https://neort.io/art/bv4dick3p9f7gigedbm0)

See on NEORT

---

## Sidenote

These particles are most likely to fly away to the upper side of the screen.
I didn't implement this behavior intentionally, but after observed it, I found out why.

The secret is in [these lines](https://github.com/kissge/etude-processing/blob/9850043501b168ace53d070ee427ca2be72e5ecd/sketch_201118a_stars/sketch_201118a_stars.pde#L53-L55):

```java
float th = noise(x / 1000, y / 1000, t) * 10;
x += cos(th) * t * 2;
y += sin(th) * t * 2;
```

Here, the function `noise` returns value within 0.0 through 1.0, hence the variable `th` ranges from 0.0 through 10.0.
Since `sin` and `cos` take the degree parameters in radians, the range corresponds to 0° through about 572.96°.

(I believe) The `noise` function's return values are uniformly distributed.
Therefore, the probability each particle moves upward (⇔ 0° < `th` < 180° or 360° < `th` < 540°) is roughly twice as higher as the probability of the opposite.
