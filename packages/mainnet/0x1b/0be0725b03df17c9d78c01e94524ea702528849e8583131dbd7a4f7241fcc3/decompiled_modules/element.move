module 0x1b0be0725b03df17c9d78c01e94524ea702528849e8583131dbd7a4f7241fcc3::element {
    struct ELEMENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELEMENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELEMENT>(arg0, 6, b"Element", b"ELEMENT", b"Where Ai Meets Meme And Chaos Turns To Creativity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1001254217_e209e4604a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELEMENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELEMENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

