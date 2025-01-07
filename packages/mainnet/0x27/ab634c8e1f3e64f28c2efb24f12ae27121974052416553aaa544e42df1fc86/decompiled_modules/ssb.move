module 0x27ab634c8e1f3e64f28c2efb24f12ae27121974052416553aaa544e42df1fc86::ssb {
    struct SSB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSB>(arg0, 6, b"SSB", b"Sui Street Bets CTO", b"SUI STREET BETS, THE ULTIMATE MEME COMMUNITY ON SUI! INSPIRED BY THE LEGENDARY WALL STREET BETS SUBREDDIT. NOW A CTO!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_bb43490c6f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSB>>(v1);
    }

    // decompiled from Move bytecode v6
}

