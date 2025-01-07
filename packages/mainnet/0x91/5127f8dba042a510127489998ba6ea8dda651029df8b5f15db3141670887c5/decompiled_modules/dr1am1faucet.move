module 0x915127f8dba042a510127489998ba6ea8dda651029df8b5f15db3141670887c5::dr1am1faucet {
    struct DR1AM1FAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: DR1AM1FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DR1AM1FAUCET>(arg0, 8, b"DR1AM1FAUCET", b"DR1AM1FAUCET", b"this is dr1am1coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DR1AM1FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<DR1AM1FAUCET>>(v0);
    }

    // decompiled from Move bytecode v6
}

