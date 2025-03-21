module 0x4c6dc55a1d670c1cf6e5fc05af631f6108bdbc603826aaef1e51abe329a8e1c4::faucet_fly {
    struct FAUCET_FLY has drop {
        dummy_field: bool,
    }

    public fun faucet_fly_mint(arg0: &mut 0x2::coin::TreasuryCap<FAUCET_FLY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FAUCET_FLY>>(0x2::coin::mint<FAUCET_FLY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FAUCET_FLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCET_FLY>(arg0, 8, b"FAUCET_FLY", b"FAUCET_FLY", b"FLY currency but can faucet", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCET_FLY>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUCET_FLY>>(v0);
    }

    // decompiled from Move bytecode v6
}

