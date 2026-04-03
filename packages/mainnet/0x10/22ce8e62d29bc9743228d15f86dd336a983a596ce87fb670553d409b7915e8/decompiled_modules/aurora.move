module 0x1022ce8e62d29bc9743228d15f86dd336a983a596ce87fb670553d409b7915e8::aurora {
    struct AURORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AURORA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775200014602-09622e6519364d83b3699cbbf882686d.png";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775200014602-09622e6519364d83b3699cbbf882686d.png"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<AURORA>(arg0, 9, b"AURORA", b"AURORA", b"Aurora bridge Near To World blockchains", v1, arg1);
        let v4 = v2;
        if (21000000000000000 > 0) {
            0x2::coin::mint_and_transfer<AURORA>(&mut v4, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AURORA>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AURORA>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

