module 0x150e1400bd243d952c47d180e077324fc0434363bc80cfaf6abadebf9b51705c::GAMA {
    struct GAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAMA>(arg0, 9, b"GAMA", b"Gama Trump", b"Gama Trump Boost", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GAMA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAMA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

