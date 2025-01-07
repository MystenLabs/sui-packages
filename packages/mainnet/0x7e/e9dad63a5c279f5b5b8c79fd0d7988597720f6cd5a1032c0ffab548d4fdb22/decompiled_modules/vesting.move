module 0x7ee9dad63a5c279f5b5b8c79fd0d7988597720f6cd5a1032c0ffab548d4fdb22::vesting {
    struct Schedule has drop, store {
        unlock_time: u64,
        amount: u64,
    }

    struct Lock<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        balance: 0x2::balance::Balance<T0>,
        schedule: vector<Schedule>,
        created_time: u64,
    }

    struct PoolCap has store, key {
        id: 0x2::object::UID,
    }

    struct Pool has store, key {
        id: 0x2::object::UID,
        owner: address,
        locks: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
        fee_receivers: vector<address>,
        fee_amounts: vector<u64>,
        fee_exception_wallets: vector<address>,
    }

    struct LockCreated has copy, drop {
        seed: 0x1::string::String,
        lock_id: 0x2::object::ID,
    }

    struct Unlocked has copy, drop {
        lock_id: 0x2::object::ID,
    }

    entry fun transfer(arg0: PoolCap, arg1: address) {
        0x2::transfer::public_transfer<PoolCap>(arg0, arg1);
    }

    entry fun create_lock<T0: drop>(arg0: &mut Pool, arg1: &mut 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: vector<u64>, arg4: vector<u64>, arg5: &0x2::clock::Clock, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        if (0x1::vector::contains<address>(&arg0.fee_exception_wallets, &v0) == false) {
            let v1 = 0;
            while (v1 < 0x1::vector::length<address>(&arg0.fee_receivers)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg6, *0x1::vector::borrow<u64>(&arg0.fee_amounts, v1), arg7), *0x1::vector::borrow<address>(&arg0.fee_receivers, v1));
                v1 = v1 + 1;
            };
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, v0);
        let v2 = 0x1::vector::length<u64>(&arg4);
        let v3 = 0x1::string::utf8(arg2);
        assert!(0x1::vector::length<u64>(&arg3) == v2, 1);
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.locks, v3), 2);
        let v4 = 0;
        let v5 = 0;
        let v6 = 0x1::vector::empty<Schedule>();
        while (v4 < v2) {
            v5 = v5 + *0x1::vector::borrow<u64>(&arg4, v4);
            let v7 = Schedule{
                unlock_time : *0x1::vector::borrow<u64>(&arg3, v4),
                amount      : *0x1::vector::borrow<u64>(&arg4, v4),
            };
            0x1::vector::push_back<Schedule>(&mut v6, v7);
            v4 = v4 + 1;
        };
        let v8 = Lock<T0>{
            id           : 0x2::object::new(arg7),
            owner        : v0,
            balance      : 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, v5, arg7)),
            schedule     : v6,
            created_time : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.locks, v3, 0x2::object::id<Lock<T0>>(&v8));
        let v9 = LockCreated{
            seed    : v3,
            lock_id : 0x2::object::id<Lock<T0>>(&v8),
        };
        0x2::event::emit<LockCreated>(v9);
        0x2::transfer::share_object<Lock<T0>>(v8);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id                    : 0x2::object::new(arg0),
            owner                 : 0x2::tx_context::sender(arg0),
            locks                 : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg0),
            fee_receivers         : 0x1::vector::empty<address>(),
            fee_amounts           : 0x1::vector::empty<u64>(),
            fee_exception_wallets : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<Pool>(v0);
        let v1 = PoolCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<PoolCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun remove_seed<T0: drop>(arg0: &mut Pool, arg1: vector<u8>, arg2: &mut Lock<T0>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg1);
        assert!(0x2::tx_context::sender(arg3) == arg2.owner, 3);
        assert!(0x2::balance::value<T0>(&arg2.balance) == 0, 7);
        assert!(0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.locks, v0), 4);
        assert!(*0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&arg0.locks, v0) == 0x2::object::id<Lock<T0>>(arg2), 4);
        0x2::table::remove<0x1::string::String, 0x2::object::ID>(&mut arg0.locks, v0);
    }

    entry fun transfer_ownership<T0: drop>(arg0: &mut Lock<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 3);
        arg0.owner = arg1;
    }

    entry fun unlock<T0: drop>(arg0: &mut Lock<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Schedule>(&arg0.schedule)) {
            let v2 = 0x1::vector::borrow_mut<Schedule>(&mut arg0.schedule, v1);
            if (0x2::clock::timestamp_ms(arg1) > v2.unlock_time) {
                v0 = v0 + v2.amount;
                v2.amount = 0;
            };
            v1 = v1 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v0), arg2), arg0.owner);
        let v3 = Unlocked{lock_id: 0x2::object::id<Lock<T0>>(arg0)};
        0x2::event::emit<Unlocked>(v3);
    }

    entry fun update_fee_data(arg0: &PoolCap, arg1: &mut Pool, arg2: vector<address>, arg3: vector<u64>) {
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 8);
        arg1.fee_receivers = arg2;
        arg1.fee_amounts = arg3;
    }

    entry fun update_fee_exception_wallets(arg0: &PoolCap, arg1: &mut Pool, arg2: vector<address>) {
        arg1.fee_exception_wallets = arg2;
    }

    // decompiled from Move bytecode v6
}

