module 0xe6d5debd1383e108ed850cd69f6a78de33302129ec8daa4828c7f8045baf28de::onsen {
    struct ONSEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONSEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONSEN>(arg0, 6, b"ONSEN", b"Onsen", b"Onsen Sui | Token project on the Sui network | Bridging community and innovation in DeFi | Join us in revolutionizing the future of finance! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/onsen_dccfeff46a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONSEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONSEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

