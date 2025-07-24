module 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::loyalty {
    struct LoyaltyProgram has key {
        id: 0x2::object::UID,
        user_levels: 0x2::table::Table<address, u8>,
        levels: 0x2::table::Table<u8, LoyaltyLevel>,
    }

    struct LoyaltyLevel has copy, drop, store {
        fee_discount_rate: u64,
        member_count: u64,
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

    public fun add_loyalty_level(arg0: &mut LoyaltyProgram, arg1: &0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::admin::AdminCap, arg2: u8, arg3: u64, arg4: vector<vector<u8>>, arg5: vector<u8>, arg6: u16, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::multisig::check_if_sender_is_multisig_address(arg4, arg5, arg6, arg7), 7);
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

    public fun grant_user_level(arg0: &mut LoyaltyProgram, arg1: &0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::admin::AdminCap, arg2: address, arg3: u8, arg4: vector<vector<u8>>, arg5: vector<u8>, arg6: u16, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::multisig::check_if_sender_is_multisig_address(arg4, arg5, arg6, arg7), 7);
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
        0x2::transfer::share_object<LoyaltyProgram>(v0);
    }

    public fun remove_loyalty_level(arg0: &mut LoyaltyProgram, arg1: &0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::admin::AdminCap, arg2: u8, arg3: vector<vector<u8>>, arg4: vector<u8>, arg5: u16, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::multisig::check_if_sender_is_multisig_address(arg3, arg4, arg5, arg6), 7);
        assert!(0x2::table::contains<u8, LoyaltyLevel>(&arg0.levels, arg2), 1);
        assert!(0x2::table::borrow<u8, LoyaltyLevel>(&arg0.levels, arg2).member_count == 0, 3);
        0x2::table::remove<u8, LoyaltyLevel>(&mut arg0.levels, arg2);
        let v0 = LoyaltyLevelRemoved{
            loyalty_program_id : 0x2::object::uid_to_inner(&arg0.id),
            level              : arg2,
        };
        0x2::event::emit<LoyaltyLevelRemoved>(v0);
    }

    public fun revoke_user_level(arg0: &mut LoyaltyProgram, arg1: &0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::admin::AdminCap, arg2: address, arg3: vector<vector<u8>>, arg4: vector<u8>, arg5: u16, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::multisig::check_if_sender_is_multisig_address(arg3, arg4, arg5, arg6), 7);
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

    // decompiled from Move bytecode v6
}

