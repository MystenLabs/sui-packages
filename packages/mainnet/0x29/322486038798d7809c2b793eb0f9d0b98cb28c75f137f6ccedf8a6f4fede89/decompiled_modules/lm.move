module 0x29322486038798d7809c2b793eb0f9d0b98cb28c75f137f6ccedf8a6f4fede89::lm {
    struct LM has drop {
        dummy_field: bool,
    }

    fun init(arg0: LM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LM>(arg0, 6, b"Lm", b"Luma Ai", b"You are here to create, we will make you a Luma machine for artificial intelligence... You are here to create.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000034918_86c87a94c1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LM>>(v1);
    }

    // decompiled from Move bytecode v6
}

