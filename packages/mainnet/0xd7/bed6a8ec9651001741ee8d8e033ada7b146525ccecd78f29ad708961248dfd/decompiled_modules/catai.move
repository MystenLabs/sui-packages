module 0xd7bed6a8ec9651001741ee8d8e033ada7b146525ccecd78f29ad708961248dfd::catai {
    struct CATAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATAI>(arg0, 6, b"CATAI", b"AiCat", b"This robotic cat doesnt chase mice  it chases gains. Powered by the strength and unity of its community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/header_137f71e1dd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

