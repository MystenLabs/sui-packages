module 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle {
    struct Observation has copy, drop, store {
        timestamp: u64,
        sqrt_price: u128,
    }

    struct PriceOracle has key {
        id: 0x2::object::UID,
        observations: vector<Observation>,
    }

    struct CetusPairOracle<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        observations: vector<Observation>,
    }

    struct ObservationRecorded has copy, drop {
        timestamp: u64,
        sqrt_price: u128,
        samples: u64,
    }

    public fun cetus_pair_twap_sqrt_price<T0, T1>(arg0: &CetusPairOracle<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : u128 {
        assert!(arg1 >= 300, 3);
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v1 = if (v0 > arg1) {
            v0 - arg1
        } else {
            0
        };
        let v2 = 0x1::vector::length<Observation>(&arg0.observations);
        assert!(v2 >= 2, 2);
        let v3 = *0x1::vector::borrow<Observation>(&arg0.observations, 0);
        let v4 = 1;
        while (v4 < v2) {
            let v5 = *0x1::vector::borrow<Observation>(&arg0.observations, v4);
            if (v5.timestamp > v1) {
                break
            };
            v3 = v5;
            v4 = v4 + 1;
        };
        assert!(v3.timestamp <= v1, 2);
        assert!(v1 <= v3.timestamp + 120, 4);
        assert!(0x1::vector::borrow<Observation>(&arg0.observations, v2 - 1).timestamp + 120 >= v0, 4);
        let v6 = 0;
        let v7 = 0;
        while (v4 < v2) {
            let v8 = *0x1::vector::borrow<Observation>(&arg0.observations, v4);
            let v9 = if (v3.timestamp > v1) {
                v3.timestamp
            } else {
                v1
            };
            let v10 = if (v8.timestamp < v0) {
                v8.timestamp
            } else {
                v0
            };
            assert!(v8.timestamp <= v3.timestamp + 120, 4);
            if (v10 > v9) {
                let v11 = v10 - v9;
                v6 = v6 + (v3.sqrt_price as u256) * (v11 as u256);
                v7 = v7 + v11;
            };
            v3 = v8;
            v4 = v4 + 1;
        };
        if (v0 > v3.timestamp) {
            let v12 = v0 - v3.timestamp;
            assert!(v12 <= 120, 4);
            v6 = v6 + (v3.sqrt_price as u256) * (v12 as u256);
            v7 = v7 + v12;
        };
        assert!(v7 == arg1, 2);
        ((v6 / (v7 as u256)) as u128)
    }

    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceOracle{
            id           : 0x2::object::new(arg0),
            observations : 0x1::vector::empty<Observation>(),
        };
        0x2::transfer::share_object<PriceOracle>(v0);
    }

    public entry fun create_cetus_pair<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CetusPairOracle<T0, T1>{
            id           : 0x2::object::new(arg1),
            pool_id      : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg0),
            observations : 0x1::vector::empty<Observation>(),
        };
        0x2::transfer::share_object<CetusPairOracle<T0, T1>>(v0);
    }

    public fun is_spot_within_twap_deviation(arg0: u128, arg1: u128) : bool {
        if (arg1 == 0) {
            return false
        };
        let v0 = (arg0 as u256) * (arg0 as u256);
        let v1 = (arg1 as u256) * (arg1 as u256);
        v0 * 10000 >= v1 * 9800 && v0 * 10000 <= v1 * 10200
    }

    public fun is_twap_ready(arg0: &PriceOracle, arg1: u64, arg2: &0x2::clock::Clock) : bool {
        if (arg1 < 300) {
            return false
        };
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v1 = if (v0 > arg1) {
            v0 - arg1
        } else {
            0
        };
        let v2 = 0x1::vector::length<Observation>(&arg0.observations);
        if (v2 < 2) {
            return false
        };
        let v3 = *0x1::vector::borrow<Observation>(&arg0.observations, 0);
        let v4 = 1;
        while (v4 < v2) {
            let v5 = *0x1::vector::borrow<Observation>(&arg0.observations, v4);
            if (v5.timestamp > v1) {
                break
            };
            v3 = v5;
            v4 = v4 + 1;
        };
        if (v3.timestamp > v1 || v1 > v3.timestamp + 120) {
            return false
        };
        if (0x1::vector::borrow<Observation>(&arg0.observations, v2 - 1).timestamp + 120 < v0) {
            return false
        };
        let v6 = 0;
        while (v4 < v2) {
            let v7 = *0x1::vector::borrow<Observation>(&arg0.observations, v4);
            if (v7.timestamp > v3.timestamp + 120) {
                return false
            };
            let v8 = if (v3.timestamp > v1) {
                v3.timestamp
            } else {
                v1
            };
            let v9 = if (v7.timestamp < v0) {
                v7.timestamp
            } else {
                v0
            };
            if (v9 > v8) {
                v6 = v6 + v9 - v8;
            };
            v3 = v7;
            v4 = v4 + 1;
        };
        if (v0 > v3.timestamp) {
            let v10 = v0 - v3.timestamp;
            if (v10 > 120) {
                return false
            };
            v6 = v6 + v10;
        };
        v6 == arg1
    }

    public fun quote_a_to_b(arg0: u64, arg1: u128) : u64 {
        let v0 = 18446744073709551616;
        let v1 = (arg0 as u256) * (arg1 as u256) * (arg1 as u256) / v0 * v0;
        assert!(v1 <= 18446744073709551615, 3);
        (v1 as u64)
    }

    public fun quote_b_to_a(arg0: u64, arg1: u128) : u64 {
        assert!(arg1 > 0, 3);
        let v0 = 18446744073709551616;
        let v1 = (arg0 as u256) * v0 * v0 / (arg1 as u256) * (arg1 as u256);
        assert!(v1 <= 18446744073709551615, 3);
        (v1 as u64)
    }

    public entry fun record_cetus_pair<T0, T1>(arg0: &mut CetusPairOracle<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock) {
        assert!(arg0.pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1), 3);
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v1 = 0x1::vector::length<Observation>(&arg0.observations);
        if (v1 > 0) {
            assert!(v0 >= 0x1::vector::borrow<Observation>(&arg0.observations, v1 - 1).timestamp + 60, 1);
        };
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v3 = Observation{
            timestamp  : v0,
            sqrt_price : v2,
        };
        0x1::vector::push_back<Observation>(&mut arg0.observations, v3);
        if (0x1::vector::length<Observation>(&arg0.observations) > 60) {
            0x1::vector::remove<Observation>(&mut arg0.observations, 0);
        };
        let v4 = ObservationRecorded{
            timestamp  : v0,
            sqrt_price : v2,
            samples    : 0x1::vector::length<Observation>(&arg0.observations),
        };
        0x2::event::emit<ObservationRecorded>(v4);
    }

    public entry fun record_lumi_sui(arg0: &mut PriceOracle, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI, 0x2::sui::SUI>, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v1 = 0x1::vector::length<Observation>(&arg0.observations);
        if (v1 > 0) {
            assert!(v0 >= 0x1::vector::borrow<Observation>(&arg0.observations, v1 - 1).timestamp + 60, 1);
        };
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI, 0x2::sui::SUI>(arg1);
        let v3 = Observation{
            timestamp  : v0,
            sqrt_price : v2,
        };
        0x1::vector::push_back<Observation>(&mut arg0.observations, v3);
        if (0x1::vector::length<Observation>(&arg0.observations) > 60) {
            0x1::vector::remove<Observation>(&mut arg0.observations, 0);
        };
        let v4 = ObservationRecorded{
            timestamp  : v0,
            sqrt_price : v2,
            samples    : 0x1::vector::length<Observation>(&arg0.observations),
        };
        0x2::event::emit<ObservationRecorded>(v4);
    }

    public fun sample_count(arg0: &PriceOracle) : u64 {
        0x1::vector::length<Observation>(&arg0.observations)
    }

    public fun twap_sqrt_price(arg0: &PriceOracle, arg1: u64, arg2: &0x2::clock::Clock) : u128 {
        assert!(arg1 >= 300, 3);
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v1 = if (v0 > arg1) {
            v0 - arg1
        } else {
            0
        };
        let v2 = 0x1::vector::length<Observation>(&arg0.observations);
        assert!(v2 >= 2, 2);
        let v3 = *0x1::vector::borrow<Observation>(&arg0.observations, 0);
        let v4 = 1;
        while (v4 < v2) {
            let v5 = *0x1::vector::borrow<Observation>(&arg0.observations, v4);
            if (v5.timestamp > v1) {
                break
            };
            v3 = v5;
            v4 = v4 + 1;
        };
        assert!(v3.timestamp <= v1, 2);
        assert!(v1 <= v3.timestamp + 120, 4);
        assert!(0x1::vector::borrow<Observation>(&arg0.observations, v2 - 1).timestamp + 120 >= v0, 4);
        let v6 = 0;
        let v7 = 0;
        while (v4 < v2) {
            let v8 = *0x1::vector::borrow<Observation>(&arg0.observations, v4);
            let v9 = if (v3.timestamp > v1) {
                v3.timestamp
            } else {
                v1
            };
            let v10 = if (v8.timestamp < v0) {
                v8.timestamp
            } else {
                v0
            };
            assert!(v8.timestamp <= v3.timestamp + 120, 4);
            if (v10 > v9) {
                let v11 = v10 - v9;
                v6 = v6 + (v3.sqrt_price as u256) * (v11 as u256);
                v7 = v7 + v11;
            };
            v3 = v8;
            v4 = v4 + 1;
        };
        if (v0 > v3.timestamp) {
            let v12 = v0 - v3.timestamp;
            assert!(v12 <= 120, 4);
            v6 = v6 + (v3.sqrt_price as u256) * (v12 as u256);
            v7 = v7 + v12;
        };
        assert!(v7 == arg1, 2);
        ((v6 / (v7 as u256)) as u128)
    }

    // decompiled from Move bytecode v7
}

