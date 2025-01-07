module 0x77422af070abfe9e4470868ec61424dce2b604c3889ce9675d2619368a4a60e0::Ox4e33Faucet {
    struct OX4E33FAUCET has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<OX4E33FAUCET>, arg1: 0x2::coin::Coin<OX4E33FAUCET>) {
        0x2::coin::burn<OX4E33FAUCET>(arg0, arg1);
    }

    fun init(arg0: OX4E33FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OX4E33FAUCET>(arg0, 18, b"0x4E33Faucet", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OX4E33FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<OX4E33FAUCET>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<OX4E33FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<OX4E33FAUCET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

