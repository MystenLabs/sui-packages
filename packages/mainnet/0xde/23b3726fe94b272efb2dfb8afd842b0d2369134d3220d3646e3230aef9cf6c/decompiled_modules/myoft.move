module 0xde23b3726fe94b272efb2dfb8afd842b0d2369134d3220d3646e3230aef9cf6c::myoft {
    struct MYOFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYOFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYOFT>(arg0, 6, b"MYOFT", b"My Omnichain Fungible Token", b"A LayerZero OFT on Sui with mint/burn capabilities", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYOFT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYOFT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

