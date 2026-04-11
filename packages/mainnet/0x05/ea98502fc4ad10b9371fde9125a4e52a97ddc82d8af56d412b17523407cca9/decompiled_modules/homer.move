module 0x5ea98502fc4ad10b9371fde9125a4e52a97ddc82d8af56d412b17523407cca9::homer {
    struct HOMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOMER>(arg0, 6, b"HOMER", b"HOMER", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HOMER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

