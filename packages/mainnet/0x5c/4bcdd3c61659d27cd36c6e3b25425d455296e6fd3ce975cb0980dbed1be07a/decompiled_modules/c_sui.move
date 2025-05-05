module 0x5c4bcdd3c61659d27cd36c6e3b25425d455296e6fd3ce975cb0980dbed1be07a::c_sui {
    struct C_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: C_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<C_SUI>(arg0, 9, b"cSUI", b"Cyber Staked SUI", b"Cyber-staked Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/34a527d5-c524-4d3a-ac2e-cb16fdd41c96/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<C_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<C_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

