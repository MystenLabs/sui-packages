module 0x9f4bfb2224e7d8b94cde9c7d0c58b3410162f8acf89d38889eef182da1924b46::task5_swap {
    struct Bank has key {
        id: 0x2::object::UID,
        USD: 0x2::balance::Balance<0x371938ce3f96b99720eaf1083e1d36a62d052fa5d315e5b3f066e526e1961551::geekzlk_coin::GEEKZLK_COIN>,
        RMB: 0x2::balance::Balance<0x371938ce3f96b99720eaf1083e1d36a62d052fa5d315e5b3f066e526e1961551::geekzlk_faucet_coin::GEEKZLK_FAUCET_COIN>,
        rate: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit_RMB(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x371938ce3f96b99720eaf1083e1d36a62d052fa5d315e5b3f066e526e1961551::geekzlk_faucet_coin::GEEKZLK_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x371938ce3f96b99720eaf1083e1d36a62d052fa5d315e5b3f066e526e1961551::geekzlk_faucet_coin::GEEKZLK_FAUCET_COIN>(&mut arg0.RMB, 0x2::coin::into_balance<0x371938ce3f96b99720eaf1083e1d36a62d052fa5d315e5b3f066e526e1961551::geekzlk_faucet_coin::GEEKZLK_FAUCET_COIN>(arg1));
    }

    public entry fun deposit_USD(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x371938ce3f96b99720eaf1083e1d36a62d052fa5d315e5b3f066e526e1961551::geekzlk_coin::GEEKZLK_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x371938ce3f96b99720eaf1083e1d36a62d052fa5d315e5b3f066e526e1961551::geekzlk_coin::GEEKZLK_COIN>(&mut arg0.USD, 0x2::coin::into_balance<0x371938ce3f96b99720eaf1083e1d36a62d052fa5d315e5b3f066e526e1961551::geekzlk_coin::GEEKZLK_COIN>(arg1));
    }

    public fun get_rate(arg0: &Bank) : u64 {
        arg0.rate
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id   : 0x2::object::new(arg0),
            USD  : 0x2::balance::zero<0x371938ce3f96b99720eaf1083e1d36a62d052fa5d315e5b3f066e526e1961551::geekzlk_coin::GEEKZLK_COIN>(),
            RMB  : 0x2::balance::zero<0x371938ce3f96b99720eaf1083e1d36a62d052fa5d315e5b3f066e526e1961551::geekzlk_faucet_coin::GEEKZLK_FAUCET_COIN>(),
            rate : 7,
        };
        0x2::transfer::share_object<Bank>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun set_rate(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.rate = arg2;
    }

    public entry fun swap_rmb2usd(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x371938ce3f96b99720eaf1083e1d36a62d052fa5d315e5b3f066e526e1961551::geekzlk_faucet_coin::GEEKZLK_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x371938ce3f96b99720eaf1083e1d36a62d052fa5d315e5b3f066e526e1961551::geekzlk_faucet_coin::GEEKZLK_FAUCET_COIN>(&mut arg0.RMB, 0x2::coin::into_balance<0x371938ce3f96b99720eaf1083e1d36a62d052fa5d315e5b3f066e526e1961551::geekzlk_faucet_coin::GEEKZLK_FAUCET_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x371938ce3f96b99720eaf1083e1d36a62d052fa5d315e5b3f066e526e1961551::geekzlk_coin::GEEKZLK_COIN>>(0x2::coin::from_balance<0x371938ce3f96b99720eaf1083e1d36a62d052fa5d315e5b3f066e526e1961551::geekzlk_coin::GEEKZLK_COIN>(0x2::balance::split<0x371938ce3f96b99720eaf1083e1d36a62d052fa5d315e5b3f066e526e1961551::geekzlk_coin::GEEKZLK_COIN>(&mut arg0.USD, 0x2::coin::value<0x371938ce3f96b99720eaf1083e1d36a62d052fa5d315e5b3f066e526e1961551::geekzlk_faucet_coin::GEEKZLK_FAUCET_COIN>(&arg1) / arg0.rate), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_usd2rmb(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x371938ce3f96b99720eaf1083e1d36a62d052fa5d315e5b3f066e526e1961551::geekzlk_coin::GEEKZLK_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x371938ce3f96b99720eaf1083e1d36a62d052fa5d315e5b3f066e526e1961551::geekzlk_coin::GEEKZLK_COIN>(&mut arg0.USD, 0x2::coin::into_balance<0x371938ce3f96b99720eaf1083e1d36a62d052fa5d315e5b3f066e526e1961551::geekzlk_coin::GEEKZLK_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x371938ce3f96b99720eaf1083e1d36a62d052fa5d315e5b3f066e526e1961551::geekzlk_faucet_coin::GEEKZLK_FAUCET_COIN>>(0x2::coin::from_balance<0x371938ce3f96b99720eaf1083e1d36a62d052fa5d315e5b3f066e526e1961551::geekzlk_faucet_coin::GEEKZLK_FAUCET_COIN>(0x2::balance::split<0x371938ce3f96b99720eaf1083e1d36a62d052fa5d315e5b3f066e526e1961551::geekzlk_faucet_coin::GEEKZLK_FAUCET_COIN>(&mut arg0.RMB, 0x2::coin::value<0x371938ce3f96b99720eaf1083e1d36a62d052fa5d315e5b3f066e526e1961551::geekzlk_coin::GEEKZLK_COIN>(&arg1) * arg0.rate), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

