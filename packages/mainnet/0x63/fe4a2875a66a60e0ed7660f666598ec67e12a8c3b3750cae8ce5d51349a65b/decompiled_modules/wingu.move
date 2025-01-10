module 0x63fe4a2875a66a60e0ed7660f666598ec67e12a8c3b3750cae8ce5d51349a65b::wingu {
    struct WINGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINGU>(arg0, 6, b"WINGU", b"Wingu Space", b"WINGU - Once upon a time, a colony of SpacePenguins lived in Antarctica, but now they don spacesuits and jump into spaceships in search of a new habitat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000023332_2203b765d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WINGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

