module 0x98698915eb365a0a65e506cede3583e5f8dab62cde9dbc27e64496a73c6ecf23::dot {
    struct DOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOT>(arg0, 6, b"DOT", b"The Dot", b"It's just a dot.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732420590569.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

