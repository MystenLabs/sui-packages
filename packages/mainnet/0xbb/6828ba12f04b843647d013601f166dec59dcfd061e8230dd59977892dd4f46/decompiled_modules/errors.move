module 0xbb6828ba12f04b843647d013601f166dec59dcfd061e8230dd59977892dd4f46::errors {
    public fun already_claimed() : u64 {
        10
    }

    public fun envelope_empty() : u64 {
        5
    }

    public fun envelope_expired() : u64 {
        6
    }

    public fun insufficient_payment() : u64 {
        11
    }

    public fun invalid_commitment() : u64 {
        4
    }

    public fun invalid_count() : u64 {
        3
    }

    public fun invalid_mode() : u64 {
        2
    }

    public fun invalid_proof() : u64 {
        8
    }

    public fun not_admin() : u64 {
        1
    }

    public fun not_expired() : u64 {
        7
    }

    public fun not_owner() : u64 {
        9
    }

    public fun paused() : u64 {
        0
    }

    // decompiled from Move bytecode v6
}

