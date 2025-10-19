module 0x711e4ec41202b45da5c5745b059ef830e401ed9f8dc19f06bfa1b0a80c498f61::fnx {
    struct FNX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FNX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FNX>(arg0, 6, b"FNX", b"FINDEX", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FNX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FNX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

