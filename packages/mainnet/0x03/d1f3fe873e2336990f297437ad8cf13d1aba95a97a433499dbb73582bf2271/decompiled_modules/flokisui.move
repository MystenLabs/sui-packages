module 0x3d1f3fe873e2336990f297437ad8cf13d1aba95a97a433499dbb73582bf2271::flokisui {
    struct FLOKISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOKISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOKISUI>(arg0, 2, b"FLOKISUI", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLOKISUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOKISUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FLOKISUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FLOKISUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

