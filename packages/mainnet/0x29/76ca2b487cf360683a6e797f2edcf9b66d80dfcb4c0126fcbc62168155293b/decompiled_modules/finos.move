module 0x2976ca2b487cf360683a6e797f2edcf9b66d80dfcb4c0126fcbc62168155293b::finos {
    struct FINOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINOS>(arg0, 6, b"FINOS", b"Finos the sticks", b"A new meme friend in Suiverse.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732240993841.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FINOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

