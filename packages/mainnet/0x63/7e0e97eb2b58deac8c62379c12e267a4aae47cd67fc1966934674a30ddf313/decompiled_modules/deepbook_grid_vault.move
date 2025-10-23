module 0xbef3f732902523778e5a1577498d9fa506509977e8a1e943b3676409cfa39d0b::deepbook_grid_vault {
    struct GridVault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        balance_manager: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager,
        trade_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap,
        deposit_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap,
        withdraw_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap,
        allowed_pool_id: 0x2::object::ID,
        total_shares: u64,
        user_shares: 0x2::table::Table<address, u64>,
        user_cost_basis: 0x2::table::Table<address, u64>,
        strategy_params: 0x2::table::Table<0x1::string::String, u64>,
        active_order_ids: 0x2::vec_set::VecSet<u128>,
        bot_address: address,
        admin_address: address,
        is_paused: bool,
        total_volume_traded: u64,
        total_fees_collected_base: u64,
        total_fees_collected_quote: u64,
        orders_filled_count: u64,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        admin: address,
        bot: address,
    }

    struct UserDeposit has copy, drop {
        vault_id: 0x2::object::ID,
        user: address,
        base_amount: u64,
        quote_amount: u64,
        shares_minted: u64,
        total_shares: u64,
    }

    struct UserWithdraw has copy, drop {
        vault_id: 0x2::object::ID,
        user: address,
        base_amount: u64,
        quote_amount: u64,
        shares_burned: u64,
        total_shares: u64,
    }

    struct GridOrderPlaced has copy, drop {
        vault_id: 0x2::object::ID,
        order_id: u128,
        price: u64,
        quantity: u64,
        is_bid: bool,
        timestamp: u64,
    }

    struct GridOrderFilled has copy, drop {
        vault_id: 0x2::object::ID,
        order_id: u128,
        filled_base: u64,
        filled_quote: u64,
        timestamp: u64,
    }

    struct GridRebalanced has copy, drop {
        vault_id: 0x2::object::ID,
        orders_canceled: u64,
        orders_placed: u64,
        timestamp: u64,
    }

    struct StrategyParamsUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        param_key: 0x1::string::String,
        param_value: u64,
    }

    public entry fun admin_cancel_all_orders<T0, T1>(arg0: &mut GridVault<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin_address, 0);
        assert!(0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1) == arg0.allowed_pool_id, 2);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg3);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg1, &mut arg0.balance_manager, &v0, arg2, arg3);
        arg0.active_order_ids = 0x2::vec_set::empty<u128>();
    }

    public fun bot_cancel_all_orders<T0, T1>(arg0: &mut GridVault<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.bot_address, 0);
        assert!(0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1) == arg0.allowed_pool_id, 2);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg3);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg1, &mut arg0.balance_manager, &v0, arg2, arg3);
        arg0.active_order_ids = 0x2::vec_set::empty<u128>();
    }

    public fun bot_cancel_order<T0, T1>(arg0: &mut GridVault<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.bot_address, 0);
        assert!(0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1) == arg0.allowed_pool_id, 2);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg1, &mut arg0.balance_manager, &v0, arg2, arg3, arg4);
        0x2::vec_set::remove<u128>(&mut arg0.active_order_ids, &arg2);
    }

    public fun bot_place_limit_order<T0, T1>(arg0: &mut GridVault<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : u128 {
        assert!(0x2::tx_context::sender(arg7) == arg0.bot_address, 0);
        assert!(!arg0.is_paused, 1);
        assert!(0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1) == arg0.allowed_pool_id, 2);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg7);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg1, &mut arg0.balance_manager, &v0, arg2, 0, 0, arg3, arg4, arg5, false, 18446744073709551615, arg6, arg7);
        let v1 = (arg2 as u128);
        0x2::vec_set::insert<u128>(&mut arg0.active_order_ids, v1);
        let v2 = GridOrderPlaced{
            vault_id  : 0x2::object::id<GridVault<T0, T1>>(arg0),
            order_id  : v1,
            price     : arg3,
            quantity  : arg4,
            is_bid    : arg5,
            timestamp : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<GridOrderPlaced>(v2);
        v1
    }

    public fun bot_withdraw_settled<T0, T1>(arg0: &mut GridVault<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.bot_address, 0);
        assert!(0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1) == arg0.allowed_pool_id, 2);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg1, &mut arg0.balance_manager, &v0);
    }

    public entry fun create_and_share_grid_vault<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<GridVault<T0, T1>>(create_grid_vault<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6));
    }

    public entry fun create_and_share_grid_vault_v2<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<GridVault<T0, T1>>(create_grid_vault_v2<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7));
    }

    public entry fun create_and_share_grid_vault_v3<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: u8, arg8: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<GridVault<T0, T1>>(create_grid_vault_v3<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8));
    }

    public fun create_grid_vault<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : GridVault<T0, T1> {
        create_grid_vault_v2<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, 0, arg6)
    }

    public fun create_grid_vault_v2<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) : GridVault<T0, T1> {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::new(arg7);
        let v2 = 0x2::table::new<0x1::string::String, u64>(arg7);
        0x2::table::add<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"upper_price"), arg2);
        0x2::table::add<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"lower_price"), arg3);
        0x2::table::add<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"grid_levels"), arg4);
        0x2::table::add<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"order_size_base"), arg5);
        0x2::table::add<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"strategy_type"), (arg6 as u64));
        let v3 = GridVault<T0, T1>{
            id                         : 0x2::object::new(arg7),
            balance_manager            : v1,
            trade_cap                  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_trade_cap(&mut v1, arg7),
            deposit_cap                : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_deposit_cap(&mut v1, arg7),
            withdraw_cap               : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_withdraw_cap(&mut v1, arg7),
            allowed_pool_id            : arg0,
            total_shares               : 0,
            user_shares                : 0x2::table::new<address, u64>(arg7),
            user_cost_basis            : 0x2::table::new<address, u64>(arg7),
            strategy_params            : v2,
            active_order_ids           : 0x2::vec_set::empty<u128>(),
            bot_address                : arg1,
            admin_address              : v0,
            is_paused                  : false,
            total_volume_traded        : 0,
            total_fees_collected_base  : 0,
            total_fees_collected_quote : 0,
            orders_filled_count        : 0,
        };
        let v4 = VaultCreated{
            vault_id : 0x2::object::id<GridVault<T0, T1>>(&v3),
            pool_id  : arg0,
            admin    : v0,
            bot      : arg1,
        };
        0x2::event::emit<VaultCreated>(v4);
        v3
    }

    public fun create_grid_vault_v3<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: u8, arg8: &mut 0x2::tx_context::TxContext) : GridVault<T0, T1> {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::new(arg8);
        let v2 = 0x2::table::new<0x1::string::String, u64>(arg8);
        0x2::table::add<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"upper_price"), arg2);
        0x2::table::add<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"lower_price"), arg3);
        0x2::table::add<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"grid_levels"), arg4);
        0x2::table::add<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"order_size_base"), arg5);
        0x2::table::add<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"strategy_type"), (arg6 as u64));
        0x2::table::add<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"grid_spacing"), (arg7 as u64));
        let v3 = GridVault<T0, T1>{
            id                         : 0x2::object::new(arg8),
            balance_manager            : v1,
            trade_cap                  : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_trade_cap(&mut v1, arg8),
            deposit_cap                : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_deposit_cap(&mut v1, arg8),
            withdraw_cap               : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::mint_withdraw_cap(&mut v1, arg8),
            allowed_pool_id            : arg0,
            total_shares               : 0,
            user_shares                : 0x2::table::new<address, u64>(arg8),
            user_cost_basis            : 0x2::table::new<address, u64>(arg8),
            strategy_params            : v2,
            active_order_ids           : 0x2::vec_set::empty<u128>(),
            bot_address                : arg1,
            admin_address              : v0,
            is_paused                  : false,
            total_volume_traded        : 0,
            total_fees_collected_base  : 0,
            total_fees_collected_quote : 0,
            orders_filled_count        : 0,
        };
        let v4 = VaultCreated{
            vault_id : 0x2::object::id<GridVault<T0, T1>>(&v3),
            pool_id  : arg0,
            admin    : v0,
            bot      : arg1,
        };
        0x2::event::emit<VaultCreated>(v4);
        v3
    }

    public fun deposit<T0, T1>(arg0: &mut GridVault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 1);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = if (arg0.total_shares == 0) {
            v0
        } else {
            let v4 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(&arg0.balance_manager);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(&arg0.balance_manager);
            if (v4 > 0) {
                v0 * arg0.total_shares / v4
            } else {
                v0
            }
        };
        assert!(v3 > 0, 5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<T0>(&mut arg0.balance_manager, &arg0.deposit_cap, arg1, arg3);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<T1>(&mut arg0.balance_manager, &arg0.deposit_cap, arg2, arg3);
        if (0x2::table::contains<address, u64>(&arg0.user_shares, v2)) {
            let v5 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_shares, v2);
            *v5 = *v5 + v3;
            let v6 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_cost_basis, v2);
            *v6 = *v6 + v0 + v1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.user_shares, v2, v3);
            0x2::table::add<address, u64>(&mut arg0.user_cost_basis, v2, v0 + v1);
        };
        arg0.total_shares = arg0.total_shares + v3;
        let v7 = UserDeposit{
            vault_id      : 0x2::object::id<GridVault<T0, T1>>(arg0),
            user          : v2,
            base_amount   : v0,
            quote_amount  : v1,
            shares_minted : v3,
            total_shares  : arg0.total_shares,
        };
        0x2::event::emit<UserDeposit>(v7);
    }

    public fun get_active_orders<T0, T1>(arg0: &GridVault<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>) : vector<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order> {
        assert!(0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1) == arg0.allowed_pool_id, 2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_account_order_details<T0, T1>(arg1, &arg0.balance_manager)
    }

    public fun get_admin_address<T0, T1>(arg0: &GridVault<T0, T1>) : address {
        arg0.admin_address
    }

    public fun get_bot_address<T0, T1>(arg0: &GridVault<T0, T1>) : address {
        arg0.bot_address
    }

    public fun get_grid_spacing<T0, T1>(arg0: &GridVault<T0, T1>) : u8 {
        let v0 = 0x1::string::utf8(b"grid_spacing");
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.strategy_params, v0)) {
            (*0x2::table::borrow<0x1::string::String, u64>(&arg0.strategy_params, v0) as u8)
        } else {
            1
        }
    }

    public fun get_pool_id<T0, T1>(arg0: &GridVault<T0, T1>) : 0x2::object::ID {
        arg0.allowed_pool_id
    }

    public fun get_strategy_param<T0, T1>(arg0: &GridVault<T0, T1>, arg1: 0x1::string::String) : u64 {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.strategy_params, arg1)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.strategy_params, arg1)
        } else {
            0
        }
    }

    public fun get_strategy_type<T0, T1>(arg0: &GridVault<T0, T1>) : u8 {
        let v0 = 0x1::string::utf8(b"strategy_type");
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.strategy_params, v0)) {
            (*0x2::table::borrow<0x1::string::String, u64>(&arg0.strategy_params, v0) as u8)
        } else {
            0
        }
    }

    public fun get_total_shares<T0, T1>(arg0: &GridVault<T0, T1>) : u64 {
        arg0.total_shares
    }

    public fun get_user_shares<T0, T1>(arg0: &GridVault<T0, T1>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.user_shares, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.user_shares, arg1)
        } else {
            0
        }
    }

    public fun get_vault_balances<T0, T1>(arg0: &GridVault<T0, T1>) : (u64, u64) {
        (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(&arg0.balance_manager), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(&arg0.balance_manager))
    }

    public fun get_vault_stats<T0, T1>(arg0: &GridVault<T0, T1>) : (u64, u64, u64, u64) {
        (arg0.total_volume_traded, arg0.total_fees_collected_base, arg0.total_fees_collected_quote, arg0.orders_filled_count)
    }

    public fun is_vault_paused<T0, T1>(arg0: &GridVault<T0, T1>) : bool {
        arg0.is_paused
    }

    public entry fun set_bot_address<T0, T1>(arg0: &mut GridVault<T0, T1>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin_address, 0);
        arg0.bot_address = arg1;
    }

    public fun set_paused<T0, T1>(arg0: &mut GridVault<T0, T1>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin_address, 0);
        arg0.is_paused = arg1;
    }

    public fun share_vault<T0, T1>(arg0: GridVault<T0, T1>) {
        0x2::transfer::share_object<GridVault<T0, T1>>(arg0);
    }

    public fun update_strategy_param<T0, T1>(arg0: &mut GridVault<T0, T1>, arg1: 0x1::string::String, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin_address, 0);
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.strategy_params, arg1)) {
            *0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg0.strategy_params, arg1) = arg2;
        } else {
            0x2::table::add<0x1::string::String, u64>(&mut arg0.strategy_params, arg1, arg2);
        };
        let v0 = StrategyParamsUpdated{
            vault_id    : 0x2::object::id<GridVault<T0, T1>>(arg0),
            param_key   : arg1,
            param_value : arg2,
        };
        0x2::event::emit<StrategyParamsUpdated>(v0);
    }

    public fun withdraw<T0, T1>(arg0: &mut GridVault<T0, T1>, arg1: u64, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(!arg0.is_paused, 1);
        assert!(0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2) == arg0.allowed_pool_id, 2);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, u64>(&arg0.user_shares, v0), 0);
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_shares, v0);
        assert!(*v1 >= arg1, 3);
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg3);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg2, &mut arg0.balance_manager, &v2);
        let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(&arg0.balance_manager) * arg1 / arg0.total_shares;
        let v4 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(&arg0.balance_manager) * arg1 / arg0.total_shares;
        *v1 = *v1 - arg1;
        arg0.total_shares = arg0.total_shares - arg1;
        let v5 = UserWithdraw{
            vault_id      : 0x2::object::id<GridVault<T0, T1>>(arg0),
            user          : v0,
            base_amount   : v3,
            quote_amount  : v4,
            shares_burned : arg1,
            total_shares  : arg0.total_shares,
        };
        0x2::event::emit<UserWithdraw>(v5);
        (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T0>(&mut arg0.balance_manager, &arg0.withdraw_cap, v3, arg3), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T1>(&mut arg0.balance_manager, &arg0.withdraw_cap, v4, arg3))
    }

    public entry fun withdraw_all<T0, T1>(arg0: &mut GridVault<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.user_shares, v0), 0);
        let v1 = *0x2::table::borrow<address, u64>(&arg0.user_shares, v0);
        assert!(v1 > 0, 3);
        let (v2, v3) = withdraw<T0, T1>(arg0, v1, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, v0);
    }

    public entry fun withdraw_all_with_cancel<T0, T1>(arg0: &mut GridVault<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, u64>(&arg0.user_shares, v0), 0);
        let v1 = *0x2::table::borrow<address, u64>(&arg0.user_shares, v0);
        assert!(v1 > 0, 3);
        let (v2, v3) = withdraw_with_cancel<T0, T1>(arg0, v1, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, v0);
    }

    public entry fun withdraw_shares<T0, T1>(arg0: &mut GridVault<T0, T1>, arg1: u64, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let (v1, v2) = withdraw<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, v0);
    }

    public entry fun withdraw_shares_with_cancel<T0, T1>(arg0: &mut GridVault<T0, T1>, arg1: u64, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let (v1, v2) = withdraw_with_cancel<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, v0);
    }

    fun withdraw_with_cancel<T0, T1>(arg0: &mut GridVault<T0, T1>, arg1: u64, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(!arg0.is_paused, 1);
        assert!(0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg2) == arg0.allowed_pool_id, 2);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, u64>(&arg0.user_shares, v0), 0);
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_shares, v0);
        assert!(*v1 >= arg1, 3);
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<T0, T1>(arg2, &mut arg0.balance_manager, &v2, arg3, arg4);
        arg0.active_order_ids = 0x2::vec_set::empty<u128>();
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg2, &mut arg0.balance_manager, &v2);
        let v3 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(&arg0.balance_manager) * arg1 / arg0.total_shares;
        let v4 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(&arg0.balance_manager) * arg1 / arg0.total_shares;
        *v1 = *v1 - arg1;
        arg0.total_shares = arg0.total_shares - arg1;
        let v5 = UserWithdraw{
            vault_id      : 0x2::object::id<GridVault<T0, T1>>(arg0),
            user          : v0,
            base_amount   : v3,
            quote_amount  : v4,
            shares_burned : arg1,
            total_shares  : arg0.total_shares,
        };
        0x2::event::emit<UserWithdraw>(v5);
        (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T0>(&mut arg0.balance_manager, &arg0.withdraw_cap, v3, arg4), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T1>(&mut arg0.balance_manager, &arg0.withdraw_cap, v4, arg4))
    }

    // decompiled from Move bytecode v6
}

