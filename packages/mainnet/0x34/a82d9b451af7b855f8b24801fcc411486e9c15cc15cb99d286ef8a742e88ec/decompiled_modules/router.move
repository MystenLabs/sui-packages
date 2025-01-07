module 0x34a82d9b451af7b855f8b24801fcc411486e9c15cc15cb99d286ef8a742e88ec::router {
    struct OrderRecord has copy, drop {
        order_id: u64,
        decimal: u8,
    }

    entry fun cetus_swap_a2b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: u64, arg9: u8, arg10: address, arg11: &mut 0x2::tx_context::TxContext) {
        0x34a82d9b451af7b855f8b24801fcc411486e9c15cc15cb99d286ef8a742e88ec::cetus_adapter::swap<T0, T1>(arg0, arg1, arg2, 0x1::vector::empty<0x2::coin::Coin<T1>>(), true, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        let v0 = OrderRecord{
            order_id : arg8,
            decimal  : arg9,
        };
        0x2::event::emit<OrderRecord>(v0);
    }

    entry fun cetus_swap_b2a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T1>>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: u64, arg9: u8, arg10: address, arg11: &mut 0x2::tx_context::TxContext) {
        0x34a82d9b451af7b855f8b24801fcc411486e9c15cc15cb99d286ef8a742e88ec::cetus_adapter::swap<T0, T1>(arg0, arg1, 0x1::vector::empty<0x2::coin::Coin<T0>>(), arg2, false, arg3, arg4, arg5, arg6, arg7, arg10, arg11);
        let v0 = OrderRecord{
            order_id : arg8,
            decimal  : arg9,
        };
        0x2::event::emit<OrderRecord>(v0);
    }

    entry fun suiswap_x_2_y<T0, T1>(arg0: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: address, arg7: u8, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_x_to_y_direct<T0, T1>(arg0, arg1, arg2, arg4, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, arg6);
        let v2 = OrderRecord{
            order_id : arg5,
            decimal  : arg7,
        };
        0x2::event::emit<OrderRecord>(v2);
    }

    entry fun suiswap_y_2_x<T0, T1>(arg0: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T1>>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: address, arg7: u8, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_y_to_x_direct<T0, T1>(arg0, arg1, arg2, arg4, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, arg6);
        let v2 = OrderRecord{
            order_id : arg5,
            decimal  : arg7,
        };
        0x2::event::emit<OrderRecord>(v2);
    }

    // decompiled from Move bytecode v6
}

