module 0xe854d9eac6dcd7161c157505e513bcdea92993432c5e60076fe22713b213211::justin_faucet_coin {
    struct JUSTIN_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    struct Faucet_Account has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<JUSTIN_FAUCET_COIN>,
        mint_amount: u64,
    }

    public entry fun get_faucet(arg0: &mut Faucet_Account, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<JUSTIN_FAUCET_COIN>(&arg0.balance) >= arg0.mint_amount, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<JUSTIN_FAUCET_COIN>>(0x2::coin::from_balance<JUSTIN_FAUCET_COIN>(0x2::balance::split<JUSTIN_FAUCET_COIN>(&mut arg0.balance, arg0.mint_amount), arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: JUSTIN_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUSTIN_FAUCET_COIN>(arg0, 8, b"JFCOIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUSTIN_FAUCET_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUSTIN_FAUCET_COIN>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = Faucet_Account{
            id          : 0x2::object::new(arg1),
            balance     : 0x2::balance::zero<JUSTIN_FAUCET_COIN>(),
            mint_amount : 100000000,
        };
        0x2::transfer::share_object<Faucet_Account>(v2);
    }

    public entry fun mint_faucet(arg0: &mut 0x2::coin::TreasuryCap<JUSTIN_FAUCET_COIN>, arg1: u64, arg2: &mut Faucet_Account, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<JUSTIN_FAUCET_COIN>(&mut arg2.balance, 0x2::coin::into_balance<JUSTIN_FAUCET_COIN>(0x2::coin::mint<JUSTIN_FAUCET_COIN>(arg0, arg1, arg3)));
    }

    public entry fun update_mint_amount(arg0: &mut 0x2::coin::TreasuryCap<JUSTIN_FAUCET_COIN>, arg1: &mut Faucet_Account, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.mint_amount = arg2;
    }

    // decompiled from Move bytecode v6
}

