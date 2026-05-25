module 0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::scripts {
    struct PoolStatsQueryEvent has copy, drop {
        pool_id: 0x2::object::ID,
        total_supply: u64,
        total_borrow: u64,
        true_interest_rate: u64,
        timestamp: u64,
    }

    struct UserSupplyQueryEvent has copy, drop {
        supplier_cap_id: 0x2::object::ID,
        user_supply_amount: u64,
        timestamp: u64,
    }

    struct ManagerStateQueryEvent has copy, drop {
        manager_id: 0x2::object::ID,
        deepbook_pool_id: 0x2::object::ID,
        risk_ratio: u64,
        base_asset: u64,
        quote_asset: u64,
        base_debt: u64,
        quote_debt: u64,
        base_pyth_price: u64,
        base_pyth_decimals: u8,
        quote_pyth_price: u64,
        quote_pyth_decimals: u8,
        current_price: u64,
        lowest_trigger_above_price: u64,
        highest_trigger_below_price: u64,
        timestamp: u64,
    }

    struct UserCollateralTVLQueryEvent has copy, drop {
        pool_managers: 0x2::vec_map::VecMap<0x2::object::ID, vector<0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::turbos_margin_manager::UserManagerItem>>,
        timestamp: u64,
    }

    struct UserSupplyTVLQueryEvent has copy, drop {
        margin_pool_id: 0x2::object::ID,
        referral_id: 0x2::object::ID,
        total_supply_amount: u64,
        timestamp: u64,
    }

    public fun query_all_managers(arg0: &0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::turbos_margin_manager::TurbosMarginRegistry, arg1: &0x2::clock::Clock) {
        let v0 = UserCollateralTVLQueryEvent{
            pool_managers : 0xf98f613416225e42930e0f25daacd83443abca19e9ce869ae05c657dba59f503::turbos_margin_manager::get_all_managers(arg0),
            timestamp     : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<UserCollateralTVLQueryEvent>(v0);
    }

    public fun query_manager_state<T0, T1>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg1: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg6: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg7: &0x2::clock::Clock) {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13) = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::manager_state<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v14 = ManagerStateQueryEvent{
            manager_id                  : v0,
            deepbook_pool_id            : v1,
            risk_ratio                  : v2,
            base_asset                  : v3,
            quote_asset                 : v4,
            base_debt                   : v5,
            quote_debt                  : v6,
            base_pyth_price             : v7,
            base_pyth_decimals          : v8,
            quote_pyth_price            : v9,
            quote_pyth_decimals         : v10,
            current_price               : v11,
            lowest_trigger_above_price  : v12,
            highest_trigger_below_price : v13,
            timestamp                   : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<ManagerStateQueryEvent>(v14);
    }

    public fun query_pool_stats<T0>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg1: &0x2::clock::Clock) {
        let v0 = PoolStatsQueryEvent{
            pool_id            : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::id<T0>(arg0),
            total_supply       : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::total_supply_with_interest<T0>(arg0, arg1),
            total_borrow       : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::total_borrow<T0>(arg0),
            true_interest_rate : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::true_interest_rate<T0>(arg0),
            timestamp          : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<PoolStatsQueryEvent>(v0);
    }

    public fun query_referral_supply_tvl<T0>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let v0 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::protocol_fees<T0>(arg0);
        let (v1, _) = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::protocol_fees::referral_tracker(v0, arg1);
        let v3 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::protocol_fees::total_shares(v0);
        let v4 = if (v3 == 0) {
            0
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v1, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::div(0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::total_supply_with_interest<T0>(arg0, arg2), v3))
        };
        let v5 = UserSupplyTVLQueryEvent{
            margin_pool_id      : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::id<T0>(arg0),
            referral_id         : arg1,
            total_supply_amount : v4,
            timestamp           : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<UserSupplyTVLQueryEvent>(v5);
    }

    public fun query_user_supplies<T0>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg1: vector<0x2::object::ID>, arg2: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            let v1 = *0x1::vector::borrow<0x2::object::ID>(&arg1, v0);
            let v2 = UserSupplyQueryEvent{
                supplier_cap_id    : v1,
                user_supply_amount : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::user_supply_amount<T0>(arg0, v1, arg2),
                timestamp          : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<UserSupplyQueryEvent>(v2);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

