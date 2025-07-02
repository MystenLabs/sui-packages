module 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::manager {
    struct GuardManager<phantom T0> has key {
        id: 0x2::object::UID,
        actions: 0x2::table::Table<address, 0x2::vec_map::VecMap<0x1::type_name::TypeName, Args>>,
        version: u64,
    }

    struct Args has drop, store {
        args_byte_sets: 0x1::option::Option<0x2::vec_set::VecSet<vector<u8>>>,
    }

    struct ActionAuthorized has copy, drop {
        strategist: address,
        action: 0x1::ascii::String,
    }

    struct ActionGranted has copy, drop {
        strategist: address,
        action: 0x1::ascii::String,
    }

    struct ActionRemoved has copy, drop {
        strategist: address,
        action: 0x1::ascii::String,
    }

    struct StrategistRemoved has copy, drop {
        strategist: address,
    }

    struct AssetsWithdrawn has copy, drop {
        strategist: address,
        amount: u64,
    }

    struct AssetsReturned has copy, drop {
        strategist: address,
        amount: u64,
    }

    struct VersionUpdated has copy, drop {
        version: u64,
    }

    fun are_sanitized(arg0: &vector<u8>, arg1: &0x2::vec_set::VecSet<vector<u8>>) : bool {
        0x2::vec_set::contains<vector<u8>>(arg1, arg0)
    }

    public fun authorize_and_withdraw_if_needed<T0, T1: drop, T2>(arg0: &mut 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::boring_vault::Vault<T2>, arg1: &GuardManager<T2>, arg2: T1, arg3: u64, arg4: &0x1::option::Option<vector<u8>>, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        assert!(arg1.version == 0, 6);
        validate_strategist_and_action<T1, T2>(arg1, 0x2::tx_context::sender(arg5));
        let v0 = 0x1::type_name::get<T1>();
        validate_args_sanitization(arg4, 0x2::vec_map::get<0x1::type_name::TypeName, Args>(get_actions<T2>(arg1, 0x2::tx_context::sender(arg5)), &v0));
        let v1 = ActionAuthorized{
            strategist : 0x2::tx_context::sender(arg5),
            action     : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
        };
        0x2::event::emit<ActionAuthorized>(v1);
        if (arg3 > 0) {
            let v2 = AssetsWithdrawn{
                strategist : 0x2::tx_context::sender(arg5),
                amount     : arg3,
            };
            0x2::event::emit<AssetsWithdrawn>(v2);
            return 0x1::option::some<0x2::coin::Coin<T0>>(pull_assets<T0, T2>(arg0, arg3, arg5))
        };
        0x1::option::none<0x2::coin::Coin<T0>>()
    }

    fun create_new_action_args(arg0: &mut 0x2::vec_map::VecMap<0x1::type_name::TypeName, Args>, arg1: 0x1::type_name::TypeName, arg2: vector<u8>) {
        let v0 = 0x2::vec_set::empty<vector<u8>>();
        if (!0x1::vector::is_empty<u8>(&arg2)) {
            0x2::vec_set::insert<vector<u8>>(&mut v0, arg2);
        };
        let v1 = Args{args_byte_sets: 0x1::option::some<0x2::vec_set::VecSet<vector<u8>>>(v0)};
        0x2::vec_map::insert<0x1::type_name::TypeName, Args>(arg0, arg1, v1);
    }

    fun get_actions<T0>(arg0: &GuardManager<T0>, arg1: address) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, Args> {
        0x2::table::borrow<address, 0x2::vec_map::VecMap<0x1::type_name::TypeName, Args>>(&arg0.actions, arg1)
    }

    fun get_actions_mut<T0>(arg0: &mut GuardManager<T0>, arg1: address) : &mut 0x2::vec_map::VecMap<0x1::type_name::TypeName, Args> {
        0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<0x1::type_name::TypeName, Args>>(&mut arg0.actions, arg1)
    }

    fun get_or_create_strategist_actions<T0>(arg0: &mut GuardManager<T0>, arg1: address) : &mut 0x2::vec_map::VecMap<0x1::type_name::TypeName, Args> {
        if (!0x2::table::contains<address, 0x2::vec_map::VecMap<0x1::type_name::TypeName, Args>>(&arg0.actions, arg1)) {
            0x2::table::add<address, 0x2::vec_map::VecMap<0x1::type_name::TypeName, Args>>(&mut arg0.actions, arg1, 0x2::vec_map::empty<0x1::type_name::TypeName, Args>());
        };
        get_actions_mut<T0>(arg0, arg1)
    }

    public fun grant_action<T0, T1>(arg0: &0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::Auth<T0>, arg1: &mut GuardManager<T0>, arg2: address, arg3: &mut 0x1::option::Option<vector<u8>>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0, 6);
        assert!(0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::has_cap<T0, 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::OwnerCap>(arg0, 0x2::tx_context::sender(arg4)), 0);
        let v0 = 0x1::type_name::get<T1>();
        let v1 = get_or_create_strategist_actions<T0>(arg1, arg2);
        let v2 = if (0x1::option::is_some<vector<u8>>(arg3)) {
            0x1::option::extract<vector<u8>>(arg3)
        } else {
            0x1::vector::empty<u8>()
        };
        if (0x2::vec_map::contains<0x1::type_name::TypeName, Args>(v1, &v0)) {
            let v3 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, Args>(v1, &v0);
            update_existing_action_args(v3, v2);
        } else {
            create_new_action_args(v1, v0, v2);
        };
        let v4 = ActionGranted{
            strategist : arg2,
            action     : 0x1::type_name::into_string(v0),
        };
        0x2::event::emit<ActionGranted>(v4);
    }

    entry fun migrate_guard_manager<T0>(arg0: &mut GuardManager<T0>) {
        arg0.version = 0;
        let v0 = VersionUpdated{version: 0};
        0x2::event::emit<VersionUpdated>(v0);
    }

    public(friend) fun new_manager<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GuardManager<T0>{
            id      : 0x2::object::new(arg0),
            actions : 0x2::table::new<address, 0x2::vec_map::VecMap<0x1::type_name::TypeName, Args>>(arg0),
            version : 0,
        };
        0x2::transfer::share_object<GuardManager<T0>>(v0);
    }

    fun pull_assets<T0, T1>(arg0: &mut 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::boring_vault::Vault<T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 <= 0x2::balance::value<T0>(0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::boring_vault::get_balance<T0, T1>(arg0)), 1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::boring_vault::get_balance_mut<T0, T1>(arg0), arg1), arg2)
    }

    public fun remove_action<T0, T1>(arg0: &0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::Auth<T0>, arg1: &mut GuardManager<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0, 6);
        assert!(0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::has_cap<T0, 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::auth::OwnerCap>(arg0, 0x2::tx_context::sender(arg3)), 0);
        assert!(0x2::table::contains<address, 0x2::vec_map::VecMap<0x1::type_name::TypeName, Args>>(&arg1.actions, arg2), 2);
        let v0 = 0x1::type_name::get<T1>();
        let v1 = get_actions_mut<T0>(arg1, arg2);
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, Args>(v1, &v0), 3);
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, Args>(v1, &v0);
        let v4 = ActionRemoved{
            strategist : arg2,
            action     : 0x1::type_name::into_string(v0),
        };
        0x2::event::emit<ActionRemoved>(v4);
        if (0x2::vec_map::is_empty<0x1::type_name::TypeName, Args>(v1)) {
            0x2::table::remove<address, 0x2::vec_map::VecMap<0x1::type_name::TypeName, Args>>(&mut arg1.actions, arg2);
            let v5 = StrategistRemoved{strategist: arg2};
            0x2::event::emit<StrategistRemoved>(v5);
        };
    }

    public fun return_asset<T0, T1>(arg0: &mut 0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::boring_vault::Vault<T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        0x2::balance::join<T0>(0xcc70b29c45c2f22bb7bd8c9a3b5c8819c793e3076f2353b3412a412b5cde89cc::boring_vault::get_balance_mut<T0, T1>(arg0), v0);
        let v1 = AssetsReturned{
            strategist : 0x2::tx_context::sender(arg2),
            amount     : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<AssetsReturned>(v1);
    }

    fun update_existing_action_args(arg0: &mut Args, arg1: vector<u8>) {
        let v0 = if (0x1::option::is_some<0x2::vec_set::VecSet<vector<u8>>>(&arg0.args_byte_sets)) {
            0x1::option::borrow_mut<0x2::vec_set::VecSet<vector<u8>>>(&mut arg0.args_byte_sets)
        } else {
            arg0.args_byte_sets = 0x1::option::some<0x2::vec_set::VecSet<vector<u8>>>(0x2::vec_set::empty<vector<u8>>());
            0x1::option::borrow_mut<0x2::vec_set::VecSet<vector<u8>>>(&mut arg0.args_byte_sets)
        };
        if (!0x1::vector::is_empty<u8>(&arg1)) {
            0x2::vec_set::insert<vector<u8>>(v0, arg1);
        };
    }

    fun validate_args_sanitization(arg0: &0x1::option::Option<vector<u8>>, arg1: &Args) {
        if (0x1::option::is_some<vector<u8>>(arg0)) {
            assert!(0x1::option::is_some<0x2::vec_set::VecSet<vector<u8>>>(&arg1.args_byte_sets), 4);
            assert!(are_sanitized(0x1::option::borrow<vector<u8>>(arg0), 0x1::option::borrow<0x2::vec_set::VecSet<vector<u8>>>(&arg1.args_byte_sets)), 4);
        } else {
            assert!(0x2::vec_set::is_empty<vector<u8>>(0x1::option::borrow<0x2::vec_set::VecSet<vector<u8>>>(&arg1.args_byte_sets)), 5);
        };
    }

    fun validate_strategist_and_action<T0, T1>(arg0: &GuardManager<T1>, arg1: address) {
        assert!(0x2::table::contains<address, 0x2::vec_map::VecMap<0x1::type_name::TypeName, Args>>(&arg0.actions, arg1), 2);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, Args>(get_actions<T1>(arg0, arg1), &v0), 3);
    }

    // decompiled from Move bytecode v6
}

