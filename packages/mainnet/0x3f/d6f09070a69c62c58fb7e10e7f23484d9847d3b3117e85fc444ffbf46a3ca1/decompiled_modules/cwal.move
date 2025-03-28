module 0x3fd6f09070a69c62c58fb7e10e7f23484d9847d3b3117e85fc444ffbf46a3ca1::cwal {
    struct CWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CWAL>(arg0, 6, b"CWAL", b"Captain Walrus", b"Welcome to the next generation of data storage. Secure, efficient, and decentralized. On Testnet.ready for future airdrop of #WAL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_proxy_2_2d42a65b7a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CWAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

