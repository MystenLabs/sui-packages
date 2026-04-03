module 0x3197c2b429a8c2f985c98ea8347db0afe82db785ffc714520c1c36bfc9e9726e::abtc {
    struct ABTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABTC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775250389655-218e1dd02e8a41135ad68e9e22a713ea.png";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775250389655-218e1dd02e8a41135ad68e9e22a713ea.png"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<ABTC>(arg0, 9, b"ABTC", b"Alpha Bitcoin", b"ALPHA bTC", v1, arg1);
        let v4 = v2;
        if (1000000000000000000 > 0) {
            0x2::coin::mint_and_transfer<ABTC>(&mut v4, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABTC>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ABTC>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

