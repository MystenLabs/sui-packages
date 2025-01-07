module 0x871ddf5b2ede9260b08d4b96f49579e79ec38baca649806b3b6b0258266eccd8::aka {
    struct AKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKA>(arg0, 6, b"AKA", b"She Rises", b"She Rises (AKA) Akasha is the Queen of the Swarm, an AI agent and so much more.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/test2_46d580d621.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

