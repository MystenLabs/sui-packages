module 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::constants {
    public fun FlashLoanMultiple() : u64 {
        10000
    }

    public fun max_number_of_reserves() : u8 {
        255
    }

    public fun option_type_borrow() : u8 {
        3
    }

    public fun option_type_repay() : u8 {
        4
    }

    public fun option_type_supply() : u8 {
        1
    }

    public fun option_type_withdraw() : u8 {
        2
    }

    public fun percentage_benchmark() : u64 {
        10000
    }

    public fun seconds_per_year() : u256 {
        31536000
    }

    public fun version() : u64 {
        13
    }

    // decompiled from Move bytecode v6
}

