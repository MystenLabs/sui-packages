module 0x4bf94ee97292f288cfa1a73ebc890f1f68d7469c412709e0dec1dfab2b92d1a4::sws {
    struct SWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWS>(arg0, 6, b"SWS", b"Sui Wall Street", b"The future of finance runs on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreien3l7qlvxlwo57s4eeqfambwcycmt6blwnj2qootwynujo5wbvbm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SWS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

