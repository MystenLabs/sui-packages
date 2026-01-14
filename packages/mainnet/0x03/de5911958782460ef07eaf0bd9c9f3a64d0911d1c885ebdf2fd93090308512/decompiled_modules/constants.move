module 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::constants {
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
        14
    }

    // decompiled from Move bytecode v6
}

