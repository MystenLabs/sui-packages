module 0x1544318803fb908844282a6ab6bcfb5e9db16907cdf1455a0e5418ae8cf140c7::faucet {
    struct Faucet has store, key {
        id: 0x2::object::UID,
        drop_amount: vector<u64>,
        interval: u64,
        usdc: 0x2::balance::Balance<0x1544318803fb908844282a6ab6bcfb5e9db16907cdf1455a0e5418ae8cf140c7::usdc::USDC>,
        usdt: 0x2::balance::Balance<0x1544318803fb908844282a6ab6bcfb5e9db16907cdf1455a0e5418ae8cf140c7::usdt::USDT>,
        weth: 0x2::balance::Balance<0x1544318803fb908844282a6ab6bcfb5e9db16907cdf1455a0e5418ae8cf140c7::weth::WETH>,
        wbtc: 0x2::balance::Balance<0x1544318803fb908844282a6ab6bcfb5e9db16907cdf1455a0e5418ae8cf140c7::wbtc::WBTC>,
        last_time: 0x2::table::Table<address, u64>,
    }

    public entry fun add_water(arg0: &mut 0x2::coin::TreasuryCap<0x1544318803fb908844282a6ab6bcfb5e9db16907cdf1455a0e5418ae8cf140c7::usdc::USDC>, arg1: &mut 0x2::coin::TreasuryCap<0x1544318803fb908844282a6ab6bcfb5e9db16907cdf1455a0e5418ae8cf140c7::usdt::USDT>, arg2: &mut 0x2::coin::TreasuryCap<0x1544318803fb908844282a6ab6bcfb5e9db16907cdf1455a0e5418ae8cf140c7::weth::WETH>, arg3: &mut 0x2::coin::TreasuryCap<0x1544318803fb908844282a6ab6bcfb5e9db16907cdf1455a0e5418ae8cf140c7::wbtc::WBTC>, arg4: &mut Faucet, arg5: vector<u64>) {
        assert!(0x1::vector::length<u64>(&arg5) == 4, 0);
        let v0 = &mut arg4.usdc;
        balance_join<0x1544318803fb908844282a6ab6bcfb5e9db16907cdf1455a0e5418ae8cf140c7::usdc::USDC>(arg0, v0, *0x1::vector::borrow<u64>(&arg5, 0));
        let v1 = &mut arg4.usdt;
        balance_join<0x1544318803fb908844282a6ab6bcfb5e9db16907cdf1455a0e5418ae8cf140c7::usdt::USDT>(arg1, v1, *0x1::vector::borrow<u64>(&arg5, 1));
        let v2 = &mut arg4.weth;
        balance_join<0x1544318803fb908844282a6ab6bcfb5e9db16907cdf1455a0e5418ae8cf140c7::weth::WETH>(arg2, v2, *0x1::vector::borrow<u64>(&arg5, 2));
        let v3 = &mut arg4.wbtc;
        balance_join<0x1544318803fb908844282a6ab6bcfb5e9db16907cdf1455a0e5418ae8cf140c7::wbtc::WBTC>(arg3, v3, *0x1::vector::borrow<u64>(&arg5, 3));
    }

    fun balance_join<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::balance::Balance<T0>, arg2: u64) {
        0x2::balance::join<T0>(arg1, 0x2::coin::mint_balance<T0>(arg0, arg2));
    }

    public entry fun get_water(arg0: &0x2::clock::Clock, arg1: &mut Faucet, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0;
        if (0x2::table::contains<address, u64>(&arg1.last_time, v0)) {
            v1 = 0x2::table::remove<address, u64>(&mut arg1.last_time, v0);
        };
        assert!(0x2::clock::timestamp_ms(arg0) - v1 > arg1.interval, 0);
        let v2 = &mut arg1.usdc;
        split_and_transfer<0x1544318803fb908844282a6ab6bcfb5e9db16907cdf1455a0e5418ae8cf140c7::usdc::USDC>(v2, 1, arg2);
        let v3 = &mut arg1.usdt;
        split_and_transfer<0x1544318803fb908844282a6ab6bcfb5e9db16907cdf1455a0e5418ae8cf140c7::usdt::USDT>(v3, 1, arg2);
        let v4 = &mut arg1.weth;
        split_and_transfer<0x1544318803fb908844282a6ab6bcfb5e9db16907cdf1455a0e5418ae8cf140c7::weth::WETH>(v4, 1, arg2);
        let v5 = &mut arg1.wbtc;
        split_and_transfer<0x1544318803fb908844282a6ab6bcfb5e9db16907cdf1455a0e5418ae8cf140c7::wbtc::WBTC>(v5, 1, arg2);
        0x2::table::add<address, u64>(&mut arg1.last_time, v0, 0x2::clock::timestamp_ms(arg0));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, 1000000000);
        0x1::vector::push_back<u64>(&mut v0, 1000000000);
        0x1::vector::push_back<u64>(&mut v0, 600000000);
        0x1::vector::push_back<u64>(&mut v0, 40000000);
        let v1 = Faucet{
            id          : 0x2::object::new(arg0),
            drop_amount : v0,
            interval    : 3600000,
            usdc        : 0x2::balance::zero<0x1544318803fb908844282a6ab6bcfb5e9db16907cdf1455a0e5418ae8cf140c7::usdc::USDC>(),
            usdt        : 0x2::balance::zero<0x1544318803fb908844282a6ab6bcfb5e9db16907cdf1455a0e5418ae8cf140c7::usdt::USDT>(),
            weth        : 0x2::balance::zero<0x1544318803fb908844282a6ab6bcfb5e9db16907cdf1455a0e5418ae8cf140c7::weth::WETH>(),
            wbtc        : 0x2::balance::zero<0x1544318803fb908844282a6ab6bcfb5e9db16907cdf1455a0e5418ae8cf140c7::wbtc::WBTC>(),
            last_time   : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<Faucet>(v1);
    }

    fun split_and_transfer<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg0, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

