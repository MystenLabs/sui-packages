module 0xdcf3749d51e66858ee2443fcc0b92b33482986580aa2db686e5a0d1e5a07ffac::rr {
    struct RR has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<RR>, arg1: 0x2::coin::Coin<RR>) {
        0x2::coin::burn<RR>(arg0, arg1);
    }

    fun init(arg0: RR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RR>(arg0, 0, b"RR", b"RR", b"this id my faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RR>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<RR>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<RR>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<RR>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

