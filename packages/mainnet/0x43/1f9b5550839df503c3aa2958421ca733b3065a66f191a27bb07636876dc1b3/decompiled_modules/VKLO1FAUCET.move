module 0x431f9b5550839df503c3aa2958421ca733b3065a66f191a27bb07636876dc1b3::VKLO1FAUCET {
    struct VKLO1FAUCET has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<VKLO1FAUCET>, arg1: 0x2::coin::Coin<VKLO1FAUCET>) {
        0x2::coin::burn<VKLO1FAUCET>(arg0, arg1);
    }

    fun init(arg0: VKLO1FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VKLO1FAUCET>(arg0, 3, b"VKLO1FAUCET", b"CA", b"learning for VKLO1FAUCET", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VKLO1FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<VKLO1FAUCET>>(v0);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<VKLO1FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<VKLO1FAUCET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

