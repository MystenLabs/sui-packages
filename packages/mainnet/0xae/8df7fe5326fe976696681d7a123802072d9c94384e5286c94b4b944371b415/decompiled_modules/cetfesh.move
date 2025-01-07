module 0xae8df7fe5326fe976696681d7a123802072d9c94384e5286c94b4b944371b415::cetfesh {
    struct CETFESH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CETFESH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CETFESH>(arg0, 6, b"CETFESH", b"CetFesh", b"CetFesh Token is your beacon in the fog of finance, a testament to the joy of the unexpected. Because in the end, isnt life too short for boring investments?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/O0_B5f_Ojr_400x400_4d93f1dcab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CETFESH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CETFESH>>(v1);
    }

    // decompiled from Move bytecode v6
}

