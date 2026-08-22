module 0x3c8b16f5ebfeb9da1debff47f885fb6fbf4fc512f891879cc59047a0d77d8a30::clmm {
    public fun limit(arg0: bool) : u128 {
        if (arg0) {
            limit_a2b()
        } else {
            limit_b2a()
        }
    }

    public fun limit_a2b() : u128 {
        4295048016 + 1
    }

    public fun limit_b2a() : u128 {
        79226673515401279992447579055 - 1
    }

    // decompiled from Move bytecode v7
}

