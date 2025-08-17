module 0x8982893d8de631d685f2b68a5f7b84738c29fab59dd176356486e0ba71b2c7f3::GOBLIN {
    struct GOBLIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOBLIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOBLIN>(arg0, 6, b"Goblin Gold", b"GOBLIN", b"A mischievous meme coin for those who love chaos, loot, and a little bit of magic. Goblin Gold is the ultimate treasure for crypto degenerates and fantasy enthusiasts alike. Ride the wave of chaos and claim your share of the loot!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w3s.link/ipfs/bafkreihea624rdfesbc6kzlvi3kjlnrbunsftr2lfvxvzsejp3uydip4eq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOBLIN>>(v0, @0x6ff7574e679298a9304c0e6415db222a49b0e29f888d4f792daa466237498764);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOBLIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

