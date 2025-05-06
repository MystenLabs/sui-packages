module 0xb3964384aa5fc09c12b919ca66f36834147a9295c1ec3f3abc03d9d950d1eb45::l_sui {
    struct L_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: L_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<L_SUI>(arg0, 9, b"lSUI", b"Lukfm Staked SUI", b"lukfm ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/4d18e734-381a-4d92-aa0f-69fc4c89e392/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<L_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<L_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

