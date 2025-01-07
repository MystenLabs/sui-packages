module 0x4c56e6ab4287b54dc3cc823a9ea870868a78ab86905ff2aa6d51430022c11435::ssb {
    struct SSB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSB>(arg0, 6, b"SSB", b"Sui Street Bets", b"INTRODUCING SUI STREET BETS, THE ULTIMATE MEME COMMUNITY ON SUI! INSPIRED BY THE LEGENDARY WALL STREET BETS SUBREDDIT, WE'RE ON A MISSION TO RALLY MILLIONS OF CHADS TO JOIN US IN REVOLUTIONIZING THE SUI ECOSYSTEM.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731097745805.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

