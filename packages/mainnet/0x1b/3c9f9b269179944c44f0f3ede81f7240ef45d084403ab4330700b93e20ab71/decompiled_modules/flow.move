module 0x1b3c9f9b269179944c44f0f3ede81f7240ef45d084403ab4330700b93e20ab71::flow {
    public fun allocate_current<T0, T1>(arg0: &mut 0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::state::SAMState<T0, T1>, arg1: vector<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::rbr::RebalanceRequest<T0, T1>>, arg2: &mut 0x1b3c9f9b269179944c44f0f3ede81f7240ef45d084403ab4330700b93e20ab71::current_adapter::CurrentAdapter<T0, T1>, arg3: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg4: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket>, arg5: &0x2::clock::Clock, arg6: &0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) : vector<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::rbr::RebalanceRequest<T0, T1>> {
        let v0 = 0x1::vector::empty<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::rbr::RebalanceRequest<T0, T1>>();
        0x1::vector::reverse<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::rbr::RebalanceRequest<T0, T1>>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::rbr::RebalanceRequest<T0, T1>>(&arg1)) {
            let v2 = 0x1::vector::pop_back<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::rbr::RebalanceRequest<T0, T1>>(&mut arg1);
            if (0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::rbr::to_witness<T0, T1>(&v2) == 0x1::option::some<0x1::type_name::TypeName>(0x1b3c9f9b269179944c44f0f3ede81f7240ef45d084403ab4330700b93e20ab71::current_adapter::witness_type<T1>())) {
                0x1b3c9f9b269179944c44f0f3ede81f7240ef45d084403ab4330700b93e20ab71::current_adapter::allocate_to_protocol<T0, T1>(arg2, arg0, arg3, arg4, v2, arg5, arg6, arg7);
            } else {
                0x1::vector::push_back<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::rbr::RebalanceRequest<T0, T1>>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::rbr::RebalanceRequest<T0, T1>>(arg1);
        v0
    }

    public fun fill_current<T0, T1>(arg0: &mut 0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::state::SAMState<T0, T1>, arg1: vector<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::wdr::WithdrawRequest<T0, T1>>, arg2: &mut 0x1b3c9f9b269179944c44f0f3ede81f7240ef45d084403ab4330700b93e20ab71::current_adapter::CurrentAdapter<T0, T1>, arg3: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg4: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket>, arg5: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::sam_allowed_versions::AllowedVersions, arg9: &mut 0x2::tx_context::TxContext) : vector<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::wdr::WithdrawRequest<T0, T1>> {
        let v0 = &mut arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::wdr::WithdrawRequest<T0, T1>>(v0)) {
            let v2 = 0x1::vector::borrow_mut<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::wdr::WithdrawRequest<T0, T1>>(v0, v1);
            if (0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::wdr::get_witness<T0, T1>(v2) == 0x1b3c9f9b269179944c44f0f3ede81f7240ef45d084403ab4330700b93e20ab71::current_adapter::witness_type<T1>()) {
                0x1b3c9f9b269179944c44f0f3ede81f7240ef45d084403ab4330700b93e20ab71::current_adapter::withdraw_wdr<T0, T1>(arg2, arg0, arg3, arg4, arg5, arg6, v2, arg7, arg8, arg9);
            };
            v1 = v1 + 1;
        };
        arg1
    }

    public fun fill_rebalance_current<T0, T1>(arg0: &mut 0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::state::SAMState<T0, T1>, arg1: vector<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::rbr::RebalanceRequest<T0, T1>>, arg2: &mut 0x1b3c9f9b269179944c44f0f3ede81f7240ef45d084403ab4330700b93e20ab71::current_adapter::CurrentAdapter<T0, T1>, arg3: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg4: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket>, arg5: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::sam_allowed_versions::AllowedVersions, arg9: &mut 0x2::tx_context::TxContext) : vector<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::rbr::RebalanceRequest<T0, T1>> {
        let v0 = &mut arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::rbr::RebalanceRequest<T0, T1>>(v0)) {
            let v2 = 0x1::vector::borrow_mut<0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::rbr::RebalanceRequest<T0, T1>>(v0, v1);
            if (0xe87b8f0d267ca2436863570c735dfda4130fd0f7446059ec64343c4962cd0735::rbr::from_witness<T0, T1>(v2) == 0x1::option::some<0x1::type_name::TypeName>(0x1b3c9f9b269179944c44f0f3ede81f7240ef45d084403ab4330700b93e20ab71::current_adapter::witness_type<T1>())) {
                0x1b3c9f9b269179944c44f0f3ede81f7240ef45d084403ab4330700b93e20ab71::current_adapter::withdraw_rbr<T0, T1>(arg2, arg0, arg3, arg4, arg5, arg6, v2, arg7, arg8, arg9);
            };
            v1 = v1 + 1;
        };
        arg1
    }

    // decompiled from Move bytecode v7
}

