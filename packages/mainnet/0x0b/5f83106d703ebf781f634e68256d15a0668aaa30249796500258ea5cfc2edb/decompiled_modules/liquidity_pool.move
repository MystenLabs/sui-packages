module 0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::liquidity_pool {
    struct Liquidity has store, key {
        id: 0x2::object::UID,
        last_add_timestamp: u64,
        liquidity_balance: 0x2::balance::Balance<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>,
    }

    struct LiquidityPool has store, key {
        id: 0x2::object::UID,
        version: u64,
        lp_supply: 0x2::balance::Supply<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>,
        usdj_available_amount: u64,
        usdj_available_balance: 0x2::balance::Balance<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::vault::USDJ>,
        fee_balance: 0x2::balance::Balance<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>,
        pause: bool,
        exclude_addresses: 0x2::table::Table<address, bool>,
        config: 0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::cell::Cell<LiquidityPoolConfig>,
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
        sender: address,
        coin_type: 0x1::type_name::TypeName,
        coin_amount: u64,
        usdj_amount: u64,
        liquidity_amount: u64,
        liquidity_fee_amount: u64,
        fee_basis_points: 0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::decimal::Decimal,
    }

    struct RemoveLiquidityEvent has copy, drop {
        liquidity_id: 0x2::object::ID,
        sender: address,
        coin_type: 0x1::type_name::TypeName,
        coin_amount: u64,
        usdj_amount: u64,
        liquidity_amount: u64,
        liquidity_fee_amount: u64,
        fee_basis_points: 0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::decimal::Decimal,
    }

    struct ClaimFeeEvent has copy, drop {
        sender: address,
        fee_amount: u64,
    }

    struct SettleLpEvent has copy, drop {
        sender: address,
        amount: u64,
        isIn: bool,
    }

    public fun add_exclude_address(arg0: &0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::admin::AdminCap, arg1: &mut LiquidityPool, arg2: address) {
        assert!(arg1.version == 1, 1);
        0x2::table::add<address, bool>(&mut arg1.exclude_addresses, arg2, true);
    }

    public fun add_liquidity<T0>(arg0: &mut LiquidityPool, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::vault::Vault, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN> {
        assert!(arg0.version == 1, 1);
        assert_pause(arg0);
        let v0 = 0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::vault::get_aum(arg2, true, arg4);
        let v1 = 0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::vault::buy_usdj<T0>(arg2, arg3, arg1, arg4);
        let v2 = 0x2::balance::value<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::vault::USDJ>(&v1);
        assert!(0x2::balance::value<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::vault::USDJ>(&v1) > 0, 2);
        arg0.usdj_available_amount = arg0.usdj_available_amount + 0x2::balance::value<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::vault::USDJ>(&v1);
        0x2::balance::join<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::vault::USDJ>(&mut arg0.usdj_available_balance, v1);
        let v3 = if (v0 == 0) {
            v2 * 100
        } else {
            0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::decimal::floor(0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::decimal::div(0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::decimal::mul(0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::decimal::from(v2), 0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::decimal::from(0x2::balance::supply_value<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>(&arg0.lp_supply))), 0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::decimal::from(v0)))
        };
        let v4 = 0x2::balance::increase_supply<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>(&mut arg0.lp_supply, v3);
        let v5 = 0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::decimal::from(0);
        if (!is_exclude_address(arg0, 0x2::tx_context::sender(arg5))) {
            v5 = add_liquidity_fee_basis_points(config(arg0));
        };
        let v6 = 0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::decimal::ceil(0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::decimal::mul(v5, 0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::decimal::from(v3)));
        if (v6 > 0) {
            0x2::balance::join<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>(&mut arg0.fee_balance, 0x2::balance::split<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>(&mut v4, v6));
        };
        let v7 = AddLiquidityEvent{
            sender               : 0x2::tx_context::sender(arg5),
            coin_type            : 0x1::type_name::get<T0>(),
            coin_amount          : 0x2::coin::value<T0>(&arg1),
            usdj_amount          : v2,
            liquidity_amount     : v3,
            liquidity_fee_amount : v6,
            fee_basis_points     : v5,
        };
        0x2::event::emit<AddLiquidityEvent>(v7);
        0x2::coin::from_balance<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>(v4, arg5)
    }

    public fun add_liquidity_fee_basis_points(arg0: &LiquidityPoolConfig) : 0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::decimal::Decimal {
        0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::decimal::from_bps(arg0.fees.add_liquidity_fee_basis_points)
    }

    public fun admin_settle_lp(arg0: &0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::admin::HandlerCap, arg1: &mut LiquidityPool, arg2: &mut 0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::recharge::Recharge<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 1);
        if (arg4) {
            0x2::balance::decrease_supply<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>(&mut arg1.lp_supply, 0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::recharge::withdraw<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>(arg2, arg3, true));
        } else {
            0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::recharge::deposit<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>(arg2, 0x2::coin::from_balance<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>(0x2::balance::increase_supply<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>(&mut arg1.lp_supply, arg3), arg5), @0x0, true, arg5);
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

    public fun claim_fee(arg0: &0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::admin::AdminCap, arg1: &mut LiquidityPool, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN> {
        assert!(arg1.version == 1, 1);
        let v0 = ClaimFeeEvent{
            sender     : 0x2::tx_context::sender(arg2),
            fee_amount : 0x2::balance::value<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>(&arg1.fee_balance),
        };
        0x2::event::emit<ClaimFeeEvent>(v0);
        0x2::coin::from_balance<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>(0x2::balance::withdraw_all<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>(&mut arg1.fee_balance), arg2)
    }

    public fun config(arg0: &LiquidityPool) : &LiquidityPoolConfig {
        0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::cell::get<LiquidityPoolConfig>(&arg0.config)
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
            liquidity_balance  : 0x2::balance::zero<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>(),
        }
    }

    public fun destroy_zero_liquidity(arg0: Liquidity) {
        let Liquidity {
            id                 : v0,
            last_add_timestamp : _,
            liquidity_balance  : v2,
        } = arg0;
        0x2::balance::destroy_zero<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>(v2);
        0x2::object::delete(v0);
    }

    public fun get_lp_price(arg0: &LiquidityPool, arg1: &0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::vault::Vault, arg2: bool, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::balance::supply_value<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>(&arg0.lp_supply);
        if (v0 == 0) {
            10000
        } else {
            0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::decimal::floor(0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::decimal::div(0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::decimal::mul(0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::decimal::from(1000000), 0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::decimal::from(0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::vault::get_aum(arg1, arg2, arg3))), 0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::decimal::from(v0)))
        }
    }

    public fun get_pause_status(arg0: &LiquidityPool) : bool {
        arg0.pause
    }

    public fun is_exclude_address(arg0: &LiquidityPool, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.exclude_addresses, arg1)
    }

    public fun join_liquidity(arg0: &mut Liquidity, arg1: 0x2::coin::Coin<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>, arg2: &0x2::clock::Clock) : u64 {
        arg0.last_add_timestamp = 0x2::clock::timestamp_ms(arg2) / 1000;
        0x2::balance::join<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>(&mut arg0.liquidity_balance, 0x2::coin::into_balance<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>(arg1))
    }

    public fun make_pool(arg0: 0x2::coin::TreasuryCap<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = FeesConfig{
            add_liquidity_fee_basis_points    : 0,
            remove_liquidity_fee_basis_points : 10,
        };
        let v1 = LiquidityPoolConfig{fees: v0};
        validate_config(&v1);
        let v2 = LiquidityPool{
            id                     : 0x2::object::new(arg1),
            version                : 1,
            lp_supply              : 0x2::coin::treasury_into_supply<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>(arg0),
            usdj_available_amount  : 0,
            usdj_available_balance : 0x2::balance::zero<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::vault::USDJ>(),
            fee_balance            : 0x2::balance::zero<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>(),
            pause                  : false,
            exclude_addresses      : 0x2::table::new<address, bool>(arg1),
            config                 : 0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::cell::new<LiquidityPoolConfig>(v1),
        };
        0x2::transfer::share_object<LiquidityPool>(v2);
    }

    public fun merge_liquidity(arg0: &mut Liquidity, arg1: Liquidity) : u64 {
        let Liquidity {
            id                 : v0,
            last_add_timestamp : v1,
            liquidity_balance  : v2,
        } = arg1;
        0x2::object::delete(v0);
        arg0.last_add_timestamp = 0x1::u64::max(arg0.last_add_timestamp, v1);
        0x2::balance::join<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>(&mut arg0.liquidity_balance, v2)
    }

    entry fun migrate(arg0: &0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::admin::AdminCap, arg1: &mut LiquidityPool) {
        assert!(arg1.version <= 1 - 1, 1);
        arg1.version = 1;
    }

    public fun remove_exclude_address(arg0: &0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::admin::AdminCap, arg1: &mut LiquidityPool, arg2: address) {
        assert!(arg1.version == 1, 1);
        0x2::table::remove<address, bool>(&mut arg1.exclude_addresses, arg2);
    }

    public fun remove_liquidity<T0>(arg0: &mut LiquidityPool, arg1: &mut Liquidity, arg2: &mut 0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::vault::Vault, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 1, 1);
        assert_pause(arg0);
        let v0 = 0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::decimal::from(0);
        if (!is_exclude_address(arg0, 0x2::tx_context::sender(arg6))) {
            assert!(0x2::clock::timestamp_ms(arg5) / 1000 - arg1.last_add_timestamp > 900, 4);
            v0 = remove_liquidity_fee_basis_points(config(arg0));
        };
        let v1 = 0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::decimal::ceil(0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::decimal::mul(v0, 0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::decimal::from(arg4)));
        if (v1 > 0) {
            0x2::balance::join<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>(&mut arg0.fee_balance, 0x2::balance::split<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>(&mut arg1.liquidity_balance, v1));
        };
        let v2 = arg4 - v1;
        let v3 = 0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::decimal::floor(0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::decimal::div(0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::decimal::mul(0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::decimal::from(v2), 0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::decimal::from(0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::vault::get_aum(arg2, false, arg5))), 0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::decimal::from(0x2::balance::supply_value<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>(&arg0.lp_supply))));
        if (v3 > arg0.usdj_available_amount) {
            let v4 = 0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::vault::increase_usdj(arg2, v3 - arg0.usdj_available_amount);
            arg0.usdj_available_amount = arg0.usdj_available_amount + 0x2::balance::value<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::vault::USDJ>(&v4);
            0x2::balance::join<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::vault::USDJ>(&mut arg0.usdj_available_balance, v4);
        };
        let v5 = 0x2::balance::split<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::vault::USDJ>(&mut arg0.usdj_available_balance, v3);
        arg0.usdj_available_amount = arg0.usdj_available_amount - 0x2::balance::value<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::vault::USDJ>(&v5);
        let v6 = 0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::vault::sell_usdj<T0>(arg2, arg3, 0x2::coin::from_balance<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::vault::USDJ>(v5, arg6), arg5);
        assert!(0x2::balance::value<T0>(&v6) > 0, 2);
        0x2::balance::decrease_supply<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>(&mut arg0.lp_supply, 0x2::balance::split<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>(&mut arg1.liquidity_balance, v2));
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

    public fun remove_liquidity_fee_basis_points(arg0: &LiquidityPoolConfig) : 0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::decimal::Decimal {
        0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::decimal::from_bps(arg0.fees.remove_liquidity_fee_basis_points)
    }

    public fun set_pause_status(arg0: &0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::admin::HandlerCap, arg1: &mut LiquidityPool, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 1);
        arg1.pause = arg2;
        let v0 = SetPauseEvent{
            sender : 0x2::tx_context::sender(arg3),
            pause  : arg2,
        };
        0x2::event::emit<SetPauseEvent>(v0);
    }

    public fun split_liquidity(arg0: &mut Liquidity, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN> {
        0x2::coin::from_balance<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>(0x2::balance::split<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>(&mut arg0.liquidity_balance, arg1), arg2)
    }

    public fun update_config(arg0: &0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::admin::AdminCap, arg1: &mut LiquidityPool, arg2: LiquidityPoolConfig) {
        assert!(arg1.version == 1, 1);
        let LiquidityPoolConfig { fees: v0 } = 0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::cell::set<LiquidityPoolConfig>(&mut arg1.config, arg2);
        let FeesConfig {
            add_liquidity_fee_basis_points    : _,
            remove_liquidity_fee_basis_points : _,
        } = v0;
    }

    fun validate_config(arg0: &LiquidityPoolConfig) {
        assert!(arg0.fees.add_liquidity_fee_basis_points <= 10000, 5);
        assert!(arg0.fees.remove_liquidity_fee_basis_points <= 10000, 5);
    }

    public fun withdraw_all_liquidity(arg0: &mut Liquidity, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN> {
        let v0 = 0x2::balance::value<0xb5f83106d703ebf781f634e68256d15a0668aaa30249796500258ea5cfc2edb::jackson_liquidity_coin::JACKSON_LIQUIDITY_COIN>(&arg0.liquidity_balance);
        split_liquidity(arg0, v0, arg1)
    }

    // decompiled from Move bytecode v6
}

