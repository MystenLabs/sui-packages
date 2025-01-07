module 0x803a4f31065d27a1a3c79a41e2040c5b524538e508ff77a25ba9312103e5fdcb::greyhaofaucet {
    struct GREYHAOFAUCET has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GREYHAOFAUCET>, arg1: 0x2::coin::Coin<GREYHAOFAUCET>) {
        0x2::coin::burn<GREYHAOFAUCET>(arg0, arg1);
    }

    fun init(arg0: GREYHAOFAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREYHAOFAUCET>(arg0, 8, b"GREYHAOFAUCET", b"GHF", b"faucet coin by Greyhao", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GREYHAOFAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<GREYHAOFAUCET>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GREYHAOFAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GREYHAOFAUCET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

