module 0xb27550227d38c73f17659e1c2154e882aced735f9ca2dcc4d6d0c97ec2412ad5::random {
    struct LuckyClub has key {
        id: 0x2::object::UID,
        user_list: vector<address>,
        base_drand_round: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct EventJoin has copy, drop {
        sender: address,
        user_length: u64,
    }

    struct EventRandomUserPickedByClock has copy, drop {
        user: address,
        random_index: u64,
        current_timestamp: u64,
    }

    struct EventRandomUserPickedByTxHash has copy, drop {
        user: address,
        random_index: u64,
        tx_digest_u64: u64,
    }

    struct EventRandomUserPickedByWeatherOracle has copy, drop {
        user: address,
        random_index: u64,
        random_pressure_sz: u32,
    }

    struct EventRandomUserPickedByDrand has copy, drop {
        user: address,
        random_index: u64,
        drand_round: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LuckyClub{
            id               : 0x2::object::new(arg0),
            user_list        : 0x1::vector::empty<address>(),
            base_drand_round : 0,
        };
        0x2::transfer::share_object<LuckyClub>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun join(arg0: &mut LuckyClub, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x1::vector::contains<address>(&arg0.user_list, &v0), 1);
        0x1::vector::push_back<address>(&mut arg0.user_list, v0);
        let v1 = EventJoin{
            sender      : v0,
            user_length : 0x1::vector::length<address>(&arg0.user_list),
        };
        0x2::event::emit<EventJoin>(v1);
    }

    public entry fun pick_random_user_by_clock(arg0: &AdminCap, arg1: &LuckyClub, arg2: &0x2::clock::Clock) {
        let v0 = 0x1::vector::length<address>(&arg1.user_list);
        assert!(v0 > 0, 2);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = v1 % v0;
        let v3 = EventRandomUserPickedByClock{
            user              : *0x1::vector::borrow<address>(&arg1.user_list, v2),
            random_index      : v2,
            current_timestamp : v1,
        };
        0x2::event::emit<EventRandomUserPickedByClock>(v3);
    }

    public entry fun pick_random_user_by_drand(arg0: &AdminCap, arg1: &mut LuckyClub, arg2: u64, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.base_drand_round < arg2, 3);
        0xb27550227d38c73f17659e1c2154e882aced735f9ca2dcc4d6d0c97ec2412ad5::drand_lib::verify_drand_signature(arg3, arg2);
        arg1.base_drand_round = arg2;
        let v0 = 0x1::vector::length<address>(&arg1.user_list);
        assert!(v0 > 0, 2);
        let v1 = 0xb27550227d38c73f17659e1c2154e882aced735f9ca2dcc4d6d0c97ec2412ad5::drand_lib::derive_randomness(arg3);
        let v2 = 0xb27550227d38c73f17659e1c2154e882aced735f9ca2dcc4d6d0c97ec2412ad5::drand_lib::safe_selection(v0, &v1);
        let v3 = EventRandomUserPickedByDrand{
            user         : *0x1::vector::borrow<address>(&arg1.user_list, v2),
            random_index : v2,
            drand_round  : arg2,
        };
        0x2::event::emit<EventRandomUserPickedByDrand>(v3);
    }

    public entry fun pick_random_user_by_tx_hash(arg0: &AdminCap, arg1: &LuckyClub, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1.user_list);
        assert!(v0 > 0, 2);
        let v1 = 0x2::bcs::new(*0x2::tx_context::digest(arg2));
        let v2 = 0x2::bcs::peel_u64(&mut v1);
        let v3 = v2 % v0;
        let v4 = EventRandomUserPickedByTxHash{
            user          : *0x1::vector::borrow<address>(&arg1.user_list, v3),
            random_index  : v3,
            tx_digest_u64 : v2,
        };
        0x2::event::emit<EventRandomUserPickedByTxHash>(v4);
    }

    public entry fun pick_random_user_by_weather_oracle(arg0: &AdminCap, arg1: &LuckyClub, arg2: &0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::WeatherOracle, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1.user_list);
        assert!(v0 > 0, 2);
        let v1 = 0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::city_weather_oracle_pressure(arg2, 1795566);
        let v2 = (v1 as u64) % v0;
        let v3 = EventRandomUserPickedByWeatherOracle{
            user               : *0x1::vector::borrow<address>(&arg1.user_list, v2),
            random_index       : v2,
            random_pressure_sz : v1,
        };
        0x2::event::emit<EventRandomUserPickedByWeatherOracle>(v3);
    }

    // decompiled from Move bytecode v6
}

