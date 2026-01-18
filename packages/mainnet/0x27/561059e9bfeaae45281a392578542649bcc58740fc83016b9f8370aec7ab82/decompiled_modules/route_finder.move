module 0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::route_finder {
    struct QuoteResult has drop, store {
        amount_out: u64,
        path: vector<u8>,
    }

    struct QuoteEvent has copy, drop, store {
        amount_out: u64,
        path: vector<u8>,
    }

    fun assert_deadline(arg0: &0x2::clock::Clock, arg1: u64) {
        assert!(0x2::clock::timestamp_ms(arg0) <= arg1, 0);
    }

    fun assert_min_output<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
    }

    fun emit_quote_event(arg0: QuoteResult) {
        let QuoteResult {
            amount_out : v0,
            path       : v1,
        } = arg0;
        let v2 = QuoteEvent{
            amount_out : v0,
            path       : v1,
        };
        0x2::event::emit<QuoteEvent>(v2);
    }

    public fun quote_best_cetus_exact_in<T0, T1, T2>(arg0: &0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::registry::Registry, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: u64) : QuoteResult {
        let v0 = quote_cetus_direct_exact_in<T0, T2>(arg0, arg1, arg4);
        let v1 = quote_cetus_via_base_exact_in<T0, T1, T2>(arg0, arg2, arg3, arg4);
        if (v0.amount_out >= v1.amount_out) {
            v0
        } else {
            v1
        }
    }

    public fun quote_cetus_direct_exact_in<T0, T1>(arg0: &0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::registry::Registry, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64) : QuoteResult {
        0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::registry::assert_pool<T0, T1>(arg0, 0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::registry::dex_cetus());
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, true, true, arg2);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v1, 0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::router::dex_cetus());
        QuoteResult{
            amount_out : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0),
            path       : v1,
        }
    }

    entry fun quote_cetus_direct_exact_in_entry<T0, T1>(arg0: &0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::registry::Registry, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64) {
        emit_quote_event(quote_cetus_direct_exact_in<T0, T1>(arg0, arg1, arg2));
    }

    public fun quote_cetus_direct_exact_in_reverse<T0, T1>(arg0: &0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::registry::Registry, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: u64) : QuoteResult {
        0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::registry::assert_pool<T1, T0>(arg0, 0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::registry::dex_cetus());
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T0>(arg1, false, true, arg2);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v1, 0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::router::dex_cetus());
        QuoteResult{
            amount_out : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0),
            path       : v1,
        }
    }

    public fun quote_cetus_via_base_exact_in<T0, T1, T2>(arg0: &0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::registry::Registry, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: u64) : QuoteResult {
        0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::registry::assert_base_token<T1>(arg0);
        0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::registry::assert_pool<T0, T1>(arg0, 0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::registry::dex_cetus());
        0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::registry::assert_pool<T1, T2>(arg0, 0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::registry::dex_cetus());
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, true, true, arg3);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T2>(arg2, true, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0));
        let v2 = 0x1::vector::empty<u8>();
        let v3 = &mut v2;
        0x1::vector::push_back<u8>(v3, 0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::router::dex_cetus());
        0x1::vector::push_back<u8>(v3, 0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::router::dex_cetus());
        QuoteResult{
            amount_out : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v1),
            path       : v2,
        }
    }

    entry fun quote_cetus_via_base_exact_in_entry<T0, T1, T2>(arg0: &0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::registry::Registry, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: u64) {
        emit_quote_event(quote_cetus_via_base_exact_in<T0, T1, T2>(arg0, arg1, arg2, arg3));
    }

    public fun swap_best_cetus_exact_in<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: &0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::registry::Registry, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_deadline(arg6, arg8);
        let v0 = quote_best_cetus_exact_in<T0, T1, T2>(arg1, arg3, arg4, arg5, 0x2::coin::value<T0>(&arg0));
        assert!(v0.amount_out >= arg7, 1);
        let v1 = if (0x1::vector::length<u8>(&v0.path) == 1) {
            0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::cetus_adapter::swap_a2b<T0, T2>(arg0, arg2, arg3, arg6, arg9)
        } else {
            assert!(0x1::vector::length<u8>(&v0.path) == 2, 2);
            0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::cetus_adapter::swap_a2b<T1, T2>(0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::cetus_adapter::swap_a2b<T0, T1>(arg0, arg2, arg4, arg6, arg9), arg2, arg5, arg6, arg9)
        };
        let v2 = v1;
        assert_min_output<T2>(&v2, arg7);
        v2
    }

    entry fun swap_best_cetus_exact_in_entry<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: &0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::registry::Registry, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg6: &0x2::clock::Clock, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_best_cetus_exact_in<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, 0x2::tx_context::sender(arg9));
    }

    public fun swap_cetus_via_base_exact_in<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: &0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::registry::Registry, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_deadline(arg5, arg7);
        0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::registry::assert_base_token<T1>(arg1);
        0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::registry::assert_pool<T0, T1>(arg1, 0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::registry::dex_cetus());
        0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::registry::assert_pool<T1, T2>(arg1, 0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::registry::dex_cetus());
        let v0 = 0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::cetus_adapter::swap_a2b<T1, T2>(0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::cetus_adapter::swap_a2b<T0, T1>(arg0, arg2, arg3, arg5, arg8), arg2, arg4, arg5, arg8);
        assert_min_output<T2>(&v0, arg6);
        v0
    }

    entry fun swap_cetus_via_base_exact_in_entry<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: &0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::registry::Registry, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_cetus_via_base_exact_in<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, 0x2::tx_context::sender(arg8));
    }

    public fun swap_cetus_via_base_exact_in_reverse<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: &0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::registry::Registry, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_deadline(arg5, arg7);
        0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::registry::assert_base_token<T1>(arg1);
        0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::registry::assert_pool<T1, T0>(arg1, 0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::registry::dex_cetus());
        0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::registry::assert_pool<T2, T1>(arg1, 0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::registry::dex_cetus());
        let v0 = 0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::cetus_adapter::swap_b2a<T2, T1>(0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::cetus_adapter::swap_b2a<T1, T0>(arg0, arg2, arg3, arg5, arg8), arg2, arg4, arg5, arg8);
        assert_min_output<T2>(&v0, arg6);
        v0
    }

    entry fun swap_cetus_via_base_exact_in_reverse_entry<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: &0xd2061fa306c7cfbc755128642a501d72fd8bea57363775ebb794fbf6690d33f2::registry::Registry, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_cetus_via_base_exact_in_reverse<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, 0x2::tx_context::sender(arg8));
    }

    // decompiled from Move bytecode v6
}

