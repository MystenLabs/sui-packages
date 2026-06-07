module 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::state_inner {
    struct SamStateV1<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        paused: bool,
        decimals: u8,
        balance: 0x2::balance::Balance<T0>,
        total_coin_in: u64,
        deployed_liquidity: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18,
        available_liquidity: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18,
        exchange_rate: 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::exchange_rate::ExchangeRate,
        fees: 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::fee_balances::FeeBalances<T0>,
        fee_config: 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::fee_config::FeeConfig,
        allocation_config: AllocationConfig,
        incentive: IncentiveStream<T0>,
        points: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolPoint>,
        registry: 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::extended_field::ExtendedField<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolRegistry>,
        treasury: 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::extended_field::ExtendedField<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::sam_coin_treasury::SamTreasury<T1>>,
        metadata: 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::extended_field::ExtendedField<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::sam_coin_metadata::SamMetadata>,
    }

    struct AllocationConfig has copy, drop, store {
        idle_buffer_bps: u64,
        max_exposure_bps: u64,
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
        };
        let v2 = SamStateV1<T0, T1>{
            id                  : 0x2::object::new(arg2),
            paused              : false,
            decimals            : 0x2::coin_registry::decimals<T1>(arg1),
            balance             : 0x2::balance::zero<T0>(),
            total_coin_in       : 0,
            deployed_liquidity  : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::zero(),
            available_liquidity : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::zero(),
            exchange_rate       : 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::exchange_rate::empty(),
            fees                : 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::fee_balances::new<T0>(),
            fee_config          : 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::fee_config::new(),
            allocation_config   : v1,
            incentive           : v0,
            points              : 0x2::vec_map::empty<0x1::type_name::TypeName, 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolPoint>(),
            registry            : 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::extended_field::new<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolRegistry>(0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::new(arg2), arg2),
            treasury            : 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::extended_field::new<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::sam_coin_treasury::SamTreasury<T1>>(0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::sam_coin_treasury::new<T1>(arg0, arg2), arg2),
            metadata            : 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::extended_field::new<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::sam_coin_metadata::SamMetadata>(0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::sam_coin_metadata::new<T1>(arg1), arg2),
        };
        0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::sam_events::new_state<T0, T1>(0x2::object::uid_to_inner(&v2.id), 0x2::coin_registry::decimals<T1>(arg1), 0x2::coin_registry::name<T1>(arg1), 0x2::coin_registry::symbol<T1>(arg1));
        v2
    }

    public(friend) fun exchange_rate<T0, T1>(arg0: &SamStateV1<T0, T1>) : 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::exchange_rate::ExchangeRate {
        arg0.exchange_rate
    }

    public(friend) fun fee_config<T0, T1>(arg0: &SamStateV1<T0, T1>) : 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::fee_config::FeeConfig {
        arg0.fee_config
    }

    public(friend) fun deposit<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(!arg0.paused, 11);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 12);
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let v1 = 0x2::balance::value<T0>(&v0);
        let v2 = 0x14844479546b92d12dc4c8476cbcb112b730d11341e01ee3a9f7146b88cfba77::bps::calc_up(0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::fee_config::deposit(&arg0.fee_config), v1);
        0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::fee_balances::add_deposit<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut v0, v2));
        let v3 = v1 - v2;
        0x2::balance::join<T0>(&mut arg0.balance, v0);
        arg0.total_coin_in = arg0.total_coin_in + v3;
        arg0.available_liquidity = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::add(arg0.available_liquidity, 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(v3, arg0.decimals));
        let v4 = 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::exchange_rate::add_coin_in_down(&mut arg0.exchange_rate, v3);
        assert!(v4 > 0, 17);
        0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::sam_events::deposit<T0, T1>(v2, v3, v4, 0x2::tx_context::sender(arg2));
        0x2::coin::mint<T1>(0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::sam_coin_treasury::inner_mut<T1>(0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::extended_field::borrow_mut<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::sam_coin_treasury::SamTreasury<T1>>(&mut arg0.treasury)), v4, arg2)
    }

    public(friend) fun withdraw<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: vector<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolLiquidity>, arg3: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, vector<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::wdr::WithdrawRequest<T0>>, vector<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::rbr::RebalanceRequest<T0>>) {
        assert!(!arg0.paused, 11);
        assert!(0x2::coin::value<T1>(&arg1) > 0, 12);
        let v0 = 0x2::coin::value<T1>(&arg1);
        let v1 = 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::exchange_rate::sub_sam_down(&mut arg0.exchange_rate, v0);
        0x2::coin::burn<T1>(0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::sam_coin_treasury::inner_mut<T1>(0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::extended_field::borrow_mut<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::sam_coin_treasury::SamTreasury<T1>>(&mut arg0.treasury)), arg1);
        let v2 = 0x2::balance::value<T0>(&arg0.balance);
        let v3 = 0x2::balance::split<T0>(&mut arg0.balance, 0x1::u64::min(v1, v2));
        let v4 = arg0.decimals;
        arg0.available_liquidity = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::sub(arg0.available_liquidity, 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(0x1::u64::min(v1, v2), v4));
        arg0.total_coin_in = arg0.total_coin_in - v1;
        let v5 = 0x14844479546b92d12dc4c8476cbcb112b730d11341e01ee3a9f7146b88cfba77::bps::calc_up(0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::fee_config::withdraw(&arg0.fee_config), 0x2::balance::value<T0>(&v3));
        0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::fee_balances::add_withdraw<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut v3, v5));
        let v6 = 0x1::vector::empty<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::wdr::WithdrawRequest<T0>>();
        if (v1 <= v2) {
            0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::sam_events::withdraw<T0, T1>(v5, v0, v1, 0x2::tx_context::sender(arg3), 0x1::vector::empty<0x1::type_name::TypeName>(), vector[], v1);
            return (v3, v6, 0x1::vector::empty<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::rbr::RebalanceRequest<T0>>())
        };
        let v7 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::zero();
        0x1::vector::reverse<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolLiquidity>(&mut arg2);
        let v8 = 0;
        while (v8 < 0x1::vector::length<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolLiquidity>(&arg2)) {
            let v9 = 0x1::vector::pop_back<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolLiquidity>(&mut arg2);
            v7 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::add(v7, 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::available_liquidity(&v9));
            v8 = v8 + 1;
        };
        0x1::vector::destroy_empty<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolLiquidity>(arg2);
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
        0x1::vector::reverse<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolLiquidity>(&mut arg2);
        let v15 = 0;
        while (v15 < 0x1::vector::length<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolLiquidity>(&arg2)) {
            let v16 = 0x1::vector::pop_back<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolLiquidity>(&mut arg2);
            let v17 = 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::apr(&v16);
            let v18 = if (v17 == 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::zero()) {
                0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::one()
            } else {
                v17
            };
            let v19 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::mul_up(0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::div_up(0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::available_liquidity(&v16), v7), 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::div_up(0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::one(), v18));
            v13 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::add(v13, v19);
            0x1::vector::push_back<0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18>(&mut v14, v19);
            v15 = v15 + 1;
        };
        0x1::vector::destroy_empty<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolLiquidity>(arg2);
        let v20 = 0x1::vector::length<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolLiquidity>(&arg2);
        let v21 = vector[];
        let v22 = 0;
        while (v22 < v20) {
            let v23 = 0x1::u64::min(0x1::u64::min(0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::to_u64_up(0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::mul_up(0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::div_up(*0x1::vector::borrow<0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18>(&v14, v22), v13), 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(v12, v4)), v4), 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::to_u64_up(0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::available_liquidity(0x1::vector::borrow<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolLiquidity>(&arg2, v22)), v4)), v12);
            0x1::vector::push_back<u64>(&mut v21, v23);
            v12 = v12 - v23;
            v22 = v22 + 1;
        };
        v22 = 0;
        while (v22 < v20 && v12 > 0) {
            let v24 = 0x1::u64::min(0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::to_u64_up(0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::available_liquidity(0x1::vector::borrow<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolLiquidity>(&arg2, v22)), v4) - *0x1::vector::borrow<u64>(&v21, v22), v12);
            *0x1::vector::borrow_mut<u64>(&mut v21, v22) = *0x1::vector::borrow<u64>(&v21, v22) + v24;
            v12 = v12 - v24;
            v22 = v22 + 1;
        };
        assert!(v12 == 0, 13);
        v22 = 0;
        while (v22 < v20) {
            let v25 = *0x1::vector::borrow<u64>(&v21, v22);
            if (v25 > 0) {
                0x1::vector::push_back<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::wdr::WithdrawRequest<T0>>(&mut v6, 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::wdr::new<T0>(v25, 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::witness_type_name(0x1::vector::borrow<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolLiquidity>(&arg2, v22))));
            };
            v22 = v22 + 1;
        };
        let (v26, _) = get_allocation_config<T0, T1>(arg0);
        let v28 = (((arg0.total_coin_in as u128) * (v26 as u128) / 10000) as u64);
        let v29 = 0x1::vector::empty<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::rbr::RebalanceRequest<T0>>();
        let v30 = 0;
        v22 = 0;
        while (v22 < v20 && v30 < v28) {
            let v31 = 0x1::u64::min(0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::to_u64_up(0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::available_liquidity(0x1::vector::borrow<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolLiquidity>(&arg2, v22)), v4) - *0x1::vector::borrow<u64>(&v21, v22), v28 - v30);
            if (v31 >= 1000) {
                let v32 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(v31, v4);
                arg0.deployed_liquidity = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::sub(arg0.deployed_liquidity, v32);
                arg0.available_liquidity = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::add(arg0.available_liquidity, v32);
                0x1::vector::push_back<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::rbr::RebalanceRequest<T0>>(&mut v29, 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::rbr::new<T0>(v31, 0x1::option::some<0x1::type_name::TypeName>(0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::witness_type_name(0x1::vector::borrow<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolLiquidity>(&arg2, v22))), 0x1::option::none<0x1::type_name::TypeName>()));
                v30 = v30 + v31;
            };
            v22 = v22 + 1;
        };
        let v33 = &v6;
        let v34 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v35 = 0;
        while (v35 < 0x1::vector::length<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::wdr::WithdrawRequest<T0>>(v33)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v34, 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::wdr::get_witness<T0>(0x1::vector::borrow<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::wdr::WithdrawRequest<T0>>(v33, v35)));
            v35 = v35 + 1;
        };
        let v36 = &v6;
        let v37 = vector[];
        let v38 = 0;
        while (v38 < 0x1::vector::length<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::wdr::WithdrawRequest<T0>>(v36)) {
            0x1::vector::push_back<u64>(&mut v37, 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::wdr::get_coin_amount<T0>(0x1::vector::borrow<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::wdr::WithdrawRequest<T0>>(v36, v38)));
            v38 = v38 + 1;
        };
        0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::sam_events::withdraw<T0, T1>(v5, v0, v1, 0x2::tx_context::sender(arg3), v34, v37, 0x2::balance::value<T0>(&v3));
        (v3, v6, v29)
    }

    public(friend) fun available_liquidity<T0, T1>(arg0: &SamStateV1<T0, T1>) : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18 {
        arg0.available_liquidity
    }

    public(friend) fun rebalance<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: vector<0x1::option::Option<0x1::type_name::TypeName>>, arg2: vector<0x1::option::Option<0x1::type_name::TypeName>>, arg3: vector<u64>, arg4: &0x2::tx_context::TxContext) : vector<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::rbr::RebalanceRequest<T0>> {
        assert!(!arg0.paused, 11);
        assert!(0x1::vector::length<0x1::option::Option<0x1::type_name::TypeName>>(&arg1) == 0x1::vector::length<0x1::option::Option<0x1::type_name::TypeName>>(&arg2) && 0x1::vector::length<0x1::option::Option<0x1::type_name::TypeName>>(&arg1) == 0x1::vector::length<u64>(&arg3), 14);
        let v0 = 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::extended_field::borrow<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolRegistry>(&arg0.registry);
        let v1 = 0x1::vector::empty<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::rbr::RebalanceRequest<T0>>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::option::Option<0x1::type_name::TypeName>>(&arg1)) {
            let v3 = *0x1::vector::borrow<0x1::option::Option<0x1::type_name::TypeName>>(&arg1, v2);
            let v4 = *0x1::vector::borrow<0x1::option::Option<0x1::type_name::TypeName>>(&arg2, v2);
            let v5 = *0x1::vector::borrow<u64>(&arg3, v2);
            assert!(v5 > 0, 12);
            if (0x1::option::is_some<0x1::type_name::TypeName>(&v3)) {
                assert!(0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::contains_type_name(v0, *0x1::option::borrow<0x1::type_name::TypeName>(&v3)), 7);
            };
            if (0x1::option::is_some<0x1::type_name::TypeName>(&v4)) {
                assert!(0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::contains_type_name(v0, *0x1::option::borrow<0x1::type_name::TypeName>(&v4)), 7);
            };
            let v6 = 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::rbr::new<T0>(v5, v3, v4);
            let v7 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(v5, arg0.decimals);
            if (0x1::option::is_none<0x1::type_name::TypeName>(&v3)) {
                arg0.available_liquidity = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::sub(arg0.available_liquidity, v7);
                arg0.deployed_liquidity = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::add(arg0.deployed_liquidity, v7);
                0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::rbr::fill_idle<T0>(&mut v6, 0x2::balance::split<T0>(&mut arg0.balance, v5));
            };
            if (0x1::option::is_none<0x1::type_name::TypeName>(&v4)) {
                arg0.deployed_liquidity = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::sub(arg0.deployed_liquidity, v7);
                arg0.available_liquidity = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::add(arg0.available_liquidity, v7);
            };
            0x1::vector::push_back<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::rbr::RebalanceRequest<T0>>(&mut v1, v6);
            v2 = v2 + 1;
        };
        0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::sam_events::rebalance(arg1, arg2, arg3, 0x2::tx_context::sender(arg4));
        v1
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

    public(friend) fun allocate_to_protocol<T0, T1, T2: drop>(arg0: &SamStateV1<T0, T1>, arg1: 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::rbr::RebalanceRequest<T0>, arg2: T2) : 0x2::balance::Balance<T0> {
        assert!(!arg0.paused, 11);
        0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::rbr::consume<T0, T2>(arg1, arg2)
    }

    public(friend) fun approve_protocol_request<T0: drop, T1, T2>(arg0: &mut SamStateV1<T1, T2>, arg1: &mut 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolRequest<T1>, arg2: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18, arg3: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18, arg4: 0x2::balance::Balance<T1>, arg5: T0) {
        0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::approve_request<T1, T0>(0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::extended_field::borrow_mut<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolRegistry>(&mut arg0.registry), arg1, arg5, arg2, arg3, arg4);
    }

    public(friend) fun consume_protocol_earnings<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolRequest<T0>) : vector<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolLiquidity> {
        let (v0, v1) = 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::consume<T0>(0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::extended_field::borrow_mut<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolRegistry>(&mut arg0.registry), arg1);
        let v2 = v0;
        let v3 = 0x14844479546b92d12dc4c8476cbcb112b730d11341e01ee3a9f7146b88cfba77::bps::calc_up(0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::fee_config::protocol(&arg0.fee_config), 0x2::balance::value<T0>(&v2));
        0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::fee_balances::add_protocol<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut v2, v3));
        fold_earnings<T0, T1>(arg0, v2, v3);
        v1
    }

    public(friend) fun consume_withdraw<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::wdr::WithdrawRequest<T0>, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(!arg0.paused, 11);
        let (v0, v1) = 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::wdr::consume<T0>(arg1);
        let v2 = v0;
        let v3 = 0x14844479546b92d12dc4c8476cbcb112b730d11341e01ee3a9f7146b88cfba77::bps::calc_up(0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::fee_config::withdraw(&arg0.fee_config), 0x2::balance::value<T0>(&v2));
        0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::fee_balances::add_withdraw<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut v2, v3));
        0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::sam_events::protocol_withdraw<T0, T1>(v3, 0x2::balance::value<T0>(&v2), 0x2::tx_context::sender(arg2), v1, 0x2::balance::value<T0>(&v2));
        v2
    }

    public(friend) fun deployed_liquidity<T0, T1>(arg0: &SamStateV1<T0, T1>) : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18 {
        arg0.deployed_liquidity
    }

    public(friend) fun fees<T0, T1>(arg0: &SamStateV1<T0, T1>) : &0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::fee_balances::FeeBalances<T0> {
        &arg0.fees
    }

    fun fold_earnings<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        if (0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::exchange_rate::sam(arg0.exchange_rate) == 0) {
            0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::fee_balances::add_protocol<T0>(&mut arg0.fees, arg1);
            0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::sam_events::earnings<T0>(arg2 + v0, 0);
            return
        };
        0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::exchange_rate::add_earnings(&mut arg0.exchange_rate, v0);
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
        arg0.total_coin_in = arg0.total_coin_in + v0;
        arg0.available_liquidity = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::add(arg0.available_liquidity, 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(v0, arg0.decimals));
        0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::sam_events::earnings<T0>(arg2, v0);
    }

    public(friend) fun get_allocation_config<T0, T1>(arg0: &SamStateV1<T0, T1>) : (u64, u64) {
        (arg0.allocation_config.idle_buffer_bps, arg0.allocation_config.max_exposure_bps)
    }

    public(friend) fun get_metadata<T0, T1>(arg0: &SamStateV1<T0, T1>) : &0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::sam_coin_metadata::SamMetadata {
        0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::extended_field::borrow<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::sam_coin_metadata::SamMetadata>(&arg0.metadata)
    }

    public(friend) fun get_registry<T0, T1>(arg0: &SamStateV1<T0, T1>) : &0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolRegistry {
        0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::extended_field::borrow<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolRegistry>(&arg0.registry)
    }

    public(friend) fun get_treasury<T0, T1>(arg0: &SamStateV1<T0, T1>) : &0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::sam_coin_treasury::SamTreasury<T1> {
        0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::extended_field::borrow<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::sam_coin_treasury::SamTreasury<T1>>(&arg0.treasury)
    }

    public(friend) fun paused<T0, T1>(arg0: &SamStateV1<T0, T1>) : bool {
        arg0.paused
    }

    public(friend) fun rebalance_optimal<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: &vector<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolLiquidity>, arg2: &0x2::tx_context::TxContext) : vector<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::rbr::RebalanceRequest<T0>> {
        assert!(!arg0.paused, 11);
        let v0 = 0x1::vector::empty<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::rbr::RebalanceRequest<T0>>();
        let v1 = 0x1::vector::length<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolLiquidity>(arg1);
        if (v1 == 0) {
            return v0
        };
        let v2 = arg0.decimals;
        let (v3, v4) = get_allocation_config<T0, T1>(arg0);
        let v5 = vector[];
        let v6 = 0;
        let v7 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::zero();
        let v8 = 0;
        while (v8 < 0x1::vector::length<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolLiquidity>(arg1)) {
            let v9 = 0x1::vector::borrow<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolLiquidity>(arg1, v8);
            let v10 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::to_u64(0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::available_liquidity(v9), v2);
            0x1::vector::push_back<u64>(&mut v5, v10);
            v6 = v6 + v10;
            v7 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::add(v7, 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::apr(v9));
            v8 = v8 + 1;
        };
        let v11 = 0x2::balance::value<T0>(&arg0.balance);
        let v12 = v11 + v6;
        let v13 = (((arg0.total_coin_in as u128) * (v3 as u128) / 10000) as u64);
        let v14 = if (v12 > v13) {
            v12 - v13
        } else {
            0
        };
        if (v14 == 0) {
            return v0
        };
        let v15 = if (v11 > v13) {
            v11 - v13
        } else {
            0
        };
        let v16 = if (v1 <= 1) {
            v14
        } else {
            (((v14 as u128) * (v4 as u128) / 10000) as u64)
        };
        let v17 = vector[];
        let v18 = vector[];
        let v19 = 0;
        while (v19 < v1) {
            let v20 = if (0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::is_zero(v7)) {
                v14 / v1
            } else {
                0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::to_u64(0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::mul_down(0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::div_down(0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::apr(0x1::vector::borrow<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolLiquidity>(arg1, v19)), v7), 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(v14, v2)), v2)
            };
            let v21 = 0x1::u64::min(v20, v16);
            0x1::vector::push_back<u64>(&mut v17, v21);
            let v22 = *0x1::vector::borrow<u64>(&v5, v19);
            let v23 = if (v22 > v21) {
                v22 - v21
            } else {
                0
            };
            0x1::vector::push_back<u64>(&mut v18, v23);
            v19 = v19 + 1;
        };
        let v24 = 0x1::vector::empty<0x1::option::Option<0x1::type_name::TypeName>>();
        let v25 = 0x1::vector::empty<0x1::option::Option<0x1::type_name::TypeName>>();
        let v26 = vector[];
        let v27 = v15;
        let v28 = 0;
        while (v28 < v1) {
            let v29 = *0x1::vector::borrow<u64>(&v5, v28);
            let v30 = *0x1::vector::borrow<u64>(&v17, v28);
            if (v30 > v29) {
                let v31 = 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::witness_type_name(0x1::vector::borrow<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolLiquidity>(arg1, v28));
                let v32 = v30 - v29;
                let v33 = v32;
                let v34 = 0x1::u64::min(v32, v27);
                if (v34 >= 1000) {
                    let v35 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(v34, v2);
                    arg0.available_liquidity = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::sub(arg0.available_liquidity, v35);
                    arg0.deployed_liquidity = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::add(arg0.deployed_liquidity, v35);
                    let v36 = 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::rbr::new<T0>(v34, 0x1::option::none<0x1::type_name::TypeName>(), 0x1::option::some<0x1::type_name::TypeName>(v31));
                    0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::rbr::fill_idle<T0>(&mut v36, 0x2::balance::split<T0>(&mut arg0.balance, v34));
                    0x1::vector::push_back<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::rbr::RebalanceRequest<T0>>(&mut v0, v36);
                    0x1::vector::push_back<0x1::option::Option<0x1::type_name::TypeName>>(&mut v24, 0x1::option::none<0x1::type_name::TypeName>());
                    0x1::vector::push_back<0x1::option::Option<0x1::type_name::TypeName>>(&mut v25, 0x1::option::some<0x1::type_name::TypeName>(v31));
                    0x1::vector::push_back<u64>(&mut v26, v34);
                    v27 = v27 - v34;
                    v33 = v32 - v34;
                };
                let v37 = 0;
                while (v37 < v1 && v33 >= 1000) {
                    let v38 = *0x1::vector::borrow<u64>(&v18, v37);
                    if (v37 != v28 && v38 >= 1000) {
                        let v39 = 0x1::u64::min(v33, v38);
                        let v40 = 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::witness_type_name(0x1::vector::borrow<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolLiquidity>(arg1, v37));
                        0x1::vector::push_back<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::rbr::RebalanceRequest<T0>>(&mut v0, 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::rbr::new<T0>(v39, 0x1::option::some<0x1::type_name::TypeName>(v40), 0x1::option::some<0x1::type_name::TypeName>(v31)));
                        0x1::vector::push_back<0x1::option::Option<0x1::type_name::TypeName>>(&mut v24, 0x1::option::some<0x1::type_name::TypeName>(v40));
                        0x1::vector::push_back<0x1::option::Option<0x1::type_name::TypeName>>(&mut v25, 0x1::option::some<0x1::type_name::TypeName>(v31));
                        0x1::vector::push_back<u64>(&mut v26, v39);
                        *0x1::vector::borrow_mut<u64>(&mut v18, v37) = v38 - v39;
                        v33 = v33 - v39;
                    };
                    v37 = v37 + 1;
                };
            };
            v28 = v28 + 1;
        };
        let v41 = if (v11 < v13) {
            v13 - v11
        } else {
            0
        };
        let v42 = v41;
        let v43 = 0;
        while (v43 < v1 && v42 >= 1000) {
            let v44 = *0x1::vector::borrow<u64>(&v18, v43);
            if (v44 >= 1000) {
                let v45 = 0x1::u64::min(v42, v44);
                let v46 = 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::witness_type_name(0x1::vector::borrow<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolLiquidity>(arg1, v43));
                let v47 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(v45, v2);
                arg0.deployed_liquidity = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::sub(arg0.deployed_liquidity, v47);
                arg0.available_liquidity = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::add(arg0.available_liquidity, v47);
                0x1::vector::push_back<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::rbr::RebalanceRequest<T0>>(&mut v0, 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::rbr::new<T0>(v45, 0x1::option::some<0x1::type_name::TypeName>(v46), 0x1::option::none<0x1::type_name::TypeName>()));
                0x1::vector::push_back<0x1::option::Option<0x1::type_name::TypeName>>(&mut v24, 0x1::option::some<0x1::type_name::TypeName>(v46));
                0x1::vector::push_back<0x1::option::Option<0x1::type_name::TypeName>>(&mut v25, 0x1::option::none<0x1::type_name::TypeName>());
                0x1::vector::push_back<u64>(&mut v26, v45);
                *0x1::vector::borrow_mut<u64>(&mut v18, v43) = v44 - v45;
                v42 = v42 - v45;
            };
            v43 = v43 + 1;
        };
        0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::sam_events::rebalance(v24, v25, v26, 0x2::tx_context::sender(arg2));
        v0
    }

    public(friend) fun reclaim_from_protocol<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::rbr::RebalanceRequest<T0>) {
        assert!(!arg0.paused, 11);
        0x2::balance::join<T0>(&mut arg0.balance, 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::rbr::consume_idle<T0>(arg1));
    }

    public(friend) fun record_point<T0, T1, T2>(arg0: &mut SamStateV1<T0, T1>, arg1: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18, arg2: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18) {
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolPoint>(&arg0.points, &v0)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolPoint>(&mut arg0.points, &v0) = 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::new_point(arg1, arg2);
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolPoint>(&mut arg0.points, v0, 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::new_point(arg1, arg2));
        };
    }

    public(friend) fun refresh_metadata<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: &0x2::coin_registry::Currency<T1>) {
        *0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::extended_field::borrow_mut<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::sam_coin_metadata::SamMetadata>(&mut arg0.metadata) = 0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::sam_coin_metadata::new<T1>(arg1);
    }

    public(friend) fun register_protocol<T0, T1, T2>(arg0: &mut SamStateV1<T0, T1>) {
        0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::add<T2>(0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::extended_field::borrow_mut<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolRegistry>(&mut arg0.registry));
    }

    public(friend) fun set_allocation_config<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: u64, arg2: u64) {
        assert!(arg1 <= 10000 && arg2 <= 10000, 16);
        let v0 = AllocationConfig{
            idle_buffer_bps  : arg1,
            max_exposure_bps : arg2,
        };
        arg0.allocation_config = v0;
    }

    public(friend) fun set_paused<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: bool) {
        arg0.paused = arg1;
    }

    public(friend) fun total_coin_in<T0, T1>(arg0: &SamStateV1<T0, T1>) : u64 {
        arg0.total_coin_in
    }

    public(friend) fun unregister_protocol<T0, T1, T2>(arg0: &mut SamStateV1<T0, T1>) {
        0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::remove<T2>(0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::extended_field::borrow_mut<0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::ptr::ProtocolRegistry>(&mut arg0.registry));
    }

    public(friend) fun update_deposit_fee<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: u64) {
        0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::fee_config::set_deposit(&mut arg0.fee_config, arg1);
    }

    public(friend) fun update_protocol_fee<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: u64) {
        0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::fee_config::set_protocol(&mut arg0.fee_config, arg1);
    }

    public(friend) fun update_withdraw_fee<T0, T1>(arg0: &mut SamStateV1<T0, T1>, arg1: u64) {
        0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::fee_config::set_withdraw(&mut arg0.fee_config, arg1);
    }

    public(friend) fun withdraw_all_fees<T0, T1>(arg0: &mut SamStateV1<T0, T1>) : 0x2::balance::Balance<T0> {
        0x5e01eb950e3e205f132b6b1ae999f7d15c7fa856febd63b276dbdd5e876dbf60::fee_balances::withdraw_all<T0>(&mut arg0.fees)
    }

    // decompiled from Move bytecode v7
}

