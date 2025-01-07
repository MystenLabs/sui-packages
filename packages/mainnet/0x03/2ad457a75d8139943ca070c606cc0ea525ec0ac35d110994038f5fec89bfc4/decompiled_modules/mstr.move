module 0x32ad457a75d8139943ca070c606cc0ea525ec0ac35d110994038f5fec89bfc4::mstr {
    struct MSTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSTR>(arg0, 8, b"MSTR", b"Wrapped token for MicroStrategy Inc", b"Sudo Virtual Coin for MicroStrategy Inc", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSTR>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MSTR>>(v0);
    }

    // decompiled from Move bytecode v6
}

