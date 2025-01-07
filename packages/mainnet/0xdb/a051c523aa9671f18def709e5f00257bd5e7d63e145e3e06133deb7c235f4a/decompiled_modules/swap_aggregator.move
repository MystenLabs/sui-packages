module 0xdba051c523aa9671f18def709e5f00257bd5e7d63e145e3e06133deb7c235f4a::swap_aggregator {
    struct TimeEvent has copy, drop {
        timestamp_ms: u64,
    }

    struct InitiateSwapEvent has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        steps: u64,
    }

    struct TerminateSwapEvent has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun cetus_swap_x_to_y<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, arg3, arg5, arg6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0xdba051c523aa9671f18def709e5f00257bd5e7d63e145e3e06133deb7c235f4a::utils::merge_coins<T0>(arg2, arg7)), 0x2::balance::zero<T1>(), v2);
        0x2::balance::destroy_zero<T0>(v0);
        0x2::coin::from_balance<T1>(v1, arg7)
    }

    public fun cetus_swap_y_to_x<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg3, arg5, arg6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0xdba051c523aa9671f18def709e5f00257bd5e7d63e145e3e06133deb7c235f4a::utils::merge_coins<T1>(arg2, arg7)), v2);
        0x2::balance::destroy_zero<T1>(v1);
        0x2::coin::from_balance<T0>(v0, arg7)
    }

    public fun initiate_swap<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = InitiateSwapEvent{
            coin_type : 0x1::type_name::get<T0>(),
            amount    : arg1,
            steps     : arg2,
        };
        0x2::event::emit<InitiateSwapEvent>(v0);
        0xdba051c523aa9671f18def709e5f00257bd5e7d63e145e3e06133deb7c235f4a::utils::split_coins_and_transfer_rest<T0>(arg0, arg1, arg3, arg4)
    }

    public fun terminate_swap<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        let v0 = 0x2::coin::value<T0>(arg0);
        let v1 = TerminateSwapEvent{
            coin_type : 0x1::type_name::get<T0>(),
            amount    : v0,
        };
        0x2::event::emit<TerminateSwapEvent>(v1);
        assert!(v0 >= arg1, 134008);
    }

    // decompiled from Move bytecode v6
}

