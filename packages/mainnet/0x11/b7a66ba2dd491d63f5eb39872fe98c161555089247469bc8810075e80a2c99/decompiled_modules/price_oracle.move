module 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle {
    struct Observation has copy, drop, store {
        timestamp: u64,
        sqrt_price: u128,
    }

    struct PriceOracle has key {
        id: 0x2::object::UID,
        observations: vector<Observation>,
    }

    struct ObservationRecorded has copy, drop {
        timestamp: u64,
        sqrt_price: u128,
        samples: u64,
    }

    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceOracle{
            id           : 0x2::object::new(arg0),
            observations : 0x1::vector::empty<Observation>(),
        };
        0x2::transfer::share_object<PriceOracle>(v0);
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
        let v3 = 0x1::vector::borrow<Observation>(&arg0.observations, 0);
        assert!(v3.timestamp <= v1, 2);
        assert!(0x1::vector::borrow<Observation>(&arg0.observations, v2 - 1).timestamp + 120 >= v0, 4);
        let v4 = 0;
        let v5 = 0;
        let v6 = *v3;
        let v7 = 1;
        while (v7 < v2) {
            let v8 = *0x1::vector::borrow<Observation>(&arg0.observations, v7);
            let v9 = if (v6.timestamp > v1) {
                v6.timestamp
            } else {
                v1
            };
            let v10 = if (v8.timestamp < v0) {
                v8.timestamp
            } else {
                v0
            };
            assert!(v8.timestamp <= v6.timestamp + 120, 4);
            if (v10 > v9) {
                let v11 = v10 - v9;
                v4 = v4 + (v6.sqrt_price as u256) * (v11 as u256);
                v5 = v5 + v11;
            };
            v6 = v8;
            v7 = v7 + 1;
        };
        if (v0 > v6.timestamp) {
            let v12 = v0 - v6.timestamp;
            assert!(v12 <= 120, 4);
            v4 = v4 + (v6.sqrt_price as u256) * (v12 as u256);
            v5 = v5 + v12;
        };
        assert!(v5 == arg1, 2);
        ((v4 / (v5 as u256)) as u128)
    }

    // decompiled from Move bytecode v7
}

