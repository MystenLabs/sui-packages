module 0x2acd403583bc24f236265aef299752685de6457479ef8aec17f9bebd056af2e2::fa {
    struct FA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FA>(arg0, 6, b"FA", b"Financial Advice", b"Dont Buy ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3077_779de3576e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FA>>(v1);
    }

    // decompiled from Move bytecode v6
}

