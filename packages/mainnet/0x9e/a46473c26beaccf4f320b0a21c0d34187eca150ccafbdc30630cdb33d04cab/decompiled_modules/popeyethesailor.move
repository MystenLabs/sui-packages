module 0x9ea46473c26beaccf4f320b0a21c0d34187eca150ccafbdc30630cdb33d04cab::popeyethesailor {
    struct POPEYETHESAILOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPEYETHESAILOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPEYETHESAILOR>(arg0, 6, b"PopeyetheSailor", b"Popeye", b"Popeye is an energetic man, as energetic as sui! Oh, by the way, Popeyes Chinese name is shuishou!Lfg!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20241009114754_75af2dd7db.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPEYETHESAILOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPEYETHESAILOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

