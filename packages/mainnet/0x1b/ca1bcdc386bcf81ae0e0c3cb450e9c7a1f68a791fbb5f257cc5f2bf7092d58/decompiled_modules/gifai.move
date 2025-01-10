module 0x1bca1bcdc386bcf81ae0e0c3cb450e9c7a1f68a791fbb5f257cc5f2bf7092d58::gifai {
    struct GIFAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIFAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GIFAI>(arg0, 6, b"GIFAI", b"GIFAI by SuiAI", b"GIFAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/apps_51345_13780191306179685_c793ad1d_d472_4c59_92cd_e73635ade010_2b90e930_bb02_41ea_b47c_d1f1baeb5a74_f917cc5971.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GIFAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIFAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

