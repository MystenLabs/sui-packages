module 0xeeb0e41bd5d8525020065a50c811b42a001547a720419e230612404951639009::fo100sb {
    struct FO100SB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FO100SB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FO100SB>(arg0, 6, b"FO100SB", b"FO100SB", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FO100SB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FO100SB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

