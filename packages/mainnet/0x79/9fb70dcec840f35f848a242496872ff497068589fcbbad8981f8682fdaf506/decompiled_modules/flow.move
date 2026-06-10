module 0xa09373c8873b083cdfaaebd77cf95e4215701c7057b9f54f7ea7a9d25c1057a1::flow {
    public fun allocate_current<T0, T1>(arg0: &mut 0x6ca43acc2a33139ec1cb6a3d09cc92e30568ba06601052e80a468955a0f0a8dc::state::SAMState<T0, T1>, arg1: vector<0x6ca43acc2a33139ec1cb6a3d09cc92e30568ba06601052e80a468955a0f0a8dc::rbr::RebalanceRequest<T0, T1>>, arg2: &mut 0xa09373c8873b083cdfaaebd77cf95e4215701c7057b9f54f7ea7a9d25c1057a1::current_adapter::CurrentAdapter<T0, T1>, arg3: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg4: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket>, arg5: &0x2::clock::Clock, arg6: &0x6ca43acc2a33139ec1cb6a3d09cc92e30568ba06601052e80a468955a0f0a8dc::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) : vector<0x6ca43acc2a33139ec1cb6a3d09cc92e30568ba06601052e80a468955a0f0a8dc::rbr::RebalanceRequest<T0, T1>> {
        let v0 = 0x1::vector::empty<0x6ca43acc2a33139ec1cb6a3d09cc92e30568ba06601052e80a468955a0f0a8dc::rbr::RebalanceRequest<T0, T1>>();
        0x1::vector::reverse<0x6ca43acc2a33139ec1cb6a3d09cc92e30568ba06601052e80a468955a0f0a8dc::rbr::RebalanceRequest<T0, T1>>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x6ca43acc2a33139ec1cb6a3d09cc92e30568ba06601052e80a468955a0f0a8dc::rbr::RebalanceRequest<T0, T1>>(&arg1)) {
            let v2 = 0x1::vector::pop_back<0x6ca43acc2a33139ec1cb6a3d09cc92e30568ba06601052e80a468955a0f0a8dc::rbr::RebalanceRequest<T0, T1>>(&mut arg1);
            if (0x6ca43acc2a33139ec1cb6a3d09cc92e30568ba06601052e80a468955a0f0a8dc::rbr::to_witness<T0, T1>(&v2) == 0x1::option::some<0x1::type_name::TypeName>(0xa09373c8873b083cdfaaebd77cf95e4215701c7057b9f54f7ea7a9d25c1057a1::current_adapter::witness_type<T1>())) {
                0xa09373c8873b083cdfaaebd77cf95e4215701c7057b9f54f7ea7a9d25c1057a1::current_adapter::allocate_to_protocol<T0, T1>(arg2, arg0, arg3, arg4, v2, arg5, arg6, arg7);
            } else {
                0x1::vector::push_back<0x6ca43acc2a33139ec1cb6a3d09cc92e30568ba06601052e80a468955a0f0a8dc::rbr::RebalanceRequest<T0, T1>>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x6ca43acc2a33139ec1cb6a3d09cc92e30568ba06601052e80a468955a0f0a8dc::rbr::RebalanceRequest<T0, T1>>(arg1);
        v0
    }

    public fun fill_current<T0, T1>(arg0: &mut 0x6ca43acc2a33139ec1cb6a3d09cc92e30568ba06601052e80a468955a0f0a8dc::state::SAMState<T0, T1>, arg1: vector<0x6ca43acc2a33139ec1cb6a3d09cc92e30568ba06601052e80a468955a0f0a8dc::wdr::WithdrawRequest<T0, T1>>, arg2: &mut 0xa09373c8873b083cdfaaebd77cf95e4215701c7057b9f54f7ea7a9d25c1057a1::current_adapter::CurrentAdapter<T0, T1>, arg3: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg4: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket>, arg5: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &0x6ca43acc2a33139ec1cb6a3d09cc92e30568ba06601052e80a468955a0f0a8dc::sam_allowed_versions::AllowedVersions, arg9: &mut 0x2::tx_context::TxContext) : vector<0x6ca43acc2a33139ec1cb6a3d09cc92e30568ba06601052e80a468955a0f0a8dc::wdr::WithdrawRequest<T0, T1>> {
        let v0 = &mut arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x6ca43acc2a33139ec1cb6a3d09cc92e30568ba06601052e80a468955a0f0a8dc::wdr::WithdrawRequest<T0, T1>>(v0)) {
            let v2 = 0x1::vector::borrow_mut<0x6ca43acc2a33139ec1cb6a3d09cc92e30568ba06601052e80a468955a0f0a8dc::wdr::WithdrawRequest<T0, T1>>(v0, v1);
            if (0x6ca43acc2a33139ec1cb6a3d09cc92e30568ba06601052e80a468955a0f0a8dc::wdr::get_witness<T0, T1>(v2) == 0xa09373c8873b083cdfaaebd77cf95e4215701c7057b9f54f7ea7a9d25c1057a1::current_adapter::witness_type<T1>()) {
                0xa09373c8873b083cdfaaebd77cf95e4215701c7057b9f54f7ea7a9d25c1057a1::current_adapter::withdraw_wdr<T0, T1>(arg2, arg0, arg3, arg4, arg5, arg6, v2, arg7, arg8, arg9);
            };
            v1 = v1 + 1;
        };
        arg1
    }

    public fun fill_rebalance_current<T0, T1>(arg0: &mut 0x6ca43acc2a33139ec1cb6a3d09cc92e30568ba06601052e80a468955a0f0a8dc::state::SAMState<T0, T1>, arg1: vector<0x6ca43acc2a33139ec1cb6a3d09cc92e30568ba06601052e80a468955a0f0a8dc::rbr::RebalanceRequest<T0, T1>>, arg2: &mut 0xa09373c8873b083cdfaaebd77cf95e4215701c7057b9f54f7ea7a9d25c1057a1::current_adapter::CurrentAdapter<T0, T1>, arg3: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg4: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket>, arg5: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &0x6ca43acc2a33139ec1cb6a3d09cc92e30568ba06601052e80a468955a0f0a8dc::sam_allowed_versions::AllowedVersions, arg9: &mut 0x2::tx_context::TxContext) : vector<0x6ca43acc2a33139ec1cb6a3d09cc92e30568ba06601052e80a468955a0f0a8dc::rbr::RebalanceRequest<T0, T1>> {
        let v0 = &mut arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x6ca43acc2a33139ec1cb6a3d09cc92e30568ba06601052e80a468955a0f0a8dc::rbr::RebalanceRequest<T0, T1>>(v0)) {
            let v2 = 0x1::vector::borrow_mut<0x6ca43acc2a33139ec1cb6a3d09cc92e30568ba06601052e80a468955a0f0a8dc::rbr::RebalanceRequest<T0, T1>>(v0, v1);
            if (0x6ca43acc2a33139ec1cb6a3d09cc92e30568ba06601052e80a468955a0f0a8dc::rbr::from_witness<T0, T1>(v2) == 0x1::option::some<0x1::type_name::TypeName>(0xa09373c8873b083cdfaaebd77cf95e4215701c7057b9f54f7ea7a9d25c1057a1::current_adapter::witness_type<T1>())) {
                0xa09373c8873b083cdfaaebd77cf95e4215701c7057b9f54f7ea7a9d25c1057a1::current_adapter::withdraw_rbr<T0, T1>(arg2, arg0, arg3, arg4, arg5, arg6, v2, arg7, arg8, arg9);
            };
            v1 = v1 + 1;
        };
        arg1
    }

    // decompiled from Move bytecode v7
}

