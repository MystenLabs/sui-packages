module 0x7e18593bf7331bc4a7e1b9d386307786fb9c866b5eeeb1e8baa6b9e0e7cb1dc::hydr {
    struct HYDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYDR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1780475978442-2cb7b27b1af7aab3ca9c9568704ec0c4.jpg";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1780475978442-2cb7b27b1af7aab3ca9c9568704ec0c4.jpg"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<HYDR>(arg0, 9, b"HYDR", b"HydrAxios", b"HydrAxios (HYDR) is a real-world utility. Inspired by the strength, resilience, and visionary spirit of the Viking era, HYDR is designed to become a versatile ecosystem token powering innovation across multiple technological sectors.", v1, arg1);
        let v4 = v2;
        if (1000000000000000000 > 0) {
            0x2::coin::mint_and_transfer<HYDR>(&mut v4, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYDR>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HYDR>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

