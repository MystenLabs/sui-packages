module 0xddaa6c2260a2c054bc928c2d75f1df82662b18da175dfc6d8e508947852aa5eb::vaskosofia {
    struct VASKOSOFIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: VASKOSOFIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VASKOSOFIA>(arg0, 9, b"vaskosofia", b"vaskosofia", b"hakunabratemee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VASKOSOFIA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VASKOSOFIA>>(v2, @0xb302f81310c48939483fa3a8501c4ccb1907c554eae96665b276bad2e933a09a);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VASKOSOFIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

