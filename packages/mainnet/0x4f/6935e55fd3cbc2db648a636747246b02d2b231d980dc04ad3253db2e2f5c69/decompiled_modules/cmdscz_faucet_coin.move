module 0x4f6935e55fd3cbc2db648a636747246b02d2b231d980dc04ad3253db2e2f5c69::cmdscz_faucet_coin {
    struct CMDSCZ_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<CMDSCZ_FAUCET_COIN>, arg1: 0x2::coin::Coin<CMDSCZ_FAUCET_COIN>) {
        0x2::coin::burn<CMDSCZ_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: CMDSCZ_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CMDSCZ_FAUCET_COIN>(arg0, 9, b"CMDS", b"CMDSCZ_FAUCET_COIN", b"CMDSCZ Faucet Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/169383631")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CMDSCZ_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CMDSCZ_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CMDSCZ_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CMDSCZ_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

