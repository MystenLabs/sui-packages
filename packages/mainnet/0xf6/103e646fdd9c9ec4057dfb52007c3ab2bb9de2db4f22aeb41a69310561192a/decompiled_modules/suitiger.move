module 0xf6103e646fdd9c9ec4057dfb52007c3ab2bb9de2db4f22aeb41a69310561192a::suitiger {
    struct SUITIGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITIGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITIGER>(arg0, 2, b"SUITIGER", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITIGER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITIGER>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUITIGER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUITIGER>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

