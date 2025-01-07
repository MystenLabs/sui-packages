module 0xe591650769e712cad9909de9662b74e06f41e9903b84c3ba45479e9c541126e5::flexy {
    struct FLEXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLEXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLEXY>(arg0, 6, b"FLEXY", b"Flexy Beez Ai", b"Flexy Beez Ai is an innovative platform dedicated to integrating artificial intelligence with blockchain technology. The platform is designed to harness the power of AI to increase productivity in various fields, targeting businesses, creators, developers, and general users.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0780_47da6af98c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLEXY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLEXY>>(v1);
    }

    // decompiled from Move bytecode v6
}

