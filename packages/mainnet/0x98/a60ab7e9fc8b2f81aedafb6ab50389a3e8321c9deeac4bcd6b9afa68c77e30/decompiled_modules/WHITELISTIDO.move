module 0x98a60ab7e9fc8b2f81aedafb6ab50389a3e8321c9deeac4bcd6b9afa68c77e30::WHITELISTIDO {
    struct WhiteListIDO<phantom T0> has store, key {
        id: 0x2::object::UID,
        start_time: u64,
        end_time: u64,
        tge_time: u64,
        hard_cap: u64,
        min_commit: u64,
        max_commit: u64,
        owner: address,
        whitelist_addresses: vector<address>,
        total_committed: u64,
        balance: 0x2::balance::Balance<T0>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        commited_table: 0x2::table::Table<address, u128>,
        claimed_table: 0x2::table::Table<address, u128>,
        status: u64,
    }

    struct WhitelistIDOAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct IDOCommittedEvent has copy, drop {
        sender: address,
        amount: u64,
    }

    struct IDOClaimedEvent has copy, drop {
        sender: address,
        received: u128,
    }

    public entry fun add_liquidity<T0>(arg0: &WhitelistIDOAdminCap, arg1: &mut WhiteListIDO<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_balance)), arg3), arg2);
    }

    public entry fun add_whitelist<T0>(arg0: &WhitelistIDOAdminCap, arg1: &mut WhiteListIDO<T0>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 4);
        0x1::vector::append<address>(&mut arg1.whitelist_addresses, arg2);
    }

    public entry fun admin_deposit_tokens<T0>(arg0: &mut WhiteListIDO<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun claim_tokens<T0>(arg0: &mut WhiteListIDO<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.tge_time, 7);
        assert!(arg0.status == 1, 7);
        assert!(!0x2::table::contains<address, u128>(&arg0.claimed_table, v0), 8);
        let v1 = *0x2::table::borrow_mut<address, u128>(&mut arg0.commited_table, v0) * 3125 * 1000000000 / 1000 * 1000000000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, (v1 as u64)), arg2), v0);
        0x2::table::add<address, u128>(&mut arg0.claimed_table, v0, (v1 as u128));
        let v2 = IDOClaimedEvent{
            sender   : 0x2::tx_context::sender(arg2),
            received : v1,
        };
        0x2::event::emit<IDOClaimedEvent>(v2);
    }

    public fun claimed_amount<T0>(arg0: &WhiteListIDO<T0>, arg1: address) : u128 {
        *0x2::table::borrow<address, u128>(&arg0.claimed_table, arg1)
    }

    public entry fun commit_whitelist_ido<T0>(arg0: &mut WhiteListIDO<T0>, arg1: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(is_whitelisted<T0>(arg0, v0), 1);
        assert!(arg0.total_committed != arg0.hard_cap, 3);
        let v1 = false;
        if (arg0.total_committed + arg2 > arg0.hard_cap) {
            arg2 = arg0.hard_cap - arg0.total_committed;
            v1 = true;
        };
        let (v2, v3) = split_coin_vec<0x2::sui::SUI>(arg1, arg2, arg4);
        let v4 = v2;
        let v5 = 0x2::clock::timestamp_ms(arg3);
        assert!(v5 >= arg0.start_time && v5 <= arg0.end_time, 2);
        let v6 = 0x2::coin::value<0x2::sui::SUI>(&v4);
        arg0.total_committed = arg0.total_committed + v6;
        if (!0x2::table::contains<address, u128>(&arg0.commited_table, v0)) {
            if (!v1) {
                assert!(v6 >= arg0.min_commit, 5);
            };
            assert!(v6 <= arg0.max_commit, 6);
            0x2::table::add<address, u128>(&mut arg0.commited_table, v0, (v6 as u128));
        } else {
            let v7 = 0x2::table::borrow_mut<address, u128>(&mut arg0.commited_table, v0);
            assert!(*v7 + (v6 as u128) <= (arg0.max_commit as u128), 6);
            *v7 = *v7 + (v6 as u128);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(v4));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, 0x2::tx_context::sender(arg4));
        let v8 = IDOCommittedEvent{
            sender : 0x2::tx_context::sender(arg4),
            amount : v6,
        };
        0x2::event::emit<IDOCommittedEvent>(v8);
    }

    public fun commited_amount<T0>(arg0: &WhiteListIDO<T0>, arg1: address) : u128 {
        *0x2::table::borrow<address, u128>(&arg0.commited_table, arg1)
    }

    public entry fun ido_initialize<T0>(arg0: &WhitelistIDOAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = WhiteListIDO<T0>{
            id                  : 0x2::object::new(arg1),
            start_time          : 1706533200000,
            end_time            : 1706534100000,
            tge_time            : 1706620500000,
            hard_cap            : 32000000000000,
            min_commit          : 10000000000,
            max_commit          : 5000000000000,
            owner               : 0x2::tx_context::sender(arg1),
            whitelist_addresses : 0x1::vector::empty<address>(),
            total_committed     : 0,
            balance             : 0x2::balance::zero<T0>(),
            sui_balance         : 0x2::balance::zero<0x2::sui::SUI>(),
            commited_table      : 0x2::table::new<address, u128>(arg1),
            claimed_table       : 0x2::table::new<address, u128>(arg1),
            status              : 0,
        };
        0x2::transfer::share_object<WhiteListIDO<T0>>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = WhitelistIDOAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<WhitelistIDOAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_whitelisted<T0>(arg0: &WhiteListIDO<T0>, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.whitelist_addresses, &arg1)
    }

    public entry fun liquidity_already<T0>(arg0: &WhitelistIDOAdminCap, arg1: &mut WhiteListIDO<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 4);
        arg1.status = 1;
    }

    public entry fun set_time<T0>(arg0: &WhitelistIDOAdminCap, arg1: &mut WhiteListIDO<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg9), 4);
        arg1.start_time = arg2;
        arg1.end_time = arg3;
        arg1.tge_time = arg4;
        arg1.hard_cap = arg5;
        arg1.status = arg6;
        arg1.min_commit = arg7;
        arg1.max_commit = arg8;
    }

    public fun split_coin_vec<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::zero<T0>(arg2);
        0x2::pay::join_vec<T0>(&mut v0, arg0);
        (0x2::coin::split<T0>(&mut v0, arg1, arg2), v0)
    }

    // decompiled from Move bytecode v6
}

