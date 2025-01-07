module 0x57ecdb0c14aa3ef101ca521bae0e7b984d79bd23cfd7a2a40d9b1563a0204f3a::turtles {
    struct TURTLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURTLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURTLES>(arg0, 6, b"Turtles", b"turtles", b"turtles.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_15_07_47_048b76fdc8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURTLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURTLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

