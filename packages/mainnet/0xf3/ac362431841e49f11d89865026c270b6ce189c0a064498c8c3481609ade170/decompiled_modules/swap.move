module 0xf3ac362431841e49f11d89865026c270b6ce189c0a064498c8c3481609ade170::swap {
    struct Bank has key {
        id: 0x2::object::UID,
        USD: 0x2::balance::Balance<0x722335fed7ef240e3890ef4bd8d77c26c633855d93f0388a6fafa7eb9fd59615::chara64d_coin::CHARA64D_COIN>,
        RMB: 0x2::balance::Balance<0x722335fed7ef240e3890ef4bd8d77c26c633855d93f0388a6fafa7eb9fd59615::chara64d_faucet_coin::CHARA64D_FAUCET_COIN>,
        rate: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit_RMB(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x722335fed7ef240e3890ef4bd8d77c26c633855d93f0388a6fafa7eb9fd59615::chara64d_faucet_coin::CHARA64D_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x722335fed7ef240e3890ef4bd8d77c26c633855d93f0388a6fafa7eb9fd59615::chara64d_faucet_coin::CHARA64D_FAUCET_COIN>(&mut arg0.RMB, 0x2::coin::into_balance<0x722335fed7ef240e3890ef4bd8d77c26c633855d93f0388a6fafa7eb9fd59615::chara64d_faucet_coin::CHARA64D_FAUCET_COIN>(arg1));
    }

    public entry fun deposit_USD(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x722335fed7ef240e3890ef4bd8d77c26c633855d93f0388a6fafa7eb9fd59615::chara64d_coin::CHARA64D_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x722335fed7ef240e3890ef4bd8d77c26c633855d93f0388a6fafa7eb9fd59615::chara64d_coin::CHARA64D_COIN>(&mut arg0.USD, 0x2::coin::into_balance<0x722335fed7ef240e3890ef4bd8d77c26c633855d93f0388a6fafa7eb9fd59615::chara64d_coin::CHARA64D_COIN>(arg1));
    }

    public fun get_rate(arg0: &Bank) : u64 {
        arg0.rate
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id   : 0x2::object::new(arg0),
            USD  : 0x2::balance::zero<0x722335fed7ef240e3890ef4bd8d77c26c633855d93f0388a6fafa7eb9fd59615::chara64d_coin::CHARA64D_COIN>(),
            RMB  : 0x2::balance::zero<0x722335fed7ef240e3890ef4bd8d77c26c633855d93f0388a6fafa7eb9fd59615::chara64d_faucet_coin::CHARA64D_FAUCET_COIN>(),
            rate : 7,
        };
        0x2::transfer::share_object<Bank>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun set_rate(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.rate = arg2;
    }

    public entry fun swap_rmb2usd(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x722335fed7ef240e3890ef4bd8d77c26c633855d93f0388a6fafa7eb9fd59615::chara64d_faucet_coin::CHARA64D_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x722335fed7ef240e3890ef4bd8d77c26c633855d93f0388a6fafa7eb9fd59615::chara64d_faucet_coin::CHARA64D_FAUCET_COIN>(&mut arg0.RMB, 0x2::coin::into_balance<0x722335fed7ef240e3890ef4bd8d77c26c633855d93f0388a6fafa7eb9fd59615::chara64d_faucet_coin::CHARA64D_FAUCET_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x722335fed7ef240e3890ef4bd8d77c26c633855d93f0388a6fafa7eb9fd59615::chara64d_coin::CHARA64D_COIN>>(0x2::coin::from_balance<0x722335fed7ef240e3890ef4bd8d77c26c633855d93f0388a6fafa7eb9fd59615::chara64d_coin::CHARA64D_COIN>(0x2::balance::split<0x722335fed7ef240e3890ef4bd8d77c26c633855d93f0388a6fafa7eb9fd59615::chara64d_coin::CHARA64D_COIN>(&mut arg0.USD, 0x2::coin::value<0x722335fed7ef240e3890ef4bd8d77c26c633855d93f0388a6fafa7eb9fd59615::chara64d_faucet_coin::CHARA64D_FAUCET_COIN>(&arg1) / arg0.rate), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_usd2rmb(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x722335fed7ef240e3890ef4bd8d77c26c633855d93f0388a6fafa7eb9fd59615::chara64d_coin::CHARA64D_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x722335fed7ef240e3890ef4bd8d77c26c633855d93f0388a6fafa7eb9fd59615::chara64d_coin::CHARA64D_COIN>(&mut arg0.USD, 0x2::coin::into_balance<0x722335fed7ef240e3890ef4bd8d77c26c633855d93f0388a6fafa7eb9fd59615::chara64d_coin::CHARA64D_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x722335fed7ef240e3890ef4bd8d77c26c633855d93f0388a6fafa7eb9fd59615::chara64d_faucet_coin::CHARA64D_FAUCET_COIN>>(0x2::coin::from_balance<0x722335fed7ef240e3890ef4bd8d77c26c633855d93f0388a6fafa7eb9fd59615::chara64d_faucet_coin::CHARA64D_FAUCET_COIN>(0x2::balance::split<0x722335fed7ef240e3890ef4bd8d77c26c633855d93f0388a6fafa7eb9fd59615::chara64d_faucet_coin::CHARA64D_FAUCET_COIN>(&mut arg0.RMB, 0x2::coin::value<0x722335fed7ef240e3890ef4bd8d77c26c633855d93f0388a6fafa7eb9fd59615::chara64d_coin::CHARA64D_COIN>(&arg1) * arg0.rate), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

