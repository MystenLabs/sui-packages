module 0xa68f56306ca580cc2c6314caaa92d5a10c1a29b9258976501e44dd5636651204::chessai {
    struct CHESSAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHESSAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CHESSAI>(arg0, 6, b"CHESSAI", b"CHESSAI ON SUI by SuiAI", b"ChessAI on SUIAI combines AI and blockchain to offer a secure, fair, and rewarding chess experience. Play, earn Chess Tokens, and improve your skills with personalized AI coaching. ..Our AI monitors ensure fair play by detecting cheaters through quizzes and behavior analysis, while matching you with opponents at your skill level. Compete in blockchain-powered tournaments and enjoy tamper-proof game results. Join ChessAI on SUI today and take your chess to the next level!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000276710_b8f2f65b4e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHESSAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHESSAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

