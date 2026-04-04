module 0xc8cd59a8b0faa6c293224f5c88328eef29ac4d775ffe5e052c386adfe9c57f13::alpha {
    struct ALPHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALPHA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775345690141-8131fd102db2b6ebb09e7b758fd4670e.png";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775345690141-8131fd102db2b6ebb09e7b758fd4670e.png"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<ALPHA>(arg0, 9, b"ALPHA", b"Alpha SUI", b"ALpha Sui Just a Meme Coin launch on sui At : 4/05/2026", v1, arg1);
        let v4 = v2;
        if (1000000000000000000 > 0) {
            0x2::coin::mint_and_transfer<ALPHA>(&mut v4, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPHA>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ALPHA>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

