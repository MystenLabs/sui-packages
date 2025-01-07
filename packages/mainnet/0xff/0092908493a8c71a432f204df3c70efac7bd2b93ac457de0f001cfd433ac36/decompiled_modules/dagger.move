module 0xff0092908493a8c71a432f204df3c70efac7bd2b93ac457de0f001cfd433ac36::dagger {
    struct DAGGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAGGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAGGER>(arg0, 6, b"DAGGER", b"Dagger of Sui", b"Sharp and precise, $DAGGER slices through the Sui Network with lethal accuracy. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_1_22_eba54db0dd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAGGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAGGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

