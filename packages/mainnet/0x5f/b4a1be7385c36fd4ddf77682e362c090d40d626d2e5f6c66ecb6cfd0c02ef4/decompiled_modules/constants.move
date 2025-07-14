module 0x5fb4a1be7385c36fd4ddf77682e362c090d40d626d2e5f6c66ecb6cfd0c02ef4::constants {
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

