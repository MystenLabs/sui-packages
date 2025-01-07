module 0x31f22170f8b957a7d59a0b3ca85fe92335fa6b82047683b9b4ec52a120d9da99::bullshit {
    struct BULLSHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLSHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLSHIT>(arg0, 6, b"Bullshit", b"BullshitCoin", b"Welcome to BullshitCoin  the worlds first cryptocurrency thats not just about making money, but about calling out the bullshit. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042084_2e575b2d4c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLSHIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLSHIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

