module 0x1da3df7043698387821405ea29671e20bc0ecfbc5c948c3c1f08cf00940f98fc::funnyyanne_faucet_coin {
    struct FUNNYYANNE_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUNNYYANNE_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUNNYYANNE_FAUCET_COIN>(arg0, 9, b"FUNNYYANNE_FAUCET_COIN", b"FUNNYYANNE_FAUCET_COIN", b"It is faucet coin. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://cdn3.iconfinder.com/data/icons/leto-space/64/__space_cat_helmet-1024.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUNNYYANNE_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FUNNYYANNE_FAUCET_COIN>>(v0);
    }

    public entry fun mint_in_my_module(arg0: &mut 0x2::coin::TreasuryCap<FUNNYYANNE_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FUNNYYANNE_FAUCET_COIN>>(0x2::coin::mint<FUNNYYANNE_FAUCET_COIN>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

