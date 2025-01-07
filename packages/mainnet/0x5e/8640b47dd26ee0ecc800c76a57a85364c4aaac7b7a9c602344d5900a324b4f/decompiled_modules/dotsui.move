module 0x5e8640b47dd26ee0ecc800c76a57a85364c4aaac7b7a9c602344d5900a324b4f::dotsui {
    struct DOTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOTSUI>(arg0, 6, b"DOTSUI", b"DotSui", x"4561736965737420446f6d61696e205365727669636520666f7220535549206164647265737365730a0a4d6f726520696e666f726d6174696f6e2077696c6c2062652072656c656173656420647572696e67204a616e756172792032303235202d2044594f52", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_DOMAIN_6_7d7891fc00.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

