module 0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::liquidity_pool {
    struct Jackson_Liquidity_Coin has drop {
        dummy_field: bool,
    }

    struct Liquidity has store, key {
        id: 0x2::object::UID,
        last_add_timestamp: u64,
        liquidity_balance: 0x2::balance::Balance<Jackson_Liquidity_Coin>,
    }

    struct LiquidityPool has store, key {
        id: 0x2::object::UID,
        version: u64,
        lp_supply: 0x2::balance::Supply<Jackson_Liquidity_Coin>,
        usdj_available_amount: u64,
        usdj_available_balance: 0x2::balance::Balance<0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::vault::USDJ>,
        fee_balance: 0x2::balance::Balance<Jackson_Liquidity_Coin>,
        pause: bool,
        exclude_addresses: 0x2::table::Table<address, bool>,
        config: 0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::cell::Cell<LiquidityPoolConfig>,
    }

    struct LiquidityPoolConfig has store {
        fees: FeesConfig,
    }

    struct FeesConfig has store {
        add_liquidity_fee_basis_points: u64,
        remove_liquidity_fee_basis_points: u64,
    }

    struct SetPauseEvent has copy, drop {
        sender: address,
        pause: bool,
    }

    struct AddLiquidityEvent has copy, drop {
        liquidity_id: 0x2::object::ID,
        sender: address,
        coin_type: 0x1::type_name::TypeName,
        coin_amount: u64,
        usdj_amount: u64,
        liquidity_amount: u64,
        liquidity_fee_amount: u64,
        fee_basis_points: 0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::decimal::Decimal,
    }

    struct RemoveLiquidityEvent has copy, drop {
        liquidity_id: 0x2::object::ID,
        sender: address,
        coin_type: 0x1::type_name::TypeName,
        coin_amount: u64,
        usdj_amount: u64,
        liquidity_amount: u64,
        liquidity_fee_amount: u64,
        fee_basis_points: 0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::decimal::Decimal,
    }

    struct ClaimFeeEvent has copy, drop {
        receive_liquidity_id: 0x2::object::ID,
        fee_amount: u64,
    }

    struct SettleLpEvent has copy, drop {
        sender: address,
        amount: u64,
        isIn: bool,
    }

    public fun add_exclude_address(arg0: &0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::admin::AdminCap, arg1: &mut LiquidityPool, arg2: address) {
        assert!(arg1.version == 1, 1);
        0x2::table::add<address, bool>(&mut arg1.exclude_addresses, arg2, true);
    }

    public fun add_liquidity<T0>(arg0: &mut LiquidityPool, arg1: &mut Liquidity, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::vault::Vault, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg0.version == 1, 1);
        assert_pause(arg0);
        arg1.last_add_timestamp = 0x2::clock::timestamp_ms(arg5) / 1000;
        let v0 = 0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::vault::get_aum(arg3, true, arg5);
        let v1 = 0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::vault::buy_usdj<T0>(arg3, arg4, arg2, arg5);
        let v2 = 0x2::balance::value<0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::vault::USDJ>(&v1);
        assert!(0x2::balance::value<0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::vault::USDJ>(&v1) > 0, 2);
        arg0.usdj_available_amount = arg0.usdj_available_amount + 0x2::balance::value<0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::vault::USDJ>(&v1);
        0x2::balance::join<0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::vault::USDJ>(&mut arg0.usdj_available_balance, v1);
        let v3 = if (v0 == 0) {
            v2
        } else {
            0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::decimal::floor(0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::decimal::div(0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::decimal::mul(0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::decimal::from(v2), 0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::decimal::from(0x2::balance::supply_value<Jackson_Liquidity_Coin>(&arg0.lp_supply))), 0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::decimal::from(v0)))
        };
        let v4 = 0x2::balance::increase_supply<Jackson_Liquidity_Coin>(&mut arg0.lp_supply, v3);
        let v5 = 0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::decimal::from(0);
        if (!is_exclude_address(arg0, 0x2::tx_context::sender(arg6))) {
            v5 = add_liquidity_fee_basis_points(config(arg0));
        };
        let v6 = 0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::decimal::ceil(0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::decimal::mul(v5, 0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::decimal::from(v3)));
        if (v6 > 0) {
            0x2::balance::join<Jackson_Liquidity_Coin>(&mut arg0.fee_balance, 0x2::balance::split<Jackson_Liquidity_Coin>(&mut v4, v6));
        };
        0x2::balance::join<Jackson_Liquidity_Coin>(&mut arg1.liquidity_balance, v4);
        let v7 = AddLiquidityEvent{
            liquidity_id         : 0x2::object::id<Liquidity>(arg1),
            sender               : 0x2::tx_context::sender(arg6),
            coin_type            : 0x1::type_name::get<T0>(),
            coin_amount          : 0x2::coin::value<T0>(&arg2),
            usdj_amount          : v2,
            liquidity_amount     : v3,
            liquidity_fee_amount : v6,
            fee_basis_points     : v5,
        };
        0x2::event::emit<AddLiquidityEvent>(v7);
        v3
    }

    public fun add_liquidity_fee_basis_points(arg0: &LiquidityPoolConfig) : 0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::decimal::Decimal {
        0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::decimal::from_bps(arg0.fees.add_liquidity_fee_basis_points)
    }

    public fun admin_settle_lp(arg0: &0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::admin::HandlerCap, arg1: &mut LiquidityPool, arg2: &mut 0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::recharge::Recharge<Jackson_Liquidity_Coin>, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 1);
        if (arg4) {
            0x2::balance::decrease_supply<Jackson_Liquidity_Coin>(&mut arg1.lp_supply, 0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::recharge::withdraw<Jackson_Liquidity_Coin>(arg2, arg3, true));
        } else {
            0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::recharge::deposit<Jackson_Liquidity_Coin>(arg2, 0x2::coin::from_balance<Jackson_Liquidity_Coin>(0x2::balance::increase_supply<Jackson_Liquidity_Coin>(&mut arg1.lp_supply, arg3), arg5), @0x0, true, arg5);
        };
        let v0 = SettleLpEvent{
            sender : 0x2::tx_context::sender(arg5),
            amount : arg3,
            isIn   : arg4,
        };
        0x2::event::emit<SettleLpEvent>(v0);
    }

    fun assert_pause(arg0: &LiquidityPool) {
        assert!(!get_pause_status(arg0), 3);
    }

    public fun claim_fee(arg0: &0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::admin::AdminCap, arg1: &mut LiquidityPool, arg2: &mut Liquidity) {
        assert!(arg1.version == 1, 1);
        0x2::balance::join<Jackson_Liquidity_Coin>(&mut arg2.liquidity_balance, 0x2::balance::withdraw_all<Jackson_Liquidity_Coin>(&mut arg1.fee_balance));
        let v0 = ClaimFeeEvent{
            receive_liquidity_id : 0x2::object::id<Liquidity>(arg2),
            fee_amount           : 0x2::balance::value<Jackson_Liquidity_Coin>(&arg1.fee_balance),
        };
        0x2::event::emit<ClaimFeeEvent>(v0);
    }

    public fun config(arg0: &LiquidityPool) : &LiquidityPoolConfig {
        0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::cell::get<LiquidityPoolConfig>(&arg0.config)
    }

    public fun create_config(arg0: &LiquidityPool, arg1: u64, arg2: u64) : LiquidityPoolConfig {
        assert!(arg0.version == 1, 1);
        let v0 = FeesConfig{
            add_liquidity_fee_basis_points    : arg1,
            remove_liquidity_fee_basis_points : arg2,
        };
        let v1 = LiquidityPoolConfig{fees: v0};
        validate_config(&v1);
        v1
    }

    public fun create_liquidity(arg0: &LiquidityPool, arg1: &mut 0x2::tx_context::TxContext) : Liquidity {
        assert!(arg0.version == 1, 1);
        Liquidity{
            id                 : 0x2::object::new(arg1),
            last_add_timestamp : 0,
            liquidity_balance  : 0x2::balance::zero<Jackson_Liquidity_Coin>(),
        }
    }

    public fun get_pause_status(arg0: &LiquidityPool) : bool {
        arg0.pause
    }

    public fun glp_price(arg0: &LiquidityPool, arg1: &0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::vault::Vault, arg2: bool, arg3: &0x2::clock::Clock) : u64 {
        0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::decimal::floor(0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::decimal::div(0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::decimal::mul(0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::decimal::from(1000000), 0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::decimal::from(0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::vault::get_aum(arg1, arg2, arg3))), 0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::decimal::from(0x2::balance::supply_value<Jackson_Liquidity_Coin>(&arg0.lp_supply))))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<LiquidityPool>(make_pool(arg0));
    }

    public fun is_exclude_address(arg0: &LiquidityPool, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.exclude_addresses, arg1)
    }

    public fun join_liquidity(arg0: &mut Liquidity, arg1: 0x2::coin::Coin<Jackson_Liquidity_Coin>, arg2: &0x2::clock::Clock) : u64 {
        arg0.last_add_timestamp = 0x2::clock::timestamp_ms(arg2) / 1000;
        0x2::balance::join<Jackson_Liquidity_Coin>(&mut arg0.liquidity_balance, 0x2::coin::into_balance<Jackson_Liquidity_Coin>(arg1))
    }

    fun make_pool(arg0: &mut 0x2::tx_context::TxContext) : LiquidityPool {
        let v0 = Jackson_Liquidity_Coin{dummy_field: false};
        let v1 = FeesConfig{
            add_liquidity_fee_basis_points    : 0,
            remove_liquidity_fee_basis_points : 10,
        };
        let v2 = LiquidityPoolConfig{fees: v1};
        validate_config(&v2);
        LiquidityPool{
            id                     : 0x2::object::new(arg0),
            version                : 1,
            lp_supply              : 0x2::balance::create_supply<Jackson_Liquidity_Coin>(v0),
            usdj_available_amount  : 0,
            usdj_available_balance : 0x2::balance::zero<0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::vault::USDJ>(),
            fee_balance            : 0x2::balance::zero<Jackson_Liquidity_Coin>(),
            pause                  : false,
            exclude_addresses      : 0x2::table::new<address, bool>(arg0),
            config                 : 0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::cell::new<LiquidityPoolConfig>(v2),
        }
    }

    public fun merge_liquidity(arg0: &mut Liquidity, arg1: Liquidity) : u64 {
        let Liquidity {
            id                 : v0,
            last_add_timestamp : v1,
            liquidity_balance  : v2,
        } = arg1;
        0x2::object::delete(v0);
        arg0.last_add_timestamp = 0x1::u64::max(arg0.last_add_timestamp, v1);
        0x2::balance::join<Jackson_Liquidity_Coin>(&mut arg0.liquidity_balance, v2)
    }

    entry fun migrate(arg0: &0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::admin::AdminCap, arg1: &mut LiquidityPool) {
        assert!(arg1.version <= 1 - 1, 1);
        arg1.version = 1;
    }

    public fun remove_exclude_address(arg0: &0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::admin::AdminCap, arg1: &mut LiquidityPool, arg2: address) {
        assert!(arg1.version == 1, 1);
        0x2::table::remove<address, bool>(&mut arg1.exclude_addresses, arg2);
    }

    public fun remove_liquidity<T0>(arg0: &mut LiquidityPool, arg1: &mut Liquidity, arg2: &mut 0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::vault::Vault, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 1, 1);
        assert_pause(arg0);
        let v0 = 0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::decimal::from(0);
        if (!is_exclude_address(arg0, 0x2::tx_context::sender(arg6))) {
            assert!(0x2::clock::timestamp_ms(arg5) / 1000 - arg1.last_add_timestamp > 900, 4);
            v0 = remove_liquidity_fee_basis_points(config(arg0));
        };
        let v1 = 0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::decimal::ceil(0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::decimal::mul(v0, 0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::decimal::from(arg4)));
        if (v1 > 0) {
            0x2::balance::join<Jackson_Liquidity_Coin>(&mut arg0.fee_balance, 0x2::balance::split<Jackson_Liquidity_Coin>(&mut arg1.liquidity_balance, v1));
        };
        let v2 = arg4 - v1;
        let v3 = 0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::decimal::floor(0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::decimal::div(0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::decimal::mul(0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::decimal::from(v2), 0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::decimal::from(0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::vault::get_aum(arg2, false, arg5))), 0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::decimal::from(0x2::balance::supply_value<Jackson_Liquidity_Coin>(&arg0.lp_supply))));
        if (v3 > arg0.usdj_available_amount) {
            let v4 = 0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::vault::increase_usdj(arg2, v3 - arg0.usdj_available_amount);
            arg0.usdj_available_amount = arg0.usdj_available_amount + 0x2::balance::value<0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::vault::USDJ>(&v4);
            0x2::balance::join<0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::vault::USDJ>(&mut arg0.usdj_available_balance, v4);
        };
        let v5 = 0x2::balance::split<0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::vault::USDJ>(&mut arg0.usdj_available_balance, v3);
        arg0.usdj_available_amount = arg0.usdj_available_amount - 0x2::balance::value<0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::vault::USDJ>(&v5);
        let v6 = 0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::vault::sell_usdj<T0>(arg2, arg3, 0x2::coin::from_balance<0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::vault::USDJ>(v5, arg6), arg5);
        assert!(0x2::balance::value<T0>(&v6) > 0, 2);
        0x2::balance::decrease_supply<Jackson_Liquidity_Coin>(&mut arg0.lp_supply, 0x2::balance::split<Jackson_Liquidity_Coin>(&mut arg1.liquidity_balance, v2));
        let v7 = 0x2::coin::from_balance<T0>(v6, arg6);
        let v8 = RemoveLiquidityEvent{
            liquidity_id         : 0x2::object::id<Liquidity>(arg1),
            sender               : 0x2::tx_context::sender(arg6),
            coin_type            : 0x1::type_name::get<T0>(),
            coin_amount          : 0x2::coin::value<T0>(&v7),
            usdj_amount          : v3,
            liquidity_amount     : v2,
            liquidity_fee_amount : v1,
            fee_basis_points     : v0,
        };
        0x2::event::emit<RemoveLiquidityEvent>(v8);
        v7
    }

    public fun remove_liquidity_fee_basis_points(arg0: &LiquidityPoolConfig) : 0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::decimal::Decimal {
        0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::decimal::from_bps(arg0.fees.remove_liquidity_fee_basis_points)
    }

    public fun set_pause_status(arg0: &0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::admin::HandlerCap, arg1: &mut LiquidityPool, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 1);
        arg1.pause = arg2;
        let v0 = SetPauseEvent{
            sender : 0x2::tx_context::sender(arg3),
            pause  : arg2,
        };
        0x2::event::emit<SetPauseEvent>(v0);
    }

    public fun split_liquidity(arg0: &mut Liquidity, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<Jackson_Liquidity_Coin> {
        0x2::coin::from_balance<Jackson_Liquidity_Coin>(0x2::balance::split<Jackson_Liquidity_Coin>(&mut arg0.liquidity_balance, arg1), arg2)
    }

    public fun update_config(arg0: &0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::admin::AdminCap, arg1: &mut LiquidityPool, arg2: LiquidityPoolConfig) {
        assert!(arg1.version == 1, 1);
        let LiquidityPoolConfig { fees: v0 } = 0xbb8901d3f00f630e9648c6f78c23029e2bc6976bfd2700743d02a55df8b380f7::cell::set<LiquidityPoolConfig>(&mut arg1.config, arg2);
        let FeesConfig {
            add_liquidity_fee_basis_points    : _,
            remove_liquidity_fee_basis_points : _,
        } = v0;
    }

    fun validate_config(arg0: &LiquidityPoolConfig) {
        assert!(arg0.fees.add_liquidity_fee_basis_points <= 10000, 5);
        assert!(arg0.fees.remove_liquidity_fee_basis_points <= 10000, 5);
    }

    // decompiled from Move bytecode v6
}

