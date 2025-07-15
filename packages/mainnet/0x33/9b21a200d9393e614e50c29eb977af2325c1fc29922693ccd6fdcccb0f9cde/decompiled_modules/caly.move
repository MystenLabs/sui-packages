module 0x339b21a200d9393e614e50c29eb977af2325c1fc29922693ccd6fdcccb0f9cde::caly {
    struct CALY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CALY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CALY>(arg0, 6, b"CALY", b"SCALY", x"5468657265206e6f20736563726574206e6f206c75636b206a75737420736d617274206465636973696f6e73200a200a20426520736d61727420626520616e20696e766573746f72206f6620434c4159", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidawb3km4a64w77ktdnlzs2p5xoc6uejw2y6nd2fnhvopxk2xihpe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CALY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CALY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

