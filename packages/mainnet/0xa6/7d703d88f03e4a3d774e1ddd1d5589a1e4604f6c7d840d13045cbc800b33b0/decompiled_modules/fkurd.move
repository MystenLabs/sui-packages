module 0xa67d703d88f03e4a3d774e1ddd1d5589a1e4604f6c7d840d13045cbc800b33b0::fkurd {
    struct FKURD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FKURD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1774397686001-d1bb7fedb797ebffb90a2c9c5dbcfd12.png";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1774397686001-d1bb7fedb797ebffb90a2c9c5dbcfd12.png"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<FKURD>(arg0, 9, b"FKURD", b"Free Kurdstan", b"This token is dedicated to the brave fighters of the Kurdish people", v1, arg1);
        let v4 = v2;
        if (800000000000000000 > 0) {
            0x2::coin::mint_and_transfer<FKURD>(&mut v4, 800000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FKURD>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FKURD>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

