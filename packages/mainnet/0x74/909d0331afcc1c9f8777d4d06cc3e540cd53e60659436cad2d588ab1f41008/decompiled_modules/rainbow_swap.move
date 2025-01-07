module 0x74909d0331afcc1c9f8777d4d06cc3e540cd53e60659436cad2d588ab1f41008::rainbow_swap {
    struct Bank has key {
        id: 0x2::object::UID,
        NB: 0x2::balance::Balance<0x4280d7b4218d048382b33c5e4ca907f69d140e3c4bb529d2ab6faa04f10f313f::faucet_coin::FAUCET_COIN>,
        BULL_COIN: 0x2::balance::Balance<0x5141c8439abcb4504de35932fa4bb97f08cb572e789203451291d54d294f2751::my_coin::MY_COIN>,
        rate: u64,
        service_charge: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun deposit_BULL_COIN(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x5141c8439abcb4504de35932fa4bb97f08cb572e789203451291d54d294f2751::my_coin::MY_COIN>) {
        0x2::balance::join<0x5141c8439abcb4504de35932fa4bb97f08cb572e789203451291d54d294f2751::my_coin::MY_COIN>(&mut arg0.BULL_COIN, 0x2::coin::into_balance<0x5141c8439abcb4504de35932fa4bb97f08cb572e789203451291d54d294f2751::my_coin::MY_COIN>(arg1));
    }

    public fun deposit_NB(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x4280d7b4218d048382b33c5e4ca907f69d140e3c4bb529d2ab6faa04f10f313f::faucet_coin::FAUCET_COIN>) {
        0x2::balance::join<0x4280d7b4218d048382b33c5e4ca907f69d140e3c4bb529d2ab6faa04f10f313f::faucet_coin::FAUCET_COIN>(&mut arg0.NB, 0x2::coin::into_balance<0x4280d7b4218d048382b33c5e4ca907f69d140e3c4bb529d2ab6faa04f10f313f::faucet_coin::FAUCET_COIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id             : 0x2::object::new(arg0),
            NB             : 0x2::balance::zero<0x4280d7b4218d048382b33c5e4ca907f69d140e3c4bb529d2ab6faa04f10f313f::faucet_coin::FAUCET_COIN>(),
            BULL_COIN      : 0x2::balance::zero<0x5141c8439abcb4504de35932fa4bb97f08cb572e789203451291d54d294f2751::my_coin::MY_COIN>(),
            rate           : 2,
            service_charge : 10,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Bank>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun set_rate(arg0: &AdminCap, arg1: &mut Bank, arg2: u64) {
        arg1.rate = arg2;
    }

    public fun set_service_charge(arg0: &AdminCap, arg1: &mut Bank, arg2: u64) {
        arg1.service_charge = arg2;
    }

    public entry fun swap_BULL_COIN_to_NB(arg0: &mut Bank, arg1: &mut 0x2::coin::Coin<0x5141c8439abcb4504de35932fa4bb97f08cb572e789203451291d54d294f2751::my_coin::MY_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = (arg2 - arg2 / 100 * arg0.service_charge) / arg0.rate;
        let v1 = 0x2::coin::balance_mut<0x5141c8439abcb4504de35932fa4bb97f08cb572e789203451291d54d294f2751::my_coin::MY_COIN>(arg1);
        assert!(0x2::balance::value<0x4280d7b4218d048382b33c5e4ca907f69d140e3c4bb529d2ab6faa04f10f313f::faucet_coin::FAUCET_COIN>(&arg0.NB) > v0, 0);
        assert!(0x2::balance::value<0x5141c8439abcb4504de35932fa4bb97f08cb572e789203451291d54d294f2751::my_coin::MY_COIN>(v1) > arg2, 1);
        0x2::balance::join<0x5141c8439abcb4504de35932fa4bb97f08cb572e789203451291d54d294f2751::my_coin::MY_COIN>(&mut arg0.BULL_COIN, 0x2::balance::split<0x5141c8439abcb4504de35932fa4bb97f08cb572e789203451291d54d294f2751::my_coin::MY_COIN>(v1, arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4280d7b4218d048382b33c5e4ca907f69d140e3c4bb529d2ab6faa04f10f313f::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0x4280d7b4218d048382b33c5e4ca907f69d140e3c4bb529d2ab6faa04f10f313f::faucet_coin::FAUCET_COIN>(0x2::balance::split<0x4280d7b4218d048382b33c5e4ca907f69d140e3c4bb529d2ab6faa04f10f313f::faucet_coin::FAUCET_COIN>(&mut arg0.NB, v0), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_NB_to_BULL_COIN(arg0: &mut Bank, arg1: &mut 0x2::coin::Coin<0x4280d7b4218d048382b33c5e4ca907f69d140e3c4bb529d2ab6faa04f10f313f::faucet_coin::FAUCET_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = (arg2 - arg2 / 100 * arg0.service_charge) * arg0.rate;
        let v1 = 0x2::coin::balance_mut<0x4280d7b4218d048382b33c5e4ca907f69d140e3c4bb529d2ab6faa04f10f313f::faucet_coin::FAUCET_COIN>(arg1);
        assert!(0x2::balance::value<0x4280d7b4218d048382b33c5e4ca907f69d140e3c4bb529d2ab6faa04f10f313f::faucet_coin::FAUCET_COIN>(&arg0.NB) > v0, 0);
        assert!(0x2::balance::value<0x4280d7b4218d048382b33c5e4ca907f69d140e3c4bb529d2ab6faa04f10f313f::faucet_coin::FAUCET_COIN>(v1) > arg2, 1);
        0x2::balance::join<0x4280d7b4218d048382b33c5e4ca907f69d140e3c4bb529d2ab6faa04f10f313f::faucet_coin::FAUCET_COIN>(&mut arg0.NB, 0x2::balance::split<0x4280d7b4218d048382b33c5e4ca907f69d140e3c4bb529d2ab6faa04f10f313f::faucet_coin::FAUCET_COIN>(v1, arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5141c8439abcb4504de35932fa4bb97f08cb572e789203451291d54d294f2751::my_coin::MY_COIN>>(0x2::coin::from_balance<0x5141c8439abcb4504de35932fa4bb97f08cb572e789203451291d54d294f2751::my_coin::MY_COIN>(0x2::balance::split<0x5141c8439abcb4504de35932fa4bb97f08cb572e789203451291d54d294f2751::my_coin::MY_COIN>(&mut arg0.BULL_COIN, v0), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

