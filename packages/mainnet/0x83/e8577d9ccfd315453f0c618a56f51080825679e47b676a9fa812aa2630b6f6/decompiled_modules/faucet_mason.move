module 0x83e8577d9ccfd315453f0c618a56f51080825679e47b676a9fa812aa2630b6f6::faucet_mason {
    struct FAUCET_MASON has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAUCET_MASON, arg1: &mut 0x2::tx_context::TxContext) {
        0x1::option::none<0x2::url::Url>();
        let (v0, v1) = 0x2::coin::create_currency<FAUCET_MASON>(arg0, 8, b"FMC", b"Faucet_Mason_coin", b"Mason Faucet_Coin , service for anyone!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://1000logos.net/wp-content/uploads/2022/03/Mason-Logo-Classic.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCET_MASON>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUCET_MASON>>(v0);
    }

    // decompiled from Move bytecode v6
}

