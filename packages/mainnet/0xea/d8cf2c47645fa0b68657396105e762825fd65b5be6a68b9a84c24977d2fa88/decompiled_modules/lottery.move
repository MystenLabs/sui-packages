module 0xead8cf2c47645fa0b68657396105e762825fd65b5be6a68b9a84c24977d2fa88::lottery {
    struct Lottery has store, key {
        id: 0x2::object::UID,
        reward_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        publisher: address,
        price: u64,
        start_time: u64,
        end_time: u64,
        status: u8,
        ticket_num: u64,
        player_num: u64,
        winner: 0x1::option::Option<address>,
        winner_ticket: 0x1::option::Option<u64>,
        winner_claimed: bool,
        fee_ratio: u64,
    }

    struct Ticket has store, key {
        id: 0x2::object::UID,
        lottery_id: 0x2::object::ID,
        tickets: vector<u64>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LOTTERY has drop {
        dummy_field: bool,
    }

    public fun buy_lottory(arg0: &mut Lottery, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 > arg0.start_time && v0 < arg0.end_time, 1);
        let v1 = arg0.price * arg1;
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v2 >= v1, 2);
        let v3 = spilt_coin(v1, v2, arg2, arg4);
        let v4 = 1;
        let v5 = arg0.ticket_num;
        let v6 = 0x1::vector::empty<u64>();
        while (v4 <= arg1) {
            0x1::vector::push_back<u64>(&mut v6, v5 + 1);
            v4 = v4 + 1;
        };
        arg0.ticket_num = v5 + arg1;
        arg0.player_num = arg0.player_num + 1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reward_pool, 0x2::coin::into_balance<0x2::sui::SUI>(v3));
        let v7 = Ticket{
            id         : 0x2::object::new(arg4),
            lottery_id : 0x2::object::uid_to_inner(&arg0.id),
            tickets    : v6,
        };
        0x2::transfer::transfer<Ticket>(v7, 0x2::tx_context::sender(arg4));
    }

    public entry fun claimLottery(arg0: &Ticket, arg1: &mut Lottery, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 2, 4);
        assert!(0x1::vector::contains<u64>(&arg0.tickets, 0x1::option::borrow<u64>(&arg1.winner_ticket)), 4);
        let v0 = 0x2::tx_context::sender(arg2);
        arg1.winner = 0x1::option::some<address>(v0);
        arg1.winner_claimed = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.reward_pool, 0x2::balance::value<0x2::sui::SUI>(&arg1.reward_pool), arg2), v0);
    }

    public entry fun create_lottory(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = Lottery{
            id             : 0x2::object::new(arg5),
            reward_pool    : 0x2::balance::zero<0x2::sui::SUI>(),
            publisher      : 0x2::tx_context::sender(arg5),
            price          : arg1,
            start_time     : v0,
            end_time       : v0 + arg2,
            status         : 1,
            ticket_num     : 0,
            player_num     : 0,
            winner         : 0x1::option::none<address>(),
            winner_ticket  : 0x1::option::none<u64>(),
            winner_claimed : false,
            fee_ratio      : arg3,
        };
        0x2::transfer::share_object<Lottery>(v1);
    }

    public entry fun endLottery(arg0: &0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::WeatherOracle, arg1: &mut Lottery, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.status == 1, 4);
        assert!(0x2::clock::timestamp_ms(arg2) > arg1.end_time, 3);
        arg1.winner_ticket = 0x1::option::some<u64>(get_random(arg0, arg1.ticket_num, arg2, arg3));
        arg1.status = 2;
    }

    fun get_random(arg0: &0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::WeatherOracle, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::tx_context::sender(arg3)));
        0x1::vector::append<u8>(&mut v0, 0xead8cf2c47645fa0b68657396105e762825fd65b5be6a68b9a84c24977d2fa88::utils::u32_to_ascii(0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::city_weather_oracle_pressure(arg0, 2988507)));
        0x1::vector::append<u8>(&mut v0, 0xead8cf2c47645fa0b68657396105e762825fd65b5be6a68b9a84c24977d2fa88::utils::u32_to_ascii(0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::city_weather_oracle_pressure(arg0, 2147714)));
        0x1::vector::append<u8>(&mut v0, 0xead8cf2c47645fa0b68657396105e762825fd65b5be6a68b9a84c24977d2fa88::utils::u32_to_ascii(0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::city_weather_oracle_temp(arg0, 1785286)));
        0x1::vector::append<u8>(&mut v0, 0xead8cf2c47645fa0b68657396105e762825fd65b5be6a68b9a84c24977d2fa88::utils::u64_to_ascii(0x2::clock::timestamp_ms(arg2)));
        0x1::vector::append<u8>(&mut v0, *0x2::tx_context::digest(arg3));
        let v1 = 0x2::bcs::new(0x2::hash::blake2b256(&v0));
        let v2 = ((0x2::bcs::peel_u64(&mut v1) % arg1) as u64);
        0x1::debug::print<u64>(&v2);
        v2
    }

    fun init(arg0: LOTTERY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<LOTTERY>(arg0, arg1), v0);
    }

    fun spilt_coin(arg0: u64, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        if (arg1 > arg0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg3));
            return 0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg0, arg3)
        };
        arg2
    }

    // decompiled from Move bytecode v6
}

