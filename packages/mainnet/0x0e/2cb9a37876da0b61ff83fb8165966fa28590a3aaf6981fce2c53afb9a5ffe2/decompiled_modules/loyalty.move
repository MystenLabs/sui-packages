module 0xe2cb9a37876da0b61ff83fb8165966fa28590a3aaf6981fce2c53afb9a5ffe2::loyalty {
    struct LoyaltyProgram has key {
        id: 0x2::object::UID,
        user_levels: 0x2::table::Table<address, u8>,
        levels: 0x2::table::Table<u8, LoyaltyLevel>,
    }

    struct LoyaltyLevel has copy, drop, store {
        fee_discount_rate: u64,
        member_count: u64,
    }

    struct LoyaltyAdminCap has key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct UserLevelGranted has copy, drop {
        loyalty_program_id: 0x2::object::ID,
        user: address,
        level: u8,
    }

    struct UserLevelRevoked has copy, drop {
        loyalty_program_id: 0x2::object::ID,
        user: address,
        level: u8,
    }

    struct LoyaltyLevelAdded has copy, drop {
        loyalty_program_id: 0x2::object::ID,
        level: u8,
        fee_discount_rate: u64,
    }

    struct LoyaltyLevelRemoved has copy, drop {
        loyalty_program_id: 0x2::object::ID,
        level: u8,
    }

    struct LoyaltyAdminCapOwnerUpdated has copy, drop {
        loyalty_admin_cap_id: 0x2::object::ID,
        old_owner: address,
        new_owner: address,
    }

    struct MultipleUsersLevelGranted has copy, drop {
        loyalty_program_id: 0x2::object::ID,
        users: vector<address>,
        level: u8,
        count: u64,
    }

    struct UserLevelRevocation has copy, drop {
        user: address,
        revoked_level: u8,
    }

    struct MultipleUsersLevelRevoked has copy, drop {
        loyalty_program_id: 0x2::object::ID,
        revocations: vector<UserLevelRevocation>,
        count: u64,
    }

    public fun add_loyalty_level(arg0: &mut LoyaltyProgram, arg1: &LoyaltyAdminCap, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        validate_loyalty_admin_cap(arg1, arg4);
        assert!(arg3 > 0 && arg3 <= 1000000000, 6);
        assert!(!0x2::table::contains<u8, LoyaltyLevel>(&arg0.levels, arg2), 2);
        let v0 = LoyaltyLevel{
            fee_discount_rate : arg3,
            member_count      : 0,
        };
        0x2::table::add<u8, LoyaltyLevel>(&mut arg0.levels, arg2, v0);
        let v1 = LoyaltyLevelAdded{
            loyalty_program_id : 0x2::object::uid_to_inner(&arg0.id),
            level              : arg2,
            fee_discount_rate  : arg3,
        };
        0x2::event::emit<LoyaltyLevelAdded>(v1);
    }

    public fun get_level_member_count(arg0: &LoyaltyProgram, arg1: u8) : u64 {
        if (0x2::table::contains<u8, LoyaltyLevel>(&arg0.levels, arg1)) {
            0x2::table::borrow<u8, LoyaltyLevel>(&arg0.levels, arg1).member_count
        } else {
            0
        }
    }

    public fun get_loyalty_level_fee_discount_rate(arg0: &LoyaltyProgram, arg1: u8) : 0x1::option::Option<u64> {
        if (0x2::table::contains<u8, LoyaltyLevel>(&arg0.levels, arg1)) {
            0x1::option::some<u64>(0x2::table::borrow<u8, LoyaltyLevel>(&arg0.levels, arg1).fee_discount_rate)
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun get_user_discount_rate(arg0: &LoyaltyProgram, arg1: address) : u64 {
        let v0 = get_user_loyalty_level(arg0, arg1);
        if (0x1::option::is_none<u8>(&v0)) {
            return 0
        };
        let v1 = get_loyalty_level_fee_discount_rate(arg0, 0x1::option::extract<u8>(&mut v0));
        if (0x1::option::is_none<u64>(&v1)) {
            return 0
        };
        0x1::option::extract<u64>(&mut v1)
    }

    public fun get_user_loyalty_level(arg0: &LoyaltyProgram, arg1: address) : 0x1::option::Option<u8> {
        if (0x2::table::contains<address, u8>(&arg0.user_levels, arg1)) {
            0x1::option::some<u8>(*0x2::table::borrow<address, u8>(&arg0.user_levels, arg1))
        } else {
            0x1::option::none<u8>()
        }
    }

    public fun grant_multiple_users_level(arg0: &mut LoyaltyProgram, arg1: &LoyaltyAdminCap, arg2: vector<address>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        validate_loyalty_admin_cap(arg1, arg4);
        assert!(0x2::table::contains<u8, LoyaltyLevel>(&arg0.levels, arg3), 1);
        let v0 = 0x1::vector::length<address>(&arg2);
        0x1::vector::reverse<address>(&mut arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg2)) {
            let v2 = 0x1::vector::pop_back<address>(&mut arg2);
            assert!(!0x2::table::contains<address, u8>(&arg0.user_levels, v2), 4);
            0x2::table::add<address, u8>(&mut arg0.user_levels, v2, arg3);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<address>(arg2);
        let v3 = 0x2::table::borrow_mut<u8, LoyaltyLevel>(&mut arg0.levels, arg3);
        v3.member_count = v3.member_count + v0;
        let v4 = MultipleUsersLevelGranted{
            loyalty_program_id : 0x2::object::uid_to_inner(&arg0.id),
            users              : arg2,
            level              : arg3,
            count              : v0,
        };
        0x2::event::emit<MultipleUsersLevelGranted>(v4);
    }

    public fun grant_user_level(arg0: &mut LoyaltyProgram, arg1: &LoyaltyAdminCap, arg2: address, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        validate_loyalty_admin_cap(arg1, arg4);
        assert!(0x2::table::contains<u8, LoyaltyLevel>(&arg0.levels, arg3), 1);
        assert!(!0x2::table::contains<address, u8>(&arg0.user_levels, arg2), 4);
        0x2::table::add<address, u8>(&mut arg0.user_levels, arg2, arg3);
        let v0 = 0x2::table::borrow_mut<u8, LoyaltyLevel>(&mut arg0.levels, arg3);
        v0.member_count = v0.member_count + 1;
        let v1 = UserLevelGranted{
            loyalty_program_id : 0x2::object::uid_to_inner(&arg0.id),
            user               : arg2,
            level              : arg3,
        };
        0x2::event::emit<UserLevelGranted>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LoyaltyProgram{
            id          : 0x2::object::new(arg0),
            user_levels : 0x2::table::new<address, u8>(arg0),
            levels      : 0x2::table::new<u8, LoyaltyLevel>(arg0),
        };
        let v1 = LoyaltyAdminCap{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<LoyaltyAdminCap>(v1);
        0x2::transfer::share_object<LoyaltyProgram>(v0);
    }

    public fun remove_loyalty_level(arg0: &mut LoyaltyProgram, arg1: &LoyaltyAdminCap, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        validate_loyalty_admin_cap(arg1, arg3);
        assert!(0x2::table::contains<u8, LoyaltyLevel>(&arg0.levels, arg2), 1);
        assert!(0x2::table::borrow<u8, LoyaltyLevel>(&arg0.levels, arg2).member_count == 0, 3);
        0x2::table::remove<u8, LoyaltyLevel>(&mut arg0.levels, arg2);
        let v0 = LoyaltyLevelRemoved{
            loyalty_program_id : 0x2::object::uid_to_inner(&arg0.id),
            level              : arg2,
        };
        0x2::event::emit<LoyaltyLevelRemoved>(v0);
    }

    public fun revoke_multiple_users_level(arg0: &mut LoyaltyProgram, arg1: &LoyaltyAdminCap, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        validate_loyalty_admin_cap(arg1, arg3);
        let v0 = 0x1::vector::empty<UserLevelRevocation>();
        0x1::vector::reverse<address>(&mut arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg2)) {
            let v2 = 0x1::vector::pop_back<address>(&mut arg2);
            let v3 = &mut v0;
            assert!(0x2::table::contains<address, u8>(&arg0.user_levels, v2), 5);
            let v4 = *0x2::table::borrow<address, u8>(&arg0.user_levels, v2);
            assert!(0x2::table::contains<u8, LoyaltyLevel>(&arg0.levels, v4), 1);
            0x2::table::remove<address, u8>(&mut arg0.user_levels, v2);
            let v5 = 0x2::table::borrow_mut<u8, LoyaltyLevel>(&mut arg0.levels, v4);
            v5.member_count = v5.member_count - 1;
            let v6 = UserLevelRevocation{
                user          : v2,
                revoked_level : v4,
            };
            0x1::vector::push_back<UserLevelRevocation>(v3, v6);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<address>(arg2);
        let v7 = MultipleUsersLevelRevoked{
            loyalty_program_id : 0x2::object::uid_to_inner(&arg0.id),
            revocations        : v0,
            count              : 0x1::vector::length<address>(&arg2),
        };
        0x2::event::emit<MultipleUsersLevelRevoked>(v7);
    }

    public fun revoke_user_level(arg0: &mut LoyaltyProgram, arg1: &LoyaltyAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        validate_loyalty_admin_cap(arg1, arg3);
        assert!(0x2::table::contains<address, u8>(&arg0.user_levels, arg2), 5);
        let v0 = *0x2::table::borrow<address, u8>(&arg0.user_levels, arg2);
        assert!(0x2::table::contains<u8, LoyaltyLevel>(&arg0.levels, v0), 1);
        0x2::table::remove<address, u8>(&mut arg0.user_levels, arg2);
        let v1 = 0x2::table::borrow_mut<u8, LoyaltyLevel>(&mut arg0.levels, v0);
        v1.member_count = v1.member_count - 1;
        let v2 = UserLevelRevoked{
            loyalty_program_id : 0x2::object::uid_to_inner(&arg0.id),
            user               : arg2,
            level              : v0,
        };
        0x2::event::emit<UserLevelRevoked>(v2);
    }

    public fun total_loyalty_program_members(arg0: &LoyaltyProgram) : u64 {
        0x2::table::length<address, u8>(&arg0.user_levels)
    }

    public fun update_loyalty_admin_cap_owner(arg0: &mut LoyaltyAdminCap, arg1: &0xe2cb9a37876da0b61ff83fb8165966fa28590a3aaf6981fce2c53afb9a5ffe2::admin::AdminCap, arg2: address, arg3: vector<vector<u8>>, arg4: vector<u8>, arg5: u16, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x8438f6d7b1efa6eb1fb7aa2cfa82667de6eaa8c6c1934a11e25b7aa0392417ab::multisig::check_if_sender_is_multisig_address(arg3, arg4, arg5, arg6), 7);
        arg0.owner = arg2;
        let v0 = LoyaltyAdminCapOwnerUpdated{
            loyalty_admin_cap_id : 0x2::object::uid_to_inner(&arg0.id),
            old_owner            : arg0.owner,
            new_owner            : arg2,
        };
        0x2::event::emit<LoyaltyAdminCapOwnerUpdated>(v0);
    }

    fun validate_loyalty_admin_cap(arg0: &LoyaltyAdminCap, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 8);
    }

    // decompiled from Move bytecode v6
}

