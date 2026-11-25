module 0x9940b4f4f40b47be8cc1bbd5280bc4e6aa5c1d6e1de14576dfbc3f1cb951f28::cdog {
    struct CDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1795566121037-a21d68e75940b4937a3f9dac201d909c.png";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1795566121037-a21d68e75940b4937a3f9dac201d909c.png"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<CDOG>(arg0, 9, b"CDOG", b"Cool Dog", b"cooldog", v1, arg1);
        let v4 = v2;
        if (1000000000000000000 > 0) {
            0x2::coin::mint_and_transfer<CDOG>(&mut v4, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CDOG>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CDOG>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

