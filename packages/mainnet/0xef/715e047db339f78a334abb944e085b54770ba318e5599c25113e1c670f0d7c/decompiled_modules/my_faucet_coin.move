module 0xef715e047db339f78a334abb944e085b54770ba318e5599c25113e1c670f0d7c::my_faucet_coin {
    struct MY_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    struct FaucetCap has store, key {
        id: 0x2::object::UID,
        treasure_cap: 0x2::coin::TreasuryCap<MY_FAUCET_COIN>,
    }

    public fun faucet_mint(arg0: &mut FaucetCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MY_FAUCET_COIN>>(0x2::coin::mint<MY_FAUCET_COIN>(&mut arg0.treasure_cap, arg1, arg3), arg2);
    }

    fun init(arg0: MY_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_FAUCET_COIN>(arg0, 8, b"MFC", b"MY_FAUCET_COIN", b"My faucet coin by beam-magnum", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = FaucetCap{
            id           : 0x2::object::new(arg1),
            treasure_cap : v0,
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<FaucetCap>(v2);
    }

    // decompiled from Move bytecode v6
}

