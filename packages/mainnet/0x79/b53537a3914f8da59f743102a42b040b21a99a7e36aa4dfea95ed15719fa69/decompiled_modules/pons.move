module 0x79b53537a3914f8da59f743102a42b040b21a99a7e36aa4dfea95ed15719fa69::pons {
    struct PONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONS>(arg0, 8, b"PONS", b"Wrapped PONS", b"ZO Finance Virtual Coin for PONS", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PONS>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PONS>>(v0);
    }

    // decompiled from Move bytecode v7
}

