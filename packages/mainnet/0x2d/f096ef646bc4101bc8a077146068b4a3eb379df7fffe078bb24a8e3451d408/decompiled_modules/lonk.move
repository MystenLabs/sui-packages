module 0x2df096ef646bc4101bc8a077146068b4a3eb379df7fffe078bb24a8e3451d408::lonk {
    struct LONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LONK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775165641973-f9699f32292eab6ced645a6b695b7cf8.jpg";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775165641973-f9699f32292eab6ced645a6b695b7cf8.jpg"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<LONK>(arg0, 9, b"LONK", b"Lonk Meme", b"lonking fungible token", v1, arg1);
        let v4 = v2;
        if (1000000000000000 > 0) {
            0x2::coin::mint_and_transfer<LONK>(&mut v4, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LONK>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LONK>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

