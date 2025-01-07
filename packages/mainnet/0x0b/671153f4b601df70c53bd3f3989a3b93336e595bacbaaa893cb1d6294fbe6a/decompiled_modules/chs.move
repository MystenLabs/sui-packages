module 0xb671153f4b601df70c53bd3f3989a3b93336e595bacbaaa893cb1d6294fbe6a::chs {
    struct CHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHS>(arg0, 6, b"CHS", b"CHILLSANTA", b"ChillSanta: A festive-themed token spreading holiday cheer with rewards, giveaways, and surprises for a fun and engaging crypto experience!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9a832c1d_1dc3_4f99_a5e7_2a5a82f40409_142e7e00d3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHS>>(v1);
    }

    // decompiled from Move bytecode v6
}

