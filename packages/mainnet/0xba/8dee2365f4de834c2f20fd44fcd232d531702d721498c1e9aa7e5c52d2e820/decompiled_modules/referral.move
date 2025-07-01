module 0xba8dee2365f4de834c2f20fd44fcd232d531702d721498c1e9aa7e5c52d2e820::referral {
    struct REFERRAL has drop {
        dummy_field: bool,
    }

    struct ReferralRegistry has key {
        id: 0x2::object::UID,
        app_name: 0x1::string::String,
        code_to_address: 0x2::table::Table<0x1::string::String, address>,
        user_profiles: 0x2::table::Table<address, UserProfile>,
        all_users: 0x2::table_vec::TableVec<address>,
        total_expired_rewards: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        last_expiration_time: u64,
        expiration_current_index: u64,
        expiration_in_progress: bool,
    }

    struct ReferralRegistryCap has store, key {
        id: 0x2::object::UID,
        app_name: 0x1::string::String,
        registry_id: 0x2::object::ID,
    }

    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct UserProfile has store, key {
        id: 0x2::object::UID,
        address: address,
        referral_code: 0x1::string::String,
        referred_by: 0x1::option::Option<address>,
        referrals: 0x2::table_vec::TableVec<address>,
        registered_at: u64,
        balance_amounts: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        total_rewards_earned: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        app_data: 0x2::table::Table<0x1::string::String, vector<u8>>,
    }

    struct UserRegistered has copy, drop {
        user: address,
        referral_code: 0x1::string::String,
        referred_by: 0x1::option::Option<address>,
        timestamp: u64,
    }

    struct ReferralRecorded has copy, drop {
        referrer: address,
        referred: address,
        timestamp: u64,
    }

    struct ReferralRewardDeposited has copy, drop {
        referrer: address,
        amount: u64,
        coin_type: 0x1::string::String,
        from_referral: address,
    }

    struct ReferralRewardWithdrawn has copy, drop {
        user: address,
        amount: u64,
        coin_type: 0x1::string::String,
    }

    struct ReferralRegistryIssued has copy, drop {
        app_name: 0x1::string::String,
        registry_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    struct RewardsExpired has copy, drop {
        total_users_processed: u64,
        timestamp: u64,
        coin_type: 0x1::string::String,
        total_amount: u64,
    }

    struct ExpiredRewardsWithdrawn has copy, drop {
        admin: address,
        amount: u64,
        coin_type: 0x1::string::String,
    }

    fun assert_admin(arg0: &0x2::package::Publisher) {
        assert!(0x2::package::from_module<REFERRAL>(arg0), 4);
    }

    public fun cancel_expiration_process(arg0: &mut ReferralRegistry, arg1: &0x2::package::Publisher) {
        assert_admin(arg1);
        arg0.expiration_in_progress = false;
        arg0.expiration_current_index = 0;
    }

    public fun code_to_address(arg0: &ReferralRegistry, arg1: 0x1::string::String) : 0x1::option::Option<address> {
        if (0x2::table::contains<0x1::string::String, address>(&arg0.code_to_address, arg1)) {
            0x1::option::some<address>(*0x2::table::borrow<0x1::string::String, address>(&arg0.code_to_address, arg1))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun deposit_referral_reward<T0>(arg0: &mut ReferralRegistry, arg1: address, arg2: 0x2::coin::Coin<T0>) {
        assert!(0x2::table::contains<address, UserProfile>(&arg0.user_profiles, arg1), 3);
        let v0 = 0x2::table::borrow<address, UserProfile>(&arg0.user_profiles, arg1);
        assert!(0x1::option::is_some<address>(&v0.referred_by), 5);
        let v1 = *0x1::option::borrow<address>(&v0.referred_by);
        let v2 = 0x2::coin::value<T0>(&arg2);
        let v3 = 0x1::type_name::get<T0>();
        let v4 = 0x2::table::borrow_mut<address, UserProfile>(&mut arg0.user_profiles, v1);
        let v5 = BalanceKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<BalanceKey<T0>>(&v4.id, v5)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut v4.id, v5), 0x2::coin::into_balance<T0>(arg2));
        } else {
            0x2::dynamic_field::add<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut v4.id, v5, 0x2::coin::into_balance<T0>(arg2));
        };
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v4.balance_amounts, &v3)) {
            let v6 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v4.balance_amounts, &v3);
            *v6 = *v6 + v2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v4.balance_amounts, v3, v2);
        };
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v4.total_rewards_earned, &v3)) {
            let v7 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut v4.total_rewards_earned, &v3);
            *v7 = *v7 + v2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v4.total_rewards_earned, v3, v2);
        };
        let v8 = ReferralRewardDeposited{
            referrer      : v1,
            amount        : v2,
            coin_type     : 0x1::string::from_ascii(0x1::type_name::into_string(v3)),
            from_referral : arg1,
        };
        0x2::event::emit<ReferralRewardDeposited>(v8);
    }

    public fun get_app_data(arg0: &ReferralRegistry, arg1: address, arg2: 0x1::string::String) : 0x1::option::Option<vector<u8>> {
        if (!0x2::table::contains<address, UserProfile>(&arg0.user_profiles, arg1)) {
            return 0x1::option::none<vector<u8>>()
        };
        let v0 = 0x2::table::borrow<address, UserProfile>(&arg0.user_profiles, arg1);
        if (0x2::table::contains<0x1::string::String, vector<u8>>(&v0.app_data, arg2)) {
            0x1::option::some<vector<u8>>(*0x2::table::borrow<0x1::string::String, vector<u8>>(&v0.app_data, arg2))
        } else {
            0x1::option::none<vector<u8>>()
        }
    }

    public fun get_balance_coin_types(arg0: &ReferralRegistry, arg1: address) : vector<0x1::type_name::TypeName> {
        if (!0x2::table::contains<address, UserProfile>(&arg0.user_profiles, arg1)) {
            return 0x1::vector::empty<0x1::type_name::TypeName>()
        };
        0x2::vec_map::keys<0x1::type_name::TypeName, u64>(&0x2::table::borrow<address, UserProfile>(&arg0.user_profiles, arg1).balance_amounts)
    }

    public fun get_expiration_progress(arg0: &ReferralRegistry) : (bool, u64, u64) {
        (arg0.expiration_in_progress, arg0.expiration_current_index, 0x2::table_vec::length<address>(&arg0.all_users))
    }

    public fun get_referral_code(arg0: &ReferralRegistry, arg1: address) : 0x1::string::String {
        assert!(0x2::table::contains<address, UserProfile>(&arg0.user_profiles, arg1), 3);
        0x2::table::borrow<address, UserProfile>(&arg0.user_profiles, arg1).referral_code
    }

    public fun get_referral_stats<T0>(arg0: &ReferralRegistry, arg1: address) : (u64, 0x1::option::Option<address>, u64) {
        assert!(0x2::table::contains<address, UserProfile>(&arg0.user_profiles, arg1), 3);
        let v0 = 0x2::table::borrow<address, UserProfile>(&arg0.user_profiles, arg1);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v0.total_rewards_earned, &v1)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&v0.total_rewards_earned, &v1)
        } else {
            0
        };
        (0x2::table_vec::length<address>(&v0.referrals), v0.referred_by, v2)
    }

    public fun get_referrals(arg0: &ReferralRegistry, arg1: address) : &0x2::table_vec::TableVec<address> {
        assert!(0x2::table::contains<address, UserProfile>(&arg0.user_profiles, arg1), 3);
        &0x2::table::borrow<address, UserProfile>(&arg0.user_profiles, arg1).referrals
    }

    public fun get_referrer(arg0: &ReferralRegistry, arg1: address) : 0x1::option::Option<address> {
        if (0x2::table::contains<address, UserProfile>(&arg0.user_profiles, arg1)) {
            0x2::table::borrow<address, UserProfile>(&arg0.user_profiles, arg1).referred_by
        } else {
            0x1::option::none<address>()
        }
    }

    public fun get_reward_balance<T0>(arg0: &ReferralRegistry, arg1: address) : u64 {
        if (!0x2::table::contains<address, UserProfile>(&arg0.user_profiles, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, UserProfile>(&arg0.user_profiles, arg1);
        let v1 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v0.balance_amounts, &v1)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&v0.balance_amounts, &v1)
        } else {
            0
        }
    }

    public fun get_total_expired_rewards<T0>(arg0: &ReferralRegistry) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.total_expired_rewards, &v0)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.total_expired_rewards, &v0)
        } else {
            0
        }
    }

    fun init(arg0: REFERRAL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<REFERRAL>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun is_registered(arg0: &ReferralRegistry, arg1: address) : bool {
        0x2::table::contains<address, UserProfile>(&arg0.user_profiles, arg1)
    }

    public fun issue_referral_registry(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0);
        let v0 = ReferralRegistry{
            id                       : 0x2::object::new(arg2),
            app_name                 : arg1,
            code_to_address          : 0x2::table::new<0x1::string::String, address>(arg2),
            user_profiles            : 0x2::table::new<address, UserProfile>(arg2),
            all_users                : 0x2::table_vec::empty<address>(arg2),
            total_expired_rewards    : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            last_expiration_time     : 0,
            expiration_current_index : 0,
            expiration_in_progress   : false,
        };
        let v1 = ReferralRegistryCap{
            id          : 0x2::object::new(arg2),
            app_name    : arg1,
            registry_id : 0x2::object::id<ReferralRegistry>(&v0),
        };
        let v2 = ReferralRegistryIssued{
            app_name    : arg1,
            registry_id : 0x2::object::id<ReferralRegistry>(&v0),
            cap_id      : 0x2::object::id<ReferralRegistryCap>(&v1),
        };
        0x2::event::emit<ReferralRegistryIssued>(v2);
        0x2::transfer::share_object<ReferralRegistry>(v0);
        0x2::transfer::transfer<ReferralRegistryCap>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun process_expiration_batch<T0>(arg0: &mut ReferralRegistry, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg1);
        assert!(arg0.expiration_in_progress, 12);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x2::table_vec::length<address>(&arg0.all_users);
        while (v2 < 100 && arg0.expiration_current_index < v3) {
            let v4 = *0x2::table_vec::borrow<address>(&arg0.all_users, arg0.expiration_current_index);
            if (0x2::table::contains<address, UserProfile>(&arg0.user_profiles, v4)) {
                let v5 = 0x2::table::borrow_mut<address, UserProfile>(&mut arg0.user_profiles, v4);
                let v6 = BalanceKey<T0>{dummy_field: false};
                if (0x2::dynamic_field::exists_<BalanceKey<T0>>(&v5.id, v6)) {
                    let v7 = 0x2::dynamic_field::remove<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut v5.id, v6);
                    if (0x2::dynamic_field::exists_<BalanceKey<T0>>(&arg0.id, v6)) {
                        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v6), v7);
                    } else {
                        0x2::dynamic_field::add<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v6, v7);
                    };
                    if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v5.balance_amounts, &v0)) {
                        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut v5.balance_amounts, &v0);
                    };
                    v1 = v1 + 0x2::balance::value<T0>(&v7);
                };
            };
            arg0.expiration_current_index = arg0.expiration_current_index + 1;
            v2 = v2 + 1;
        };
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.total_expired_rewards, &v0)) {
            let v10 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.total_expired_rewards, &v0);
            *v10 = *v10 + v1;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.total_expired_rewards, v0, v1);
        };
        if (arg0.expiration_current_index >= v3) {
            arg0.expiration_in_progress = false;
            arg0.expiration_current_index = 0;
            let v11 = RewardsExpired{
                total_users_processed : v3,
                timestamp             : arg0.last_expiration_time,
                coin_type             : 0x1::string::from_ascii(0x1::type_name::into_string(v0)),
                total_amount          : v1,
            };
            0x2::event::emit<RewardsExpired>(v11);
        };
    }

    public fun register(arg0: &mut ReferralRegistry, arg1: 0x1::string::String, arg2: 0x1::option::Option<0x1::string::String>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!0x2::table::contains<address, UserProfile>(&arg0.user_profiles, v0), 1);
        assert!(0x1::string::length(&arg1) >= 3, 7);
        assert!(0x1::string::length(&arg1) <= 20, 8);
        assert!(validate_referral_code(&arg1), 9);
        assert!(!0x2::table::contains<0x1::string::String, address>(&arg0.code_to_address, arg1), 10);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x1::option::none<address>();
        if (0x1::option::is_some<0x1::string::String>(&arg2)) {
            let v3 = *0x1::option::borrow<0x1::string::String>(&arg2);
            assert!(0x2::table::contains<0x1::string::String, address>(&arg0.code_to_address, v3), 2);
            let v4 = *0x2::table::borrow<0x1::string::String, address>(&arg0.code_to_address, v3);
            0x2::table_vec::push_back<address>(&mut 0x2::table::borrow_mut<address, UserProfile>(&mut arg0.user_profiles, v4).referrals, v0);
            v2 = 0x1::option::some<address>(v4);
            let v5 = ReferralRecorded{
                referrer  : v4,
                referred  : v0,
                timestamp : v1,
            };
            0x2::event::emit<ReferralRecorded>(v5);
        };
        let v6 = UserProfile{
            id                   : 0x2::object::new(arg4),
            address              : v0,
            referral_code        : arg1,
            referred_by          : v2,
            referrals            : 0x2::table_vec::empty<address>(arg4),
            registered_at        : v1,
            balance_amounts      : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            total_rewards_earned : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            app_data             : 0x2::table::new<0x1::string::String, vector<u8>>(arg4),
        };
        0x2::table::add<0x1::string::String, address>(&mut arg0.code_to_address, arg1, v0);
        0x2::table::add<address, UserProfile>(&mut arg0.user_profiles, v0, v6);
        0x2::table_vec::push_back<address>(&mut arg0.all_users, v0);
        let v7 = UserRegistered{
            user          : v0,
            referral_code : arg1,
            referred_by   : v2,
            timestamp     : v1,
        };
        0x2::event::emit<UserRegistered>(v7);
    }

    public fun register_with_reward<T0>(arg0: &mut ReferralRegistry, arg1: 0x1::string::String, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        register(arg0, arg1, arg2, arg4, arg5);
        let v1 = 0x2::table::borrow<address, UserProfile>(&arg0.user_profiles, v0);
        if (0x1::option::is_some<address>(&v1.referred_by)) {
            assert!(0x2::table::contains<address, UserProfile>(&arg0.user_profiles, *0x1::option::borrow<address>(&v1.referred_by)), 3);
            deposit_referral_reward<T0>(arg0, v0, arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0);
        };
    }

    public fun start_expiration_process(arg0: &mut ReferralRegistry, arg1: &0x2::package::Publisher, arg2: &0x2::clock::Clock) {
        assert_admin(arg1);
        assert!(!arg0.expiration_in_progress, 11);
        arg0.expiration_in_progress = true;
        arg0.expiration_current_index = 0;
        arg0.last_expiration_time = 0x2::clock::timestamp_ms(arg2);
    }

    public fun store_app_data(arg0: &mut ReferralRegistry, arg1: &ReferralRegistryCap, arg2: address, arg3: 0x1::string::String, arg4: vector<u8>) {
        assert!(arg1.registry_id == 0x2::object::id<ReferralRegistry>(arg0), 4);
        assert!(0x2::table::contains<address, UserProfile>(&arg0.user_profiles, arg2), 3);
        let v0 = 0x2::table::borrow_mut<address, UserProfile>(&mut arg0.user_profiles, arg2);
        if (0x2::table::contains<0x1::string::String, vector<u8>>(&v0.app_data, arg3)) {
            *0x2::table::borrow_mut<0x1::string::String, vector<u8>>(&mut v0.app_data, arg3) = arg4;
        } else {
            0x2::table::add<0x1::string::String, vector<u8>>(&mut v0.app_data, arg3, arg4);
        };
    }

    fun validate_referral_code(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        if (v1 < 3 || v1 > 20) {
            return false
        };
        let v2 = 0;
        while (v2 < v1) {
            let v3 = *0x1::vector::borrow<u8>(v0, v2);
            let v4 = if (v3 >= 48 && v3 <= 57) {
                true
            } else if (v3 >= 97 && v3 <= 122) {
                true
            } else {
                v3 == 95
            };
            if (!v4) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    public fun verify_referral(arg0: &ReferralRegistry, arg1: address, arg2: address) : bool {
        if (!0x2::table::contains<address, UserProfile>(&arg0.user_profiles, arg1) || !0x2::table::contains<address, UserProfile>(&arg0.user_profiles, arg2)) {
            return false
        };
        let v0 = 0x2::table::borrow<address, UserProfile>(&arg0.user_profiles, arg2);
        if (0x1::option::is_some<address>(&v0.referred_by)) {
            return *0x1::option::borrow<address>(&v0.referred_by) == arg1
        };
        false
    }

    public fun withdraw_expired_rewards<T0>(arg0: &mut ReferralRegistry, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg1);
        let v0 = BalanceKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<BalanceKey<T0>>(&arg0.id, v0), 6);
        let v1 = 0x2::dynamic_field::remove<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0);
        let v2 = ExpiredRewardsWithdrawn{
            admin     : 0x2::tx_context::sender(arg2),
            amount    : 0x2::balance::value<T0>(&v1),
            coin_type : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
        };
        0x2::event::emit<ExpiredRewardsWithdrawn>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun withdraw_rewards<T0>(arg0: &mut ReferralRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, UserProfile>(&arg0.user_profiles, v0), 3);
        let v1 = 0x2::table::borrow_mut<address, UserProfile>(&mut arg0.user_profiles, v0);
        let v2 = BalanceKey<T0>{dummy_field: false};
        let v3 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_field::exists_<BalanceKey<T0>>(&v1.id, v2), 6);
        let v4 = 0x2::dynamic_field::remove<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut v1.id, v2);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&v1.balance_amounts, &v3)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut v1.balance_amounts, &v3);
        };
        let v7 = ReferralRewardWithdrawn{
            user      : v0,
            amount    : 0x2::balance::value<T0>(&v4),
            coin_type : 0x1::string::from_ascii(0x1::type_name::into_string(v3)),
        };
        0x2::event::emit<ReferralRewardWithdrawn>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg1), v0);
    }

    // decompiled from Move bytecode v6
}

