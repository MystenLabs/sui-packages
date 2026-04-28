module 0xecd8a262b27225d86e9a810b1de8b9e2f407935eb6cb4b9bbc0085b3ddf1aa86::qui {
    struct QUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<QUI>(arg0, 9, b"QUI", b"QUINOA", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<QUI>>(0x2::coin::mint<QUI>(&mut v3, 100000000000000, arg1), v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUI>>(v3, v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QUI>>(v2);
    }

    // decompiled from Move bytecode v6
}

