module 0x2bf06ebb29e1dde43fc251d90071c3fe86381abd4b5aafe23d3e33733f332480::joy1102_faucet_coin {
    struct JOY1102_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<JOY1102_FAUCET_COIN>, arg1: 0x2::coin::Coin<JOY1102_FAUCET_COIN>) {
        0x2::coin::burn<JOY1102_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: JOY1102_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOY1102_FAUCET_COIN>(arg0, 9, b"JOY1102_FAUCET", b"JOY1102_FAUCET", b"JOY1102's faucet coin, everyone can access and mutate.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/81794441")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOY1102_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<JOY1102_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JOY1102_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JOY1102_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

