module 0x7c8582ee6fdcb5dc2cd15fbd5da6e01c25fae4e9161e5255854d98fc0ad8bb03::share {
    struct Share has key {
        id: 0x2::object::UID,
    }

    public fun initialize(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::coin_registry::CoinRegistry, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<Share> {
        assert!(0x2::tx_context::sender(arg4) == 0x2::address::from_bytes(x"60ebad54bc6b56b025b898bdb5c607e0a86b322e1df41beb4fa01e1d0700cf4f"), 0);
        let (v0, v1) = 0x2::coin_registry::new_currency<Share>(arg3, 6, 0x1::string::utf8(b"SHARE"), arg0, arg1, arg2, arg4);
        0x2::coin_registry::finalize_and_delete_metadata_cap<Share>(v0, arg4);
        v1
    }

    // decompiled from Move bytecode v6
}

