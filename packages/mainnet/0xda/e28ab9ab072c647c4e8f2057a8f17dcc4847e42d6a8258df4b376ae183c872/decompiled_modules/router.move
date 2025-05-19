module 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::router {
    public entry fun add_liquidity<T0, T1>(arg0: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg1: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_version(arg0);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_is_normal(arg0);
        let (v0, v1) = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::core::add_liquidity<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = v1;
        assert!(0x1::vector::length<u64>(&v2) == 3, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::LP<T0, T1>>>(v0, 0x2::tx_context::sender(arg6));
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::event::add_liquidity_event(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::comparator::get_lp_name<T0, T1>(), 0x1::vector::pop_back<u64>(&mut v2), 0x1::vector::pop_back<u64>(&mut v2), 0x1::vector::pop_back<u64>(&mut v2));
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg1: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg2: 0x2::coin::Coin<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::LP<T0, T1>>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_version(arg0);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_is_normal(arg0);
        let (v0, v1, v2) = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::core::remove_liquidity<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6);
        let v3 = v1;
        let v4 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, 0x2::tx_context::sender(arg6));
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::event::removed_liquidity_event(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::comparator::get_lp_name<T0, T1>(), 0x2::coin::value<T0>(&v4), 0x2::coin::value<T1>(&v3), v2);
    }

    public entry fun swap_exact_x_to_y<T0, T1>(arg0: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg1: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_version(arg0);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_is_normal(arg0);
        let (v0, v1, v2, v3, v4) = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::core::swap_exact_x_to_y<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, 0x2::tx_context::sender(arg4));
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::event::swap_event(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::comparator::get_lp_name<T0, T1>(), v0, 0, 0, v1, v2, v3);
    }

    public entry fun swap_exact_y_to_x<T0, T1>(arg0: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg1: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_version(arg0);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_is_normal(arg0);
        let (v0, v1, v2, v3, v4) = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::core::swap_exact_y_to_x<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg4));
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::event::swap_event(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::comparator::get_lp_name<T0, T1>(), 0, v1, v0, 0, v2, v3);
    }

    public entry fun swap_x_to_exact_y<T0, T1>(arg0: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg1: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_version(arg0);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_is_normal(arg0);
        let (v0, _, v2, v3, v4, v5) = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::core::swap_x_to_exact_y<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        let v6 = v5;
        if (0x2::coin::value<T0>(&v6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::destroy_zero<T0>(v6);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, 0x2::tx_context::sender(arg4));
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::event::swap_event(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::comparator::get_lp_name<T0, T1>(), v0, 0, 0, arg3, v2, v3);
    }

    public entry fun swap_y_to_exact_x<T0, T1>(arg0: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg1: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_version(arg0);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_is_normal(arg0);
        let (v0, _, v2, v3, v4, v5) = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::core::swap_y_to_exact_x<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        let v6 = v5;
        if (0x2::coin::value<T1>(&v6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v6, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::destroy_zero<T1>(v6);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg4));
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::event::swap_event(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::comparator::get_lp_name<T0, T1>(), 0, arg3, v0, 0, v2, v3);
    }

    public fun swap_exact_x_to_y_with_return<T0, T1>(arg0: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg1: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_version(arg0);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_is_normal(arg0);
        let (v0, v1, v2, v3, v4) = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::core::swap_exact_x_to_y<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::event::swap_event(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::comparator::get_lp_name<T0, T1>(), v0, 0, 0, v1, v2, v3);
        v4
    }

    public fun swap_exact_y_to_x_with_return<T0, T1>(arg0: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg1: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_version(arg0);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_is_normal(arg0);
        let (v0, v1, v2, v3, v4) = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::core::swap_exact_y_to_x<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::event::swap_event(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::comparator::get_lp_name<T0, T1>(), 0, v1, v0, 0, v2, v3);
        v4
    }

    public fun swap_x_to_exact_y_with_return<T0, T1>(arg0: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg1: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_version(arg0);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_is_normal(arg0);
        let (v0, _, v2, v3, v4, v5) = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::core::swap_x_to_exact_y<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::event::swap_event(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::comparator::get_lp_name<T0, T1>(), v0, 0, 0, arg3, v2, v3);
        (v4, v5)
    }

    public fun swap_y_to_exact_x_with_return<T0, T1>(arg0: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg1: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_version(arg0);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_is_normal(arg0);
        let (v0, _, v2, v3, v4, v5) = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::core::swap_y_to_exact_x<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::event::swap_event(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::comparator::get_lp_name<T0, T1>(), 0, arg3, v0, 0, v2, v3);
        (v4, v5)
    }

    // decompiled from Move bytecode v6
}

