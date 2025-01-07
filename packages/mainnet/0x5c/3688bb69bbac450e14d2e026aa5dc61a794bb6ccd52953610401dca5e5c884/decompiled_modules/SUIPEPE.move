module 0x5c3688bb69bbac450e14d2e026aa5dc61a794bb6ccd52953610401dca5e5c884::SUIPEPE {
    struct SUIPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPEPE>(arg0, 6, b"SUIPEPE", b"SUIPEPE", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIPEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<SUIPEPE>(arg0) + arg1 <= 1000000000000000, 101);
        0x2::coin::mint_and_transfer<SUIPEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

