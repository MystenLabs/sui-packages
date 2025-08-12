module 0x6dede1e0e16570bf3193b91e6c9124907ffe0d53e912e6ee5bda842c64129086::zipdata1_faucet_coin {
    struct ZIPDATA1_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    struct Faucet has store, key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<ZIPDATA1_FAUCET_COIN>,
        per_tx_limit: u64,
    }

    public fun claim(arg0: &mut Faucet, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= arg0.per_tx_limit, 1);
        0x2::coin::mint_and_transfer<ZIPDATA1_FAUCET_COIN>(&mut arg0.cap, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    fun init(arg0: ZIPDATA1_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZIPDATA1_FAUCET_COIN>(arg0, 9, b"Z1F", b"ZIPDATA1_FAUCET_COIN", b"ZIPDATA1 Faucet Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = Faucet{
            id           : 0x2::object::new(arg1),
            cap          : v0,
            per_tx_limit : 1000000000,
        };
        0x2::transfer::public_share_object<Faucet>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZIPDATA1_FAUCET_COIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

