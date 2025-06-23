module 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::state_inner {
    struct SamStateV1<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        paused: bool,
        balance: 0x2::balance::Balance<T0>,
        total_coin_in: u64,
        deployed_liquidity: 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::Fixed18,
        available_liquidity: 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::Fixed18,
        exchange_rate: 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::exchange_rate::ExchangeRate,
        fees: 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::fee_balances::FeeBalances<T0>,
        fee_config: 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::fee_config::FeeConfig,
        registry: 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::extended_field::ExtendedField<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::ProtocolRegistry>,
        treasury: 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::extended_field::ExtendedField<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_coin_treasury::SamTreasury<T1>>,
        metadata: 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::extended_field::ExtendedField<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_coin_metadata::SamMetadata>,
    }

    public(friend) fun balance<T0, T1>(arg0: &SamStateV1<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public(friend) fun new<T0, T1>(arg0: 0x2::coin::TreasuryCap<T1>, arg1: &0x2::coin::CoinMetadata<T1>, arg2: &mut 0x2::tx_context::TxContext) : SamStateV1<T0, T1> {
        SamStateV1<T0, T1>{
            id                  : 0x2::object::new(arg2),
            paused              : false,
            balance             : 0x2::balance::zero<T0>(),
            total_coin_in       : 0,
            deployed_liquidity  : 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::zero(),
            available_liquidity : 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::zero(),
            exchange_rate       : 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::exchange_rate::empty(),
            fees                : 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::fee_balances::new<T0>(),
            fee_config          : 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::fee_config::new(),
            registry            : 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::extended_field::new<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::ProtocolRegistry>(0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::new(arg2), arg2),
            treasury            : 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::extended_field::new<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_coin_treasury::SamTreasury<T1>>(0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_coin_treasury::new<T1>(arg0, arg2), arg2),
            metadata            : 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::extended_field::new<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_coin_metadata::SamMetadata>(0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_coin_metadata::new<T1>(arg1), arg2),
        }
    }

    public(friend) fun exchange_rate<T0, T1>(arg0: &SamStateV1<T0, T1>) : 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::exchange_rate::ExchangeRate {
        arg0.exchange_rate
    }

    public(friend) fun fee_config<T0, T1>(arg0: &SamStateV1<T0, T1>) : 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::fee_config::FeeConfig {
        arg0.fee_config
    }

    public(friend) fun deposit<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(!arg0.paused, 11);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 12);
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let v1 = 0x2::balance::value<T0>(&v0);
        let v2 = 0x825601a3542567b0c99e2d7f29fb169d68a4b8416cfd6ec9ce3a36a835a96ee7::bps::calc_up(0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::fee_config::deposit(&arg0.fee_config), v1);
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::fee_balances::add_deposit<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut v0, v2));
        let v3 = v1 - v2;
        0x2::balance::join<T0>(&mut arg0.balance, v0);
        arg0.total_coin_in = arg0.total_coin_in + v3;
        arg0.available_liquidity = 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::add(arg0.available_liquidity, 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::u64_to_fixed18(v3, 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_coin_metadata::decimals(0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::extended_field::borrow<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_coin_metadata::SamMetadata>(&arg0.metadata))));
        0x2::coin::mint<T1>(0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_coin_treasury::inner_mut<T1>(0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::extended_field::borrow_mut<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_coin_treasury::SamTreasury<T1>>(&mut arg0.treasury)), 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::exchange_rate::add_coin_in_down(&mut arg0.exchange_rate, v3), arg2)
    }

    public(friend) fun withdraw<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: vector<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::ProtocolLiquidity>) : (0x2::balance::Balance<T0>, vector<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::wdr::WithdrawRequest<T0>>) {
        assert!(!arg0.paused, 11);
        assert!(0x2::coin::value<T1>(&arg1) > 0, 12);
        let v0 = 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::exchange_rate::sub_sam_down(&mut arg0.exchange_rate, 0x2::coin::value<T1>(&arg1));
        0x2::coin::burn<T1>(0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_coin_treasury::inner_mut<T1>(0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::extended_field::borrow_mut<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_coin_treasury::SamTreasury<T1>>(&mut arg0.treasury)), arg1);
        let v1 = 0x2::balance::value<T0>(&arg0.balance);
        let v2 = 0x2::balance::split<T0>(&mut arg0.balance, 0x1::u64::min(v0, v1));
        let v3 = 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_coin_metadata::decimals(0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::extended_field::borrow<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_coin_metadata::SamMetadata>(&arg0.metadata));
        arg0.available_liquidity = 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::sub(arg0.available_liquidity, 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::u64_to_fixed18(0x1::u64::min(v0, v1), v3));
        arg0.total_coin_in = arg0.total_coin_in - v0;
        let v4 = 0x1::vector::empty<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::wdr::WithdrawRequest<T0>>();
        if (v0 <= v1) {
            0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::fee_balances::add_withdraw<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut v2, 0x825601a3542567b0c99e2d7f29fb169d68a4b8416cfd6ec9ce3a36a835a96ee7::bps::calc_up(0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::fee_config::withdraw(&arg0.fee_config), v0)));
            return (v2, v4)
        };
        let v5 = v0 - v1;
        let v6 = v5;
        arg0.deployed_liquidity = 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::sub(arg0.deployed_liquidity, 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::u64_to_fixed18(v5, v3));
        let v7 = 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::zero();
        0x1::vector::reverse<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::ProtocolLiquidity>(&mut arg2);
        let v8 = 0;
        while (v8 < 0x1::vector::length<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::ProtocolLiquidity>(&arg2)) {
            let v9 = 0x1::vector::pop_back<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::ProtocolLiquidity>(&mut arg2);
            v7 = 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::add(v7, 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::available_liquidity(&v9));
            v8 = v8 + 1;
        };
        0x1::vector::destroy_empty<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::ProtocolLiquidity>(arg2);
        assert!(0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::to_u64_up(v7, v3) >= v5, 13);
        let v10 = 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::zero();
        let v11 = 0x1::vector::empty<0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::Fixed18>();
        0x1::vector::reverse<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::ProtocolLiquidity>(&mut arg2);
        let v12 = 0;
        while (v12 < 0x1::vector::length<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::ProtocolLiquidity>(&arg2)) {
            let v13 = 0x1::vector::pop_back<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::ProtocolLiquidity>(&mut arg2);
            let v14 = 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::apr(&v13);
            let v15 = if (v14 == 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::zero()) {
                0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::one()
            } else {
                v14
            };
            let v16 = 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::mul_up(0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::div_up(0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::available_liquidity(&v13), v7), 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::div_up(0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::one(), v15));
            v10 = 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::add(v10, v16);
            0x1::vector::push_back<0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::Fixed18>(&mut v11, v16);
            v12 = v12 + 1;
        };
        0x1::vector::destroy_empty<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::ProtocolLiquidity>(arg2);
        let v17 = 0;
        0x1::vector::reverse<0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::Fixed18>(&mut v11);
        assert!(0x1::vector::length<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::ProtocolLiquidity>(&arg2) == 0x1::vector::length<0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::Fixed18>(&v11), 13906834917372723199);
        0x1::vector::reverse<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::ProtocolLiquidity>(&mut arg2);
        let v18 = 0;
        while (v18 < 0x1::vector::length<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::ProtocolLiquidity>(&arg2)) {
            let v19 = 0x1::vector::pop_back<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::ProtocolLiquidity>(&mut arg2);
            let v20 = if (v17 == 0x1::vector::length<0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::Fixed18>(&v11) - 1) {
                0x1::u64::min(v6, 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::to_u64_up(0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::available_liquidity(&v19), v3))
            } else {
                0x1::u64::min(0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::to_u64_up(0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::mul_up(0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::div_down(0x1::vector::pop_back<0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::Fixed18>(&mut v11), v10), 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::u64_to_fixed18(v6, v3)), v3), 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::to_u64_up(0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::available_liquidity(&v19), v3))
            };
            v6 = v6 - v20;
            v17 = v17 + 1;
            0x1::vector::push_back<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::wdr::WithdrawRequest<T0>>(&mut v4, 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::wdr::new<T0>(v20, 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::witness_type_name(&v19)));
            v18 = v18 + 1;
        };
        0x1::vector::destroy_empty<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::ProtocolLiquidity>(arg2);
        0x1::vector::destroy_empty<0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::Fixed18>(v11);
        assert!(v6 == 0, 13);
        (v2, v4)
    }

    public(friend) fun available_liquidity<T0, T1>(arg0: &SamStateV1<T0, T1>) : 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::Fixed18 {
        arg0.available_liquidity
    }

    public(friend) fun allocate_to_protocol<T0, T1, T2: drop>(arg0: &SamStateV1<T0, T1>, arg1: 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::rbr::RebalanceRequest<T0>, arg2: T2) : 0x2::balance::Balance<T0> {
        assert!(!arg0.paused, 11);
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::rbr::consume<T0, T2>(arg1, arg2)
    }

    public(friend) fun approve_protocol_request<T0: drop, T1, T2>(arg0: &mut SamStateV1<T1, T2>, arg1: &mut 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::ProtocolRequest<T1>, arg2: 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::Fixed18, arg3: 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::Fixed18, arg4: 0x2::balance::Balance<T1>, arg5: T0) {
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::approve_request<T1, T0>(0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::extended_field::borrow_mut<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::ProtocolRegistry>(&mut arg0.registry), arg1, arg5, arg2, arg3, arg4);
    }

    public(friend) fun consume_protocol_earnings<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::ProtocolRequest<T0>) : vector<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::ProtocolLiquidity> {
        let (v0, v1) = 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::consume<T0>(0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::extended_field::borrow_mut<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::ProtocolRegistry>(&mut arg0.registry), arg1);
        let v2 = v0;
        let v3 = 0x2::balance::value<T0>(&v2);
        let v4 = 0x825601a3542567b0c99e2d7f29fb169d68a4b8416cfd6ec9ce3a36a835a96ee7::bps::calc_up(0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::fee_config::protocol(&arg0.fee_config), v3);
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::fee_balances::add_protocol<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut v2, v4));
        let v5 = v3 - v4;
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::exchange_rate::add_earnings(&mut arg0.exchange_rate, v5);
        0x2::balance::join<T0>(&mut arg0.balance, v2);
        arg0.total_coin_in = arg0.total_coin_in + v5;
        arg0.available_liquidity = 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::add(arg0.available_liquidity, 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::u64_to_fixed18(v5, 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_coin_metadata::decimals(0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::extended_field::borrow<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_coin_metadata::SamMetadata>(&arg0.metadata))));
        v1
    }

    public(friend) fun consume_withdraw<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::wdr::WithdrawRequest<T0>) : 0x2::balance::Balance<T0> {
        assert!(!arg0.paused, 11);
        let v0 = 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::wdr::consume<T0>(arg1);
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::fee_balances::add_withdraw<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut v0, 0x825601a3542567b0c99e2d7f29fb169d68a4b8416cfd6ec9ce3a36a835a96ee7::bps::calc_up(0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::fee_config::withdraw(&arg0.fee_config), 0x2::balance::value<T0>(&v0))));
        v0
    }

    public(friend) fun deployed_liquidity<T0, T1>(arg0: &SamStateV1<T0, T1>) : 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::Fixed18 {
        arg0.deployed_liquidity
    }

    public(friend) fun fees<T0, T1>(arg0: &SamStateV1<T0, T1>) : &0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::fee_balances::FeeBalances<T0> {
        &arg0.fees
    }

    public(friend) fun get_metadata<T0, T1>(arg0: &SamStateV1<T0, T1>) : &0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_coin_metadata::SamMetadata {
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::extended_field::borrow<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_coin_metadata::SamMetadata>(&arg0.metadata)
    }

    public(friend) fun get_registry<T0, T1>(arg0: &SamStateV1<T0, T1>) : &0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::ProtocolRegistry {
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::extended_field::borrow<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::ProtocolRegistry>(&arg0.registry)
    }

    public(friend) fun get_treasury<T0, T1>(arg0: &SamStateV1<T0, T1>) : &0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_coin_treasury::SamTreasury<T1> {
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::extended_field::borrow<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_coin_treasury::SamTreasury<T1>>(&arg0.treasury)
    }

    public(friend) fun paused<T0, T1>(arg0: &SamStateV1<T0, T1>) : bool {
        arg0.paused
    }

    public(friend) fun rebalance<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: vector<0x1::option::Option<0x1::type_name::TypeName>>, arg2: vector<0x1::option::Option<0x1::type_name::TypeName>>, arg3: vector<u64>) : vector<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::rbr::RebalanceRequest<T0>> {
        assert!(!arg0.paused, 11);
        assert!(0x1::vector::length<0x1::option::Option<0x1::type_name::TypeName>>(&arg1) == 0x1::vector::length<0x1::option::Option<0x1::type_name::TypeName>>(&arg2) && 0x1::vector::length<0x1::option::Option<0x1::type_name::TypeName>>(&arg1) == 0x1::vector::length<u64>(&arg3), 14);
        let v0 = 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::extended_field::borrow<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::ProtocolRegistry>(&arg0.registry);
        let v1 = 0x1::vector::empty<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::rbr::RebalanceRequest<T0>>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::option::Option<0x1::type_name::TypeName>>(&arg1)) {
            let v3 = *0x1::vector::borrow<0x1::option::Option<0x1::type_name::TypeName>>(&arg1, v2);
            let v4 = *0x1::vector::borrow<0x1::option::Option<0x1::type_name::TypeName>>(&arg2, v2);
            let v5 = *0x1::vector::borrow<u64>(&arg3, v2);
            assert!(v5 > 0, 12);
            if (0x1::option::is_some<0x1::type_name::TypeName>(&v3)) {
                assert!(0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::contains_type_name(v0, *0x1::option::borrow<0x1::type_name::TypeName>(&v3)), 7);
            };
            if (0x1::option::is_some<0x1::type_name::TypeName>(&v4)) {
                assert!(0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::ptr::contains_type_name(v0, *0x1::option::borrow<0x1::type_name::TypeName>(&v4)), 7);
            };
            let v6 = 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::rbr::new<T0>(v5, v3, v4);
            let v7 = 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::u64_to_fixed18(v5, 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_coin_metadata::decimals(0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::extended_field::borrow<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_coin_metadata::SamMetadata>(&arg0.metadata)));
            if (0x1::option::is_none<0x1::type_name::TypeName>(&v3)) {
                arg0.available_liquidity = 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::sub(arg0.available_liquidity, v7);
                arg0.deployed_liquidity = 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::add(arg0.deployed_liquidity, v7);
                0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::rbr::fill_idle<T0>(&mut v6, 0x2::balance::split<T0>(&mut arg0.balance, v5));
            };
            if (0x1::option::is_none<0x1::type_name::TypeName>(&v4)) {
                arg0.deployed_liquidity = 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::sub(arg0.deployed_liquidity, v7);
                arg0.available_liquidity = 0x911fd84fd98ed5c8c32cfc25f08f1493e532e4a4ba7d126290de00db75aa494f::fixed18::add(arg0.available_liquidity, v7);
            };
            0x1::vector::push_back<0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::rbr::RebalanceRequest<T0>>(&mut v1, v6);
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun reclaim_from_protocol<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::rbr::RebalanceRequest<T0>) {
        assert!(!arg0.paused, 11);
        0x2::balance::join<T0>(&mut arg0.balance, 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::rbr::consume_idle<T0>(arg1));
    }

    public(friend) fun set_paused<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: bool) {
        arg0.paused = arg1;
    }

    public(friend) fun total_coin_in<T0, T1>(arg0: &SamStateV1<T0, T1>) : u64 {
        arg0.total_coin_in
    }

    public(friend) fun update_deposit_fee<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: u64) {
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::fee_config::set_deposit(&mut arg0.fee_config, arg1);
    }

    public(friend) fun update_protocol_fee<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: u64) {
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::fee_config::set_protocol(&mut arg0.fee_config, arg1);
    }

    public(friend) fun update_withdraw_fee<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: u64) {
        0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::fee_config::set_withdraw(&mut arg0.fee_config, arg1);
    }

    // decompiled from Move bytecode v6
}

