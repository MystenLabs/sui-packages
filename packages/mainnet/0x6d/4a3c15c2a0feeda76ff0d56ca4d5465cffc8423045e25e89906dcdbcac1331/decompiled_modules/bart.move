module 0x6d4a3c15c2a0feeda76ff0d56ca4d5465cffc8423045e25e89906dcdbcac1331::bart {
    struct BART has drop {
        dummy_field: bool,
    }

    fun init(arg0: BART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BART>(arg0, 6, b"BART", b"Bart", b"$BART is a rebellious and cheeky memecoin inspired by the spirit of mischief and fun! Like its namesake, $BART is here to break the rules of boring crypto and bring back the laughter, creativity, and chaos that memecoins were meant for.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000046207_86570a3396.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BART>>(v1);
    }

    // decompiled from Move bytecode v6
}

