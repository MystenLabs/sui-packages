module 0x9996adf100b79d408360b652cf7ca6e998c83bf13a9a13e43139a027175a72f8::coralfml {
    struct CORALFML has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORALFML, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORALFML>(arg0, 6, b"Coralfml", b"Coral Family", b"The saltiest meme token on SUI - join the Family and dive into the fun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730460306693.41")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORALFML>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORALFML>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

