module 0xa225d5cb83265d817f6569cc2157f7e9ebc802d3ea5eb284041802b7beea0f06::koa {
    struct KOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOA>(arg0, 6, b"KOA", b"KOA FUN", x"4865792c2049276d20244b4f41210a50656f706c65207361792049206c6f6f6b206c696b6520506570652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_1x1_00_a54b44f2a9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOA>>(v1);
    }

    // decompiled from Move bytecode v6
}

