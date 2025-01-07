module 0x51010bacf350dde36693c3a221578a227cea48362672f365f05644c0a8369872::turtel {
    struct TURTEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURTEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURTEL>(arg0, 6, b"TURTEL", b"Turtel", b"The first Blue Turtle on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_13_39_12_89a78c567d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURTEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURTEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

