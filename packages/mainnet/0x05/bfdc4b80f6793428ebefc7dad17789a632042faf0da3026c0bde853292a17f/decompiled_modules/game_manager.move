module 0x5bfdc4b80f6793428ebefc7dad17789a632042faf0da3026c0bde853292a17f::game_manager {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct GameConfig has store, key {
        id: 0x2::object::UID,
        protocol_fee_bp: u64,
        liquidity_fee_bp: u64,
        kelly_fraction_bp: u64,
        min_bet_amount: u64,
    }

    struct GameManager has key {
        id: 0x2::object::UID,
        liquidity_manager_cap: 0xdc51e55b52bb48bcd7a4c4f629b63398706e6b0dcec43a0e43e09426bdb40839::liquidity::ManagerCap,
        config_map: 0x2::object_table::ObjectTable<0x1::type_name::TypeName, GameConfig>,
        protocol_fee_address: address,
        check_bet_amount_enabled: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun add_game_config<T0: drop>(arg0: &AdminCap, arg1: &mut GameManager, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = GameConfig{
            id                : 0x2::object::new(arg6),
            protocol_fee_bp   : arg2,
            liquidity_fee_bp  : arg3,
            kelly_fraction_bp : arg4,
            min_bet_amount    : arg5,
        };
        0x2::object_table::add<0x1::type_name::TypeName, GameConfig>(&mut arg1.config_map, 0x1::type_name::get<T0>(), v0);
    }

    public fun add_game_config_dynamic_field<T0: copy + drop + store, T1: drop + store, T2: drop>(arg0: &mut GameManager, arg1: T0, arg2: T1, arg3: T2) {
        0x2::dynamic_field::add<T0, T1>(&mut borrow_mut_game_config<T2>(arg0).id, arg1, arg2);
    }

    public fun borrow_game_config<T0: drop>(arg0: &GameManager) : &GameConfig {
        0x2::object_table::borrow<0x1::type_name::TypeName, GameConfig>(&arg0.config_map, 0x1::type_name::get<T0>())
    }

    public fun borrow_game_config_dynamic_field<T0: copy + drop + store, T1: drop + store, T2: drop>(arg0: &GameManager, arg1: T0) : &T1 {
        0x2::dynamic_field::borrow<T0, T1>(&borrow_game_config<T2>(arg0).id, arg1)
    }

    fun borrow_mut_game_config<T0: drop>(arg0: &mut GameManager) : &mut GameConfig {
        0x2::object_table::borrow_mut<0x1::type_name::TypeName, GameConfig>(&mut arg0.config_map, 0x1::type_name::get<T0>())
    }

    public fun check_bet_amount<T0, T1, T2: drop>(arg0: &GameManager, arg1: &0xdc51e55b52bb48bcd7a4c4f629b63398706e6b0dcec43a0e43e09426bdb40839::liquidity::LiquidityPool<T0, T1>, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        if (!arg0.check_bet_amount_enabled) {
            return
        };
        let v0 = borrow_game_config<T2>(arg0);
        let v1 = 0x1::u256::try_as_u64((0xdc51e55b52bb48bcd7a4c4f629b63398706e6b0dcec43a0e43e09426bdb40839::liquidity::get_total_assets<T0, T1>(arg1) as u256) * (arg2 as u256) * (v0.kelly_fraction_bp as u256) / (10000 as u256) / (1000000000 as u256));
        assert!(arg3 <= 0x1::option::extract<u64>(&mut v1), 13906834861538476038);
        assert!(arg3 >= v0.min_bet_amount, 13906834865833574408);
    }

    public fun create_game_manager(arg0: &AdminCap, arg1: 0xdc51e55b52bb48bcd7a4c4f629b63398706e6b0dcec43a0e43e09426bdb40839::liquidity::ManagerCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = GameManager{
            id                       : 0x2::object::new(arg2),
            liquidity_manager_cap    : arg1,
            config_map               : 0x2::object_table::new<0x1::type_name::TypeName, GameConfig>(arg2),
            protocol_fee_address     : 0x2::tx_context::sender(arg2),
            check_bet_amount_enabled : true,
        };
        0x2::transfer::share_object<GameManager>(v0);
    }

    fun get_liquidity_fee<T0: drop>(arg0: &GameManager, arg1: u64) : u64 {
        arg1 * borrow_game_config<T0>(arg0).liquidity_fee_bp / 10000
    }

    fun get_protocol_fee<T0: drop>(arg0: &GameManager, arg1: u64) : u64 {
        arg1 * borrow_game_config<T0>(arg0).protocol_fee_bp / 10000
    }

    public fun handle_payout<T0, T1, T2: drop>(arg0: &GameManager, arg1: &mut 0xdc51e55b52bb48bcd7a4c4f629b63398706e6b0dcec43a0e43e09426bdb40839::liquidity::LiquidityPool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: address, arg5: T2, arg6: &0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::VersionTable, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::check_version_gte<Witness>(arg6, 1);
        validate_exists_game_config<T2>(arg0);
        let v0 = get_protocol_fee<T2>(arg0, arg3);
        let v1 = arg3 - v0 - get_liquidity_fee<T2>(arg0, arg3);
        transfer_payout<T0, T1>(arg0, 0x2::coin::into_balance<T1>(arg2), arg1, v1, arg4, v0, arg6, arg7);
        v1
    }

    public fun handle_payout_with_referral<T0, T1: drop>(arg0: &GameManager, arg1: &mut 0xdc51e55b52bb48bcd7a4c4f629b63398706e6b0dcec43a0e43e09426bdb40839::liquidity::LiquidityPool<T0, 0x2::sui::SUI>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: address, arg5: T1, arg6: &mut 0xef199024460c12d9880f7b6bb9712de2a56b3761fd5a480f297dadb60f956c03::referral::ReferralRegistry, arg7: &0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::VersionTable, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::check_version_gte<Witness>(arg7, 1);
        validate_exists_game_config<T1>(arg0);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        let v1 = get_protocol_fee<T1>(arg0, arg3);
        let v2 = 0xef199024460c12d9880f7b6bb9712de2a56b3761fd5a480f297dadb60f956c03::referral::get_referral_fee(arg6, arg4, v1);
        let v3 = v1 - v2;
        let v4 = arg3 - v3 - get_liquidity_fee<T1>(arg0, arg3) - v2;
        if (v2 > 0) {
            0xef199024460c12d9880f7b6bb9712de2a56b3761fd5a480f297dadb60f956c03::referral::earn_referral_balance(arg6, arg4, arg7, 0x2::balance::split<0x2::sui::SUI>(&mut v0, v2));
        };
        transfer_payout<T0, 0x2::sui::SUI>(arg0, v0, arg1, v4, arg4, v3, arg7, arg8);
        v4
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun kelly_fraction_bp(arg0: &GameConfig) : u64 {
        arg0.kelly_fraction_bp
    }

    public fun liquidity_fee_bp(arg0: &GameConfig) : u64 {
        arg0.liquidity_fee_bp
    }

    public fun min_bet_amount(arg0: &GameConfig) : u64 {
        arg0.min_bet_amount
    }

    public fun protocol_fee_bp(arg0: &GameConfig) : u64 {
        arg0.protocol_fee_bp
    }

    public fun remove_if_exists_game_config_dynamic_field<T0: copy + drop + store, T1: drop + store, T2: drop>(arg0: &mut GameManager, arg1: T0, arg2: T2) {
        0x2::dynamic_field::remove_if_exists<T0, T1>(&mut borrow_mut_game_config<T2>(arg0).id, arg1);
    }

    fun transfer_payout<T0, T1>(arg0: &GameManager, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0xdc51e55b52bb48bcd7a4c4f629b63398706e6b0dcec43a0e43e09426bdb40839::liquidity::LiquidityPool<T0, T1>, arg3: u64, arg4: address, arg5: u64, arg6: &0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version::VersionTable, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1, arg5), arg7), arg0.protocol_fee_address);
        };
        if (arg3 > 0x2::balance::value<T1>(&arg1)) {
            0x2::balance::join<T1>(&mut arg1, 0xdc51e55b52bb48bcd7a4c4f629b63398706e6b0dcec43a0e43e09426bdb40839::liquidity::take<T0, T1>(arg2, arg3 - 0x2::balance::value<T1>(&arg1), arg6, &arg0.liquidity_manager_cap));
        };
        if (arg3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1, arg3), arg7), arg4);
        };
        if (0x2::balance::value<T1>(&arg1) > 0) {
            0xdc51e55b52bb48bcd7a4c4f629b63398706e6b0dcec43a0e43e09426bdb40839::liquidity::put<T0, T1>(arg2, arg1, arg6, &arg0.liquidity_manager_cap);
        } else {
            0x2::balance::destroy_zero<T1>(arg1);
        };
    }

    public fun update_game_config<T0: drop>(arg0: &AdminCap, arg1: &mut GameManager, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_mut_game_config<T0>(arg1);
        v0.protocol_fee_bp = arg2;
        v0.liquidity_fee_bp = arg3;
        v0.kelly_fraction_bp = arg4;
        v0.min_bet_amount = arg5;
    }

    public fun update_game_manager(arg0: &AdminCap, arg1: &mut GameManager, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        arg1.protocol_fee_address = arg2;
        arg1.check_bet_amount_enabled = arg3;
    }

    fun validate_exists_game_config<T0: drop>(arg0: &GameManager) {
        assert!(0x2::object_table::contains<0x1::type_name::TypeName, GameConfig>(&arg0.config_map, 0x1::type_name::get<T0>()), 13906835578797883396);
    }

    // decompiled from Move bytecode v6
}

