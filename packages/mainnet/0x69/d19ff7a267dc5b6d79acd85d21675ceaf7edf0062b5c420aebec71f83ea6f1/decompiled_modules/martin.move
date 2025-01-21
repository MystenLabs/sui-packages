module 0x69d19ff7a267dc5b6d79acd85d21675ceaf7edf0062b5c420aebec71f83ea6f1::martin {
    struct MARTIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARTIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARTIN>(arg0, 6, b"MARTIN", b"OFFICIAL MARTIN LUTHER KING", b"Martin Luther King Jr. (born Michael King Jr.; January 15, 1929  April 4, 1968) was an American Baptist minister, activist, and political philosopher who was one of the most prominent leaders in the civil rights movement from 1955 until his assassination in 1968.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250122_033020_527_26f7579325.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARTIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARTIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

