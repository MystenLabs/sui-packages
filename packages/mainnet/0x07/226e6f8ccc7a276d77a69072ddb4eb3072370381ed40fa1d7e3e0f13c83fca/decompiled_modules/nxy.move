module 0x7226e6f8ccc7a276d77a69072ddb4eb3072370381ed40fa1d7e3e0f13c83fca::nxy {
    struct SuiStakeItem has store, key {
        id: 0x2::object::UID,
        amount: u64,
        unstake_time: u64,
    }

    struct SuiStakeStatus has key {
        id: 0x2::object::UID,
        stake_all: 0x2::balance::Balance<0x2::sui::SUI>,
        unstake_all: u64,
        owner: address,
        bind: 0x2::table::Table<address, 0x1::string::String>,
    }

    struct CreateEvent has copy, drop {
        obj_id: 0x2::object::ID,
    }

    struct DeleteEvent has copy, drop {
        obj_id: 0x2::object::ID,
    }

    struct BindEvent has copy, drop {
        sui_addr: address,
        nxy_addr: 0x1::string::String,
    }

    public fun GetBindNxy(arg0: address, arg1: &mut SuiStakeStatus) : u64 {
        0x2::table::length<address, 0x1::string::String>(&mut arg1.bind)
    }

    entry fun bindNxy(arg0: 0x1::string::String, arg1: &mut SuiStakeStatus, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<address, 0x1::string::String>(&arg1.bind, 0x2::tx_context::sender(arg2))) {
            0x2::table::remove<address, 0x1::string::String>(&mut arg1.bind, 0x2::tx_context::sender(arg2));
        };
        0x2::table::add<address, 0x1::string::String>(&mut arg1.bind, 0x2::tx_context::sender(arg2), arg0);
        let v0 = BindEvent{
            sui_addr : 0x2::tx_context::sender(arg2),
            nxy_addr : arg0,
        };
        0x2::event::emit<BindEvent>(v0);
    }

    entry fun cancel_unstake(arg0: vector<SuiStakeItem>, arg1: &mut SuiStakeStatus, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0;
        while (!0x1::vector::is_empty<SuiStakeItem>(&mut arg0)) {
            let v2 = 0x1::vector::pop_back<SuiStakeItem>(&mut arg0);
            v0 = v0 + v2.amount;
            if (v2.unstake_time != 0) {
                v1 = v1 + v2.amount;
            };
            let SuiStakeItem {
                id           : v3,
                amount       : _,
                unstake_time : _,
            } = v2;
            let v6 = v3;
            let v7 = DeleteEvent{obj_id: 0x2::object::uid_to_inner(&v6)};
            0x2::event::emit<DeleteEvent>(v7);
            0x2::object::delete(v6);
        };
        0x1::vector::destroy_empty<SuiStakeItem>(arg0);
        if (v0 != 0) {
            let v8 = SuiStakeItem{
                id           : 0x2::object::new(arg2),
                amount       : v0,
                unstake_time : 0,
            };
            let v9 = CreateEvent{obj_id: 0x2::object::uid_to_inner(&v8.id)};
            0x2::event::emit<CreateEvent>(v9);
            0x2::transfer::transfer<SuiStakeItem>(v8, 0x2::tx_context::sender(arg2));
        };
        arg1.unstake_all = arg1.unstake_all - v1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SuiStakeStatus{
            id          : 0x2::object::new(arg0),
            stake_all   : 0x2::balance::zero<0x2::sui::SUI>(),
            unstake_all : 0,
            owner       : 0x2::tx_context::sender(arg0),
            bind        : 0x2::table::new<address, 0x1::string::String>(arg0),
        };
        0x2::transfer::share_object<SuiStakeStatus>(v0);
    }

    fun merge_coins<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x1::vector::length<0x2::coin::Coin<T0>>(&arg0) == 0) {
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
            0x2::coin::zero<T0>(arg1)
        } else {
            let v1 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
            0x2::pay::join_vec<T0>(&mut v1, arg0);
            v1
        }
    }

    entry fun set_admin(arg0: address, arg1: &mut SuiStakeStatus, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg2) == arg1.owner) {
            arg1.owner = arg0;
        };
    }

    public entry fun stake(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg1: &mut SuiStakeStatus, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = merge_coins<0x2::sui::SUI>(arg0, arg3);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(v0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v1) >= arg2, 1);
        transfer_or_destroy_zero<0x2::sui::SUI>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg3), 0x2::tx_context::sender(arg3));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.stake_all, 0x2::balance::split<0x2::sui::SUI>(&mut v1, arg2));
        let v2 = SuiStakeItem{
            id           : 0x2::object::new(arg3),
            amount       : arg2,
            unstake_time : 0,
        };
        let v3 = CreateEvent{obj_id: 0x2::object::uid_to_inner(&v2.id)};
        0x2::event::emit<CreateEvent>(v3);
        0x2::transfer::transfer<SuiStakeItem>(v2, 0x2::tx_context::sender(arg3));
    }

    fun transfer_or_destroy_zero<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    entry fun unstake(arg0: vector<SuiStakeItem>, arg1: u64, arg2: &mut SuiStakeStatus, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (!0x1::vector::is_empty<SuiStakeItem>(&mut arg0)) {
            let v1 = 0x1::vector::pop_back<SuiStakeItem>(&mut arg0);
            assert!(v1.unstake_time == 0, 1);
            v0 = v0 + v1.amount;
            let SuiStakeItem {
                id           : v2,
                amount       : _,
                unstake_time : _,
            } = v1;
            let v5 = v2;
            let v6 = DeleteEvent{obj_id: 0x2::object::uid_to_inner(&v5)};
            0x2::event::emit<DeleteEvent>(v6);
            0x2::object::delete(v5);
        };
        assert!(v0 >= arg1, 2);
        0x1::vector::destroy_empty<SuiStakeItem>(arg0);
        let v7 = SuiStakeItem{
            id           : 0x2::object::new(arg4),
            amount       : arg1,
            unstake_time : 0x2::clock::timestamp_ms(arg3),
        };
        let v8 = CreateEvent{obj_id: 0x2::object::uid_to_inner(&v7.id)};
        0x2::event::emit<CreateEvent>(v8);
        0x2::transfer::transfer<SuiStakeItem>(v7, 0x2::tx_context::sender(arg4));
        if (v0 - arg1 != 0) {
            let v9 = SuiStakeItem{
                id           : 0x2::object::new(arg4),
                amount       : v0 - arg1,
                unstake_time : 0,
            };
            let v10 = CreateEvent{obj_id: 0x2::object::uid_to_inner(&v9.id)};
            0x2::event::emit<CreateEvent>(v10);
            0x2::transfer::transfer<SuiStakeItem>(v9, 0x2::tx_context::sender(arg4));
        };
        arg2.unstake_all = arg2.unstake_all + arg1;
    }

    entry fun withdraw(arg0: vector<SuiStakeItem>, arg1: &mut SuiStakeStatus, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (!0x1::vector::is_empty<SuiStakeItem>(&mut arg0)) {
            let v1 = 0x1::vector::pop_back<SuiStakeItem>(&mut arg0);
            assert!(v1.unstake_time != 0 && 0x2::clock::timestamp_ms(arg2) - v1.unstake_time > 60000, 3);
            v0 = v0 + v1.amount;
            let SuiStakeItem {
                id           : v2,
                amount       : _,
                unstake_time : _,
            } = v1;
            let v5 = v2;
            let v6 = DeleteEvent{obj_id: 0x2::object::uid_to_inner(&v5)};
            0x2::event::emit<DeleteEvent>(v6);
            0x2::object::delete(v5);
        };
        0x1::vector::destroy_empty<SuiStakeItem>(arg0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.stake_all) >= v0, 3);
        transfer_or_destroy_zero<0x2::sui::SUI>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.stake_all, v0), arg3), 0x2::tx_context::sender(arg3));
        arg1.unstake_all = arg1.unstake_all - v0;
    }

    // decompiled from Move bytecode v6
}

