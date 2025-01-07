module 0xc30c5505912f8b665733de01677737a0638224b6acd05e246eff9dfc4826b25d::fantasyni_game {
    struct CoinKey<phantom T0> has store {
        dummy_field: bool,
    }

    struct OneCoinTreasureHunt<phantom T0> has key {
        id: 0x2::object::UID,
        custody: 0x2::balance::Balance<T0>,
        addresses: vector<address>,
        hunt_number: u64,
    }

    struct HuntEvent has copy, drop {
        hunt_index: u64,
        hunt_address: address,
        hunt_balance: u64,
    }

    struct HuntTicket {
        for: 0x2::object::ID,
        open_hunt: bool,
    }

    fun get_random(arg0: &0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::WeatherOracle, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::tx_context::sender(arg3)));
        0x1::vector::append<u8>(&mut v0, u32_to_ascii(0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::city_weather_oracle_pressure(arg0, 2988507)));
        0x1::vector::append<u8>(&mut v0, u32_to_ascii(0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::city_weather_oracle_pressure(arg0, 88319)));
        0x1::vector::append<u8>(&mut v0, u64_to_ascii(0x2::clock::timestamp_ms(arg2)));
        0x1::vector::append<u8>(&mut v0, *0x2::tx_context::digest(arg3));
        let v1 = 0x2::bcs::new(0x2::hash::blake2b256(&v0));
        ((0x2::bcs::peel_u64(&mut v1) % arg1) as u64)
    }

    public fun insert_coin<T0>(arg0: &mut OneCoinTreasureHunt<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : (HuntTicket, bool) {
        assert!(0x2::coin::value<T0>(&arg1) == 1, 1);
        assert!(arg0.hunt_number > 0, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.addresses, &v0), 3);
        0x2::balance::join<T0>(&mut arg0.custody, 0x2::coin::into_balance<T0>(arg1));
        0x1::vector::push_back<address>(&mut arg0.addresses, 0x2::tx_context::sender(arg2));
        arg0.hunt_number = arg0.hunt_number - 1;
        let v1 = arg0.hunt_number == 0;
        let v2 = HuntTicket{
            for       : 0x2::object::uid_to_inner(&arg0.id),
            open_hunt : v1,
        };
        (v2, v1)
    }

    public entry fun new_game<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 > 0, 0);
        let v0 = OneCoinTreasureHunt<T0>{
            id          : 0x2::object::new(arg1),
            custody     : 0x2::balance::zero<T0>(),
            addresses   : vector[],
            hunt_number : arg0,
        };
        0x2::transfer::share_object<OneCoinTreasureHunt<T0>>(v0);
    }

    public fun open_ticket_end<T0>(arg0: HuntTicket, arg1: OneCoinTreasureHunt<T0>, arg2: &0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::WeatherOracle, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.open_hunt == true, 4);
        assert!(arg0.for == 0x2::object::uid_to_inner(&arg1.id), 5);
        let HuntTicket {
            for       : _,
            open_hunt : _,
        } = arg0;
        let OneCoinTreasureHunt {
            id          : v2,
            custody     : v3,
            addresses   : v4,
            hunt_number : _,
        } = arg1;
        let v6 = v4;
        let v7 = v3;
        0x2::object::delete(v2);
        let v8 = get_random(arg2, 0x1::vector::length<address>(&v6), arg3, arg4);
        let v9 = *0x1::vector::borrow<address>(&v6, v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg4), v9);
        let v10 = HuntEvent{
            hunt_index   : v8,
            hunt_address : v9,
            hunt_balance : 0x2::balance::value<T0>(&v7),
        };
        0x2::event::emit<HuntEvent>(v10);
    }

    public fun open_ticket_normal(arg0: HuntTicket) {
        assert!(arg0.open_hunt == false, 4);
        let HuntTicket {
            for       : _,
            open_hunt : _,
        } = arg0;
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

