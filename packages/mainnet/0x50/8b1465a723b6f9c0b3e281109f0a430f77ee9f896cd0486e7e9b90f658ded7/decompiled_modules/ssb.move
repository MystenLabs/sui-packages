module 0x508b1465a723b6f9c0b3e281109f0a430f77ee9f896cd0486e7e9b90f658ded7::ssb {
    struct SSB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSB>(arg0, 6, b"SSB", b"Sui Street Bets", b"SUI STREET BETS, THE ULTIMATE MEME COMMUNITY ON SUI! INSPIRED BY THE LEGENDARY WALL STREET BETS SUBREDDIT, WE'RE ON A MISSION TO RALLY MILLIONS OF CHADS TO JOIN US IN REVOLUTIONIZING THE SUI ECOSYSTEM. GET READY TO RIDE THE WAVE AND BE PART OF THE NEXT BIG THING IN CRYPTO CULTUREBECAUSE AT SUI STREET BETS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SSB_Logo_b36a07fb3b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSB>>(v1);
    }

    // decompiled from Move bytecode v6
}

