module 0xef89a6f1c9beebab90bc64e34fecafff83577075bce7c921976477c4ebc0b2::aaamovepump {
    struct AAAMOVEPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAMOVEPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAMOVEPUMP>(arg0, 6, b"AAAMOVEPUMP", b"aaaMovePump", b"aaacat? aaadog? aaafish? Why cant MovePump AAAAAAAAAAAAAAAAAAAAAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/123123_e78e83b6aa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAMOVEPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAMOVEPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

