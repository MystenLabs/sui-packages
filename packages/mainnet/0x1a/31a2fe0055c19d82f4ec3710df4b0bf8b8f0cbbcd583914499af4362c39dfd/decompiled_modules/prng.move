module 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng {
    public fun draw(arg0: &mut u64) : u64 {
        let (v0, v1) = rng_next(*arg0);
        *arg0 = v0;
        v1
    }

    public fun mix(arg0: u64, arg1: u64) : u64 {
        scramble((arg0 & 4294967295) + (arg1 & 4294967295) & 4294967295)
    }

    public fun rng_int(arg0: u64, arg1: u64) : (u64, u64) {
        let (v0, v1) = rng_next(arg0);
        (v0, v1 % arg1)
    }

    public fun rng_next(arg0: u64) : (u64, u64) {
        let v0 = arg0 + 1831565813 & 4294967295;
        let v1 = ((v0 ^ v0 >> 15) & 4294967295) * (1 | v0) & 4294967295;
        let v2 = v1 + (((v1 ^ v1 >> 7) & 4294967295) * (61 | v1) & 4294967295) & 4294967295 ^ v1;
        (v0, (v2 ^ v2 >> 14) & 4294967295)
    }

    public fun rng_range(arg0: u64, arg1: u64, arg2: u64) : (u64, u64) {
        let (v0, v1) = rng_int(arg0, arg2 - arg1 + 1);
        (v0, arg1 + v1)
    }

    public fun rng_seed(arg0: u64) : u64 {
        arg0 & 4294967295
    }

    public fun scramble(arg0: u64) : u64 {
        let (_, v1) = rng_next(arg0 & 4294967295);
        v1
    }

    // decompiled from Move bytecode v7
}

