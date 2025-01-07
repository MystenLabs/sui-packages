module 0xb2cf516f2dbc282da98c66d01741ff6a525af523dff42ea554e53d685c34e6ae::prof {
    struct PROF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PROF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PROF>(arg0, 6, b"PROF", b"Professor Nova Celestis", b"Professor Nova Celestis is a charismatic AI educator, guiding learners through the intricate world of the SUI blockchain with warmth and expertise. As a futuristic professor from outer space, she demystifies complex concepts with clarity and enthusiasm, fostering a welcoming environment for all who seek to explore decentralized technologies.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image_3_d692098ea7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PROF>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PROF>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

