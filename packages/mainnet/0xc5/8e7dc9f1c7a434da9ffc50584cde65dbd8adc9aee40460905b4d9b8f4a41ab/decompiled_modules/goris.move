module 0xc58e7dc9f1c7a434da9ffc50584cde65dbd8adc9aee40460905b4d9b8f4a41ab::goris {
    struct GORIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GORIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GORIS>(arg0, 6, b"GoriS", b"GorilaSUI", b"GorilaSui is predicted to become one of the leading blockchains in the future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_GR_c8d09612e1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GORIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GORIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

