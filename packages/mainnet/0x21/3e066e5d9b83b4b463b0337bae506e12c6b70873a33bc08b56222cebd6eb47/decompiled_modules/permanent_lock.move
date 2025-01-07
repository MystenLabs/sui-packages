module 0x213e066e5d9b83b4b463b0337bae506e12c6b70873a33bc08b56222cebd6eb47::permanent_lock {
    struct PermanentLock has drop {
        dummy_field: bool,
    }

    struct PermanentLockConfig has drop, store {
        dummy_field: bool,
    }

    public fun add<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        let v0 = PermanentLock{dummy_field: false};
        let v1 = PermanentLockConfig{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, PermanentLock, PermanentLockConfig>(v0, arg0, arg1, v1);
    }

    // decompiled from Move bytecode v6
}

