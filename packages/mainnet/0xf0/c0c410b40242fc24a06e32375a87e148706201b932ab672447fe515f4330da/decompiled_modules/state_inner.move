module 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::state_inner {
    struct SamStateV1<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        paused: bool,
        decimals: u8,
        balance: 0x2::balance::Balance<T0>,
        total_coin_in: u64,
        deployed_liquidity: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18,
        available_liquidity: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18,
        exchange_rate: 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::exchange_rate::ExchangeRate,
        fees: 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::fee_balances::FeeBalances<T0>,
        fee_config: 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::fee_config::FeeConfig,
        allocation_config: AllocationConfig,
        incentive: IncentiveStream<T0>,
        registry: 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::ProtocolRegistry,
        treasury: 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam_coin_treasury::SamTreasury<T1>,
        metadata: 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam_coin_metadata::SamMetadata,
    }

    struct AllocationConfig has copy, drop, store {
        idle_buffer_bps: u64,
        max_exposure_bps: u64,
        max_depth_bps: u64,
    }

    struct IncentiveStream<phantom T0> has store {
        reserve: 0x2::balance::Balance<T0>,
        total: u64,
        released: u64,
        start_ms: u64,
        end_ms: u64,
    }

    public(friend) fun balance<T0, T1>(arg0: &SamStateV1<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public(friend) fun decimals<T0, T1>(arg0: &SamStateV1<T0, T1>) : u8 {
        arg0.decimals
    }

    public(friend) fun new<T0, T1>(arg0: 0x2::coin::TreasuryCap<T1>, arg1: &0x2::coin_registry::Currency<T1>, arg2: &mut 0x2::tx_context::TxContext) : SamStateV1<T0, T1> {
        let v0 = IncentiveStream<T0>{
            reserve  : 0x2::balance::zero<T0>(),
            total    : 0,
            released : 0,
            start_ms : 0,
            end_ms   : 0,
        };
        let v1 = AllocationConfig{
            idle_buffer_bps  : 500,
            max_exposure_bps : 7000,
            max_depth_bps    : 5000,
        };
        let v2 = SamStateV1<T0, T1>{
            id                  : 0x2::object::new(arg2),
            paused              : false,
            decimals            : 0x2::coin_registry::decimals<T1>(arg1),
            balance             : 0x2::balance::zero<T0>(),
            total_coin_in       : 0,
            deployed_liquidity  : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::zero(),
            available_liquidity : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::zero(),
            exchange_rate       : 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::exchange_rate::empty(),
            fees                : 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::fee_balances::new<T0>(),
            fee_config          : 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::fee_config::new(),
            allocation_config   : v1,
            incentive           : v0,
            registry            : 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::new(),
            treasury            : 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam_coin_treasury::new<T1>(arg0),
            metadata            : 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam_coin_metadata::new<T1>(arg1),
        };
        0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam_events::new_state<T0, T1>(0x2::object::uid_to_inner(&v2.id), 0x2::coin_registry::decimals<T1>(arg1), 0x2::coin_registry::name<T1>(arg1), 0x2::coin_registry::symbol<T1>(arg1));
        v2
    }

    public(friend) fun exchange_rate<T0, T1>(arg0: &SamStateV1<T0, T1>) : 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::exchange_rate::ExchangeRate {
        arg0.exchange_rate
    }

    public(friend) fun fee_config<T0, T1>(arg0: &SamStateV1<T0, T1>) : 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::fee_config::FeeConfig {
        arg0.fee_config
    }

    public(friend) fun deposit<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(!arg0.paused, 11);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 12);
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let v1 = 0x2::balance::value<T0>(&v0);
        let v2 = v1;
        let v3 = 0x14844479546b92d12dc4c8476cbcb112b730d11341e01ee3a9f7146b88cfba77::bps::calc_up(0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::fee_config::deposit(&arg0.fee_config), v1);
        if (v3 > 0) {
            0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::fee_balances::add_deposit<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut v0, v3));
            v2 = v1 - v3;
        };
        0x2::balance::join<T0>(&mut arg0.balance, v0);
        arg0.total_coin_in = arg0.total_coin_in + v2;
        arg0.available_liquidity = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::add(arg0.available_liquidity, 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(v2, arg0.decimals));
        let v4 = 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::exchange_rate::add_coin_in_down(&mut arg0.exchange_rate, v2);
        assert!(v4 > 0, 17);
        0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam_events::deposit<T0, T1>(v3, v2, v4, 0x2::tx_context::sender(arg2));
        0x2::coin::mint<T1>(0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam_coin_treasury::inner_mut<T1>(&mut arg0.treasury), v4, arg2)
    }

    public(friend) fun withdraw<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: vector<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::ProtocolLiquidity>, arg3: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, vector<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::wdr::WithdrawRequest<T0>>, vector<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::RebalanceRequest<T0>>) {
        assert!(!arg0.paused, 11);
        assert!(0x2::coin::value<T1>(&arg1) > 0, 12);
        let v0 = 0x2::coin::value<T1>(&arg1);
        let v1 = 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::exchange_rate::sub_sam_down(&mut arg0.exchange_rate, v0);
        0x2::coin::burn<T1>(0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam_coin_treasury::inner_mut<T1>(&mut arg0.treasury), arg1);
        let v2 = 0x2::balance::value<T0>(&arg0.balance);
        let v3 = 0x1::u64::min(v1, v2);
        let v4 = 0x2::balance::split<T0>(&mut arg0.balance, v3);
        let v5 = arg0.decimals;
        arg0.available_liquidity = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::sub(arg0.available_liquidity, 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(v3, v5));
        arg0.total_coin_in = arg0.total_coin_in - v1;
        let v6 = 0x14844479546b92d12dc4c8476cbcb112b730d11341e01ee3a9f7146b88cfba77::bps::calc_up(0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::fee_config::withdraw(&arg0.fee_config), 0x2::balance::value<T0>(&v4));
        if (v6 > 0) {
            0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::fee_balances::add_withdraw<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut v4, v6));
        };
        if (v1 <= v2) {
            0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam_events::withdraw<T0, T1>(v6, v0, v1, 0x2::tx_context::sender(arg3), 0x1::vector::empty<0x1::type_name::TypeName>(), vector[], v3);
            return (v4, 0x1::vector::empty<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::wdr::WithdrawRequest<T0>>(), 0x1::vector::empty<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::RebalanceRequest<T0>>())
        };
        let v7 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::zero();
        0x1::vector::reverse<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::ProtocolLiquidity>(&mut arg2);
        let v8 = 0;
        while (v8 < 0x1::vector::length<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::ProtocolLiquidity>(&arg2)) {
            let v9 = 0x1::vector::pop_back<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::ProtocolLiquidity>(&mut arg2);
            v7 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::add(v7, 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::available_liquidity(&v9));
            v8 = v8 + 1;
        };
        0x1::vector::destroy_empty<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::ProtocolLiquidity>(arg2);
        let v10 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::to_u64_up(v7, v5);
        let v11 = v1 - v2;
        let v12 = v11;
        if (v11 > v10) {
            assert!(v11 - v10 <= v11 / 100000 + 100, 13);
            v12 = v10;
            if (v10 == 0) {
                0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam_events::withdraw<T0, T1>(v6, v0, v1, 0x2::tx_context::sender(arg3), 0x1::vector::empty<0x1::type_name::TypeName>(), vector[], v3);
                return (v4, 0x1::vector::empty<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::wdr::WithdrawRequest<T0>>(), 0x1::vector::empty<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::RebalanceRequest<T0>>())
            };
        };
        let v13 = 0x1::vector::length<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::ProtocolLiquidity>(&arg2);
        let v14 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::zero();
        let v15 = 0x1::vector::empty<0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18>();
        let v16 = vector[];
        let v17 = &arg2;
        let v18 = 0;
        while (v18 < 0x1::vector::length<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::ProtocolLiquidity>(v17)) {
            let v19 = 0x1::vector::borrow<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::ProtocolLiquidity>(v17, v18);
            let v20 = 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::available_liquidity(v19);
            0x1::vector::push_back<u64>(&mut v16, 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::to_u64_up(v20, v5));
            let v21 = 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::apr(v19);
            let v22 = if (v21 == 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::zero()) {
                0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::one()
            } else {
                v21
            };
            let v23 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::mul_up(0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::div_up(v20, v7), 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::div_up(0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::one(), v22));
            v14 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::add(v14, v23);
            0x1::vector::push_back<0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18>(&mut v15, v23);
            v18 = v18 + 1;
        };
        let v24 = vector[];
        let v25 = 0;
        while (v25 < v13) {
            let v26 = 0x1::u64::min(0x1::u64::min(0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::to_u64_up(0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::mul_up(0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::div_up(*0x1::vector::borrow<0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18>(&v15, v25), v14), 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(v12, v5)), v5), *0x1::vector::borrow<u64>(&v16, v25)), v12);
            0x1::vector::push_back<u64>(&mut v24, v26);
            v12 = v12 - v26;
            v25 = v25 + 1;
        };
        v25 = 0;
        while (v25 < v13 && v12 > 0) {
            let v27 = 0x1::u64::min(*0x1::vector::borrow<u64>(&v16, v25) - *0x1::vector::borrow<u64>(&v24, v25), v12);
            *0x1::vector::borrow_mut<u64>(&mut v24, v25) = *0x1::vector::borrow<u64>(&v24, v25) + v27;
            v12 = v12 - v27;
            v25 = v25 + 1;
        };
        assert!(v12 == 0, 13);
        let v28 = 0x1::vector::empty<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::wdr::WithdrawRequest<T0>>();
        let v29 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v30 = vector[];
        v25 = 0;
        while (v25 < v13) {
            let v31 = *0x1::vector::borrow<u64>(&v24, v25);
            if (v31 > 0) {
                let v32 = 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::witness_type_name(0x1::vector::borrow<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::ProtocolLiquidity>(&arg2, v25));
                0x1::vector::push_back<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::wdr::WithdrawRequest<T0>>(&mut v28, 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::wdr::new<T0>(v31, v32));
                0x1::vector::push_back<0x1::type_name::TypeName>(&mut v29, v32);
                0x1::vector::push_back<u64>(&mut v30, v31);
            };
            v25 = v25 + 1;
        };
        let v33 = idle_buffer_target<T0, T1>(arg0);
        let v34 = 0x1::vector::empty<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::RebalanceRequest<T0>>();
        let v35 = 0;
        v25 = 0;
        while (v25 < v13 && v35 < v33) {
            let v36 = 0x1::u64::min(*0x1::vector::borrow<u64>(&v16, v25) - *0x1::vector::borrow<u64>(&v24, v25), v33 - v35);
            if (v36 >= 1000) {
                0x1::vector::push_back<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::RebalanceRequest<T0>>(&mut v34, 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::new<T0>(v36, 0x1::option::some<0x1::type_name::TypeName>(0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::witness_type_name(0x1::vector::borrow<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::ProtocolLiquidity>(&arg2, v25))), 0x1::option::none<0x1::type_name::TypeName>()));
                v35 = v35 + v36;
            };
            v25 = v25 + 1;
        };
        0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam_events::withdraw<T0, T1>(v6, v0, v1, 0x2::tx_context::sender(arg3), v29, v30, v3);
        (v4, v28, v34)
    }

    public(friend) fun available_liquidity<T0, T1>(arg0: &SamStateV1<T0, T1>) : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18 {
        arg0.available_liquidity
    }

    public(friend) fun rebalance<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: vector<0x1::option::Option<0x1::type_name::TypeName>>, arg2: vector<0x1::option::Option<0x1::type_name::TypeName>>, arg3: vector<u64>, arg4: &0x2::tx_context::TxContext) : vector<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::RebalanceRequest<T0>> {
        assert!(!arg0.paused, 11);
        let v0 = 0x1::vector::length<0x1::option::Option<0x1::type_name::TypeName>>(&arg1);
        assert!(v0 == 0x1::vector::length<0x1::option::Option<0x1::type_name::TypeName>>(&arg2) && v0 == 0x1::vector::length<u64>(&arg3), 14);
        let v1 = &arg0.registry;
        let v2 = 0x1::vector::empty<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::RebalanceRequest<T0>>();
        let v3 = 0;
        while (v3 < v0) {
            let v4 = *0x1::vector::borrow<0x1::option::Option<0x1::type_name::TypeName>>(&arg1, v3);
            let v5 = *0x1::vector::borrow<0x1::option::Option<0x1::type_name::TypeName>>(&arg2, v3);
            let v6 = *0x1::vector::borrow<u64>(&arg3, v3);
            assert!(v6 > 0, 12);
            if (0x1::option::is_some<0x1::type_name::TypeName>(&v4)) {
                assert!(0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::contains_type_name(v1, *0x1::option::borrow<0x1::type_name::TypeName>(&v4)), 7);
            };
            if (0x1::option::is_some<0x1::type_name::TypeName>(&v5)) {
                assert!(0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::contains_type_name(v1, *0x1::option::borrow<0x1::type_name::TypeName>(&v5)), 7);
            };
            let v7 = 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::new<T0>(v6, v4, v5);
            let v8 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(v6, arg0.decimals);
            if (0x1::option::is_none<0x1::type_name::TypeName>(&v4)) {
                arg0.available_liquidity = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::sub(arg0.available_liquidity, v8);
                arg0.deployed_liquidity = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::add(arg0.deployed_liquidity, v8);
                0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::fill_idle<T0>(&mut v7, 0x2::balance::split<T0>(&mut arg0.balance, v6));
            };
            0x1::vector::push_back<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::RebalanceRequest<T0>>(&mut v2, v7);
            v3 = v3 + 1;
        };
        0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam_events::rebalance(arg1, arg2, arg3, 0x2::tx_context::sender(arg4));
        v2
    }

    public(friend) fun accrue_incentive<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = arg0.incentive.released;
        let v2 = arg0.incentive.start_ms;
        let v3 = arg0.incentive.end_ms;
        let v4 = if (v0 >= v3) {
            arg0.incentive.total
        } else if (v0 <= v2) {
            0
        } else {
            (((arg0.incentive.total as u128) * ((v0 - v2) as u128) / ((v3 - v2) as u128)) as u64)
        };
        if (v4 <= v1) {
            return
        };
        arg0.incentive.released = v4;
        let v5 = 0x2::balance::split<T0>(&mut arg0.incentive.reserve, v4 - v1);
        fold_earnings<T0, T1>(arg0, v5, 0);
    }

    public(friend) fun add_incentive<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(0x2::balance::value<T0>(&arg1) > 0, 12);
        accrue_incentive<T0, T1>(arg0, arg3);
        0x2::balance::join<T0>(&mut arg0.incentive.reserve, arg1);
        arg0.incentive.total = 0x2::balance::value<T0>(&arg0.incentive.reserve);
        arg0.incentive.released = 0;
        arg0.incentive.start_ms = 0x2::clock::timestamp_ms(arg3);
        arg0.incentive.end_ms = 0x2::clock::timestamp_ms(arg3) + arg2;
    }

    public(friend) fun allocate_to_protocol<T0, T1, T2: drop>(arg0: &SamStateV1<T0, T1>, arg1: 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::RebalanceRequest<T0>, arg2: T2) : 0x2::balance::Balance<T0> {
        assert!(!arg0.paused, 11);
        0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::consume<T0, T2>(arg1, arg2)
    }

    public(friend) fun approve_protocol_request<T0: drop, T1, T2>(arg0: &mut SamStateV1<T1, T2>, arg1: &mut 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::ProtocolRequest<T1>, arg2: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18, arg3: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18, arg4: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18, arg5: 0x2::balance::Balance<T1>, arg6: T0) {
        0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::approve_request<T1, T0>(&arg0.registry, arg1, arg6, arg2, arg3, arg4, arg5);
    }

    public(friend) fun consume_protocol_earnings<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::ProtocolRequest<T0>) : vector<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::ProtocolLiquidity> {
        let (v0, v1) = 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::consume<T0>(&arg0.registry, arg1);
        let v2 = v0;
        let v3 = 0x14844479546b92d12dc4c8476cbcb112b730d11341e01ee3a9f7146b88cfba77::bps::calc_up(0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::fee_config::protocol(&arg0.fee_config), 0x2::balance::value<T0>(&v2));
        0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::fee_balances::add_protocol<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut v2, v3));
        fold_earnings<T0, T1>(arg0, v2, v3);
        v1
    }

    public(friend) fun consume_withdraw<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::wdr::WithdrawRequest<T0>, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(!arg0.paused, 11);
        let (v0, v1) = 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::wdr::consume<T0>(arg1);
        let v2 = v0;
        arg0.deployed_liquidity = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::sub(arg0.deployed_liquidity, 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(0x2::balance::value<T0>(&v2), arg0.decimals));
        let v3 = 0x14844479546b92d12dc4c8476cbcb112b730d11341e01ee3a9f7146b88cfba77::bps::calc_up(0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::fee_config::withdraw(&arg0.fee_config), 0x2::balance::value<T0>(&v2));
        if (v3 > 0) {
            0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::fee_balances::add_withdraw<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut v2, v3));
        };
        0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam_events::protocol_withdraw<T0, T1>(v3, 0x2::balance::value<T0>(&v2), 0x2::tx_context::sender(arg2), v1, 0x2::balance::value<T0>(&v2));
        v2
    }

    public(friend) fun deployed_liquidity<T0, T1>(arg0: &SamStateV1<T0, T1>) : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18 {
        arg0.deployed_liquidity
    }

    public(friend) fun fees<T0, T1>(arg0: &SamStateV1<T0, T1>) : &0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::fee_balances::FeeBalances<T0> {
        &arg0.fees
    }

    fun fold_earnings<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        if (0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::exchange_rate::sam(arg0.exchange_rate) == 0) {
            0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::fee_balances::add_protocol<T0>(&mut arg0.fees, arg1);
            0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam_events::earnings<T0>(arg2 + v0, 0);
            return
        };
        0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::exchange_rate::add_earnings(&mut arg0.exchange_rate, v0);
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
        arg0.total_coin_in = arg0.total_coin_in + v0;
        arg0.available_liquidity = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::add(arg0.available_liquidity, 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(v0, arg0.decimals));
        0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam_events::earnings<T0>(arg2, v0);
    }

    public(friend) fun get_allocation_config<T0, T1>(arg0: &SamStateV1<T0, T1>) : (u64, u64, u64) {
        (arg0.allocation_config.idle_buffer_bps, arg0.allocation_config.max_exposure_bps, arg0.allocation_config.max_depth_bps)
    }

    public(friend) fun get_metadata<T0, T1>(arg0: &SamStateV1<T0, T1>) : &0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam_coin_metadata::SamMetadata {
        &arg0.metadata
    }

    public(friend) fun get_registry<T0, T1>(arg0: &SamStateV1<T0, T1>) : &0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::ProtocolRegistry {
        &arg0.registry
    }

    public(friend) fun get_treasury<T0, T1>(arg0: &SamStateV1<T0, T1>) : &0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam_coin_treasury::SamTreasury<T1> {
        &arg0.treasury
    }

    fun idle_buffer_target<T0, T1>(arg0: &SamStateV1<T0, T1>) : u64 {
        (((arg0.total_coin_in as u128) * (arg0.allocation_config.idle_buffer_bps as u128) / 10000) as u64)
    }

    public(friend) fun paused<T0, T1>(arg0: &SamStateV1<T0, T1>) : bool {
        arg0.paused
    }

    public(friend) fun rebalance_optimal<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: &vector<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::ProtocolLiquidity>, arg2: &0x2::tx_context::TxContext) : vector<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::RebalanceRequest<T0>> {
        assert!(!arg0.paused, 11);
        let v0 = 0x1::vector::empty<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::RebalanceRequest<T0>>();
        let v1 = 0x1::vector::length<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::ProtocolLiquidity>(arg1);
        if (v1 == 0) {
            return v0
        };
        let v2 = arg0.decimals;
        let (_, v4, v5) = get_allocation_config<T0, T1>(arg0);
        let v6 = vector[];
        let v7 = 0;
        let v8 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::zero();
        let v9 = 0;
        while (v9 < 0x1::vector::length<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::ProtocolLiquidity>(arg1)) {
            let v10 = 0x1::vector::borrow<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::ProtocolLiquidity>(arg1, v9);
            let v11 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::to_u64(0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::available_liquidity(v10), v2);
            0x1::vector::push_back<u64>(&mut v6, v11);
            v7 = v7 + v11;
            v8 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::add(v8, 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::apr(v10));
            v9 = v9 + 1;
        };
        let v12 = 0x2::balance::value<T0>(&arg0.balance);
        let v13 = v12 + v7;
        let v14 = idle_buffer_target<T0, T1>(arg0);
        let v15 = if (v13 > v14) {
            v13 - v14
        } else {
            0
        };
        if (v15 == 0) {
            return v0
        };
        let v16 = if (v12 > v14) {
            v12 - v14
        } else {
            0
        };
        let v17 = if (v1 <= 1) {
            v15
        } else {
            (((v15 as u128) * (v4 as u128) / 10000) as u64)
        };
        let v18 = vector[];
        let v19 = vector[];
        let v20 = 0;
        while (v20 < v1) {
            let v21 = 0x1::vector::borrow<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::ProtocolLiquidity>(arg1, v20);
            let v22 = if (0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::is_zero(v8)) {
                v15 / v1
            } else {
                0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::to_u64(0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::mul_down(0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::div_down(0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::apr(v21), v8), 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(v15, v2)), v2)
            };
            let v23 = 0x1::u64::min(0x1::u64::min(v22, v17), (((0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::to_u64(0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::depth(v21), v2) as u128) * (v5 as u128) / 10000) as u64));
            0x1::vector::push_back<u64>(&mut v18, v23);
            let v24 = *0x1::vector::borrow<u64>(&v6, v20);
            let v25 = if (v24 > v23) {
                v24 - v23
            } else {
                0
            };
            0x1::vector::push_back<u64>(&mut v19, v25);
            v20 = v20 + 1;
        };
        let v26 = 0x1::vector::empty<0x1::option::Option<0x1::type_name::TypeName>>();
        let v27 = 0x1::vector::empty<0x1::option::Option<0x1::type_name::TypeName>>();
        let v28 = vector[];
        let v29 = v16;
        let v30 = 0;
        while (v30 < v1) {
            let v31 = *0x1::vector::borrow<u64>(&v6, v30);
            let v32 = *0x1::vector::borrow<u64>(&v18, v30);
            if (v32 > v31) {
                let v33 = 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::witness_type_name(0x1::vector::borrow<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::ProtocolLiquidity>(arg1, v30));
                let v34 = v32 - v31;
                let v35 = v34;
                let v36 = 0x1::u64::min(v34, v29);
                if (v36 >= 1000) {
                    let v37 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(v36, v2);
                    arg0.available_liquidity = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::sub(arg0.available_liquidity, v37);
                    arg0.deployed_liquidity = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::add(arg0.deployed_liquidity, v37);
                    let v38 = 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::new<T0>(v36, 0x1::option::none<0x1::type_name::TypeName>(), 0x1::option::some<0x1::type_name::TypeName>(v33));
                    0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::fill_idle<T0>(&mut v38, 0x2::balance::split<T0>(&mut arg0.balance, v36));
                    0x1::vector::push_back<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::RebalanceRequest<T0>>(&mut v0, v38);
                    0x1::vector::push_back<0x1::option::Option<0x1::type_name::TypeName>>(&mut v26, 0x1::option::none<0x1::type_name::TypeName>());
                    0x1::vector::push_back<0x1::option::Option<0x1::type_name::TypeName>>(&mut v27, 0x1::option::some<0x1::type_name::TypeName>(v33));
                    0x1::vector::push_back<u64>(&mut v28, v36);
                    v29 = v29 - v36;
                    v35 = v34 - v36;
                };
                let v39 = 0;
                while (v39 < v1 && v35 >= 1000) {
                    let v40 = *0x1::vector::borrow<u64>(&v19, v39);
                    if (v39 != v30 && v40 >= 1000) {
                        let v41 = 0x1::u64::min(v35, v40);
                        let v42 = 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::witness_type_name(0x1::vector::borrow<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::ProtocolLiquidity>(arg1, v39));
                        0x1::vector::push_back<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::RebalanceRequest<T0>>(&mut v0, 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::new<T0>(v41, 0x1::option::some<0x1::type_name::TypeName>(v42), 0x1::option::some<0x1::type_name::TypeName>(v33)));
                        0x1::vector::push_back<0x1::option::Option<0x1::type_name::TypeName>>(&mut v26, 0x1::option::some<0x1::type_name::TypeName>(v42));
                        0x1::vector::push_back<0x1::option::Option<0x1::type_name::TypeName>>(&mut v27, 0x1::option::some<0x1::type_name::TypeName>(v33));
                        0x1::vector::push_back<u64>(&mut v28, v41);
                        *0x1::vector::borrow_mut<u64>(&mut v19, v39) = v40 - v41;
                        v35 = v35 - v41;
                    };
                    v39 = v39 + 1;
                };
            };
            v30 = v30 + 1;
        };
        let v43 = if (v12 < v14) {
            v14 - v12
        } else {
            0
        };
        let v44 = v43;
        let v45 = 0;
        while (v45 < v1 && v44 >= 1000) {
            let v46 = *0x1::vector::borrow<u64>(&v19, v45);
            if (v46 >= 1000) {
                let v47 = 0x1::u64::min(v44, v46);
                let v48 = 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::witness_type_name(0x1::vector::borrow<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::ProtocolLiquidity>(arg1, v45));
                0x1::vector::push_back<0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::RebalanceRequest<T0>>(&mut v0, 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::new<T0>(v47, 0x1::option::some<0x1::type_name::TypeName>(v48), 0x1::option::none<0x1::type_name::TypeName>()));
                0x1::vector::push_back<0x1::option::Option<0x1::type_name::TypeName>>(&mut v26, 0x1::option::some<0x1::type_name::TypeName>(v48));
                0x1::vector::push_back<0x1::option::Option<0x1::type_name::TypeName>>(&mut v27, 0x1::option::none<0x1::type_name::TypeName>());
                0x1::vector::push_back<u64>(&mut v28, v47);
                *0x1::vector::borrow_mut<u64>(&mut v19, v45) = v46 - v47;
                v44 = v44 - v47;
            };
            v45 = v45 + 1;
        };
        0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam_events::rebalance(v26, v27, v28, 0x2::tx_context::sender(arg2));
        v0
    }

    public(friend) fun reclaim_from_protocol<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::RebalanceRequest<T0>) {
        assert!(!arg0.paused, 11);
        let v0 = 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::rbr::consume_idle<T0>(arg1);
        let v1 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(0x2::balance::value<T0>(&v0), arg0.decimals);
        arg0.deployed_liquidity = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::sub(arg0.deployed_liquidity, v1);
        arg0.available_liquidity = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::add(arg0.available_liquidity, v1);
        0x2::balance::join<T0>(&mut arg0.balance, v0);
    }

    public(friend) fun refresh_metadata<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: &0x2::coin_registry::Currency<T1>) {
        arg0.metadata = 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::sam_coin_metadata::new<T1>(arg1);
    }

    public(friend) fun register_protocol<T0, T1, T2>(arg0: &mut SamStateV1<T0, T1>) {
        0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::add<T2>(&mut arg0.registry);
    }

    public(friend) fun set_allocation_config<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = if (arg1 <= 10000) {
            if (arg2 <= 10000) {
                arg3 <= 10000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 16);
        let v1 = AllocationConfig{
            idle_buffer_bps  : arg1,
            max_exposure_bps : arg2,
            max_depth_bps    : arg3,
        };
        arg0.allocation_config = v1;
    }

    public(friend) fun set_paused<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: bool) {
        arg0.paused = arg1;
    }

    public(friend) fun total_coin_in<T0, T1>(arg0: &SamStateV1<T0, T1>) : u64 {
        arg0.total_coin_in
    }

    public(friend) fun unregister_protocol<T0, T1, T2>(arg0: &mut SamStateV1<T0, T1>, arg1: 0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::ProtocolRequest<T0>) {
        assert!(0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::is_zero(0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::available_of<T0, T2>(&arg1)), 19);
        consume_protocol_earnings<T0, T1>(arg0, arg1);
        0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::ptr::remove<T2>(&mut arg0.registry);
    }

    public(friend) fun update_deposit_fee<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: u64) {
        0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::fee_config::set_deposit(&mut arg0.fee_config, arg1);
    }

    public(friend) fun update_protocol_fee<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: u64) {
        0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::fee_config::set_protocol(&mut arg0.fee_config, arg1);
    }

    public(friend) fun update_withdraw_fee<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: u64) {
        0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::fee_config::set_withdraw(&mut arg0.fee_config, arg1);
    }

    public(friend) fun withdraw_all_fees<T0, T1>(arg0: &mut SamStateV1<T0, T1>) : 0x2::balance::Balance<T0> {
        0xf0c0c410b40242fc24a06e32375a87e148706201b932ab672447fe515f4330da::fee_balances::withdraw_all<T0>(&mut arg0.fees)
    }

    // decompiled from Move bytecode v7
}

