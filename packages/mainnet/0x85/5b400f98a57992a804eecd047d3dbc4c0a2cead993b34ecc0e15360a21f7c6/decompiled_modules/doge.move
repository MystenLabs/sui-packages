module 0x855b400f98a57992a804eecd047d3dbc4c0a2cead993b34ecc0e15360a21f7c6::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE>(arg0, 6, b"DOGE", b"D.O.G.E", b"Department of Government Efficiency - Led by Elon Musk and Vivek Ramaswamy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731465425536.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

