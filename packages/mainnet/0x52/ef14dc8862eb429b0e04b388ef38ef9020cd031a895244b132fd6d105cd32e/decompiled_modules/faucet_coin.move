module 0x52ef14dc8862eb429b0e04b388ef38ef9020cd031a895244b132fd6d105cd32e::faucet_coin {
    struct FAUCET_COIN has drop {
        dummy_field: bool,
    }

    struct TreasuryCapHolder has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<FAUCET_COIN>,
    }

    public entry fun mint(arg0: &mut TreasuryCapHolder, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FAUCET_COIN>>(0x2::coin::mint<FAUCET_COIN>(&mut arg0.treasury_cap, 10, arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCET_COIN>(arg0, 4, b"potato89757_faucet", b"fanshuF", b"potato is fanshu yeah :3", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCET_COIN>>(v1);
        let v2 = TreasuryCapHolder{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::share_object<TreasuryCapHolder>(v2);
    }

    // decompiled from Move bytecode v6
}

