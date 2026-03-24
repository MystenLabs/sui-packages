module 0xdde0b1b250e39b6ec2bccc2cedd09fc63ab26c3df146f48b0dd89963cff0bde3::fkurd {
    struct FKURD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FKURD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1774394734602-d7c71b4e86f5badd74589b25213d729f.jpg";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1774394734602-d7c71b4e86f5badd74589b25213d729f.jpg"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<FKURD>(arg0, 9, b"FKURD", b"Free Kurdstan", b"This cryptocurrency is dedicated to all the fighters of the Kurdish people", v1, arg1);
        let v4 = v2;
        if (500000000000000000 > 0) {
            0x2::coin::mint_and_transfer<FKURD>(&mut v4, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FKURD>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FKURD>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

