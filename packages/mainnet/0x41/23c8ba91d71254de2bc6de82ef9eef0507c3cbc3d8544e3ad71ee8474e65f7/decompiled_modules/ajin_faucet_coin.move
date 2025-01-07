module 0x4123c8ba91d71254de2bc6de82ef9eef0507c3cbc3d8544e3ad71ee8474e65f7::ajin_faucet_coin {
    struct AJIN_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AJIN_FAUCET_COIN>, arg1: 0x2::coin::Coin<AJIN_FAUCET_COIN>) {
        0x2::coin::burn<AJIN_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: AJIN_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AJIN_FAUCET_COIN>(arg0, 8, b"Ajin Faucet", b"Ajin Faucet", b"Ajin faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AJIN_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<AJIN_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AJIN_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AJIN_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

