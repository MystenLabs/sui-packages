module 0x805c00a6ac6f5eded32dc890bd6ff711a6d727de52355ba22d8ec5e85ed61383::si {
    struct SI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1780699281896-f59d62a02092ccfd02f3add4866a0884.jpeg";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1780699281896-f59d62a02092ccfd02f3add4866a0884.jpeg"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<SI>(arg0, 9, b"SI", b"Saiful Islam", b"Fun Token For Saiful Islam Fan base", v1, arg1);
        let v4 = v2;
        if (10000000000000000 > 0) {
            0x2::coin::mint_and_transfer<SI>(&mut v4, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SI>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SI>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

