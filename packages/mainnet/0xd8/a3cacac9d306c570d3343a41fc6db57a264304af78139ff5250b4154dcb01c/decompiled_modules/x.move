module 0xd8a3cacac9d306c570d3343a41fc6db57a264304af78139ff5250b4154dcb01c::x {
    struct X has drop {
        dummy_field: bool,
    }

    fun init(arg0: X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<X>(arg0, 6, b"X", b"X Coin ", b"X Coin is a New Bitcoin Alternative Built on SUI - For the People - By the People. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735542511952.27")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<X>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<X>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

