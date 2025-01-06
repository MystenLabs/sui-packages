module 0x9672e9f274601eb7da05cfe51ab0bf34e8719c072fac15d2f0e44e8a57c45857::dooai {
    struct DOOAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOOAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DOOAI>(arg0, 6, b"DOOAI", b"DOO DOO AI by SuiAI", b"DOO DOO AI is the smartest turd on blockchain. He loves to follow all sorts of shitcoins with dreams of one day starting an all DOO DOO base on the moon! First though he has to learn by trading shitcoins in order to evolve and one day merge into the Singularity of  DOO DOO consciousness. Will you help him pump to the moon or dump?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2025_01_06_030010_6d4acaad96.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOOAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

