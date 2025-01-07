module 0x505116c299e1202199037b7915e8e0c80c5c5dbef5cb5105178f83412521ddc2::laozpgz_faucet_coin {
    struct LAOZPGZ_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<LAOZPGZ_FAUCET_COIN>, arg1: 0x2::coin::Coin<LAOZPGZ_FAUCET_COIN>) {
        0x2::coin::burn<LAOZPGZ_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: LAOZPGZ_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAOZPGZ_FAUCET_COIN>(arg0, 9, b"LaozpgzFaucetCoin", b"LAOZPGZ FAUCET COIN", b"lets_move task2 faucet coin,for everyone.Everyone can mint this coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/22661987")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAOZPGZ_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<LAOZPGZ_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LAOZPGZ_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LAOZPGZ_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

