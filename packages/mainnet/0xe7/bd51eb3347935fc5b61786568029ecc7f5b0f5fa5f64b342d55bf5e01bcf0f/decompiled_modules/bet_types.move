module 0xe7bd51eb3347935fc5b61786568029ecc7f5b0f5fa5f64b342d55bf5e01bcf0f::bet_types {
    public fun color() : u8 {
        0
    }

    public fun column() : u8 {
        1
    }

    public fun dozen() : u8 {
        2
    }

    public fun eighteen() : u8 {
        3
    }

    public fun is_valid(arg0: u8, arg1: u8) : bool {
        if (arg0 <= 5) {
            let v1 = x"010202010124";
            arg1 <= *0x1::vector::borrow<u8>(&v1, (arg0 as u64))
        } else {
            false
        }
    }

    public fun modulus() : u8 {
        4
    }

    public fun number() : u8 {
        5
    }

    public fun number_of_bet_types() : u64 {
        6
    }

    // decompiled from Move bytecode v6
}

