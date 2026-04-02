module 0xd9cab9127a47492020e51596022bda200897beff1bac38baa6296c8bd36b93a4::bmw {
    struct BMW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775143998390-b64810fde7027715e614449aff1d595f.png";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775143998390-b64810fde7027715e614449aff1d595f.png"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<BMW>(arg0, 9, b"BMW", b"Bmw Meme Coin", b"Bmw speed", v1, arg1);
        let v4 = v2;
        if (10000000000000000000 > 0) {
            0x2::coin::mint_and_transfer<BMW>(&mut v4, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMW>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BMW>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

