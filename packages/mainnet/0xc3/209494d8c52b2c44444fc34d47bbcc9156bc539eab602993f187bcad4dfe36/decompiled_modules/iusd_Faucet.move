module 0xc3209494d8c52b2c44444fc34d47bbcc9156bc539eab602993f187bcad4dfe36::iusd_Faucet {
    struct IUSD_FAUCET has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<IUSD_FAUCET>, arg1: 0x2::coin::Coin<IUSD_FAUCET>) {
        0x2::coin::burn<IUSD_FAUCET>(arg0, arg1);
    }

    public entry fun Mint(arg0: &mut 0x2::coin::TreasuryCap<IUSD_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<IUSD_FAUCET>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: IUSD_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IUSD_FAUCET>(arg0, 8, b"IUSD_FAUCET", b"iusd_faucet", b"Sui faucet stable coin -1:1- USD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://avatars.githubusercontent.com/u/181119030?s=200&v=4"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IUSD_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<IUSD_FAUCET>>(v0);
    }

    // decompiled from Move bytecode v6
}

