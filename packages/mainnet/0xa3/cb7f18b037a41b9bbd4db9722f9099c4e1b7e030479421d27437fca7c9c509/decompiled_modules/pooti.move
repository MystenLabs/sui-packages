module 0xa3cb7f18b037a41b9bbd4db9722f9099c4e1b7e030479421d27437fca7c9c509::pooti {
    struct POOTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOTI>(arg0, 6, b"POOTI", b"Pooti Kat", b"SUIIIIIIIIIIII", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pootie_109fef4bfa.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

