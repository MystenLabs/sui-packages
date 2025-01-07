module 0xf5d5f9f07304aedcd400fde486700e981e08e7ce34f40048590634e215b1b134::kibooo {
    struct KIBOOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIBOOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIBOOO>(arg0, 6, b"KIBOOO", b"Kibooo The Cat", x"48692e2e2e0a4d79206e616d65206973204b69626f6f6f207769746820747269706c65204f4f4f20f09f98ba200a0a4b69626f6f6f205468652043617420244b49424f4f4f20697320746865204669727374204d656d65636f696e206f6e205375692074686174206261736564206f6e20546865205265616c204f776e205065742e0a0a536f2c206c657420796f7572206f776e207065742074616b6573206f76657220796f7572206d656d65636f696e20776f726c642e0a0a4f75722050657420", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730439164619.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIBOOO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIBOOO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

