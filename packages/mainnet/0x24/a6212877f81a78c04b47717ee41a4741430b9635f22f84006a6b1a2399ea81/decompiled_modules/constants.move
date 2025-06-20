module 0x24a6212877f81a78c04b47717ee41a4741430b9635f22f84006a6b1a2399ea81::constants {
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

