module 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::minter {
    struct MinterCap has key {
        id: 0x2::object::UID,
    }

    struct Minter has key {
        id: 0x2::object::UID,
        verison: u64,
        supply: 0x2::balance::Supply<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>,
        balance: 0x2::balance::Balance<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>,
        team: address,
        team_rate: u64,
        active_period: u64,
        weekly: u64,
        emission: u16,
        epoch: u32,
    }

    public fun balance(arg0: &Minter) : u64 {
        0x2::balance::value<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&arg0.balance)
    }

    public fun join(arg0: &mut Minter, arg1: 0x2::balance::Balance<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>) {
        0x2::balance::join<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&mut arg0.balance, arg1);
    }

    public fun buyback(arg0: &MinterCap, arg1: &mut Minter, arg2: 0x2::coin::Coin<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>) {
        assert!(arg1.verison == 1, 1);
        0x2::balance::decrease_supply<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&mut arg1.supply, 0x2::coin::into_balance<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(arg2));
    }

    public fun calculate_emission(arg0: &Minter) : u64 {
        (((arg0.weekly as u128) * (arg0.emission as u128) / (1000 as u128)) as u64)
    }

    public fun circulating_emission(arg0: &Minter, arg1: &0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::VSDBRegistry, arg2: &0x2::clock::Clock) : u64 {
        (((circulating_supply(arg0, arg1, arg2) as u128) * (2 as u128) / (1000 as u128)) as u64)
    }

    public fun circulating_supply(arg0: &Minter, arg1: &0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::VSDBRegistry, arg2: &0x2::clock::Clock) : u64 {
        0x2::balance::supply_value<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&arg0.supply) - 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::total_VeSDB(arg1, arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MinterCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MinterCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun initialize(arg0: 0x2::coin::TreasuryCap<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>, arg1: &mut 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::VSDBRegistry, arg2: u64, arg3: vector<address>, arg4: vector<u64>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg4) == 0x1::vector::length<address>(&arg3), 102);
        let v0 = Minter{
            id            : 0x2::object::new(arg6),
            verison       : 1,
            supply        : 0x2::coin::treasury_into_supply<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(arg0),
            balance       : 0x2::balance::zero<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(),
            team          : 0x2::tx_context::sender(arg6),
            team_rate     : 30,
            active_period : 0x2::tx_context::epoch_timestamp_ms(arg6) / 1000 / 604800 * 604800,
            weekly        : 75000 * 0x2::math::pow(10, 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::decimals()),
            emission      : 980,
            epoch         : 0,
        };
        let v1 = 0x2::balance::increase_supply<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&mut v0.supply, arg2);
        assert!(0x2::balance::supply_value<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&v0.supply) == 1000000 * 0x2::math::pow(10, 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::decimals()), 103);
        while (0 < 0x1::vector::length<address>(&arg3)) {
            0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::lock_for(arg1, 0x2::coin::take<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&mut v1, 0x1::vector::pop_back<u64>(&mut arg4), arg6), 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::max_time(), 0x1::vector::pop_back<address>(&mut arg3), arg5, arg6);
        };
        0x2::balance::join<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&mut v0.balance, v1);
        0x2::transfer::share_object<Minter>(v0);
    }

    public fun package_version() : u64 {
        1
    }

    public entry fun set_team(arg0: &mut Minter, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.verison == 1, 1);
        assert!(0x2::tx_context::sender(arg2) == arg0.team, 100);
        arg0.team = arg1;
    }

    public entry fun set_team_rate(arg0: &mut Minter, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.verison == 1, 1);
        assert!(0x2::tx_context::sender(arg2) == arg0.team, 100);
        assert!(arg1 < 50, 101);
        arg0.team_rate = arg1;
    }

    public fun total_sypply(arg0: &Minter) : u64 {
        0x2::balance::supply_value<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&arg0.supply)
    }

    public(friend) fun update_period(arg0: &mut Minter, arg1: &mut 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::VSDBRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>> {
        assert!(arg0.verison == 1, 1);
        if (0x2::clock::timestamp_ms(arg2) / 1000 >= arg0.active_period + 604800) {
            arg0.active_period = 0x2::clock::timestamp_ms(arg2) / 1000 / 604800 * 604800;
            arg0.weekly = weekly_emission(arg0, arg1, arg2);
            let v0 = arg0.weekly;
            let v1 = arg0.team_rate * v0 / (1000 - arg0.team_rate);
            let v2 = v0 + v1;
            let v3 = 0x2::balance::value<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&arg0.balance);
            if (v2 > v3) {
                0x2::balance::join<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&mut arg0.balance, 0x2::balance::increase_supply<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&mut arg0.supply, v2 - v3));
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>>(0x2::coin::take<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&mut arg0.balance, v1, arg3), arg0.team);
            arg0.epoch = arg0.epoch + 1;
            if (arg0.epoch < 96 && arg0.epoch % 24 == 0) {
                arg0.emission = arg0.emission + 5;
            };
            if (arg0.epoch == 96) {
                arg0.emission = 999;
            };
            0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::event::mint(0x2::tx_context::sender(arg3), arg0.weekly, circulating_supply(arg0, arg1, arg2), circulating_emission(arg0, arg1, arg2));
            return 0x1::option::some<0x2::coin::Coin<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>>(0x2::coin::take<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>(&mut arg0.balance, arg0.weekly, arg3))
        };
        0x1::option::none<0x2::coin::Coin<0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::sdb::SDB>>()
    }

    public fun weekly_emission(arg0: &Minter, arg1: &0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::vsdb::VSDBRegistry, arg2: &0x2::clock::Clock) : u64 {
        0x2::math::max(calculate_emission(arg0), circulating_emission(arg0, arg1, arg2))
    }

    // decompiled from Move bytecode v6
}

