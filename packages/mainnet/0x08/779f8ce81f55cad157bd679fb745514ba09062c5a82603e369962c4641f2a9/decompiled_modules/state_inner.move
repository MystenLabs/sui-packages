module 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::state_inner {
    struct SamStateV1<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        paused: bool,
        balance: 0x2::balance::Balance<T0>,
        total_coin_in: u64,
        deployed_liquidity: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18,
        available_liquidity: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18,
        exchange_rate: 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::exchange_rate::ExchangeRate,
        fees: 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::fee_balances::FeeBalances<T0>,
        fee_config: 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::fee_config::FeeConfig,
        registry: 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::extended_field::ExtendedField<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRegistry>,
        treasury: 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::extended_field::ExtendedField<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_coin_treasury::SamTreasury<T1>>,
        metadata: 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::extended_field::ExtendedField<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_coin_metadata::SamMetadata>,
    }

    struct PointKey has copy, drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    public(friend) fun balance<T0, T1>(arg0: &SamStateV1<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public(friend) fun new<T0, T1>(arg0: 0x2::coin::TreasuryCap<T1>, arg1: &0x2::coin::CoinMetadata<T1>, arg2: &mut 0x2::tx_context::TxContext) : SamStateV1<T0, T1> {
        let v0 = SamStateV1<T0, T1>{
            id                  : 0x2::object::new(arg2),
            paused              : false,
            balance             : 0x2::balance::zero<T0>(),
            total_coin_in       : 0,
            deployed_liquidity  : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::zero(),
            available_liquidity : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::zero(),
            exchange_rate       : 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::exchange_rate::empty(),
            fees                : 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::fee_balances::new<T0>(),
            fee_config          : 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::fee_config::new(),
            registry            : 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::extended_field::new<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRegistry>(0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::new(arg2), arg2),
            treasury            : 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::extended_field::new<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_coin_treasury::SamTreasury<T1>>(0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_coin_treasury::new<T1>(arg0, arg2), arg2),
            metadata            : 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::extended_field::new<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_coin_metadata::SamMetadata>(0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_coin_metadata::new<T1>(arg1), arg2),
        };
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_events::new_state<T0, T1>(0x2::object::uid_to_inner(&v0.id), 0x2::coin::get_decimals<T1>(arg1), 0x2::coin::get_name<T1>(arg1), 0x2::coin::get_symbol<T1>(arg1));
        v0
    }

    public(friend) fun exchange_rate<T0, T1>(arg0: &SamStateV1<T0, T1>) : 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::exchange_rate::ExchangeRate {
        arg0.exchange_rate
    }

    public(friend) fun fee_config<T0, T1>(arg0: &SamStateV1<T0, T1>) : 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::fee_config::FeeConfig {
        arg0.fee_config
    }

    public(friend) fun deposit<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(!arg0.paused, 11);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 12);
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let v1 = 0x2::balance::value<T0>(&v0);
        let v2 = 0x14844479546b92d12dc4c8476cbcb112b730d11341e01ee3a9f7146b88cfba77::bps::calc_up(0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::fee_config::deposit(&arg0.fee_config), v1);
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::fee_balances::add_deposit<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut v0, v2));
        let v3 = v1 - v2;
        0x2::balance::join<T0>(&mut arg0.balance, v0);
        arg0.total_coin_in = arg0.total_coin_in + v3;
        arg0.available_liquidity = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::add(arg0.available_liquidity, 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(v3, 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_coin_metadata::decimals(0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::extended_field::borrow<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_coin_metadata::SamMetadata>(&arg0.metadata))));
        let v4 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::exchange_rate::add_coin_in_down(&mut arg0.exchange_rate, v3);
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_events::deposit<T0, T1>(v2, v3, v4, 0x2::tx_context::sender(arg2));
        0x2::coin::mint<T1>(0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_coin_treasury::inner_mut<T1>(0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::extended_field::borrow_mut<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_coin_treasury::SamTreasury<T1>>(&mut arg0.treasury)), v4, arg2)
    }

    public(friend) fun withdraw<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolLiquidity>, arg3: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T0>>) {
        assert!(!arg0.paused, 11);
        assert!(0x2::coin::value<T1>(&arg1) > 0, 12);
        let v0 = 0x2::coin::value<T1>(&arg1);
        let v1 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::exchange_rate::sub_sam_down(&mut arg0.exchange_rate, v0);
        0x2::coin::burn<T1>(0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_coin_treasury::inner_mut<T1>(0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::extended_field::borrow_mut<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_coin_treasury::SamTreasury<T1>>(&mut arg0.treasury)), arg1);
        let v2 = 0x2::balance::value<T0>(&arg0.balance);
        let v3 = 0x2::balance::split<T0>(&mut arg0.balance, 0x1::u64::min(v1, v2));
        let v4 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_coin_metadata::decimals(0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::extended_field::borrow<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_coin_metadata::SamMetadata>(&arg0.metadata));
        arg0.available_liquidity = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::sub(arg0.available_liquidity, 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(0x1::u64::min(v1, v2), v4));
        arg0.total_coin_in = arg0.total_coin_in - v1;
        let v5 = 0x14844479546b92d12dc4c8476cbcb112b730d11341e01ee3a9f7146b88cfba77::bps::calc_up(0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::fee_config::withdraw(&arg0.fee_config), 0x2::balance::value<T0>(&v3));
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::fee_balances::add_withdraw<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut v3, v5));
        let v6 = 0x1::vector::empty<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T0>>();
        if (v1 <= v2) {
            0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_events::withdraw<T0, T1>(v5, v0, v1, 0x2::tx_context::sender(arg3), 0x1::vector::empty<0x1::type_name::TypeName>(), vector[], v1);
            return (v3, v6)
        };
        let v7 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::zero();
        0x1::vector::reverse<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolLiquidity>(&mut arg2);
        let v8 = 0;
        while (v8 < 0x1::vector::length<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolLiquidity>(&arg2)) {
            let v9 = 0x1::vector::pop_back<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolLiquidity>(&mut arg2);
            v7 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::add(v7, 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::available_liquidity(&v9));
            v8 = v8 + 1;
        };
        0x1::vector::destroy_empty<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolLiquidity>(arg2);
        let v10 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::to_u64_up(v7, v4);
        let v11 = v1 - v2;
        let v12 = v11;
        if (v11 > v10) {
            assert!(v11 - v10 <= v11 / 100000 + 100, 13);
            v12 = v10;
        };
        arg0.deployed_liquidity = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::sub(arg0.deployed_liquidity, 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(v12, v4));
        let v13 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::zero();
        let v14 = 0x1::vector::empty<0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18>();
        0x1::vector::reverse<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolLiquidity>(&mut arg2);
        let v15 = 0;
        while (v15 < 0x1::vector::length<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolLiquidity>(&arg2)) {
            let v16 = 0x1::vector::pop_back<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolLiquidity>(&mut arg2);
            let v17 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::apr(&v16);
            let v18 = if (v17 == 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::zero()) {
                0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::one()
            } else {
                v17
            };
            let v19 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::mul_up(0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::div_up(0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::available_liquidity(&v16), v7), 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::div_up(0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::one(), v18));
            v13 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::add(v13, v19);
            0x1::vector::push_back<0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18>(&mut v14, v19);
            v15 = v15 + 1;
        };
        0x1::vector::destroy_empty<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolLiquidity>(arg2);
        let v20 = 0;
        0x1::vector::reverse<0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18>(&mut v14);
        assert!(0x1::vector::length<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolLiquidity>(&arg2) == 0x1::vector::length<0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18>(&v14), 13906835084876447743);
        0x1::vector::reverse<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolLiquidity>(&mut arg2);
        let v21 = 0;
        while (v21 < 0x1::vector::length<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolLiquidity>(&arg2)) {
            let v22 = 0x1::vector::pop_back<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolLiquidity>(&mut arg2);
            let v23 = if (v20 == 0x1::vector::length<0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18>(&v14) - 1) {
                0x1::u64::min(v12, 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::to_u64_up(0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::available_liquidity(&v22), v4))
            } else {
                0x1::u64::min(0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::to_u64_up(0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::mul_up(0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::div_up(0x1::vector::pop_back<0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18>(&mut v14), v13), 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(v12, v4)), v4), 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::to_u64_up(0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::available_liquidity(&v22), v4))
            };
            v12 = v12 - v23;
            v20 = v20 + 1;
            if (v23 > 0) {
                0x1::vector::push_back<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T0>>(&mut v6, 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::new<T0>(v23, 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::witness_type_name(&v22)));
            };
            v21 = v21 + 1;
        };
        0x1::vector::destroy_empty<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolLiquidity>(arg2);
        0x1::vector::destroy_empty<0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18>(v14);
        assert!(v12 == 0, 13);
        let v24 = &v6;
        let v25 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v26 = 0;
        while (v26 < 0x1::vector::length<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T0>>(v24)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v25, 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::get_witness<T0>(0x1::vector::borrow<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T0>>(v24, v26)));
            v26 = v26 + 1;
        };
        let v27 = &v6;
        let v28 = vector[];
        let v29 = 0;
        while (v29 < 0x1::vector::length<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T0>>(v27)) {
            0x1::vector::push_back<u64>(&mut v28, 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::get_coin_amount<T0>(0x1::vector::borrow<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T0>>(v27, v29)));
            v29 = v29 + 1;
        };
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_events::withdraw<T0, T1>(v5, v0, v1, 0x2::tx_context::sender(arg3), v25, v28, 0x2::balance::value<T0>(&v3));
        (v3, v6)
    }

    public(friend) fun available_liquidity<T0, T1>(arg0: &SamStateV1<T0, T1>) : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18 {
        arg0.available_liquidity
    }

    public(friend) fun rebalance<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: vector<0x1::option::Option<0x1::type_name::TypeName>>, arg2: vector<0x1::option::Option<0x1::type_name::TypeName>>, arg3: vector<u64>, arg4: &0x2::tx_context::TxContext) : vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T0>> {
        assert!(!arg0.paused, 11);
        assert!(0x1::vector::length<0x1::option::Option<0x1::type_name::TypeName>>(&arg1) == 0x1::vector::length<0x1::option::Option<0x1::type_name::TypeName>>(&arg2) && 0x1::vector::length<0x1::option::Option<0x1::type_name::TypeName>>(&arg1) == 0x1::vector::length<u64>(&arg3), 14);
        let v0 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::extended_field::borrow<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRegistry>(&arg0.registry);
        let v1 = 0x1::vector::empty<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T0>>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::option::Option<0x1::type_name::TypeName>>(&arg1)) {
            let v3 = *0x1::vector::borrow<0x1::option::Option<0x1::type_name::TypeName>>(&arg1, v2);
            let v4 = *0x1::vector::borrow<0x1::option::Option<0x1::type_name::TypeName>>(&arg2, v2);
            let v5 = *0x1::vector::borrow<u64>(&arg3, v2);
            assert!(v5 > 0, 12);
            if (0x1::option::is_some<0x1::type_name::TypeName>(&v3)) {
                assert!(0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::contains_type_name(v0, *0x1::option::borrow<0x1::type_name::TypeName>(&v3)), 7);
            };
            if (0x1::option::is_some<0x1::type_name::TypeName>(&v4)) {
                assert!(0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::contains_type_name(v0, *0x1::option::borrow<0x1::type_name::TypeName>(&v4)), 7);
            };
            let v6 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::new<T0>(v5, v3, v4);
            let v7 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(v5, 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_coin_metadata::decimals(0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::extended_field::borrow<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_coin_metadata::SamMetadata>(&arg0.metadata)));
            if (0x1::option::is_none<0x1::type_name::TypeName>(&v3)) {
                arg0.available_liquidity = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::sub(arg0.available_liquidity, v7);
                arg0.deployed_liquidity = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::add(arg0.deployed_liquidity, v7);
                0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::fill_idle<T0>(&mut v6, 0x2::balance::split<T0>(&mut arg0.balance, v5));
            };
            if (0x1::option::is_none<0x1::type_name::TypeName>(&v4)) {
                arg0.deployed_liquidity = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::sub(arg0.deployed_liquidity, v7);
                arg0.available_liquidity = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::add(arg0.available_liquidity, v7);
            };
            0x1::vector::push_back<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T0>>(&mut v1, v6);
            v2 = v2 + 1;
        };
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_events::rebalance(arg1, arg2, arg3, 0x2::tx_context::sender(arg4));
        v1
    }

    public(friend) fun allocate_to_protocol<T0, T1, T2: drop>(arg0: &SamStateV1<T0, T1>, arg1: 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T0>, arg2: T2) : 0x2::balance::Balance<T0> {
        assert!(!arg0.paused, 11);
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::consume<T0, T2>(arg1, arg2)
    }

    public(friend) fun approve_protocol_request<T0: drop, T1, T2>(arg0: &mut SamStateV1<T1, T2>, arg1: &mut 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRequest<T1>, arg2: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18, arg3: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18, arg4: 0x2::balance::Balance<T1>, arg5: T0) {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::approve_request<T1, T0>(0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::extended_field::borrow_mut<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRegistry>(&mut arg0.registry), arg1, arg5, arg2, arg3, arg4);
    }

    fun apr_of(arg0: &vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolLiquidity>, arg1: 0x1::option::Option<0x1::type_name::TypeName>) : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18 {
        if (0x1::option::is_none<0x1::type_name::TypeName>(&arg1)) {
            return 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::zero()
        };
        let v0 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::zero();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolLiquidity>(arg0)) {
            if (0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::witness_type_name(0x1::vector::borrow<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolLiquidity>(arg0, v1)) == *0x1::option::borrow<0x1::type_name::TypeName>(&arg1)) {
                v0 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::apr(0x1::vector::borrow<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolLiquidity>(arg0, v1));
            };
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun consume_protocol_earnings<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRequest<T0>) : vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolLiquidity> {
        let (v0, v1) = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::consume<T0>(0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::extended_field::borrow_mut<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRegistry>(&mut arg0.registry), arg1);
        let v2 = v0;
        let v3 = 0x2::balance::value<T0>(&v2);
        let v4 = 0x14844479546b92d12dc4c8476cbcb112b730d11341e01ee3a9f7146b88cfba77::bps::calc_up(0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::fee_config::protocol(&arg0.fee_config), v3);
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::fee_balances::add_protocol<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut v2, v4));
        let v5 = v3 - v4;
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::exchange_rate::add_earnings(&mut arg0.exchange_rate, v5);
        0x2::balance::join<T0>(&mut arg0.balance, v2);
        arg0.total_coin_in = arg0.total_coin_in + v5;
        arg0.available_liquidity = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::add(arg0.available_liquidity, 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(v5, 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_coin_metadata::decimals(0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::extended_field::borrow<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_coin_metadata::SamMetadata>(&arg0.metadata))));
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_events::earnings<T0>(v4, v5);
        v1
    }

    public(friend) fun consume_withdraw<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::WithdrawRequest<T0>, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(!arg0.paused, 11);
        let (v0, v1) = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::wdr::consume<T0>(arg1);
        let v2 = v0;
        let v3 = 0x14844479546b92d12dc4c8476cbcb112b730d11341e01ee3a9f7146b88cfba77::bps::calc_up(0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::fee_config::withdraw(&arg0.fee_config), 0x2::balance::value<T0>(&v2));
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::fee_balances::add_withdraw<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut v2, v3));
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_events::protocol_withdraw<T0, T1>(v3, 0x2::balance::value<T0>(&v2), 0x2::tx_context::sender(arg2), v1, 0x2::balance::value<T0>(&v2));
        v2
    }

    public(friend) fun deployed_liquidity<T0, T1>(arg0: &SamStateV1<T0, T1>) : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18 {
        arg0.deployed_liquidity
    }

    public(friend) fun fees<T0, T1>(arg0: &SamStateV1<T0, T1>) : &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::fee_balances::FeeBalances<T0> {
        &arg0.fees
    }

    public(friend) fun get_metadata<T0, T1>(arg0: &SamStateV1<T0, T1>) : &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_coin_metadata::SamMetadata {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::extended_field::borrow<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_coin_metadata::SamMetadata>(&arg0.metadata)
    }

    public(friend) fun get_registry<T0, T1>(arg0: &SamStateV1<T0, T1>) : &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRegistry {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::extended_field::borrow<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRegistry>(&arg0.registry)
    }

    public(friend) fun get_treasury<T0, T1>(arg0: &SamStateV1<T0, T1>) : &0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_coin_treasury::SamTreasury<T1> {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::extended_field::borrow<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_coin_treasury::SamTreasury<T1>>(&arg0.treasury)
    }

    public(friend) fun paused<T0, T1>(arg0: &SamStateV1<T0, T1>) : bool {
        arg0.paused
    }

    fun point_of<T0, T1>(arg0: &SamStateV1<T0, T1>, arg1: 0x1::type_name::TypeName) : (0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18, 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18) {
        let v0 = PointKey{pos0: arg1};
        if (0x2::dynamic_field::exists_<PointKey>(&arg0.id, v0)) {
            let v3 = 0x2::dynamic_field::borrow<PointKey, 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolPoint>(&arg0.id, v0);
            (0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::point_apr(v3), 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::point_depth(v3))
        } else {
            (0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::zero(), 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::zero())
        }
    }

    public(friend) fun rebalance_auto<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: vector<0x1::option::Option<0x1::type_name::TypeName>>, arg2: vector<0x1::option::Option<0x1::type_name::TypeName>>, arg3: vector<u64>, arg4: &vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolLiquidity>, arg5: &0x2::tx_context::TxContext) : vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T0>> {
        assert!(0x1::vector::length<0x1::option::Option<0x1::type_name::TypeName>>(&arg1) == 0x1::vector::length<0x1::option::Option<0x1::type_name::TypeName>>(&arg2), 14);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::option::Option<0x1::type_name::TypeName>>(&arg1)) {
            assert!(0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::gte(apr_of(arg4, *0x1::vector::borrow<0x1::option::Option<0x1::type_name::TypeName>>(&arg2, v0)), apr_of(arg4, *0x1::vector::borrow<0x1::option::Option<0x1::type_name::TypeName>>(&arg1, v0))), 15);
            v0 = v0 + 1;
        };
        rebalance<T0, T1>(arg0, arg1, arg2, arg3, arg5)
    }

    public(friend) fun rebalance_optimal<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: &0x2::tx_context::TxContext) : vector<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T0>> {
        assert!(!arg0.paused, 11);
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        let v1 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::get_all_type_names(0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::extended_field::borrow<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRegistry>(&arg0.registry));
        let v2 = 0x1::vector::empty<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T0>>();
        if (v0 == 0 || 0x1::vector::is_empty<0x1::type_name::TypeName>(&v1)) {
            return v2
        };
        let v3 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_coin_metadata::decimals(0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::extended_field::borrow<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_coin_metadata::SamMetadata>(&arg0.metadata));
        let v4 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::zero();
        let v5 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::zero();
        let v6 = &v1;
        let v7 = 0;
        while (v7 < 0x1::vector::length<0x1::type_name::TypeName>(v6)) {
            let (v8, v9) = point_of<T0, T1>(arg0, *0x1::vector::borrow<0x1::type_name::TypeName>(v6, v7));
            v4 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::add(v4, 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::mul_down(v8, v9));
            v5 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::add(v5, v9);
            v7 = v7 + 1;
        };
        let v10 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::is_zero(v4);
        let v11 = if (v10) {
            v5
        } else {
            v4
        };
        if (0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::is_zero(v11)) {
            return v2
        };
        let v12 = 0x1::vector::length<0x1::type_name::TypeName>(&v1);
        let v13 = 0;
        let v14 = 0x1::vector::empty<0x1::option::Option<0x1::type_name::TypeName>>();
        let v15 = vector[];
        let v16 = 0;
        while (v16 < v12) {
            let v17 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v16);
            let (v18, v19) = point_of<T0, T1>(arg0, v17);
            let v20 = if (v10) {
                v19
            } else {
                0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::mul_down(v18, v19)
            };
            let v21 = if (v16 == v12 - 1) {
                v0 - v13
            } else {
                0x1::u64::min(0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::to_u64(0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::mul_down(0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::div_down(v20, v11), 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(v0, v3)), v3), v0 - v13)
            };
            let v22 = 0x1::u64::min(v21, 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::to_u64(v19, v3));
            if (v22 > 0) {
                let v23 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(v22, v3);
                arg0.available_liquidity = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::sub(arg0.available_liquidity, v23);
                arg0.deployed_liquidity = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::add(arg0.deployed_liquidity, v23);
                let v24 = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::new<T0>(v22, 0x1::option::none<0x1::type_name::TypeName>(), 0x1::option::some<0x1::type_name::TypeName>(v17));
                0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::fill_idle<T0>(&mut v24, 0x2::balance::split<T0>(&mut arg0.balance, v22));
                0x1::vector::push_back<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T0>>(&mut v2, v24);
                0x1::vector::push_back<0x1::option::Option<0x1::type_name::TypeName>>(&mut v14, 0x1::option::some<0x1::type_name::TypeName>(v17));
                0x1::vector::push_back<u64>(&mut v15, v22);
                v13 = v13 + v22;
            };
            v16 = v16 + 1;
        };
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_events::rebalance(0x1::vector::empty<0x1::option::Option<0x1::type_name::TypeName>>(), v14, v15, 0x2::tx_context::sender(arg1));
        v2
    }

    public(friend) fun reclaim_from_protocol<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::RebalanceRequest<T0>) {
        assert!(!arg0.paused, 11);
        0x2::balance::join<T0>(&mut arg0.balance, 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::rbr::consume_idle<T0>(arg1));
    }

    public(friend) fun record_point<T0, T1, T2>(arg0: &mut SamStateV1<T0, T1>, arg1: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18, arg2: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18) {
        let v0 = PointKey{pos0: 0x1::type_name::get<T2>()};
        if (0x2::dynamic_field::exists_<PointKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<PointKey, 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolPoint>(&mut arg0.id, v0) = 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::new_point(arg1, arg2);
        } else {
            0x2::dynamic_field::add<PointKey, 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolPoint>(&mut arg0.id, v0, 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::new_point(arg1, arg2));
        };
    }

    public(friend) fun register_protocol<T0, T1, T2>(arg0: &mut SamStateV1<T0, T1>) {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::add<T2>(0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::extended_field::borrow_mut<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRegistry>(&mut arg0.registry));
    }

    public(friend) fun set_paused<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: bool) {
        arg0.paused = arg1;
    }

    public(friend) fun total_coin_in<T0, T1>(arg0: &SamStateV1<T0, T1>) : u64 {
        arg0.total_coin_in
    }

    public(friend) fun unregister_protocol<T0, T1, T2>(arg0: &mut SamStateV1<T0, T1>) {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::remove<T2>(0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::extended_field::borrow_mut<0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::ptr::ProtocolRegistry>(&mut arg0.registry));
    }

    public(friend) fun update_deposit_fee<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: u64) {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::fee_config::set_deposit(&mut arg0.fee_config, arg1);
    }

    public(friend) fun update_protocol_fee<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: u64) {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::fee_config::set_protocol(&mut arg0.fee_config, arg1);
    }

    public(friend) fun update_withdraw_fee<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: u64) {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::fee_config::set_withdraw(&mut arg0.fee_config, arg1);
    }

    public(friend) fun withdraw_all_fees<T0, T1>(arg0: &mut SamStateV1<T0, T1>) : 0x2::balance::Balance<T0> {
        0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::fee_balances::withdraw_all<T0>(&mut arg0.fees)
    }

    // decompiled from Move bytecode v7
}

