module 0x5085f3f4de6730e46f19c779c6118321f4fb171503d4c2dcf9c59a13d1cc994c::stalincccp_faucet {
    struct STALINCCCP_FAUCET has drop {
        dummy_field: bool,
    }

    struct PublicWallet has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<STALINCCCP_FAUCET>,
        amount: u64,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<STALINCCCP_FAUCET>, arg1: u64, arg2: &mut PublicWallet, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<STALINCCCP_FAUCET>(&mut arg2.coin, 0x2::coin::into_balance<STALINCCCP_FAUCET>(0x2::coin::mint<STALINCCCP_FAUCET>(arg0, arg1, arg3)));
    }

    public entry fun faucet(arg0: &mut PublicWallet, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<STALINCCCP_FAUCET>(&arg0.coin) >= arg0.amount, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<STALINCCCP_FAUCET>>(0x2::coin::from_balance<STALINCCCP_FAUCET>(0x2::balance::split<STALINCCCP_FAUCET>(&mut arg0.coin, arg0.amount), arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: STALINCCCP_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STALINCCCP_FAUCET>(arg0, 1, b"STALINCCCP faucet", b"STALINCCCP faucet", b"test coin used for faucet service", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STALINCCCP_FAUCET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STALINCCCP_FAUCET>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = PublicWallet{
            id     : 0x2::object::new(arg1),
            coin   : 0x2::balance::zero<STALINCCCP_FAUCET>(),
            amount : 10,
        };
        0x2::transfer::share_object<PublicWallet>(v2);
    }

    // decompiled from Move bytecode v6
}

