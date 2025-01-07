module 0xc5cd10902e69479ccec2af1a1997fab6dc3a30aa190d426a2de5bfa4ba6a2176::yty2024_swap {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Bank has key {
        id: 0x2::object::UID,
        coin1: 0x2::balance::Balance<0x7114c3a88a83349ad87af402fe3cc1ecc743b58577cd90880faf580fccb5b884::yty2024_coin::YTY2024_COIN>,
        coin2: 0x2::balance::Balance<0x7114c3a88a83349ad87af402fe3cc1ecc743b58577cd90880faf580fccb5b884::yty2024_faucet_coin::YTY2024_FAUCET_COIN>,
    }

    public entry fun deposit_coin1(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x7114c3a88a83349ad87af402fe3cc1ecc743b58577cd90880faf580fccb5b884::yty2024_coin::YTY2024_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x7114c3a88a83349ad87af402fe3cc1ecc743b58577cd90880faf580fccb5b884::yty2024_coin::YTY2024_COIN>(&mut arg0.coin1, 0x2::coin::into_balance<0x7114c3a88a83349ad87af402fe3cc1ecc743b58577cd90880faf580fccb5b884::yty2024_coin::YTY2024_COIN>(arg1));
    }

    public entry fun deposit_coin2(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x7114c3a88a83349ad87af402fe3cc1ecc743b58577cd90880faf580fccb5b884::yty2024_faucet_coin::YTY2024_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x7114c3a88a83349ad87af402fe3cc1ecc743b58577cd90880faf580fccb5b884::yty2024_faucet_coin::YTY2024_FAUCET_COIN>(&mut arg0.coin2, 0x2::coin::into_balance<0x7114c3a88a83349ad87af402fe3cc1ecc743b58577cd90880faf580fccb5b884::yty2024_faucet_coin::YTY2024_FAUCET_COIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id    : 0x2::object::new(arg0),
            coin1 : 0x2::balance::zero<0x7114c3a88a83349ad87af402fe3cc1ecc743b58577cd90880faf580fccb5b884::yty2024_coin::YTY2024_COIN>(),
            coin2 : 0x2::balance::zero<0x7114c3a88a83349ad87af402fe3cc1ecc743b58577cd90880faf580fccb5b884::yty2024_faucet_coin::YTY2024_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Bank>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_coin1_coin2(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x7114c3a88a83349ad87af402fe3cc1ecc743b58577cd90880faf580fccb5b884::yty2024_coin::YTY2024_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x7114c3a88a83349ad87af402fe3cc1ecc743b58577cd90880faf580fccb5b884::yty2024_coin::YTY2024_COIN>(&mut arg0.coin1, 0x2::coin::into_balance<0x7114c3a88a83349ad87af402fe3cc1ecc743b58577cd90880faf580fccb5b884::yty2024_coin::YTY2024_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7114c3a88a83349ad87af402fe3cc1ecc743b58577cd90880faf580fccb5b884::yty2024_faucet_coin::YTY2024_FAUCET_COIN>>(0x2::coin::from_balance<0x7114c3a88a83349ad87af402fe3cc1ecc743b58577cd90880faf580fccb5b884::yty2024_faucet_coin::YTY2024_FAUCET_COIN>(0x2::balance::split<0x7114c3a88a83349ad87af402fe3cc1ecc743b58577cd90880faf580fccb5b884::yty2024_faucet_coin::YTY2024_FAUCET_COIN>(&mut arg0.coin2, 0x2::coin::value<0x7114c3a88a83349ad87af402fe3cc1ecc743b58577cd90880faf580fccb5b884::yty2024_coin::YTY2024_COIN>(&arg1)), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_coin2_coin1(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x7114c3a88a83349ad87af402fe3cc1ecc743b58577cd90880faf580fccb5b884::yty2024_faucet_coin::YTY2024_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x7114c3a88a83349ad87af402fe3cc1ecc743b58577cd90880faf580fccb5b884::yty2024_faucet_coin::YTY2024_FAUCET_COIN>(&mut arg0.coin2, 0x2::coin::into_balance<0x7114c3a88a83349ad87af402fe3cc1ecc743b58577cd90880faf580fccb5b884::yty2024_faucet_coin::YTY2024_FAUCET_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7114c3a88a83349ad87af402fe3cc1ecc743b58577cd90880faf580fccb5b884::yty2024_coin::YTY2024_COIN>>(0x2::coin::from_balance<0x7114c3a88a83349ad87af402fe3cc1ecc743b58577cd90880faf580fccb5b884::yty2024_coin::YTY2024_COIN>(0x2::balance::split<0x7114c3a88a83349ad87af402fe3cc1ecc743b58577cd90880faf580fccb5b884::yty2024_coin::YTY2024_COIN>(&mut arg0.coin1, 0x2::coin::value<0x7114c3a88a83349ad87af402fe3cc1ecc743b58577cd90880faf580fccb5b884::yty2024_faucet_coin::YTY2024_FAUCET_COIN>(&arg1)), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_coin1(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7114c3a88a83349ad87af402fe3cc1ecc743b58577cd90880faf580fccb5b884::yty2024_coin::YTY2024_COIN>>(0x2::coin::from_balance<0x7114c3a88a83349ad87af402fe3cc1ecc743b58577cd90880faf580fccb5b884::yty2024_coin::YTY2024_COIN>(0x2::balance::split<0x7114c3a88a83349ad87af402fe3cc1ecc743b58577cd90880faf580fccb5b884::yty2024_coin::YTY2024_COIN>(&mut arg1.coin1, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

