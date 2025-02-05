module 0x2e67a66ac79a02d988216d2c8b7d28fd5102fd42e2a3acf40d04d79752d09ac::qui {
    struct QUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUI>(arg0, 9, b"QUI", b"QUI", b"TESTTTTTTT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.myloview.com/stickers/sunglasses-emoticon-with-big-smile-700-183821678.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<QUI>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QUI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<QUI>>(v2);
    }

    // decompiled from Move bytecode v6
}

