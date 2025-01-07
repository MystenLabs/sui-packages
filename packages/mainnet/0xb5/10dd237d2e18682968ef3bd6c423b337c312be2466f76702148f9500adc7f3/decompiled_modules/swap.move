module 0xb510dd237d2e18682968ef3bd6c423b337c312be2466f76702148f9500adc7f3::swap {
    struct Pool has key {
        id: 0x2::object::UID,
        coin_balance: 0x2::balance::Balance<0x5c1042a50f66773a2da032c15aa7620527b21091c01f30c4c89bb002104da8e7::chainrex_coin::CHAINREX_COIN>,
        faucet_balance: 0x2::balance::Balance<0x4a207050f8085df4fb83b4360740ea8c39862e072da85eb6a601ca80521e8a32::chainrex_faucet_coin::CHAINREX_FAUCET_COIN>,
    }

    public entry fun Deposit(arg0: &mut Pool, arg1: &mut 0x2::coin::Coin<0x5c1042a50f66773a2da032c15aa7620527b21091c01f30c4c89bb002104da8e7::chainrex_coin::CHAINREX_COIN>, arg2: &mut 0x2::coin::Coin<0x4a207050f8085df4fb83b4360740ea8c39862e072da85eb6a601ca80521e8a32::chainrex_faucet_coin::CHAINREX_FAUCET_COIN>, arg3: u64, arg4: u64) {
        0x2::balance::join<0x5c1042a50f66773a2da032c15aa7620527b21091c01f30c4c89bb002104da8e7::chainrex_coin::CHAINREX_COIN>(&mut arg0.coin_balance, 0x2::balance::split<0x5c1042a50f66773a2da032c15aa7620527b21091c01f30c4c89bb002104da8e7::chainrex_coin::CHAINREX_COIN>(0x2::coin::balance_mut<0x5c1042a50f66773a2da032c15aa7620527b21091c01f30c4c89bb002104da8e7::chainrex_coin::CHAINREX_COIN>(arg1), arg3));
        0x2::balance::join<0x4a207050f8085df4fb83b4360740ea8c39862e072da85eb6a601ca80521e8a32::chainrex_faucet_coin::CHAINREX_FAUCET_COIN>(&mut arg0.faucet_balance, 0x2::balance::split<0x4a207050f8085df4fb83b4360740ea8c39862e072da85eb6a601ca80521e8a32::chainrex_faucet_coin::CHAINREX_FAUCET_COIN>(0x2::coin::balance_mut<0x4a207050f8085df4fb83b4360740ea8c39862e072da85eb6a601ca80521e8a32::chainrex_faucet_coin::CHAINREX_FAUCET_COIN>(arg2), arg4));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id             : 0x2::object::new(arg0),
            coin_balance   : 0x2::balance::zero<0x5c1042a50f66773a2da032c15aa7620527b21091c01f30c4c89bb002104da8e7::chainrex_coin::CHAINREX_COIN>(),
            faucet_balance : 0x2::balance::zero<0x4a207050f8085df4fb83b4360740ea8c39862e072da85eb6a601ca80521e8a32::chainrex_faucet_coin::CHAINREX_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    public entry fun swap_coin_to_faucet(arg0: &mut Pool, arg1: &mut 0x2::coin::Coin<0x5c1042a50f66773a2da032c15aa7620527b21091c01f30c4c89bb002104da8e7::chainrex_coin::CHAINREX_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x4a207050f8085df4fb83b4360740ea8c39862e072da85eb6a601ca80521e8a32::chainrex_faucet_coin::CHAINREX_FAUCET_COIN>(&arg0.faucet_balance) >= arg2, 1000);
        0x2::balance::join<0x5c1042a50f66773a2da032c15aa7620527b21091c01f30c4c89bb002104da8e7::chainrex_coin::CHAINREX_COIN>(&mut arg0.coin_balance, 0x2::balance::split<0x5c1042a50f66773a2da032c15aa7620527b21091c01f30c4c89bb002104da8e7::chainrex_coin::CHAINREX_COIN>(0x2::coin::balance_mut<0x5c1042a50f66773a2da032c15aa7620527b21091c01f30c4c89bb002104da8e7::chainrex_coin::CHAINREX_COIN>(arg1), arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4a207050f8085df4fb83b4360740ea8c39862e072da85eb6a601ca80521e8a32::chainrex_faucet_coin::CHAINREX_FAUCET_COIN>>(0x2::coin::take<0x4a207050f8085df4fb83b4360740ea8c39862e072da85eb6a601ca80521e8a32::chainrex_faucet_coin::CHAINREX_FAUCET_COIN>(&mut arg0.faucet_balance, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_faucet_to_coin(arg0: &mut Pool, arg1: &mut 0x2::coin::Coin<0x4a207050f8085df4fb83b4360740ea8c39862e072da85eb6a601ca80521e8a32::chainrex_faucet_coin::CHAINREX_FAUCET_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x5c1042a50f66773a2da032c15aa7620527b21091c01f30c4c89bb002104da8e7::chainrex_coin::CHAINREX_COIN>(&arg0.coin_balance) >= arg2, 1000);
        0x2::balance::join<0x4a207050f8085df4fb83b4360740ea8c39862e072da85eb6a601ca80521e8a32::chainrex_faucet_coin::CHAINREX_FAUCET_COIN>(&mut arg0.faucet_balance, 0x2::balance::split<0x4a207050f8085df4fb83b4360740ea8c39862e072da85eb6a601ca80521e8a32::chainrex_faucet_coin::CHAINREX_FAUCET_COIN>(0x2::coin::balance_mut<0x4a207050f8085df4fb83b4360740ea8c39862e072da85eb6a601ca80521e8a32::chainrex_faucet_coin::CHAINREX_FAUCET_COIN>(arg1), arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5c1042a50f66773a2da032c15aa7620527b21091c01f30c4c89bb002104da8e7::chainrex_coin::CHAINREX_COIN>>(0x2::coin::take<0x5c1042a50f66773a2da032c15aa7620527b21091c01f30c4c89bb002104da8e7::chainrex_coin::CHAINREX_COIN>(&mut arg0.coin_balance, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

