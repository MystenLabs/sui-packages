module 0x6e0191d5c9f87e4339f9067b687242d05ab6d0ae5e7197d7c0fae1b299d61f83::claims {
    struct Claim has store, key {
        id: 0x2::object::UID,
        tenant_id: vector<u8>,
        claim_id: u64,
        quantity: u64,
    }

    struct ClaimEvent has copy, drop, store {
        id: u64,
        user: vector<u8>,
        tenant_id: vector<u8>,
        claim_id: address,
        claim_quantity: u64,
        timestamp: u64,
    }

    struct ClaimCount has copy, drop, store {
        tenant_id: vector<u8>,
        user: vector<u8>,
        claim_count: u64,
    }

    struct BalanceCount has copy, drop, store {
        tenant_id: vector<u8>,
        user: vector<u8>,
        balance_count: u64,
    }

    struct UserClaimCount has store, key {
        id: 0x2::object::UID,
        claim_counts: 0x2::table::Table<vector<u8>, 0x2::table::Table<vector<u8>, u64>>,
        balance_counts: 0x2::table::Table<vector<u8>, 0x2::table::Table<vector<u8>, u64>>,
    }

    public fun claim_reward(arg0: vector<u8>, arg1: &0x6e0191d5c9f87e4339f9067b687242d05ab6d0ae5e7197d7c0fae1b299d61f83::access_control::AdminKey, arg2: &0x6e0191d5c9f87e4339f9067b687242d05ab6d0ae5e7197d7c0fae1b299d61f83::access_control::Executor, arg3: vector<u8>, arg4: &Claim, arg5: &0x2::clock::Clock, arg6: &mut UserClaimCount, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x6e0191d5c9f87e4339f9067b687242d05ab6d0ae5e7197d7c0fae1b299d61f83::access_control::assert_admin(0x2::tx_context::sender(arg7), arg0, arg1) || 0x6e0191d5c9f87e4339f9067b687242d05ab6d0ae5e7197d7c0fae1b299d61f83::access_control::assert_executor(0x2::tx_context::sender(arg7), arg2), 1);
        assert!(arg0 == arg4.tenant_id, 4);
        let v0 = if (0x2::table::contains<vector<u8>, 0x2::table::Table<vector<u8>, u64>>(&arg6.claim_counts, arg0)) {
            0x2::table::borrow_mut<vector<u8>, 0x2::table::Table<vector<u8>, u64>>(&mut arg6.claim_counts, arg0)
        } else {
            0x2::table::add<vector<u8>, 0x2::table::Table<vector<u8>, u64>>(&mut arg6.claim_counts, arg0, 0x2::table::new<vector<u8>, u64>(arg7));
            0x2::table::borrow_mut<vector<u8>, 0x2::table::Table<vector<u8>, u64>>(&mut arg6.claim_counts, arg0)
        };
        let v1 = if (0x2::table::contains<vector<u8>, 0x2::table::Table<vector<u8>, u64>>(&arg6.balance_counts, arg0)) {
            0x2::table::borrow_mut<vector<u8>, 0x2::table::Table<vector<u8>, u64>>(&mut arg6.balance_counts, arg0)
        } else {
            0x2::table::add<vector<u8>, 0x2::table::Table<vector<u8>, u64>>(&mut arg6.balance_counts, arg0, 0x2::table::new<vector<u8>, u64>(arg7));
            0x2::table::borrow_mut<vector<u8>, 0x2::table::Table<vector<u8>, u64>>(&mut arg6.balance_counts, arg0)
        };
        if (0x2::table::contains<vector<u8>, u64>(v0, arg3)) {
            let v2 = 0x2::table::borrow_mut<vector<u8>, u64>(v0, arg3);
            *v2 = *v2 + 1;
            let v3 = 0x2::table::borrow_mut<vector<u8>, u64>(v1, arg3);
            *v3 = *v3 + arg4.quantity;
        } else {
            0x2::table::add<vector<u8>, u64>(v0, arg3, 1);
            0x2::table::add<vector<u8>, u64>(v1, arg3, arg4.quantity);
        };
        let v4 = ClaimEvent{
            id             : arg4.claim_id,
            user           : arg3,
            tenant_id      : arg0,
            claim_id       : 0x2::object::id_address<Claim>(arg4),
            claim_quantity : arg4.quantity,
            timestamp      : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ClaimEvent>(v4);
    }

    public fun create_claim_reward(arg0: &0x6e0191d5c9f87e4339f9067b687242d05ab6d0ae5e7197d7c0fae1b299d61f83::access_control::AdminKey, arg1: &0x6e0191d5c9f87e4339f9067b687242d05ab6d0ae5e7197d7c0fae1b299d61f83::access_control::Executor, arg2: vector<u8>, arg3: u64, arg4: &mut 0x6e0191d5c9f87e4339f9067b687242d05ab6d0ae5e7197d7c0fae1b299d61f83::state::RewardClaimState, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x6e0191d5c9f87e4339f9067b687242d05ab6d0ae5e7197d7c0fae1b299d61f83::access_control::assert_admin(0x2::tx_context::sender(arg5), arg2, arg0) || 0x6e0191d5c9f87e4339f9067b687242d05ab6d0ae5e7197d7c0fae1b299d61f83::access_control::assert_executor(0x2::tx_context::sender(arg5), arg1), 1);
        let v0 = Claim{
            id        : 0x2::object::new(arg5),
            tenant_id : arg2,
            claim_id  : 0x6e0191d5c9f87e4339f9067b687242d05ab6d0ae5e7197d7c0fae1b299d61f83::state::increment_last_claim_id(arg4, arg2),
            quantity  : arg3,
        };
        0x2::transfer::share_object<Claim>(v0);
    }

    public fun delete_claim(arg0: &0x6e0191d5c9f87e4339f9067b687242d05ab6d0ae5e7197d7c0fae1b299d61f83::access_control::AdminKey, arg1: &0x6e0191d5c9f87e4339f9067b687242d05ab6d0ae5e7197d7c0fae1b299d61f83::access_control::Executor, arg2: vector<u8>, arg3: Claim, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x6e0191d5c9f87e4339f9067b687242d05ab6d0ae5e7197d7c0fae1b299d61f83::access_control::assert_admin(0x2::tx_context::sender(arg4), arg2, arg0) || 0x6e0191d5c9f87e4339f9067b687242d05ab6d0ae5e7197d7c0fae1b299d61f83::access_control::assert_executor(0x2::tx_context::sender(arg4), arg1), 1);
        let Claim {
            id        : v0,
            tenant_id : _,
            claim_id  : _,
            quantity  : _,
        } = arg3;
        0x2::object::delete(v0);
    }

    public fun get_user_balance_count(arg0: vector<u8>, arg1: vector<u8>, arg2: &UserClaimCount) : u64 {
        let v0 = 0x2::table::borrow<vector<u8>, 0x2::table::Table<vector<u8>, u64>>(&arg2.balance_counts, arg1);
        let v1 = if (0x2::table::contains<vector<u8>, u64>(v0, arg0)) {
            *0x2::table::borrow<vector<u8>, u64>(v0, arg0)
        } else {
            0
        };
        let v2 = BalanceCount{
            tenant_id     : arg1,
            user          : arg0,
            balance_count : v1,
        };
        0x2::event::emit<BalanceCount>(v2);
        v1
    }

    public fun get_user_claim_count(arg0: vector<u8>, arg1: vector<u8>, arg2: &UserClaimCount) : u64 {
        let v0 = 0x2::table::borrow<vector<u8>, 0x2::table::Table<vector<u8>, u64>>(&arg2.claim_counts, arg1);
        let v1 = if (0x2::table::contains<vector<u8>, u64>(v0, arg0)) {
            *0x2::table::borrow<vector<u8>, u64>(v0, arg0)
        } else {
            0
        };
        let v2 = ClaimCount{
            tenant_id   : arg1,
            user        : arg0,
            claim_count : v1,
        };
        0x2::event::emit<ClaimCount>(v2);
        v1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UserClaimCount{
            id             : 0x2::object::new(arg0),
            claim_counts   : 0x2::table::new<vector<u8>, 0x2::table::Table<vector<u8>, u64>>(arg0),
            balance_counts : 0x2::table::new<vector<u8>, 0x2::table::Table<vector<u8>, u64>>(arg0),
        };
        0x2::transfer::share_object<UserClaimCount>(v0);
    }

    public fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UserClaimCount{
            id             : 0x2::object::new(arg0),
            claim_counts   : 0x2::table::new<vector<u8>, 0x2::table::Table<vector<u8>, u64>>(arg0),
            balance_counts : 0x2::table::new<vector<u8>, 0x2::table::Table<vector<u8>, u64>>(arg0),
        };
        0x2::transfer::share_object<UserClaimCount>(v0);
    }

    public fun reduce_points(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut UserClaimCount, arg3: u64) {
        let v0 = 0x2::table::borrow_mut<vector<u8>, u64>(0x2::table::borrow_mut<vector<u8>, 0x2::table::Table<vector<u8>, u64>>(&mut arg2.balance_counts, arg1), arg0);
        assert!(*v0 >= arg3, 3);
        *v0 = *v0 - arg3;
    }

    // decompiled from Move bytecode v6
}

