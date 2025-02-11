module 0x9b545bff00534f06d4f826802c2cc727c3827ac9a659ceeb117940b6c234dda7::sSCA {
    struct SSCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSCA>(arg0, 6, b"sysSCA", b"SY sSCA", b"SY scallop sSCA", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSCA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSCA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

