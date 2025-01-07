module 0xa6d19ad9404855e383eb2db4069f3979f0144f8a05ced980345d3231ce904fcc::PUBLICIFO {
    struct PublicIFO<phantom T0> has store, key {
        id: 0x2::object::UID,
        start_time: u64,
        end_time: u64,
        tge_time: u64,
        hard_cap: u64,
        min_commit: u64,
        max_commit: u64,
        public_rate: u128,
        owner: address,
        total_committed: u64,
        balance: 0x2::balance::Balance<T0>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        commited_table: 0x2::table::Table<address, u128>,
        claimed_table: 0x2::table::Table<address, u128>,
        status: u64,
    }

    struct PublicIFOAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PublicIFOCommittedEvent has copy, drop {
        sender: address,
        amount: u64,
    }

    struct PublicIFOClaimedEvent has copy, drop {
        sender: address,
        received: u128,
    }

    public entry fun add_liquidity<T0>(arg0: &PublicIFOAdminCap, arg1: &mut PublicIFO<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_balance)), arg3), arg2);
    }

    public entry fun admin_deposit_tokens<T0>(arg0: &mut PublicIFO<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun claim_tokens<T0>(arg0: &mut PublicIFO<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.tge_time, 7);
        assert!(arg0.status == 1, 7);
        assert!(!0x2::table::contains<address, u128>(&mut arg0.claimed_table, v0), 8);
        let v1 = 0x2::table::borrow_mut<address, u128>(&mut arg0.commited_table, 0x2::tx_context::sender(arg2));
        if (arg0.total_committed <= arg0.hard_cap) {
            let v2 = *v1 * 200000 * 1000000000 / 1000 * 1000000000;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, (v2 as u64)), arg2), 0x2::tx_context::sender(arg2));
            0x2::table::add<address, u128>(&mut arg0.claimed_table, v0, (v2 as u128));
            let v3 = PublicIFOClaimedEvent{
                sender   : 0x2::tx_context::sender(arg2),
                received : v2,
            };
            0x2::event::emit<PublicIFOClaimedEvent>(v3);
        } else {
            let v4 = *v1 * 200000 * (1000000000 as u128) * 1000000000 / (arg0.total_committed as u128) * 1000 * 1000000000;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, (v4 as u64)), arg2), 0x2::tx_context::sender(arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, ((*v1 - *v1 * (1000000000 as u128) / (arg0.total_committed as u128)) as u64)), arg2), 0x2::tx_context::sender(arg2));
            0x2::table::add<address, u128>(&mut arg0.claimed_table, v0, (v4 as u128));
            let v5 = PublicIFOClaimedEvent{
                sender   : 0x2::tx_context::sender(arg2),
                received : v4,
            };
            0x2::event::emit<PublicIFOClaimedEvent>(v5);
        };
    }

    public fun claimed_amount<T0>(arg0: &PublicIFO<T0>, arg1: address) : u128 {
        *0x2::table::borrow<address, u128>(&arg0.claimed_table, arg1)
    }

    public entry fun commit_public_ifo<T0>(arg0: &mut PublicIFO<T0>, arg1: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let (v1, v2) = split_coin_vec<0x2::sui::SUI>(arg1, arg2, arg4);
        let v3 = v1;
        let v4 = 0x2::clock::timestamp_ms(arg3);
        assert!(v4 >= arg0.start_time && v4 <= arg0.end_time, 2);
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&v3);
        if (!0x2::table::contains<address, u128>(&mut arg0.commited_table, v0)) {
            assert!(v5 >= arg0.min_commit, 5);
            assert!(v5 <= arg0.max_commit, 6);
            0x2::table::add<address, u128>(&mut arg0.commited_table, v0, (v5 as u128));
        } else {
            let v6 = 0x2::table::borrow_mut<address, u128>(&mut arg0.commited_table, v0);
            assert!(*v6 + (v5 as u128) <= (arg0.max_commit as u128), 6);
            *v6 = *v6 + (v5 as u128);
        };
        arg0.total_committed = arg0.total_committed + v5;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(v3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, 0x2::tx_context::sender(arg4));
        let v7 = PublicIFOCommittedEvent{
            sender : 0x2::tx_context::sender(arg4),
            amount : v5,
        };
        0x2::event::emit<PublicIFOCommittedEvent>(v7);
    }

    public fun commited_amount<T0>(arg0: &PublicIFO<T0>, arg1: address) : u128 {
        *0x2::table::borrow<address, u128>(&arg0.commited_table, arg1)
    }

    public entry fun ifo_initialize<T0>(arg0: &PublicIFOAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PublicIFO<T0>{
            id              : 0x2::object::new(arg1),
            start_time      : 1683460627000,
            end_time        : 1683462000000,
            tge_time        : 1683462000000,
            hard_cap        : 1000000000,
            min_commit      : 10000000,
            max_commit      : 1000000000,
            public_rate     : 200000,
            owner           : 0x2::tx_context::sender(arg1),
            total_committed : 0,
            balance         : 0x2::balance::zero<T0>(),
            sui_balance     : 0x2::balance::zero<0x2::sui::SUI>(),
            commited_table  : 0x2::table::new<address, u128>(arg1),
            claimed_table   : 0x2::table::new<address, u128>(arg1),
            status          : 0,
        };
        0x2::transfer::share_object<PublicIFO<T0>>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PublicIFOAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PublicIFOAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun liquidity_already<T0>(arg0: &PublicIFOAdminCap, arg1: &mut PublicIFO<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 4);
        arg1.status = 1;
    }

    public entry fun set_time<T0>(arg0: &PublicIFOAdminCap, arg1: &mut PublicIFO<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg5), 4);
        arg1.start_time = arg2;
        arg1.end_time = arg3;
        arg1.tge_time = arg4;
    }

    public fun split_coin_vec<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::zero<T0>(arg2);
        0x2::pay::join_vec<T0>(&mut v0, arg0);
        (0x2::coin::split<T0>(&mut v0, arg1, arg2), v0)
    }

    public entry fun widthdraw_unsold_tokens<T0>(arg0: &PublicIFOAdminCap, arg1: &mut PublicIFO<T0>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg4), 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg3), arg4), arg2);
    }

    // decompiled from Move bytecode v6
}

