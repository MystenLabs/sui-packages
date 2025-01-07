module 0x859a3383afadb25310c43cb034088eef5e022f7aa77cde71231e2c972fc8d356::IDO {
    struct IdoPool<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        start_time: u64,
        end_time: u64,
        soft_cap: u64,
        hard_cap: u64,
        max_commit: u64,
        min_commit: u64,
        rate: u64,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        balance: 0x2::balance::Balance<T0>,
        account_commit_table: 0x2::table::Table<address, u64>,
        account_commit_table_clone: 0x2::table::Table<address, u64>,
        status: u8,
        amount: u64,
    }

    struct DepositEvent has copy, drop {
        address: address,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        address: address,
        amount: u64,
    }

    struct CommitEvent has copy, drop {
        address: address,
        amount: u64,
        total_amount: u64,
        time: u64,
    }

    struct FinalizeEvent has copy, drop {
        address: address,
        amount: u64,
        status: u8,
    }

    struct ClaimEvent has copy, drop {
        address: address,
        amount: u64,
        sui_amount: u64,
    }

    entry fun claim<T0: drop>(arg0: &mut IdoPool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.end_time, 4);
        assert!(0x2::table::contains<address, u64>(&arg0.account_commit_table, v0), 6);
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.account_commit_table, v0);
        assert!(*v1 > 0, 7);
        if (arg0.amount > arg0.soft_cap) {
            let v2 = (((*v1 as u256) * (arg0.rate as u256) / 10000000000) as u64);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v2), arg2), v0);
            let v3 = ClaimEvent{
                address    : v0,
                amount     : v2,
                sui_amount : 0,
            };
            0x2::event::emit<ClaimEvent>(v3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, *v1), arg2), v0);
            let v4 = ClaimEvent{
                address    : v0,
                amount     : 0,
                sui_amount : *v1,
            };
            0x2::event::emit<ClaimEvent>(v4);
        };
        *v1 = 0;
    }

    entry fun commit<T0: drop>(arg0: &mut IdoPool<T0>, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 >= arg0.start_time && v1 <= arg0.end_time, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg1, arg2, arg4)));
        if (0x2::table::contains<address, u64>(&arg0.account_commit_table, v0)) {
            let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg0.account_commit_table, v0);
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.account_commit_table_clone, v0);
            assert!(*v2 + arg2 >= arg0.min_commit && *v2 + arg2 <= arg0.max_commit, 3);
            assert!(arg0.amount + arg2 < arg0.hard_cap, 8);
            *v2 = *v2 + arg2;
            *v3 = *v3 + arg2;
            let v4 = CommitEvent{
                address      : v0,
                amount       : arg2,
                total_amount : *v2,
                time         : v1,
            };
            0x2::event::emit<CommitEvent>(v4);
        } else {
            assert!(arg2 >= arg0.min_commit && arg2 <= arg0.max_commit, 3);
            assert!(arg0.amount + arg2 < arg0.hard_cap, 8);
            0x2::table::add<address, u64>(&mut arg0.account_commit_table, v0, arg2);
            0x2::table::add<address, u64>(&mut arg0.account_commit_table_clone, v0, arg2);
            let v5 = CommitEvent{
                address      : v0,
                amount       : arg2,
                total_amount : arg2,
                time         : v1,
            };
            0x2::event::emit<CommitEvent>(v5);
        };
        arg0.amount = arg0.amount + arg2;
    }

    entry fun create_ido<T0: drop>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = IdoPool<T0>{
            id                         : 0x2::object::new(arg7),
            owner                      : 0x2::tx_context::sender(arg7),
            start_time                 : arg0,
            end_time                   : arg1,
            soft_cap                   : arg2,
            hard_cap                   : arg3,
            max_commit                 : arg4,
            min_commit                 : arg5,
            rate                       : arg6,
            sui_balance                : 0x2::balance::zero<0x2::sui::SUI>(),
            balance                    : 0x2::balance::zero<T0>(),
            account_commit_table       : 0x2::table::new<address, u64>(arg7),
            account_commit_table_clone : 0x2::table::new<address, u64>(arg7),
            status                     : 0,
            amount                     : 0,
        };
        0x2::transfer::share_object<IdoPool<T0>>(v0);
    }

    entry fun deposit<T0: drop>(arg0: &mut IdoPool<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, arg2, arg3)));
        let v0 = DepositEvent{
            address : 0x2::tx_context::sender(arg3),
            amount  : arg2,
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    entry fun finalize<T0: drop>(arg0: &mut IdoPool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::balance::value<T0>(&arg0.balance);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance);
        assert!(v0 == arg0.owner, 2);
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.end_time, 4);
        assert!(arg0.status == 0, 9);
        if (v2 >= arg0.soft_cap) {
            arg0.status = 1;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, v2), arg2), v0);
            let v3 = FinalizeEvent{
                address : v0,
                amount  : v2,
                status  : 1,
            };
            0x2::event::emit<FinalizeEvent>(v3);
        } else {
            arg0.status = 2;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v1), arg2), v0);
            let v4 = FinalizeEvent{
                address : v0,
                amount  : v1,
                status  : 2,
            };
            0x2::event::emit<FinalizeEvent>(v4);
        };
    }

    entry fun transfer_ownership<T0: drop>(arg0: &mut IdoPool<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 2);
        arg0.owner = arg1;
    }

    entry fun update_hard_cap<T0: drop>(arg0: &mut IdoPool<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 2);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.start_time, 4);
        arg0.hard_cap = arg1;
    }

    entry fun update_max_commit<T0: drop>(arg0: &mut IdoPool<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 2);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.start_time, 4);
        arg0.max_commit = arg1;
    }

    entry fun update_min_commit<T0: drop>(arg0: &mut IdoPool<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 2);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.start_time, 4);
        arg0.min_commit = arg1;
    }

    entry fun update_rate<T0: drop>(arg0: &mut IdoPool<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 2);
        arg0.rate = arg1;
    }

    entry fun update_soft_cap<T0: drop>(arg0: &mut IdoPool<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 2);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.start_time, 4);
        arg0.soft_cap = arg1;
    }

    entry fun withdraw<T0: drop>(arg0: &mut IdoPool<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.owner, 2);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.start_time, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg3), v0);
        let v1 = WithdrawEvent{
            address : v0,
            amount  : arg1,
        };
        0x2::event::emit<WithdrawEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

