module 0x71361c837c5492481f0c6a262894c4f3f43f1a47facc778337e7c96c2dd4de9a::soomer {
    struct SOOMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOOMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOOMER>(arg0, 6, b"SOOMER", b"SOOMER ZOOMER", b"SOOMER ZOOMER BOOMER , SOOMER IS SUI OFFICIAL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3609_abbfee7e92.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOOMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOOMER>>(v1);
    }

    // decompiled from Move bytecode v6
}

