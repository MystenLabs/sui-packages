module 0x32de70fc2e92a7abddf1675afc56b37c5403a4a846d68de328c44d528450754e::faucet_coin {
    struct FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FAUCET_COIN>, arg1: 0x2::coin::Coin<FAUCET_COIN>) {
        0x2::coin::burn<FAUCET_COIN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FAUCET_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FAUCET_COIN>>(0x2::coin::mint<FAUCET_COIN>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCET_COIN>(arg0, 6, b"ALRFAUCET", b"faucet autolife robotics", b"First ai robotics coin on sui net by autolife robotics faucet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.autolife.ai/icon.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUCET_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

