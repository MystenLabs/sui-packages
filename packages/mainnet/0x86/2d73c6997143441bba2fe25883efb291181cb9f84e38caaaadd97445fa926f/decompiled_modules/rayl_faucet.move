module 0x862d73c6997143441bba2fe25883efb291181cb9f84e38caaaadd97445fa926f::rayl_faucet {
    struct RAYL_FAUCET has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<RAYL_FAUCET>, arg1: 0x2::coin::Coin<RAYL_FAUCET>) {
        0x2::coin::burn<RAYL_FAUCET>(arg0, arg1);
    }

    fun init(arg0: RAYL_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAYL_FAUCET>(arg0, 6, b"RLF", b"RayL Coin Faucet", b"faucet coin by RayL", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAYL_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<RAYL_FAUCET>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<RAYL_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<RAYL_FAUCET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

