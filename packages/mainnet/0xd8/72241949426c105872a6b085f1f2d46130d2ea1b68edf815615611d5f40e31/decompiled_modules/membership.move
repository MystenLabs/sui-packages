module 0xd872241949426c105872a6b085f1f2d46130d2ea1b68edf815615611d5f40e31::membership {
    struct PoolCreateCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        schema_version: u64,
        pool_id: 0x2::object::ID,
    }

    struct GenesisPool<phantom T0> has key {
        id: 0x2::object::UID,
        schema_version: u64,
        receiver: address,
        paused: bool,
        total_contributed: u128,
        member_count: u64,
        level_counts: vector<u64>,
    }

    struct MemberRecord has store, key {
        id: 0x2::object::UID,
        schema_version: u64,
        pool_id: 0x2::object::ID,
        member: address,
        level: u8,
        cumulative_paid: u64,
        joined_at_ms: u64,
        updated_at_ms: u64,
        upgrade_count: u64,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        creator: address,
        receiver: address,
        payment_decimals: u8,
        timestamp_ms: u64,
    }

    struct MemberJoined has copy, drop {
        pool_id: 0x2::object::ID,
        member: address,
        level: u8,
        payment_amount: u64,
        cumulative_paid: u64,
        receiver: address,
        timestamp_ms: u64,
    }

    struct MemberUpgraded has copy, drop {
        pool_id: 0x2::object::ID,
        member: address,
        from_level: u8,
        to_level: u8,
        top_up_amount: u64,
        cumulative_paid: u64,
        receiver: address,
        timestamp_ms: u64,
    }

    struct ReceiverUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        old_receiver: address,
        new_receiver: address,
        updated_by: address,
        timestamp_ms: u64,
    }

    struct PauseStatusUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        paused: bool,
        updated_by: address,
        timestamp_ms: u64,
    }

    fun assert_admin_cap<T0>(arg0: &GenesisPool<T0>, arg1: &AdminCap) {
        assert!(arg1.pool_id == 0x2::object::id<GenesisPool<T0>>(arg0), 7);
    }

    fun assert_usdc_type<T0>() {
        assert!(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()) == 0x1::ascii::string(b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC"), 10);
    }

    public fun create_pool<T0>(arg0: PoolCreateCap, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_usdc_type<T0>();
        create_pool_internal<T0>(arg0, arg1, arg2, arg3);
    }

    fun create_pool_internal<T0>(arg0: PoolCreateCap, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 5);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = GenesisPool<T0>{
            id                : 0x2::object::new(arg3),
            schema_version    : 1,
            receiver          : arg1,
            paused            : false,
            total_contributed : 0,
            member_count      : 0,
            level_counts      : vector[0, 0, 0, 0, 0],
        };
        let v2 = 0x2::object::id<GenesisPool<T0>>(&v1);
        let v3 = AdminCap{
            id             : 0x2::object::new(arg3),
            schema_version : 1,
            pool_id        : v2,
        };
        let PoolCreateCap { id: v4 } = arg0;
        0x2::object::delete(v4);
        let v5 = PoolCreated{
            pool_id          : v2,
            creator          : v0,
            receiver         : arg1,
            payment_decimals : 6,
            timestamp_ms     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PoolCreated>(v5);
        0x2::transfer::share_object<GenesisPool<T0>>(v1);
        0x2::transfer::transfer<AdminCap>(v3, v0);
    }

    fun decrement_level_count<T0>(arg0: &mut GenesisPool<T0>, arg1: u8) {
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg0.level_counts, level_index(arg1));
        assert!(*v0 > 0, 8);
        *v0 = *v0 - 1;
    }

    public fun get_admin_pool_id(arg0: &AdminCap) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun get_all_level_counts<T0>(arg0: &GenesisPool<T0>) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, *0x1::vector::borrow<u64>(&arg0.level_counts, 0));
        0x1::vector::push_back<u64>(v1, *0x1::vector::borrow<u64>(&arg0.level_counts, 1));
        0x1::vector::push_back<u64>(v1, *0x1::vector::borrow<u64>(&arg0.level_counts, 2));
        0x1::vector::push_back<u64>(v1, *0x1::vector::borrow<u64>(&arg0.level_counts, 3));
        0x1::vector::push_back<u64>(v1, *0x1::vector::borrow<u64>(&arg0.level_counts, 4));
        v0
    }

    public fun get_all_thresholds() : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, 1000000000);
        0x1::vector::push_back<u64>(v1, 3000000000);
        0x1::vector::push_back<u64>(v1, 5000000000);
        0x1::vector::push_back<u64>(v1, 10000000000);
        0x1::vector::push_back<u64>(v1, 20000000000);
        v0
    }

    public fun get_level_count<T0>(arg0: &GenesisPool<T0>, arg1: u8) : u64 {
        assert!(is_valid_level(arg1), 1);
        *0x1::vector::borrow<u64>(&arg0.level_counts, level_index(arg1))
    }

    public fun get_level_threshold(arg0: u8) : u64 {
        assert!(is_valid_level(arg0), 1);
        level_threshold_internal(arg0)
    }

    public fun get_member_count<T0>(arg0: &GenesisPool<T0>) : u64 {
        arg0.member_count
    }

    public fun get_member_info<T0>(arg0: &GenesisPool<T0>, arg1: address) : (bool, u8, u64, u64, u64, u64) {
        if (has_member<T0>(arg0, arg1)) {
            let v6 = 0x2::dynamic_object_field::borrow<address, MemberRecord>(&arg0.id, arg1);
            (true, v6.level, v6.cumulative_paid, v6.joined_at_ms, v6.updated_at_ms, v6.upgrade_count)
        } else {
            (false, 0, 0, 0, 0, 0)
        }
    }

    public fun get_next_level_info<T0>(arg0: &GenesisPool<T0>, arg1: address) : (bool, u8, u64) {
        if (arg1 == arg0.receiver) {
            (false, 0, 0)
        } else if (!has_member<T0>(arg0, arg1)) {
            (true, 1, 1000000000)
        } else {
            let v3 = 0x2::dynamic_object_field::borrow<address, MemberRecord>(&arg0.id, arg1);
            if (v3.level == 5) {
                (false, 0, 0)
            } else {
                let v4 = v3.level + 1;
                (true, v4, level_threshold_internal(v4) - v3.cumulative_paid)
            }
        }
    }

    public fun get_payment_decimals() : u8 {
        6
    }

    public fun get_pool_info<T0>(arg0: &GenesisPool<T0>) : (u64, address, bool, u128, u64) {
        (arg0.schema_version, arg0.receiver, arg0.paused, arg0.total_contributed, arg0.member_count)
    }

    public fun get_receiver<T0>(arg0: &GenesisPool<T0>) : address {
        arg0.receiver
    }

    public fun get_total_contributed<T0>(arg0: &GenesisPool<T0>) : u128 {
        arg0.total_contributed
    }

    public fun has_member<T0>(arg0: &GenesisPool<T0>, arg1: address) : bool {
        0x2::dynamic_object_field::exists_with_type<address, MemberRecord>(&arg0.id, arg1)
    }

    fun increment_level_count<T0>(arg0: &mut GenesisPool<T0>, arg1: u8) {
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg0.level_counts, level_index(arg1));
        *v0 = *v0 + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolCreateCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PoolCreateCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_paused<T0>(arg0: &GenesisPool<T0>) : bool {
        arg0.paused
    }

    public fun is_valid_level(arg0: u8) : bool {
        arg0 >= 1 && arg0 <= 5
    }

    fun level_index(arg0: u8) : u64 {
        (arg0 as u64) - 1
    }

    fun level_threshold_internal(arg0: u8) : u64 {
        if (arg0 == 1) {
            1000000000
        } else if (arg0 == 2) {
            3000000000
        } else if (arg0 == 3) {
            5000000000
        } else if (arg0 == 4) {
            10000000000
        } else {
            20000000000
        }
    }

    fun member_level_and_paid<T0>(arg0: &GenesisPool<T0>, arg1: address) : (u8, u64) {
        if (has_member<T0>(arg0, arg1)) {
            let v2 = 0x2::dynamic_object_field::borrow<address, MemberRecord>(&arg0.id, arg1);
            (v2.level, v2.cumulative_paid)
        } else {
            (0, 0)
        }
    }

    public fun participate<T0>(arg0: &mut GenesisPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u8, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 4);
        assert!(is_valid_level(arg2), 1);
        assert!(arg3 == arg0.receiver, 6);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 != arg0.receiver, 9);
        let v1 = 0x2::object::id<GenesisPool<T0>>(arg0);
        let v2 = level_threshold_internal(arg2);
        let v3 = 0x2::coin::value<T0>(&arg1);
        let v4 = 0x2::clock::timestamp_ms(arg4);
        if (!has_member<T0>(arg0, v0)) {
            assert!(v3 == v2, 3);
            let v5 = MemberRecord{
                id              : 0x2::object::new(arg5),
                schema_version  : 1,
                pool_id         : v1,
                member          : v0,
                level           : arg2,
                cumulative_paid : v2,
                joined_at_ms    : v4,
                updated_at_ms   : v4,
                upgrade_count   : 0,
            };
            0x2::dynamic_object_field::add<address, MemberRecord>(&mut arg0.id, v0, v5);
            arg0.member_count = arg0.member_count + 1;
            increment_level_count<T0>(arg0, arg2);
            arg0.total_contributed = arg0.total_contributed + (v3 as u128);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.receiver);
            let v6 = MemberJoined{
                pool_id         : v1,
                member          : v0,
                level           : arg2,
                payment_amount  : v3,
                cumulative_paid : v2,
                receiver        : arg0.receiver,
                timestamp_ms    : v4,
            };
            0x2::event::emit<MemberJoined>(v6);
        } else {
            let v7 = 0x2::dynamic_object_field::borrow_mut<address, MemberRecord>(&mut arg0.id, v0);
            assert!(arg2 > v7.level, 2);
            let v8 = v2 - v7.cumulative_paid;
            assert!(v3 == v8, 3);
            let v9 = v7.level;
            v7.level = arg2;
            v7.cumulative_paid = v2;
            v7.updated_at_ms = v4;
            v7.upgrade_count = v7.upgrade_count + 1;
            decrement_level_count<T0>(arg0, v9);
            increment_level_count<T0>(arg0, arg2);
            arg0.total_contributed = arg0.total_contributed + (v8 as u128);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.receiver);
            let v10 = MemberUpgraded{
                pool_id         : v1,
                member          : v0,
                from_level      : v9,
                to_level        : arg2,
                top_up_amount   : v8,
                cumulative_paid : v7.cumulative_paid,
                receiver        : arg0.receiver,
                timestamp_ms    : v4,
            };
            0x2::event::emit<MemberUpgraded>(v10);
        };
    }

    public fun quote_participation<T0>(arg0: &GenesisPool<T0>, arg1: address, arg2: u8) : (bool, u8, u8, u64, u64, u64, address) {
        if (!is_valid_level(arg2)) {
            return (false, 1, 0, 0, 0, 0, arg0.receiver)
        };
        let v0 = level_threshold_internal(arg2);
        if (arg1 == arg0.receiver) {
            return (false, 6, 0, 0, v0, 0, arg0.receiver)
        };
        if (arg0.paused) {
            let (v1, v2) = member_level_and_paid<T0>(arg0, arg1);
            return (false, 5, v1, v2, v0, 0, arg0.receiver)
        };
        if (!has_member<T0>(arg0, arg1)) {
            return (true, 0, 0, 0, v0, v0, arg0.receiver)
        };
        let v3 = 0x2::dynamic_object_field::borrow<address, MemberRecord>(&arg0.id, arg1);
        if (v3.level == 5) {
            return (false, 4, v3.level, v3.cumulative_paid, v0, 0, arg0.receiver)
        };
        if (arg2 == v3.level) {
            return (false, 2, v3.level, v3.cumulative_paid, v0, 0, arg0.receiver)
        };
        if (arg2 < v3.level) {
            return (false, 3, v3.level, v3.cumulative_paid, v0, 0, arg0.receiver)
        };
        (true, 0, v3.level, v3.cumulative_paid, v0, v0 - v3.cumulative_paid, arg0.receiver)
    }

    public fun set_paused<T0>(arg0: &mut GenesisPool<T0>, arg1: &AdminCap, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin_cap<T0>(arg0, arg1);
        arg0.paused = arg2;
        let v0 = PauseStatusUpdated{
            pool_id      : 0x2::object::id<GenesisPool<T0>>(arg0),
            paused       : arg2,
            updated_by   : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PauseStatusUpdated>(v0);
    }

    public fun update_receiver<T0>(arg0: &mut GenesisPool<T0>, arg1: &AdminCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin_cap<T0>(arg0, arg1);
        assert!(arg2 != @0x0, 5);
        assert!(!has_member<T0>(arg0, arg2), 9);
        arg0.receiver = arg2;
        let v0 = ReceiverUpdated{
            pool_id      : 0x2::object::id<GenesisPool<T0>>(arg0),
            old_receiver : arg0.receiver,
            new_receiver : arg2,
            updated_by   : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ReceiverUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

