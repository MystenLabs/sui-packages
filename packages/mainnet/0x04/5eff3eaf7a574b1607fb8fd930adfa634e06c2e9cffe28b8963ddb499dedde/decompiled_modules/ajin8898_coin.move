module 0x45eff3eaf7a574b1607fb8fd930adfa634e06c2e9cffe28b8963ddb499dedde::ajin8898_coin {
    struct AJIN8898_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AJIN8898_COIN>, arg1: 0x2::coin::Coin<AJIN8898_COIN>) {
        0x2::coin::burn<AJIN8898_COIN>(arg0, arg1);
    }

    fun init(arg0: AJIN8898_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AJIN8898_COIN>(arg0, 6, b"ajin8898 COIN", b"ajin8898 COIN", b"Amazing Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AJIN8898_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AJIN8898_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AJIN8898_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AJIN8898_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

