module 0xaec2fbee8acf49c5f59ce892db0cd6889022da1e1e57794899054307516d257c::bitcatbat {
    struct BITCATBAT has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BITCATBAT>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BITCATBAT>>(0x2::coin::mint<BITCATBAT>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: BITCATBAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITCATBAT>(arg0, 9, b"CATBAT", b"BITCATBAT", b"Have you seen a cat bat, now imagine a BITCATBAT...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1846868017898045440/k2uqDGKB_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BITCATBAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITCATBAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCATBAT>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

