module 0x9408a48801816bb6b0e0c7a4a3d7a2705a5be7cfbe04ba02ada177bbc2035b53::aaamovepump {
    struct AAAMOVEPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAMOVEPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAMOVEPUMP>(arg0, 6, b"AAAMOVEPUMP", b"aaaMovePump", b"aaacat? aaadog? aaafish? Why cant MovePump AAAAAAAAAAAAAAAAAAAAAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/123123_752a6d2a80.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAMOVEPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAMOVEPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

