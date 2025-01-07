module 0x484932c474bf09f002b82e4a57206a6658a0ca6dbdb15896808dcd1929c77820::errors {
    public fun address_not_whitelisted() : u64 {
        1
    }

    public fun incorrect_amount() : u64 {
        4
    }

    public fun insufficient_amount() : u64 {
        5
    }

    public fun invalid_payment() : u64 {
        3
    }

    public fun max_supply_reached() : u64 {
        0
    }

    public fun no_caps_remaining_for_address() : u64 {
        2
    }

    public fun no_caps_remaining_for_public_sale() : u64 {
        6
    }

    // decompiled from Move bytecode v6
}

