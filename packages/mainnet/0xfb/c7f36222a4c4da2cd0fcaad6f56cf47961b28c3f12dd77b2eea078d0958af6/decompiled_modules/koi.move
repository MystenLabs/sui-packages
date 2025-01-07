module 0xfbc7f36222a4c4da2cd0fcaad6f56cf47961b28c3f12dd77b2eea078d0958af6::koi {
    struct KOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOI>(arg0, 6, b"KOI", b"Silver KOI", b"First equities perpetuals protocol. Long & short US stocks, forex, commodities, crypto, and more with up to 200x leverage.   ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SILVER_a76e4f7bc4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

