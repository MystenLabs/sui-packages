module 0xf29959f3b0f981d8ad536949c9ac9233a404784ab1d3aefc143199f5db727632::airdrop {
    struct AIRDROP has drop {
        dummy_field: bool,
    }

    struct Airdrops has store, key {
        id: 0x2::object::UID,
        owner_list: vector<address>,
    }

    struct UserAirdrop<phantom T0> has store, key {
        id: 0x2::object::UID,
        user: address,
        quantity: u64,
        is_claim: bool,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        total_amount: u64,
        claimed_amount: u64,
        start_time: u64,
        owner: address,
        reward: 0x2::balance::Balance<T0>,
        allocations: 0x2::object_table::ObjectTable<address, UserAirdrop<T0>>,
        participants: u64,
    }

    public entry fun add_whitelist<T0>(arg0: &mut Pool<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 0);
        assert!(arg0.owner == 0x2::tx_context::sender(arg5), 4);
        assert!(0x2::coin::value<T0>(&arg4) >= arg3, 0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg1);
            let v2 = UserAirdrop<T0>{
                id       : 0x2::object::new(arg5),
                user     : v1,
                quantity : 0x1::vector::pop_back<u64>(&mut arg2),
                is_claim : false,
            };
            0x2::object_table::add<address, UserAirdrop<T0>>(&mut arg0.allocations, v1, v2);
            v0 = v0 + 1;
        };
        0x2::balance::join<T0>(&mut arg0.reward, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg4, arg3, arg5)));
        arg0.total_amount = arg0.total_amount + arg3;
        if (0x2::coin::value<T0>(&arg4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<T0>(arg4);
        };
    }

    public entry fun claim<T0>(arg0: &mut Pool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.start_time, 6);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::object_table::contains<address, UserAirdrop<T0>>(&arg0.allocations, v0), 2);
        let v1 = 0x2::object_table::borrow_mut<address, UserAirdrop<T0>>(&mut arg0.allocations, v0);
        assert!(v1.is_claim == false, 3);
        let v2 = v1.quantity;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.reward, v2, arg2), v0);
        arg0.claimed_amount = arg0.claimed_amount + v2;
        arg0.participants = arg0.participants + 1;
        v1.is_claim = true;
    }

    public entry fun create_pool<T0>(arg0: vector<u8>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0>{
            id             : 0x2::object::new(arg2),
            title          : 0x1::string::utf8(arg0),
            total_amount   : 0,
            claimed_amount : 0,
            start_time     : arg1,
            owner          : 0x2::tx_context::sender(arg2),
            reward         : 0x2::balance::zero<T0>(),
            allocations    : 0x2::object_table::new<address, UserAirdrop<T0>>(arg2),
            participants   : 0,
        };
        0x2::transfer::share_object<Pool<T0>>(v0);
    }

    fun init(arg0: AIRDROP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<AIRDROP>(arg0, arg1);
        let v0 = Airdrops{
            id         : 0x2::object::new(arg1),
            owner_list : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<Airdrops>(v0);
    }

    // decompiled from Move bytecode v6
}

