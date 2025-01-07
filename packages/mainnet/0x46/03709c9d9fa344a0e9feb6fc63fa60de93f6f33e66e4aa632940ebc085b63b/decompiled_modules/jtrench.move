module 0x4603709c9d9fa344a0e9feb6fc63fa60de93f6f33e66e4aa632940ebc085b63b::jtrench {
    struct JTRENCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: JTRENCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JTRENCH>(arg0, 6, b"JTRENCH", b"Jeet Trench", b"The most Autis coin on Sui - for retardio jeets deep in the trenches only pls", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8392_a18f68bf8e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JTRENCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JTRENCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

