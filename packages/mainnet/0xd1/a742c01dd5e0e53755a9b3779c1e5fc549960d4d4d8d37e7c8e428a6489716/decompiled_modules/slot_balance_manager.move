module 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot_balance_manager {
    struct Deposit has copy, drop, store {
        to: address,
        base_token_amount: u64,
    }

    struct Withdraw has copy, drop, store {
        to: address,
        token: 0x1::ascii::String,
        amount: u64,
    }

    public entry fun deposit_amm<T0>(arg0: &mut 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot::Slot, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg4: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg5: u8, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::dex_utils::not_base<T0>();
        let (v0, v1) = 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot_swap_amm::swap_base_amm_no_fees<T0>(0x2::coin::zero<0x2::sui::SUI>(arg7), arg1, 0, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
        deposit_base(arg0, v0);
    }

    public entry fun deposit_base(arg0: &mut 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot::Slot, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = Deposit{
            to                : 0x2::object::id_address<0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot::Slot>(arg0),
            base_token_amount : 0x2::coin::value<0x2::sui::SUI>(&arg1),
        };
        0x2::event::emit<Deposit>(v0);
        0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot::add_to_balance<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public entry fun deposit_cetus<T0>(arg0: &mut 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot::Slot, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::dex_utils::not_base<T0>();
        let (v0, v1) = 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::cetus_clmm_protocol::swap<T0, 0x2::sui::SUI>(arg2, arg1, 0x2::coin::zero<0x2::sui::SUI>(arg5), arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg5));
        deposit_base(arg0, v1);
    }

    public entry fun deposit_flow_x_clmm<T0>(arg0: &mut 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot::Slot, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::dex_utils::not_base<T0>();
        let (v0, v1) = 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::flow_x_clmm_protocol::swap<T0, 0x2::sui::SUI>(arg2, arg1, 0x2::coin::zero<0x2::sui::SUI>(arg5), arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg5));
        deposit_base(arg0, v1);
    }

    public entry fun deposit_turbos<T0, T1>(arg0: &mut 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot::Slot, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::dex_utils::not_base<T0>();
        let (v0, v1) = 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::turbos_clmm_protocol::swap<T0, 0x2::sui::SUI, T1>(arg2, arg1, 0x2::coin::zero<0x2::sui::SUI>(arg5), arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg5));
        deposit_base(arg0, v1);
    }

    public entry fun withdraw_amm<T0>(arg0: &mut 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot::Slot, arg1: u64, arg2: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg4: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg5: u8, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::dex_utils::not_base<T0>();
        let (v0, v1) = 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot_swap_amm::swap_base_amm_no_fees<T0>(0x2::coin::zero<0x2::sui::SUI>(arg7), 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot::take_from_balance_with_sender<T0>(arg0, arg1, arg7), 0, arg2, arg3, arg4, arg5, arg6, arg7);
        0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot::add_to_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v1));
        withdraw_base_internal<0x2::sui::SUI>(v0, arg7);
    }

    public entry fun withdraw_base(arg0: &mut 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot::Slot, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        withdraw_base_internal<0x2::sui::SUI>(0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot::take_from_balance_with_sender<0x2::sui::SUI>(arg0, arg1, arg2), arg2);
    }

    fun withdraw_base_internal<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::tx_context::TxContext) {
        let v0 = Withdraw{
            to     : 0x2::tx_context::sender(arg1),
            token  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            amount : 0x2::coin::value<0x2::sui::SUI>(&arg0),
        };
        0x2::event::emit<Withdraw>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg1));
    }

    public entry fun withdraw_cetus<T0>(arg0: &mut 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot::Slot, arg1: u64, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::dex_utils::not_base<T0>();
        let (v0, v1) = 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::cetus_clmm_protocol::swap<T0, 0x2::sui::SUI>(arg2, 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot::take_from_balance_with_sender<T0>(arg0, arg1, arg5), 0x2::coin::zero<0x2::sui::SUI>(arg5), arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg5));
        withdraw_base_internal<0x2::sui::SUI>(v1, arg5);
    }

    public entry fun withdraw_flow_x_clmm<T0>(arg0: &mut 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot::Slot, arg1: u64, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::dex_utils::not_base<T0>();
        let (v0, v1) = 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::flow_x_clmm_protocol::swap<T0, 0x2::sui::SUI>(arg2, 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot::take_from_balance_with_sender<T0>(arg0, arg1, arg5), 0x2::coin::zero<0x2::sui::SUI>(arg5), arg3, arg4, arg5);
        0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot::add_to_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v0));
        withdraw_base_internal<0x2::sui::SUI>(v1, arg5);
    }

    public entry fun withdraw_turbos<T0, T1>(arg0: &mut 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot::Slot, arg1: u64, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::dex_utils::not_base<T0>();
        let (v0, v1) = 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::turbos_clmm_protocol::swap<T0, 0x2::sui::SUI, T1>(arg2, 0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot::take_from_balance_with_sender<T0>(arg0, arg1, arg5), 0x2::coin::zero<0x2::sui::SUI>(arg5), arg3, arg4, arg5);
        0xd1a742c01dd5e0e53755a9b3779c1e5fc549960d4d4d8d37e7c8e428a6489716::slot::add_to_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v0));
        withdraw_base_internal<0x2::sui::SUI>(v1, arg5);
    }

    // decompiled from Move bytecode v6
}

