module 0x78162ca204e3d34a0bc716114d47af33bb68692772b030e78c0a8b7e43f2ace3::kidduck {
    struct KIDDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIDDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIDDUCK>(arg0, 6, b"KIDDUCK", b"KID DUCK", x"4b4944204455434b20244b49444455434b206973207468652063757465737420616e640a66756e6e69657374206d656d65636f696e206f6e2074686520535549206e6574776f726b2c0a6272696e67696e672066756e20616e6420656e7465727461696e6d656e7420746f207468650a63727970746f20776f726c642e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ssstwitter_com_1721408116903_535a07304e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIDDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIDDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

