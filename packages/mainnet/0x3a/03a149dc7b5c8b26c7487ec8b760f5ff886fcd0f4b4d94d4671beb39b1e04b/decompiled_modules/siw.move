module 0x3a03a149dc7b5c8b26c7487ec8b760f5ff886fcd0f4b4d94d4671beb39b1e04b::siw {
    struct SIW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2, v3) = 0x2::coin::create_regulated_currency<SIW>(arg0, 6, b"SIW", b"Siw Token", b"Based on sui blockchain, let us stay in this world", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIW>>(v1, v0);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SIW>>(v3, v0);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<SIW>>(v2, v0);
    }

    // decompiled from Move bytecode v6
}

