module 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order_manager {
    public fun cancel_ft_order<T0: store + key, T1>(arg0: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::state::State, arg1: &mut 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::registry::Registry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::state::assert_version(arg0);
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::state::assert_not_paused(arg0);
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::orderbook::cancel_ft_order<T0, T1>(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::registry::borrow_mut_book<T0, T1>(arg1), arg2, arg3)
    }

    public fun cancel_ft_orders<T0: store + key, T1>(arg0: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::state::State, arg1: &mut 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::registry::Registry, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::state::assert_version(arg0);
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::state::assert_not_paused(arg0);
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::orderbook::cancel_ft_orders<T0, T1>(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::registry::borrow_mut_book<T0, T1>(arg1), arg2, arg3)
    }

    public fun cancel_nft_order<T0: store + key, T1>(arg0: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::state::State, arg1: &mut 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::registry::Registry, arg2: u64, arg3: &0x2::tx_context::TxContext) : T0 {
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::state::assert_version(arg0);
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::state::assert_not_paused(arg0);
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::orderbook::cancel_nft_order<T0, T1>(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::registry::borrow_mut_book<T0, T1>(arg1), arg2, arg3)
    }

    public fun cancel_nft_orders<T0: store + key, T1>(arg0: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::state::State, arg1: &mut 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::registry::Registry, arg2: vector<u64>, arg3: &0x2::tx_context::TxContext) : vector<T0> {
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::state::assert_version(arg0);
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::state::assert_not_paused(arg0);
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::orderbook::cancel_nft_orders<T0, T1>(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::registry::borrow_mut_book<T0, T1>(arg1), arg2, arg3)
    }

    public fun create_order_ft_to_nft<T0: store + key, T1>(arg0: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::state::State, arg1: &mut 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::registry::Registry, arg2: 0x1::option::Option<u64>, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: 0x1::option::Option<0x2::object::ID>, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::state::assert_version(arg0);
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::state::assert_not_paused(arg0);
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::orderbook::create_order_ft_to_nft<T0, T1>(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::registry::borrow_mut_book<T0, T1>(arg1), 0x1::option::get_with_default<u64>(&arg2, 0x2::clock::timestamp_ms(arg7)), arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun create_order_nft_to_ft<T0: store + key, T1>(arg0: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::state::State, arg1: &mut 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::registry::Registry, arg2: 0x1::option::Option<u64>, arg3: u64, arg4: T0, arg5: u64, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::state::assert_version(arg0);
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::state::assert_not_paused(arg0);
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::orderbook::create_order_nft_to_ft<T0, T1>(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::registry::borrow_mut_book<T0, T1>(arg1), 0x1::option::get_with_default<u64>(&arg2, 0x2::clock::timestamp_ms(arg7)), arg3, arg4, arg5, arg6, arg7, arg8);
    }

    // decompiled from Move bytecode v6
}

