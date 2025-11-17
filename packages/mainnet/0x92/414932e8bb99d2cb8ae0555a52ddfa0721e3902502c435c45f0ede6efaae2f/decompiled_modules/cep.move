module 0x92414932e8bb99d2cb8ae0555a52ddfa0721e3902502c435c45f0ede6efaae2f::cep {
    struct CEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CEP>(arg0, 6, b"CEP", b"PEPECep", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1763348438311.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CEP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

