module 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::subscription {
    struct CollectorCap has store, key {
        id: 0x2::object::UID,
    }

    struct Payment has copy, drop, store {
        payment_info: 0x1::ascii::String,
        amount: u64,
    }

    struct CollectorUpdated has copy, drop, store {
        new_collector: address,
    }

    public entry fun collect_amm<T0>(arg0: &CollectorCap, arg1: &mut 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::slot::Slot, arg2: u64, arg3: u64, arg4: &mut 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::bank::Bank, arg5: &mut 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::fee::FeeManager, arg6: u64, arg7: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg8: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg9: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg10: u8, arg11: 0x1::ascii::String, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<0x2::sui::SUI>(arg13);
        let v1 = take_from_slot_for_subscription<T0>(arg1, arg2, true, arg13);
        let (v2, v3) = 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::slot_swap_amm::swap_base_amm_no_fees<T0>(v0, v1, arg3, arg7, arg8, arg9, arg10, arg12, arg13);
        0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::slot::add_to_balance<T0>(arg1, 0x2::coin::into_balance<T0>(v3));
        split_and_pay_with_sui(v2, arg4, arg5, arg6, arg11, arg13);
    }

    public entry fun collect_cetus<T0>(arg0: &CollectorCap, arg1: &mut 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::slot::Slot, arg2: u64, arg3: &mut 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::bank::Bank, arg4: &mut 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::fee::FeeManager, arg5: u64, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: 0x1::ascii::String, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = take_from_slot_for_subscription<T0>(arg1, arg2, true, arg10);
        let (v1, v2) = 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::cetus_clmm_protocol::swap<T0, 0x2::sui::SUI>(arg6, v0, 0x2::coin::zero<0x2::sui::SUI>(arg10), arg7, arg9, arg10);
        0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::slot::add_to_balance<T0>(arg1, 0x2::coin::into_balance<T0>(v1));
        split_and_pay_with_sui(v2, arg3, arg4, arg5, arg8, arg10);
    }

    public entry fun collect_sui(arg0: &CollectorCap, arg1: &mut 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::slot::Slot, arg2: u64, arg3: &mut 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::bank::Bank, arg4: &mut 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::fee::FeeManager, arg5: u64, arg6: 0x1::ascii::String, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = take_from_slot_for_subscription<0x2::sui::SUI>(arg1, arg2, true, arg7);
        split_and_pay_with_sui(v0, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun collect_turbos<T0, T1>(arg0: &CollectorCap, arg1: &mut 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::slot::Slot, arg2: u64, arg3: &mut 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::bank::Bank, arg4: &mut 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::fee::FeeManager, arg5: u64, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: 0x1::ascii::String, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = take_from_slot_for_subscription<T0>(arg1, arg2, true, arg10);
        let (v1, v2) = 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::turbos_clmm_protocol::swap<T0, 0x2::sui::SUI, T1>(arg6, v0, 0x2::coin::zero<0x2::sui::SUI>(arg10), arg7, arg9, arg10);
        0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::slot::add_to_balance<T0>(arg1, 0x2::coin::into_balance<T0>(v1));
        split_and_pay_with_sui(v2, arg3, arg4, arg5, arg8, arg10);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CollectorCap{id: 0x2::object::new(arg0)};
        set_collector(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun set_collector(arg0: CollectorCap, arg1: address) {
        0x2::transfer::public_transfer<CollectorCap>(arg0, arg1);
        let v0 = CollectorUpdated{new_collector: arg1};
        0x2::event::emit<CollectorUpdated>(v0);
    }

    fun split_and_pay_with_sui(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::bank::Bank, arg2: &mut 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::fee::FeeManager, arg3: u64, arg4: 0x1::ascii::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = (((0x2::coin::value<0x2::sui::SUI>(&arg0) as u128) * (arg3 as u128) / 100000) as u64);
        0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::bank::add_to_bank(arg1, 0x2::coin::split<0x2::sui::SUI>(&mut arg0, v0, arg5), arg5);
        0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::fee::add_fee(arg2, arg0);
        let v1 = Payment{
            payment_info : arg4,
            amount       : 0x2::coin::value<0x2::sui::SUI>(&arg0) - v0 + v0,
        };
        0x2::event::emit<Payment>(v1);
    }

    public entry fun subscribe_amm<T0>(arg0: &mut 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::slot::Slot, arg1: u64, arg2: u64, arg3: &mut 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::bank::Bank, arg4: &mut 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::fee::FeeManager, arg5: u64, arg6: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg7: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg8: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg9: u8, arg10: 0x1::ascii::String, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<0x2::sui::SUI>(arg12);
        let v1 = take_from_slot_for_subscription<T0>(arg0, arg1, false, arg12);
        let (v2, v3) = 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::slot_swap_amm::swap_base_amm_no_fees<T0>(v0, v1, arg2, arg6, arg7, arg8, arg9, arg11, arg12);
        0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::slot::add_to_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v3));
        split_and_pay_with_sui(v2, arg3, arg4, arg5, arg10, arg12);
    }

    public entry fun subscribe_cetus<T0>(arg0: &mut 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::slot::Slot, arg1: u64, arg2: &mut 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::bank::Bank, arg3: &mut 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::fee::FeeManager, arg4: u64, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: 0x1::ascii::String, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = take_from_slot_for_subscription<T0>(arg0, arg1, false, arg9);
        let (v1, v2) = 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::cetus_clmm_protocol::swap<T0, 0x2::sui::SUI>(arg5, v0, 0x2::coin::zero<0x2::sui::SUI>(arg9), arg6, arg8, arg9);
        0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::slot::add_to_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v1));
        split_and_pay_with_sui(v2, arg2, arg3, arg4, arg7, arg9);
    }

    public entry fun subscribe_turbos<T0, T1>(arg0: &mut 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::slot::Slot, arg1: u64, arg2: &mut 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::bank::Bank, arg3: &mut 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::fee::FeeManager, arg4: u64, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: 0x1::ascii::String, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = take_from_slot_for_subscription<T0>(arg0, arg1, false, arg9);
        let (v1, v2) = 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::turbos_clmm_protocol::swap<T0, 0x2::sui::SUI, T1>(arg5, v0, 0x2::coin::zero<0x2::sui::SUI>(arg9), arg6, arg8, arg9);
        0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::slot::add_to_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v1));
        split_and_pay_with_sui(v2, arg2, arg3, arg4, arg7, arg9);
    }

    public entry fun subsribe_sui(arg0: &mut 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::slot::Slot, arg1: u64, arg2: &mut 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::bank::Bank, arg3: &mut 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::fee::FeeManager, arg4: u64, arg5: 0x1::ascii::String, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = take_from_slot_for_subscription<0x2::sui::SUI>(arg0, arg1, false, arg6);
        split_and_pay_with_sui(v0, arg2, arg3, arg4, arg5, arg6);
    }

    fun take_from_slot_for_subscription<T0>(arg0: &mut 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::slot::Slot, arg1: u64, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (arg2 && 0x2::tx_context::sender(arg3) != 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::slot::owner(arg0)) {
            abort 0
        };
        0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::slot::take_from_balance<T0>(arg0, arg1, arg3)
    }

    // decompiled from Move bytecode v6
}

