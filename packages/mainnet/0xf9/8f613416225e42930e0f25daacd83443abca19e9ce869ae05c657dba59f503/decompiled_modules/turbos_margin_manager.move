module 0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::turbos_margin_manager {
    struct TurbosMarginRegistry has store, key {
        id: 0x2::object::UID,
        margin_managers: 0x2::linked_table::LinkedTable<address, 0x2::vec_map::VecMap<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>>,
        deepbook_pool_referrals: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        margin_supply_referrals: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
    }

    struct TurbosAssetSupplied has copy, drop {
        margin_pool_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        supplier_cap_id: 0x2::object::ID,
        amount: u64,
        referral_id: 0x1::option::Option<0x2::object::ID>,
        timestamp: u64,
    }

    struct TurbosAssetWithdrawn has copy, drop {
        margin_pool_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        supplier_cap_id: 0x2::object::ID,
        amount: u64,
        timestamp: u64,
    }

    struct TurbosCollateralDeposited has copy, drop {
        margin_manager_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        amount: u64,
        timestamp: u64,
    }

    struct TurbosCollateralWithdrawn has copy, drop {
        margin_manager_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        amount: u64,
        timestamp: u64,
    }

    struct TurbosMarginManagerCreatedEvent has copy, drop {
        margin_manager_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
        deepbook_pool_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    struct TurbosMarginManagersListed has copy, drop {
        user: address,
        pool_id: 0x2::object::ID,
        managers: vector<0x2::object::ID>,
    }

    struct UserManagerItem has copy, drop, store {
        user: address,
        manager_id: 0x2::object::ID,
    }

    public fun deposit_collateral<T0, T1, T2>(arg0: &0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::global_config::GlobalConfig, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::global_config::check_package_version(arg0);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::deposit<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v0 = TurbosCollateralDeposited{
            margin_manager_id : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::id<T0, T1>(arg1),
            asset_type        : 0x1::type_name::with_defining_ids<T2>(),
            amount            : 0x2::coin::value<T2>(&arg5),
            timestamp         : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<TurbosCollateralDeposited>(v0);
    }

    public fun get_all_managers(arg0: &TurbosMarginRegistry) : 0x2::vec_map::VecMap<0x2::object::ID, vector<UserManagerItem>> {
        let v0 = 0x2::vec_map::empty<0x2::object::ID, vector<UserManagerItem>>();
        let v1 = 0x2::linked_table::front<address, 0x2::vec_map::VecMap<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>>(&arg0.margin_managers);
        while (0x1::option::is_some<address>(v1)) {
            let v2 = *0x1::option::borrow<address>(v1);
            let v3 = 0x2::linked_table::borrow<address, 0x2::vec_map::VecMap<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>>(&arg0.margin_managers, v2);
            let v4 = 0x2::vec_map::keys<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(v3);
            let v5 = 0;
            while (v5 < 0x1::vector::length<0x2::object::ID>(&v4)) {
                let v6 = *0x1::vector::borrow<0x2::object::ID>(&v4, v5);
                let v7 = 0x2::vec_set::keys<0x2::object::ID>(0x2::vec_map::get<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(v3, &v6));
                if (!0x2::vec_map::contains<0x2::object::ID, vector<UserManagerItem>>(&v0, &v6)) {
                    0x2::vec_map::insert<0x2::object::ID, vector<UserManagerItem>>(&mut v0, v6, 0x1::vector::empty<UserManagerItem>());
                };
                let v8 = 0x2::vec_map::get_mut<0x2::object::ID, vector<UserManagerItem>>(&mut v0, &v6);
                let v9 = 0;
                while (v9 < 0x1::vector::length<0x2::object::ID>(v7)) {
                    let v10 = UserManagerItem{
                        user       : v2,
                        manager_id : *0x1::vector::borrow<0x2::object::ID>(v7, v9),
                    };
                    0x1::vector::push_back<UserManagerItem>(v8, v10);
                    v9 = v9 + 1;
                };
                v5 = v5 + 1;
            };
            v1 = 0x2::linked_table::next<address, 0x2::vec_map::VecMap<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>>(&arg0.margin_managers, v2);
        };
        v0
    }

    public fun get_user_margin_managers(arg0: &TurbosMarginRegistry, arg1: address, arg2: 0x2::object::ID) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        if (0x2::linked_table::contains<address, 0x2::vec_map::VecMap<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>>(&arg0.margin_managers, arg1)) {
            let v1 = 0x2::linked_table::borrow<address, 0x2::vec_map::VecMap<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>>(&arg0.margin_managers, arg1);
            if (0x2::vec_map::contains<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(v1, &arg2)) {
                v0 = *0x2::vec_set::keys<0x2::object::ID>(0x2::vec_map::get<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(v1, &arg2));
            };
        };
        let v2 = TurbosMarginManagersListed{
            user     : arg1,
            pool_id  : arg2,
            managers : v0,
        };
        0x2::event::emit<TurbosMarginManagersListed>(v2);
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TurbosMarginRegistry{
            id                      : 0x2::object::new(arg0),
            margin_managers         : 0x2::linked_table::new<address, 0x2::vec_map::VecMap<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>>(arg0),
            deepbook_pool_referrals : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg0),
            margin_supply_referrals : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<TurbosMarginRegistry>(v0);
    }

    public fun margin_pool_supply<T0>(arg0: &TurbosMarginRegistry, arg1: &0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::global_config::GlobalConfig, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock) : u64 {
        0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::global_config::check_package_version(arg1);
        let v0 = 0x1::option::none<0x2::object::ID>();
        if (0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.margin_supply_referrals, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::id<T0>(arg2))) {
            v0 = 0x1::option::some<0x2::object::ID>(*0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.margin_supply_referrals, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::id<T0>(arg2)));
        };
        let v1 = TurbosAssetSupplied{
            margin_pool_id  : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>>(arg2),
            asset_type      : 0x1::type_name::with_defining_ids<T0>(),
            supplier_cap_id : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap>(arg4),
            amount          : 0x2::coin::value<T0>(&arg5),
            referral_id     : v0,
            timestamp       : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<TurbosAssetSupplied>(v1);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::supply<T0>(arg2, arg3, arg4, arg5, v0, arg6)
    }

    public fun margin_pool_withdraw<T0>(arg0: &0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::global_config::GlobalConfig, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap, arg4: 0x1::option::Option<u64>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::global_config::check_package_version(arg0);
        let v0 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::withdraw<T0>(arg1, arg2, arg3, arg4, arg5, arg6);
        let v1 = TurbosAssetWithdrawn{
            margin_pool_id  : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>>(arg1),
            asset_type      : 0x1::type_name::with_defining_ids<T0>(),
            supplier_cap_id : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap>(arg3),
            amount          : 0x2::coin::value<T0>(&v0),
            timestamp       : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<TurbosAssetWithdrawn>(v1);
        v0
    }

    public fun new_margin_manager<T0, T1>(arg0: &0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::global_config::GlobalConfig, arg1: &mut TurbosMarginRegistry, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::registry::Registry, arg4: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg5: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DeepBookPoolReferral, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new_margin_manager_with_initializer<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::share<T0, T1>(v0, v1);
    }

    public fun new_margin_manager_with_initializer<T0, T1>(arg0: &0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::global_config::GlobalConfig, arg1: &mut TurbosMarginRegistry, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::registry::Registry, arg4: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg5: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DeepBookPoolReferral, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::ManagerInitializer) {
        0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::global_config::check_package_version(arg0);
        let (v0, v1) = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::new_with_initializer<T0, T1>(arg2, arg3, arg4, arg6, arg7);
        let v2 = v0;
        let v3 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::id<T0, T1>(&v2);
        let v4 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::owner<T0, T1>(&v2);
        let v5 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::deepbook_pool<T0, T1>(&v2);
        if (!0x2::linked_table::contains<address, 0x2::vec_map::VecMap<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>>(&arg1.margin_managers, v4)) {
            let v6 = 0x2::vec_map::empty<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>();
            let v7 = 0x2::vec_set::empty<0x2::object::ID>();
            0x2::vec_set::insert<0x2::object::ID>(&mut v7, v3);
            0x2::vec_map::insert<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut v6, v5, v7);
            0x2::linked_table::push_back<address, 0x2::vec_map::VecMap<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>>(&mut arg1.margin_managers, v4, v6);
        } else {
            let v8 = 0x2::linked_table::borrow_mut<address, 0x2::vec_map::VecMap<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>>(&mut arg1.margin_managers, v4);
            if (!0x2::vec_map::contains<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(v8, &v5)) {
                let v9 = 0x2::vec_set::empty<0x2::object::ID>();
                0x2::vec_set::insert<0x2::object::ID>(&mut v9, v3);
                0x2::vec_map::insert<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(v8, v5, v9);
            } else {
                let v10 = 0x2::vec_map::get_mut<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(v8, &v5);
                assert!(0x2::vec_set::length<0x2::object::ID>(v10) < 1, 0);
                0x2::vec_set::insert<0x2::object::ID>(v10, v3);
            };
        };
        if (0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg1.deepbook_pool_referrals, v5)) {
            assert!(0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DeepBookPoolReferral>(arg5) == *0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg1.deepbook_pool_referrals, v5), 1);
            0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::set_margin_manager_referral<T0, T1>(&mut v2, arg5, arg7);
        };
        let v11 = TurbosMarginManagerCreatedEvent{
            margin_manager_id  : v3,
            balance_manager_id : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::id(0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::balance_manager<T0, T1>(&v2)),
            deepbook_pool_id   : v5,
            owner              : v4,
            timestamp          : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<TurbosMarginManagerCreatedEvent>(v11);
        (v2, v1)
    }

    public fun register_deepbook_pool_referral(arg0: &mut TurbosMarginRegistry, arg1: &0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::global_config::GlobalConfig, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::global_config::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg4));
        if (0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.deepbook_pool_referrals, arg2)) {
            *0x2::table::borrow_mut<0x2::object::ID, 0x2::object::ID>(&mut arg0.deepbook_pool_referrals, arg2) = arg3;
        } else {
            0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.deepbook_pool_referrals, arg2, arg3);
        };
    }

    public fun register_margin_supply_referral(arg0: &mut TurbosMarginRegistry, arg1: &0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::global_config::GlobalConfig, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::global_config::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg4));
        if (0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.margin_supply_referrals, arg2)) {
            *0x2::table::borrow_mut<0x2::object::ID, 0x2::object::ID>(&mut arg0.margin_supply_referrals, arg2) = arg3;
        } else {
            0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.margin_supply_referrals, arg2, arg3);
        };
    }

    public fun withdraw_collateral<T0, T1, T2>(arg0: &0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::global_config::GlobalConfig, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg4: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::global_config::check_package_version(arg0);
        let v0 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::withdraw<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v1 = TurbosCollateralWithdrawn{
            margin_manager_id : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::id<T0, T1>(arg1),
            asset_type        : 0x1::type_name::with_defining_ids<T2>(),
            amount            : 0x2::coin::value<T2>(&v0),
            timestamp         : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<TurbosCollateralWithdrawn>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

