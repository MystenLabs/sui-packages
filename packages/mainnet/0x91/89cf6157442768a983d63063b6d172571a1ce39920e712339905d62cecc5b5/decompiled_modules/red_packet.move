module 0x9189cf6157442768a983d63063b6d172571a1ce39920e712339905d62cecc5b5::red_packet {
    struct RedPacket<phantom T0> has store, key {
        id: 0x2::object::UID,
        sender: address,
        amount: u64,
        left_amount: u64,
        coin_amount: 0x2::balance::Balance<T0>,
    }

    struct NewRedPacket<phantom T0> has copy, drop {
        red_packet_id: 0x2::object::ID,
        sender: address,
        amount: u64,
        coin_amount: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct RED_PACKET has drop {
        dummy_field: bool,
    }

    public entry fun claim_red_packet<T0>(arg0: &mut RedPacket<T0>, arg1: &0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::WeatherOracle, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg0.left_amount == 1) {
            arg0.left_amount = arg0.left_amount - 1;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.coin_amount, 0x2::balance::value<T0>(&arg0.coin_amount), arg2), 0x2::tx_context::sender(arg2));
        } else {
            arg0.left_amount = arg0.left_amount - 1;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_amount, get_random(arg1, 0x2::balance::value<T0>(&arg0.coin_amount) / arg0.left_amount * 2, arg2)), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    fun convert_number_to_byte(arg0: u32) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 256) as u8));
            arg0 = arg0 / 256;
        };
        v0
    }

    fun get_random(arg0: &0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::WeatherOracle, arg1: u64, arg2: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v0, 0x2::address::to_string(0x2::tx_context::sender(arg2)));
        0x1::string::append(&mut v0, 0x1::string::utf8(0x2::bcs::into_remainder_bytes(0x2::bcs::new(convert_number_to_byte(0x8378b3bd39931aa74a6aa3a820304c1109d327426e4275183ed0b797eb6660a8::weather::city_weather_oracle_pressure(arg0, 2988507))))));
        let v1 = 0x2::bcs::new(0x2::hash::blake2b256(0x1::string::bytes(&v0)));
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

    public entry fun send_new_red_packet<T0>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::object::new(arg2);
        let v2 = NewRedPacket<T0>{
            red_packet_id : 0x2::object::uid_to_inner(&v1),
            sender        : v0,
            amount        : arg0,
            coin_amount   : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<NewRedPacket<T0>>(v2);
        let v3 = RedPacket<T0>{
            id          : v1,
            sender      : v0,
            amount      : arg0,
            left_amount : arg0,
            coin_amount : 0x2::coin::into_balance<T0>(arg1),
        };
        0x2::transfer::share_object<RedPacket<T0>>(v3);
    }

    // decompiled from Move bytecode v6
}

