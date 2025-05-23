module 0x782bddf0d94cd1652d91f56a1cf34db0c5631318c74eb1aab3711839bbb600aa::errors {
    struct Errors has drop {
        dummy_field: bool,
    }

    public fun EAddressAlreadyHasProfile() : u64 {
        8
    }

    public fun EAddressHasNoProfile() : u64 {
        9
    }

    public fun EAvatarTooLarge() : u64 {
        4
    }

    public fun EInsufficientBalance() : u64 {
        2
    }

    public fun EInvalidAmount() : u64 {
        3
    }

    public fun ENameTooLong() : u64 {
        5
    }

    public fun ENotAdmin() : u64 {
        1
    }

    public fun ESenderHasNoPiname() : u64 {
        6
    }

    // decompiled from Move bytecode v6
}

