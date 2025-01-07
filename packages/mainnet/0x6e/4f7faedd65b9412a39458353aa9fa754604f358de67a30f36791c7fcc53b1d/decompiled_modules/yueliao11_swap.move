module 0x6e4f7faedd65b9412a39458353aa9fa754604f358de67a30f36791c7fcc53b1d::yueliao11_swap {
    struct Pool has key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<0x4e4ca0ff3a45ec5a9f81abe87a2c87ca13c95b73a2007eeab1f1d92a5b704e5f::bright_faucet_coin::BRIGHT_FAUCET_COIN>,
        coin_b: 0x2::balance::Balance<0xc542cb63bd5b818c97a381cc9a9e412f39fc8931ea3b649d56a8ee160feb8809::bright_coin::BRIGHT_COIN>,
        lp_supply: 0x2::balance::Supply<LP>,
    }

    struct LP has drop {
        dummy_field: bool,
    }

    fun calculate_out_amount(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * (10000 - (30 as u128));
        ((v0 * (arg2 as u128) / ((arg1 as u128) * 10000 + v0)) as u64)
    }

    public entry fun create_pool(arg0: 0x2::coin::Coin<0x4e4ca0ff3a45ec5a9f81abe87a2c87ca13c95b73a2007eeab1f1d92a5b704e5f::bright_faucet_coin::BRIGHT_FAUCET_COIN>, arg1: 0x2::coin::Coin<0xc542cb63bd5b818c97a381cc9a9e412f39fc8931ea3b649d56a8ee160feb8809::bright_coin::BRIGHT_COIN>, arg2: &mut Pool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x4e4ca0ff3a45ec5a9f81abe87a2c87ca13c95b73a2007eeab1f1d92a5b704e5f::bright_faucet_coin::BRIGHT_FAUCET_COIN>(&arg0) > 0 && 0x2::coin::value<0xc542cb63bd5b818c97a381cc9a9e412f39fc8931ea3b649d56a8ee160feb8809::bright_coin::BRIGHT_COIN>(&arg1) > 0, 0);
        0x2::balance::join<0x4e4ca0ff3a45ec5a9f81abe87a2c87ca13c95b73a2007eeab1f1d92a5b704e5f::bright_faucet_coin::BRIGHT_FAUCET_COIN>(&mut arg2.coin_a, 0x2::coin::into_balance<0x4e4ca0ff3a45ec5a9f81abe87a2c87ca13c95b73a2007eeab1f1d92a5b704e5f::bright_faucet_coin::BRIGHT_FAUCET_COIN>(arg0));
        0x2::balance::join<0xc542cb63bd5b818c97a381cc9a9e412f39fc8931ea3b649d56a8ee160feb8809::bright_coin::BRIGHT_COIN>(&mut arg2.coin_b, 0x2::coin::into_balance<0xc542cb63bd5b818c97a381cc9a9e412f39fc8931ea3b649d56a8ee160feb8809::bright_coin::BRIGHT_COIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LP{dummy_field: false};
        let v1 = Pool{
            id        : 0x2::object::new(arg0),
            coin_a    : 0x2::balance::zero<0x4e4ca0ff3a45ec5a9f81abe87a2c87ca13c95b73a2007eeab1f1d92a5b704e5f::bright_faucet_coin::BRIGHT_FAUCET_COIN>(),
            coin_b    : 0x2::balance::zero<0xc542cb63bd5b818c97a381cc9a9e412f39fc8931ea3b649d56a8ee160feb8809::bright_coin::BRIGHT_COIN>(),
            lp_supply : 0x2::balance::create_supply<LP>(v0),
        };
        0x2::transfer::share_object<Pool>(v1);
    }

    public entry fun swap_a_to_b(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x4e4ca0ff3a45ec5a9f81abe87a2c87ca13c95b73a2007eeab1f1d92a5b704e5f::bright_faucet_coin::BRIGHT_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x4e4ca0ff3a45ec5a9f81abe87a2c87ca13c95b73a2007eeab1f1d92a5b704e5f::bright_faucet_coin::BRIGHT_FAUCET_COIN>(&arg1);
        assert!(v0 > 0, 0);
        0x2::balance::join<0x4e4ca0ff3a45ec5a9f81abe87a2c87ca13c95b73a2007eeab1f1d92a5b704e5f::bright_faucet_coin::BRIGHT_FAUCET_COIN>(&mut arg0.coin_a, 0x2::coin::into_balance<0x4e4ca0ff3a45ec5a9f81abe87a2c87ca13c95b73a2007eeab1f1d92a5b704e5f::bright_faucet_coin::BRIGHT_FAUCET_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc542cb63bd5b818c97a381cc9a9e412f39fc8931ea3b649d56a8ee160feb8809::bright_coin::BRIGHT_COIN>>(0x2::coin::take<0xc542cb63bd5b818c97a381cc9a9e412f39fc8931ea3b649d56a8ee160feb8809::bright_coin::BRIGHT_COIN>(&mut arg0.coin_b, calculate_out_amount(v0, 0x2::balance::value<0x4e4ca0ff3a45ec5a9f81abe87a2c87ca13c95b73a2007eeab1f1d92a5b704e5f::bright_faucet_coin::BRIGHT_FAUCET_COIN>(&arg0.coin_a), 0x2::balance::value<0xc542cb63bd5b818c97a381cc9a9e412f39fc8931ea3b649d56a8ee160feb8809::bright_coin::BRIGHT_COIN>(&arg0.coin_b)), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_b_to_a(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xc542cb63bd5b818c97a381cc9a9e412f39fc8931ea3b649d56a8ee160feb8809::bright_coin::BRIGHT_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xc542cb63bd5b818c97a381cc9a9e412f39fc8931ea3b649d56a8ee160feb8809::bright_coin::BRIGHT_COIN>(&arg1);
        assert!(v0 > 0, 0);
        0x2::balance::join<0xc542cb63bd5b818c97a381cc9a9e412f39fc8931ea3b649d56a8ee160feb8809::bright_coin::BRIGHT_COIN>(&mut arg0.coin_b, 0x2::coin::into_balance<0xc542cb63bd5b818c97a381cc9a9e412f39fc8931ea3b649d56a8ee160feb8809::bright_coin::BRIGHT_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4e4ca0ff3a45ec5a9f81abe87a2c87ca13c95b73a2007eeab1f1d92a5b704e5f::bright_faucet_coin::BRIGHT_FAUCET_COIN>>(0x2::coin::take<0x4e4ca0ff3a45ec5a9f81abe87a2c87ca13c95b73a2007eeab1f1d92a5b704e5f::bright_faucet_coin::BRIGHT_FAUCET_COIN>(&mut arg0.coin_a, calculate_out_amount(v0, 0x2::balance::value<0xc542cb63bd5b818c97a381cc9a9e412f39fc8931ea3b649d56a8ee160feb8809::bright_coin::BRIGHT_COIN>(&arg0.coin_b), 0x2::balance::value<0x4e4ca0ff3a45ec5a9f81abe87a2c87ca13c95b73a2007eeab1f1d92a5b704e5f::bright_faucet_coin::BRIGHT_FAUCET_COIN>(&arg0.coin_a)), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

