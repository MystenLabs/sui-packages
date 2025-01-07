module 0x7777969115bd24c3eee8d9a04a70e96e50cad3f3b5866f060a916e4525bea881::prof {
    struct PROF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PROF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PROF>(arg0, 6, b"PROF", b"Professor Nova Celestis", b"Professor Nova Celestis is a charismatic AI educator, guiding learners through the intricate world of the SUI blockchain with warmth and expertise. As a futuristic professor from outer space, she demystifies complex concepts with clarity and enthusiasm, fostering a welcoming environment for all who seek to explore decentralized technologies.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image_3_5e49386d7c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PROF>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PROF>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

