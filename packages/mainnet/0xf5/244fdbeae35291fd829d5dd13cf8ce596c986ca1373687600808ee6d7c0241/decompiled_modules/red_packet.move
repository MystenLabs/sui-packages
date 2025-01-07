module 0xf5244fdbeae35291fd829d5dd13cf8ce596c986ca1373687600808ee6d7c0241::red_packet {
    struct Config has key {
        id: 0x2::object::UID,
        admin: address,
        beneficiary: address,
        owner: address,
        count: u64,
        fees: 0x2::bag::Bag,
    }

    struct RedPacketInfo<phantom T0> has store, key {
        id: 0x2::object::UID,
        remain_coin: 0x2::balance::Balance<T0>,
        remain_count: u64,
        beneficiary: address,
    }

    struct RedPacketEvent has copy, drop {
        id: 0x2::object::ID,
        event_type: u8,
        remain_count: u64,
        remain_balance: u64,
    }

    struct RED_PACKET has drop {
        dummy_field: bool,
    }

    public fun calculate_fee(arg0: u64, arg1: u8) : (u64, u64) {
        let v0 = arg0 / 10000 * (arg1 as u64);
        (v0, arg0 - v0)
    }

    public entry fun close<T0>(arg0: RedPacketInfo<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let RedPacketInfo {
            id           : v0,
            remain_coin  : v1,
            remain_count : v2,
            beneficiary  : v3,
        } = arg0;
        let v4 = v1;
        let v5 = v0;
        let v6 = RedPacketEvent{
            id             : 0x2::object::uid_to_inner(&v5),
            event_type     : 2,
            remain_count   : v2,
            remain_balance : 0x2::balance::value<T0>(&v4),
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg1), v3);
        0x2::object::delete(v5);
        0x2::event::emit<RedPacketEvent>(v6);
    }

    public entry fun create<T0>(arg0: &mut Config, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg1);
        0x2::pay::join_vec<T0>(&mut v0, arg1);
        assert!(0x2::coin::value<T0>(&v0) >= arg3, 2);
        assert!(arg3 >= 10000, 4);
        assert!(arg2 <= 1000, 3);
        let (v1, v2) = calculate_fee(arg3, 250);
        let v3 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (0x2::bag::contains<vector<u8>>(&arg0.fees, v3)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.fees, v3), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, v1, arg4)));
        } else {
            0x2::bag::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.fees, v3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, v1, arg4)));
        };
        let v4 = 0x2::object::new(arg4);
        let v5 = RedPacketInfo<T0>{
            id           : v4,
            remain_coin  : 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, v2, arg4)),
            remain_count : arg2,
            beneficiary  : arg0.beneficiary,
        };
        0x2::transfer::transfer<RedPacketInfo<T0>>(v5, arg0.admin);
        if (0x2::coin::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
        arg0.count = arg0.count + 1;
        let v6 = RedPacketEvent{
            id             : 0x2::object::uid_to_inner(&v4),
            event_type     : 0,
            remain_count   : arg2,
            remain_balance : v2,
        };
        0x2::event::emit<RedPacketEvent>(v6);
    }

    fun init(arg0: RED_PACKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id          : 0x2::object::new(arg1),
            admin       : @0x601c61fcc9f18bf529a26b1a676f1e1635bd07d0f123ab2ef4ab4392c139f98,
            beneficiary : @0xa1d60f68de825850d058427188a33323a39990aaf93f2cbd93885e5073c7dae0,
            owner       : 0x2::tx_context::sender(arg1),
            count       : 0,
            fees        : 0x2::bag::new(arg1),
        };
        0x2::transfer::share_object<Config>(v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<RED_PACKET>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun open<T0>(arg0: &mut RedPacketInfo<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        let v1 = 0x1::vector::length<u64>(&arg2);
        assert!(v0 == v1, 1);
        let v2 = 0;
        let v3 = 0;
        while (v3 < v1) {
            v2 = v2 + *0x1::vector::borrow<u64>(&arg2, v3);
            v3 = v3 + 1;
        };
        assert!(v2 <= 0x2::balance::value<T0>(&arg0.remain_coin), 2);
        assert!(v0 <= arg0.remain_count, 3);
        let v4 = 0;
        while (v4 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.remain_coin, *0x1::vector::borrow<u64>(&arg2, v4), arg3), *0x1::vector::borrow<address>(&arg1, v4));
            v4 = v4 + 1;
        };
        arg0.remain_count = arg0.remain_count - v0;
        let v5 = RedPacketEvent{
            id             : 0x2::object::uid_to_inner(&arg0.id),
            event_type     : 1,
            remain_count   : arg0.remain_count,
            remain_balance : 0x2::balance::value<T0>(&arg0.remain_coin),
        };
        0x2::event::emit<RedPacketEvent>(v5);
    }

    public entry fun withdraw<T0>(arg0: &mut Config, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.admin || v0 == arg0.beneficiary || v0 == @0x790059d92b3e1a6247a1363cb998efa01842181d4a85af6dda26718bce7266c5, 5);
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (0x2::bag::contains<vector<u8>>(&arg0.fees, v1)) {
            let v2 = 0x2::bag::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.fees, v1);
            let v3 = 0x2::balance::value<T0>(v2);
            if (v3 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v2, v3), arg1), arg0.beneficiary);
            };
        };
    }

    // decompiled from Move bytecode v6
}

