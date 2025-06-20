module 0x46aa1672a57bec16073c12029966578cdc0530a21b716e02d77e310d2f7d1fa0::constants {
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

