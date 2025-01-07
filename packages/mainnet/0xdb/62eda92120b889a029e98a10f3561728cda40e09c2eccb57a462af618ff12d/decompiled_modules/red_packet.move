module 0xdb62eda92120b889a029e98a10f3561728cda40e09c2eccb57a462af618ff12d::red_packet {
    struct RedPacket<phantom T0> has store, key {
        id: 0x2::object::UID,
        sender: address,
        amount: u64,
        left_amount: u64,
        coin_type: 0x1::ascii::String,
        coin_amount: 0x2::balance::Balance<T0>,
        original_amount: u64,
        claimer_addresses: vector<address>,
        specified_recipient: 0x1::option::Option<vector<address>>,
    }

    struct NewRedPacket<phantom T0> has copy, drop {
        red_packet_id: 0x2::object::ID,
        sender: address,
        amount: u64,
        coin_type: 0x1::ascii::String,
        coin_amount: u64,
    }

    struct ClaimRedPacket<phantom T0> has copy, drop {
        claim_red_packet_id: 0x2::object::ID,
        claimer: address,
        claim_amount: u64,
        claim_coin_type: 0x1::ascii::String,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct RED_PACKET has drop {
        dummy_field: bool,
    }

    public entry fun claim_red_packet<T0>(arg0: &mut RedPacket<T0>, arg1: &0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::WeatherOracle, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x1::vector::contains<address>(&arg0.claimer_addresses, &v0), 1);
        if (!0x1::option::is_none<vector<address>>(&arg0.specified_recipient)) {
            assert!(0x1::vector::contains<address>(0x1::option::borrow<vector<address>>(&arg0.specified_recipient), &v0), 2);
        };
        let v1 = 0x2::balance::value<T0>(&arg0.coin_amount);
        let v2 = 0x1::type_name::get<T0>();
        let v3 = if (arg0.left_amount == 1) {
            arg0.left_amount = arg0.left_amount - 1;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.coin_amount, v1, arg3), v0);
            v1
        } else {
            let v4 = get_random(arg1, v1 / arg0.left_amount * 2, arg2, arg3);
            arg0.left_amount = arg0.left_amount - 1;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_amount, v4), arg3), v0);
            v4
        };
        0x1::vector::push_back<address>(&mut arg0.claimer_addresses, v0);
        let v5 = ClaimRedPacket<T0>{
            claim_red_packet_id : 0x2::object::uid_to_inner(&arg0.id),
            claimer             : v0,
            claim_amount        : v3,
            claim_coin_type     : *0x1::type_name::borrow_string(&v2),
        };
        0x2::event::emit<ClaimRedPacket<T0>>(v5);
    }

    fun get_random(arg0: &0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::WeatherOracle, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::tx_context::sender(arg3)));
        0x1::vector::append<u8>(&mut v0, u32_to_ascii(0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::city_weather_oracle_pressure(arg0, 2988507)));
        0x1::vector::append<u8>(&mut v0, u32_to_ascii(0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::city_weather_oracle_pressure(arg0, 88319)));
        0x1::vector::append<u8>(&mut v0, u64_to_ascii(0x2::clock::timestamp_ms(arg2)));
        0x1::vector::append<u8>(&mut v0, *0x2::tx_context::digest(arg3));
        let v1 = 0x2::bcs::new(0x2::hash::blake2b256(&v0));
        let v2 = ((0x2::bcs::peel_u64(&mut v1) % arg1) as u64);
        0x1::debug::print<u64>(&v2);
        v2
    }

    fun init(arg0: RED_PACKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<RED_PACKET>(arg0, arg1), v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
    }

    public entry fun send_new_red_packet<T0>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::option::Option<vector<address>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::new(arg3);
        let v2 = 0x2::coin::value<T0>(&arg1);
        let v3 = 0x1::type_name::get<T0>();
        let v4 = *0x1::type_name::borrow_string(&v3);
        let v5 = NewRedPacket<T0>{
            red_packet_id : 0x2::object::uid_to_inner(&v1),
            sender        : v0,
            amount        : arg0,
            coin_type     : v4,
            coin_amount   : v2,
        };
        0x2::event::emit<NewRedPacket<T0>>(v5);
        let v6 = RedPacket<T0>{
            id                  : v1,
            sender              : v0,
            amount              : arg0,
            left_amount         : arg0,
            coin_type           : v4,
            coin_amount         : 0x2::coin::into_balance<T0>(arg1),
            original_amount     : v2,
            claimer_addresses   : 0x1::vector::empty<address>(),
            specified_recipient : arg2,
        };
        0x2::transfer::share_object<RedPacket<T0>>(v6);
    }

    fun u32_to_ascii(arg0: u32) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            let v1 = arg0 % 10;
            arg0 = arg0 / 10;
            0x1::vector::push_back<u8>(&mut v0, (v1 as u8) + 48);
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    fun u64_to_ascii(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            let v1 = arg0 % 10;
            arg0 = arg0 / 10;
            0x1::vector::push_back<u8>(&mut v0, (v1 as u8) + 48);
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    // decompiled from Move bytecode v6
}

