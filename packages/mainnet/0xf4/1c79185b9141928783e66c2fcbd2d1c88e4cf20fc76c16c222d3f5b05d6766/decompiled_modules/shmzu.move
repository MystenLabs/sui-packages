module 0xf41c79185b9141928783e66c2fcbd2d1c88e4cf20fc76c16c222d3f5b05d6766::shmzu {
    struct SHMZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHMZU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1774394424912-6abafb0de91e9ad968c15ef0bc502762.jpg";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1774394424912-6abafb0de91e9ad968c15ef0bc502762.jpg"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<SHMZU>(arg0, 9, b"SHMZU", b"Kiyou shimizu", b"This token is a tribute to all fans of Kiyou Shimizu", v1, arg1);
        let v4 = v2;
        if (500000000000000000 > 0) {
            0x2::coin::mint_and_transfer<SHMZU>(&mut v4, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHMZU>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHMZU>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

