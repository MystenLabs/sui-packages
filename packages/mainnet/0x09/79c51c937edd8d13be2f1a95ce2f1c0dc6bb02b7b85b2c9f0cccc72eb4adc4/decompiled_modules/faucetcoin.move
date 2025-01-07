module 0x979c51c937edd8d13be2f1a95ce2f1c0dc6bb02b7b85b2c9f0cccc72eb4adc4::faucetcoin {
    struct TreasuryCapHolder has key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<FAUCETCOIN>,
    }

    struct FAUCETCOIN has drop {
        dummy_field: bool,
    }

    entry fun mint(arg0: &mut TreasuryCapHolder, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FAUCETCOIN>>(0x2::coin::mint<FAUCETCOIN>(&mut arg0.treasury, 100000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: FAUCETCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCETCOIN>(arg0, 6, b"FNFC", b"FNFaucetCoin", b"Feng nian Faucet Coin description", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = TreasuryCapHolder{
            id       : 0x2::object::new(arg1),
            treasury : v0,
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCETCOIN>>(v1);
        0x2::transfer::share_object<TreasuryCapHolder>(v2);
    }

    // decompiled from Move bytecode v6
}

