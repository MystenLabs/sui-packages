module 0xf0251e7776566fa2e1a4ad77b1d329bf4badeb2d6ffbb5d0b6a6579817050e5b::richierich {
    struct RICHIERICH has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICHIERICH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICHIERICH>(arg0, 6, b"RichieRich", b"RichieRich on Sui", b"RichieRich of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5472_a0f66a5bec.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICHIERICH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RICHIERICH>>(v1);
    }

    // decompiled from Move bytecode v6
}

