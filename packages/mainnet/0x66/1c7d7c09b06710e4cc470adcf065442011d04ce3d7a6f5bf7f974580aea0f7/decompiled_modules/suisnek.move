module 0x661c7d7c09b06710e4cc470adcf065442011d04ce3d7a6f5bf7f974580aea0f7::suisnek {
    struct SUISNEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISNEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISNEK>(arg0, 6, b"SUISNEK", b"Sui Snake", b"SUISSSSSSsszzZs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Diseno_sin_titulo_31_1ddab41043.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISNEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISNEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

