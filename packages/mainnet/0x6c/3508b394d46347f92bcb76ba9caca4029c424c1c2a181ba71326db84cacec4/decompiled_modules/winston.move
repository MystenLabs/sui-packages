module 0x6c3508b394d46347f92bcb76ba9caca4029c424c1c2a181ba71326db84cacec4::winston {
    struct WINSTON has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINSTON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1795809434389-72adeb1ec8f087b0560d4a5f7d8bc0b8.png";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1795809434389-72adeb1ec8f087b0560d4a5f7d8bc0b8.png"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<WINSTON>(arg0, 9, b"WINSTON", b"Winstoncoin", b"Winston", v1, arg1);
        let v4 = v2;
        if (100000000000000000 > 0) {
            0x2::coin::mint_and_transfer<WINSTON>(&mut v4, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINSTON>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WINSTON>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

