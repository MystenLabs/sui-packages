module 0x399cda4f653a1ca16a6757da1c19052d14172551b8821578158c24bd3edce4d::pp_sui {
    struct PP_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PP_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PP_SUI>(arg0, 9, b"ppSUI", b"Pumpsui Staked SUI", b"PumpFun on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/5dd73ed7-cf4d-473a-9a35-b31a57380b46/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PP_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PP_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

