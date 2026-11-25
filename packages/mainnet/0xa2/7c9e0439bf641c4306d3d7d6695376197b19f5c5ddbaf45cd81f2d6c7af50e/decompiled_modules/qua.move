module 0xa27c9e0439bf641c4306d3d7d6695376197b19f5c5ddbaf45cd81f2d6c7af50e::qua {
    struct QUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1795567518535-244d4060787475bd3cc050a366051333.png";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1795567518535-244d4060787475bd3cc050a366051333.png"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<QUA>(arg0, 9, b"QUA", b"Quantusui", b"qua", v1, arg1);
        let v4 = v2;
        if (1000000000000000000 > 0) {
            0x2::coin::mint_and_transfer<QUA>(&mut v4, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUA>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<QUA>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

