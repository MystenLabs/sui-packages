module 0xd3929e729b017a3c1ce40a4458cc00db8e71bb5882c99b1fe86bdc25899bb2ce::leon_dev_1024_faucet_coin {
    struct LEON_DEV_1024_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEON_DEV_1024_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEON_DEV_1024_FAUCET_COIN>(arg0, 9, b"LDFC", b"LEON_DEV_1024_FAUCET_COIN", b"this is a faucet coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://avatars.githubusercontent.com/u/16557117?v=4"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEON_DEV_1024_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<LEON_DEV_1024_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LEON_DEV_1024_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LEON_DEV_1024_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

