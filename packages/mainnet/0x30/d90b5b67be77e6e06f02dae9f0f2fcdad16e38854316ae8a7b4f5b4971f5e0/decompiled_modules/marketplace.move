module 0x3164fcf73eb6b41ff3d2129346141bd68469964c2d95a5b1533e8d16e6ea6e13::marketplace {
    struct MarketPlace<phantom T0> has store, key {
        id: 0x2::object::UID,
        beneficiary: address,
        fee_bps: u64,
        profit: 0x2::balance::Balance<T0>,
    }

    public fun calc_market_fee<T0>(arg0: &MarketPlace<T0>, arg1: u64) : u64 {
        0x1::fixed_point32::multiply_u64(arg1, 0x1::fixed_point32::create_from_rational(arg0.fee_bps, 10000))
    }

    public entry fun create_market<T0>(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketPlace<T0>{
            id          : 0x2::object::new(arg2),
            beneficiary : arg0,
            fee_bps     : arg1,
            profit      : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::public_share_object<MarketPlace<T0>>(v0);
    }

    public fun deposit_profit<T0>(arg0: &mut MarketPlace<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.profit, arg1);
    }

    public fun get_beneficiary<T0>(arg0: &MarketPlace<T0>) : address {
        arg0.beneficiary
    }

    public fun get_profit<T0>(arg0: &MarketPlace<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.profit)
    }

    public fun update_market<T0>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &0x2::package::Publisher, arg2: &mut MarketPlace<T0>, arg3: u64, arg4: address) {
        0x3164fcf73eb6b41ff3d2129346141bd68469964c2d95a5b1533e8d16e6ea6e13::utils::check_version(arg0);
        assert!(0x2::package::from_package<MarketPlace<T0>>(arg1), 1);
        arg2.fee_bps = arg3;
        arg2.beneficiary = arg4;
    }

    public fun withdraw_profit<T0>(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &mut MarketPlace<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x3164fcf73eb6b41ff3d2129346141bd68469964c2d95a5b1533e8d16e6ea6e13::utils::check_version(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg1.beneficiary, 1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.profit, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

