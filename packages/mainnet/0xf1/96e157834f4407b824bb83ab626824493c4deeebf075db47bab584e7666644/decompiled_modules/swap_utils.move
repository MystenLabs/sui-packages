module 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::swap_utils {
    public(friend) fun repay_sponsor_gas<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::dex_utils::is_base<T0>(), 1);
        if (arg1 > 0) {
            assert!(0x2::coin::value<T0>(arg0) >= arg1, 0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, arg1, arg3), arg2);
        };
    }

    public(friend) fun repay_sponsor_gas_cetus<T0>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg2 > 0) {
            let v0 = 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::cetus_clmm_protocol::get_required_coin_amount<T0>(arg0, arg2);
            assert!(0x2::coin::value<T0>(arg1) > v0, 0);
            let (v1, v2) = 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::cetus_clmm_protocol::swap<T0, 0x2::sui::SUI>(arg0, 0x2::coin::split<T0>(arg1, v0, arg6), 0x2::coin::zero<0x2::sui::SUI>(arg6), arg4, arg5, arg6);
            0x2::coin::join<T0>(arg1, v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, arg3);
        };
    }

    public(friend) fun repay_sponsor_gas_v2<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg3: u8, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg4 > 0) {
            let v0 = if (arg3 == 0) {
                0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::flow_x_amm_protocol::get_required_coin_amount<T0>(arg1, arg4)
            } else {
                0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::blue_move_protocol::get_required_coin_amount<T0>(arg2, arg4)
            };
            assert!(0x2::coin::value<T0>(arg0) > v0, 0);
            let v1 = if (arg3 == 0) {
                0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::flow_x_amm_protocol::swap_a_to_b<T0, 0x2::sui::SUI>(0x2::coin::split<T0>(arg0, v0, arg6), arg1, arg6)
            } else {
                0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::blue_move_protocol::swap_a_to_b<T0, 0x2::sui::SUI>(0x2::coin::split<T0>(arg0, v0, arg6), 102, arg2, arg6)
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, arg5);
        };
    }

    public(friend) fun take_fee(arg0: &mut 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::bank::Bank, arg1: &mut 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::fee::FeeManager, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::dex_utils::calculate_fee(0x2::coin::value<0x2::sui::SUI>(arg2), arg4);
        let v1 = 0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::dex_utils::calculate_fee(v0, arg3);
        0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::bank::add_to_bank(arg0, 0x2::coin::split<0x2::sui::SUI>(arg2, v1, arg5), arg5);
        0xf196e157834f4407b824bb83ab626824493c4deeebf075db47bab584e7666644::fee::add_fee(arg1, 0x2::coin::split<0x2::sui::SUI>(arg2, v0 - v1, arg5));
    }

    // decompiled from Move bytecode v6
}

