module 0x43fe018a2eb9f6bb8de951acc05b36ab0a948a4f2d4f54bd179e954246232625::chess {
    struct CHESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHESS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CHESS>(arg0, 6, b"CHESS", b"CHESSAI ON SUI by SuiAI", b"ChessAI on SUI combines AI and blockchain to offer a secure, fair, and rewarding chess experience. Play, earn Chess Tokens, and improve your skills with personalized AI coaching. Our AI monitors ensure fair play by detecting cheaters through quizzes and behavior analysis, while matching you with opponents at your skill level. Compete in blockchain-powered tournaments and enjoy tamper-proof game results. Join ChessAI on SUI today and take your chess to the next level!..Our AI Agent on SUIAI offers personalized insights, analyzes your actions, and ensures fair play by detecting cheating. It matches you with opponents at your skill level and provides coaching to help you improve, creating a seamless and secure experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_20250115_033247_214_9463e65644.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHESS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHESS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

