module 0x8b0c233da2cfb4ea22f972b3dbcb8844376f5e9d62730965505c6f02ada7d484::prisoncat {
    struct PRISONCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRISONCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRISONCAT>(arg0, 6, b"PrisonCat", b"Prison Cat", b"I didn't make any mistakes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c_c_c_a_c_c_ae_3afea9a0fc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRISONCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRISONCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

