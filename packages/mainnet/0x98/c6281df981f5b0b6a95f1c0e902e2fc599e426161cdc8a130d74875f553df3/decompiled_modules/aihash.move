module 0x98c6281df981f5b0b6a95f1c0e902e2fc599e426161cdc8a130d74875f553df3::aihash {
    struct AIHASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIHASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIHASH>(arg0, 6, b"AIHASH", b"aiHash", b"The aiHash token is the cornerstone of the Decentralized AI-Powered Hashing Marketplace, merging blockchain technology with advanced AI solutions to revolutionize cryptocurrency mining. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AI_Hash_Logo_8b0776d37f_6eb02fc62e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIHASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIHASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

