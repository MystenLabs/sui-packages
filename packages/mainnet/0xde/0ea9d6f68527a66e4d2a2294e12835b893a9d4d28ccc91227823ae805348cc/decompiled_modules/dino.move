module 0xde0ea9d6f68527a66e4d2a2294e12835b893a9d4d28ccc91227823ae805348cc::dino {
    struct DINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DINO>(arg0, 6, b"DINO", b"DinoSuir", x"f09fa6965374657020627920737465702c2077652772652067726f77696e67207374726f6e67657220616e6420726973696e67206869676865722c207265616368696e6720666f722074686520746f702120576527726520726561647920746f2073686f6f7420666f7220746865206d6f6f6e21f09fa6962e206c61756e6368696e67206f6e20687474703a2f2f547572626f732e66756e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731448250923.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DINO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DINO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

