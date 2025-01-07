module 0xca5cf766fee82ff53f7c3c1c3180e79dbf46090106c6ea14054c7653f864d5da::faucetcoin {
    struct TreasuryCapHolder has key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<FAUCETCOIN>,
    }

    struct FAUCETCOIN has drop {
        dummy_field: bool,
    }

    entry fun mint(arg0: &mut TreasuryCapHolder, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FAUCETCOIN>>(0x2::coin::mint<FAUCETCOIN>(&mut arg0.treasury, 100, arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: FAUCETCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCETCOIN>(arg0, 6, b"MYFC", b"MyFaucetCoin", b"My Faucet Coin description", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = TreasuryCapHolder{
            id       : 0x2::object::new(arg1),
            treasury : v0,
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCETCOIN>>(v1);
        0x2::transfer::share_object<TreasuryCapHolder>(v2);
    }

    // decompiled from Move bytecode v6
}

