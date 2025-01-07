module 0xfcd919d41891cb954cae4354efb35b1b744de67e8d3e5798339901d22b4ef4f4::sparko {
    struct SPARKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPARKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPARKO>(arg0, 6, b"SPARKO", b"SPARKO AI", b"In 1940, Westinghouse unveiled their groundbreaking creation: Sparko, the mechanical marvel designed to be the perfect robotic companion. With a sleek chrome exterior and loyal electronic eyes, Sparko quickly became a beloved pet for his owner, a tech enthusiast named Richard. Together, they embarked on countless adventures, drawing the admiration of those around them.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e8260b2d_85a2_4022_be1c_9c73edf12bd7_1f796885fa.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPARKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPARKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

