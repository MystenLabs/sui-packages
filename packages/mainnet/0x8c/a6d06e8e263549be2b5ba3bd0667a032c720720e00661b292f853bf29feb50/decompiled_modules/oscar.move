module 0x8ca6d06e8e263549be2b5ba3bd0667a032c720720e00661b292f853bf29feb50::oscar {
    struct OSCAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSCAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775162962439-f5f6249a29672628fda797a7c1f06d5d.png";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775162962439-f5f6249a29672628fda797a7c1f06d5d.png"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<OSCAR>(arg0, 9, b"OSCAR", b"Oscar Lion", b"OScar Lion Meme", v1, arg1);
        let v4 = v2;
        if (21000000000000000 > 0) {
            0x2::coin::mint_and_transfer<OSCAR>(&mut v4, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSCAR>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OSCAR>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

