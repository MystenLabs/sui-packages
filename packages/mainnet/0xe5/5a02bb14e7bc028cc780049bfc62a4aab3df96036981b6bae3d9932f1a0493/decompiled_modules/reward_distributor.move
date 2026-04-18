module 0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::reward_distributor {
    struct Logs has store, key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<address, bool>,
    }

    struct UserArchive has store, key {
        id: 0x2::object::UID,
        owner: address,
        nonce_type: 0x2::table::Table<u8, u128>,
        total_yield_claim: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        total_reward_claim: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        last_updated_name: u64,
    }

    struct NewUserEvent has copy, drop {
        archive_id: 0x2::object::ID,
        owner: address,
    }

    struct YieldClaimedEvent has copy, drop {
        pair_id: 0x2::object::ID,
        claimer: address,
        amount: u64,
        token_type: 0x1::string::String,
        nonce: u128,
    }

    struct RewardClaimedEvent has copy, drop {
        pair_id: 0x2::object::ID,
        claimer: address,
        amount: u64,
        token_type: 0x1::string::String,
        nonce: u128,
    }

    public fun update_validator(arg0: &0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::AdminCap, arg1: vector<u8>, arg2: &mut 0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::Config) {
        0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::update_validator(arg0, arg1, arg2);
    }

    public fun claim_yield<T0>(arg0: &0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::Config, arg1: &mut 0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::vault::StrategyVault, arg2: &mut UserArchive, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::assert_not_paused(arg0);
        0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = 0x2::bcs::new(arg5);
        let v3 = 0x2::bcs::peel_u8(&mut v2);
        let v4 = 0x2::bcs::peel_address(&mut v2);
        assert!(v3 == 1, 706);
        let v5 = 0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::vault::vault_pair_id(arg1);
        assert!(0x2::object::id_to_address(&v5) == 0x2::bcs::peel_address(&mut v2), 707);
        assert!(v0 == v4, 700);
        assert!(arg3 > 0 && 0x2::bcs::peel_u64(&mut v2) == arg3, 701);
        let v6 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        assert!(v6 == 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v2)), 702);
        assert!(v1 < 0x2::bcs::peel_u64(&mut v2), 703);
        let v7 = update_user_nonce(arg2, v3, 0x2::bcs::peel_u128(&mut v2));
        arg2.last_updated_name = v1;
        let v8 = YieldClaimedEvent{
            pair_id    : 0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::vault::vault_pair_id(arg1),
            claimer    : v0,
            amount     : arg3,
            token_type : v6,
            nonce      : v7,
        };
        0x2::event::emit<YieldClaimedEvent>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::vault::withdraw_yield<T0>(arg1, arg3), arg7), v4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Logs{
            id    : 0x2::object::new(arg0),
            users : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<Logs>(v0);
    }

    public fun register(arg0: &mut Logs, arg1: &mut 0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::Config, arg2: &mut 0x2::tx_context::TxContext) : UserArchive {
        0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::assert_not_paused(arg1);
        0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::assert_version(arg1);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, bool>(&arg0.users, v0), 705);
        let v1 = UserArchive{
            id                 : 0x2::object::new(arg2),
            owner              : 0x2::tx_context::sender(arg2),
            nonce_type         : 0x2::table::new<u8, u128>(arg2),
            total_yield_claim  : 0x2::table::new<0x1::type_name::TypeName, u64>(arg2),
            total_reward_claim : 0x2::table::new<0x1::type_name::TypeName, u64>(arg2),
            last_updated_name  : 0,
        };
        0x2::table::add<address, bool>(&mut arg0.users, v0, true);
        let v2 = NewUserEvent{
            archive_id : 0x2::object::id<UserArchive>(&v1),
            owner      : v0,
        };
        0x2::event::emit<NewUserEvent>(v2);
        v1
    }

    fun update_user_nonce(arg0: &mut UserArchive, arg1: u8, arg2: u128) : u128 {
        let v0 = if (!0x2::table::contains<u8, u128>(&arg0.nonce_type, arg1)) {
            0
        } else {
            0x2::table::remove<u8, u128>(&mut arg0.nonce_type, arg1)
        };
        assert!(v0 < arg2, 704);
        0x2::table::add<u8, u128>(&mut arg0.nonce_type, arg1, arg2);
        arg2
    }

    // decompiled from Move bytecode v6
}

