module 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::vault {
    struct RedeemRequest<phantom T0, phantom T1> has store {
        who: address,
        shares: 0x2::balance::Balance<LPToken<T0, T1>>,
        request_time_ms: u64,
    }

    struct RedeemQueue<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<u64, RedeemRequest<T0, T1>>,
        next_request_id: u64,
    }

    struct LPToken<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct Vault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        idle_liquidity: 0x2::balance::Balance<T1>,
        lp_supply: 0x2::balance::Supply<LPToken<T0, T1>>,
        total_deposit: u64,
        redeem_queue: RedeemQueue<T0, T1>,
        interest_rate_ms: u64,
        last_interest_rate_updated_time_ms: u64,
        last_interest_updated_time_ms: u64,
        config: 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::config::VaultConfig,
        liquidity_miner_admin: 0xf97c8e0837131b4fc9f29eddfce7e9790bae9ceec1d7d465eddfea521a661f6b::liquidity_miner::AdminCap,
        liquidity_miner_id: 0x2::object::ID,
        wishes: 0x2::bag::Bag,
        version: u16,
    }

    fun accrue_interest<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::global::VaultRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.last_interest_updated_time_ms;
        let v1 = 0x2::clock::timestamp_ms(arg2);
        if (v1 == v0) {
            return
        };
        assert!(v1 > v0, 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::error::clock_went_backwards());
        let v2 = arg0.total_deposit;
        let v3 = 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::math::safe_cast((arg0.interest_rate_ms as u256) * ((v1 - v0) as u256) * (v2 as u256) / (0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::math::wad() as u256));
        let v4 = 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::math::mul_div(v3, 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::config::performance_fee_bps(borrow_config<T0, T1>(arg0)), 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::math::max_bps());
        let v5 = v2 + v3 - v4;
        let v6 = 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::math::convert_to_shares(v4, v5, total_shares<T0, T1>(arg0));
        if (v6 != 0) {
            0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::global::earn_fee<LPToken<T0, T1>>(arg1, 0x2::object::id<Vault<T0, T1>>(arg0), 0x2::coin::into_balance<LPToken<T0, T1>>(0x2::coin::from_balance<LPToken<T0, T1>>(0x2::balance::increase_supply<LPToken<T0, T1>>(&mut arg0.lp_supply, v6), arg3)));
        };
        arg0.total_deposit = v5 + v4;
        arg0.last_interest_updated_time_ms = v1;
        0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::event::emit_interest_accrued(0x2::object::id<Vault<T0, T1>>(arg0), v2, arg0.total_deposit, v6, v1);
    }

    public(friend) fun borrow_config<T0, T1>(arg0: &Vault<T0, T1>) : &0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::config::VaultConfig {
        &arg0.config
    }

    public(friend) fun borrow_config_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : &mut 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::config::VaultConfig {
        &mut arg0.config
    }

    public(friend) fun borrow_wishes_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : &mut 0x2::bag::Bag {
        &mut arg0.wishes
    }

    public fun deposit<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::global::VaultRegistry, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LPToken<T0, T1>> {
        ensure_version_matches<T0, T1>(arg0);
        0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::config::ensure_not_circuit_breaked(&arg0.config);
        accrue_interest<T0, T1>(arg0, arg1, arg3, arg4);
        let v0 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 >= 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::config::min_per_deposit(&arg0.config), 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::error::deposit_too_small());
        arg0.total_deposit = arg0.total_deposit + v0;
        assert!(arg0.total_deposit <= 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::config::max_total_deposit(&arg0.config), 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::error::max_total_deposit_exceeded());
        0x2::balance::join<T1>(&mut arg0.idle_liquidity, 0x2::coin::into_balance<T1>(arg2));
        let v1 = 0x2::coin::from_balance<LPToken<T0, T1>>(0x2::balance::increase_supply<LPToken<T0, T1>>(&mut arg0.lp_supply, 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::math::convert_to_shares(v0, arg0.total_deposit, total_shares<T0, T1>(arg0))), arg4);
        0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::event::emit_deposit(0x2::object::id<Vault<T0, T1>>(arg0), 0x2::tx_context::sender(arg4), v0, 0x2::coin::value<LPToken<T0, T1>>(&v1), 0x2::clock::timestamp_ms(arg3));
        v1
    }

    public(friend) fun empty_liquidity<T0, T1>(arg0: &mut Vault<T0, T1>) : 0x2::balance::Balance<T1> {
        0x2::balance::split<T1>(&mut arg0.idle_liquidity, 0x2::balance::value<T1>(&arg0.idle_liquidity))
    }

    public fun ensure_version_matches<T0, T1>(arg0: &Vault<T0, T1>) {
        assert!(arg0.version == 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::config::current_version(), 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::error::version_mismatch());
    }

    public(friend) fun fulfill_redeem<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::global::VaultRegistry, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        accrue_interest<T0, T1>(arg0, arg1, arg4, arg5);
        assert!(0x2::table::contains<u64, RedeemRequest<T0, T1>>(&arg0.redeem_queue.table, arg2), 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::error::request_not_match());
        let RedeemRequest {
            who             : v0,
            shares          : v1,
            request_time_ms : _,
        } = 0x2::table::remove<u64, RedeemRequest<T0, T1>>(&mut arg0.redeem_queue.table, arg2);
        let v3 = v1;
        assert!(v0 == arg3, 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::error::request_not_match());
        let v4 = 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::math::convert_to_assets(0x2::balance::value<LPToken<T0, T1>>(&v3), arg0.total_deposit, total_shares<T0, T1>(arg0));
        0x2::balance::decrease_supply<LPToken<T0, T1>>(&mut arg0.lp_supply, v3);
        arg0.total_deposit = arg0.total_deposit - v4;
        v4
    }

    public fun has_wish<T0, T1, T2: store>(arg0: &Vault<T0, T1>) : bool {
        0x2::bag::contains<0x1::type_name::TypeName>(&arg0.wishes, 0x1::type_name::with_defining_ids<T2>())
    }

    public fun idle_liquidity<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.idle_liquidity)
    }

    public(friend) fun liquidity_miner_admin_cap<T0, T1>(arg0: &Vault<T0, T1>) : &0xf97c8e0837131b4fc9f29eddfce7e9790bae9ceec1d7d465eddfea521a661f6b::liquidity_miner::AdminCap {
        &arg0.liquidity_miner_admin
    }

    public(friend) fun new_vault<T0, T1>(arg0: &mut 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::global::VaultRegistry, arg1: 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::config::VaultParams, arg2: 0x2::object::ID, arg3: 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::config::FeeStructure, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (Vault<T0, T1>, 0x2::object::ID) {
        let (v0, v1) = 0xf97c8e0837131b4fc9f29eddfce7e9790bae9ceec1d7d465eddfea521a661f6b::liquidity_miner::new_liquidity_miner<LPToken<T0, T1>>(arg6);
        let v2 = v0;
        let v3 = 0x2::object::id<0xf97c8e0837131b4fc9f29eddfce7e9790bae9ceec1d7d465eddfea521a661f6b::liquidity_miner::LiquidityMiner<LPToken<T0, T1>>>(&v2);
        0x2::transfer::public_share_object<0xf97c8e0837131b4fc9f29eddfce7e9790bae9ceec1d7d465eddfea521a661f6b::liquidity_miner::LiquidityMiner<LPToken<T0, T1>>>(v2);
        let v4 = RedeemQueue<T0, T1>{
            id              : 0x2::object::new(arg6),
            table           : 0x2::table::new<u64, RedeemRequest<T0, T1>>(arg6),
            next_request_id : 0,
        };
        let v5 = LPToken<T0, T1>{dummy_field: false};
        let v6 = Vault<T0, T1>{
            id                                 : 0x2::object::new(arg6),
            idle_liquidity                     : 0x2::balance::zero<T1>(),
            lp_supply                          : 0x2::balance::create_supply<LPToken<T0, T1>>(v5),
            total_deposit                      : 0,
            redeem_queue                       : v4,
            interest_rate_ms                   : 0,
            last_interest_rate_updated_time_ms : 0,
            last_interest_updated_time_ms      : 0,
            config                             : 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::config::new_vault_config(arg1, arg3, arg4, arg2, arg5),
            liquidity_miner_admin              : v1,
            liquidity_miner_id                 : v3,
            wishes                             : 0x2::bag::new(arg6),
            version                            : 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::config::current_version(),
        };
        0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::global::register<T0, T1>(arg0, 0x2::object::id<Vault<T0, T1>>(&v6), arg6);
        (v6, v3)
    }

    public fun request_redeem<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::global::VaultRegistry, arg2: 0x2::coin::Coin<LPToken<T0, T1>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        ensure_version_matches<T0, T1>(arg0);
        0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::config::ensure_not_circuit_breaked(&arg0.config);
        accrue_interest<T0, T1>(arg0, arg1, arg3, arg4);
        let v0 = 0x2::coin::value<LPToken<T0, T1>>(&arg2);
        assert!(0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::math::convert_to_assets(v0, arg0.total_deposit, total_shares<T0, T1>(arg0)) >= 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::config::min_per_redeem(&arg0.config), 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::error::redeem_too_small());
        let v1 = store_new_request<T0, T1>(arg0, 0x2::tx_context::sender(arg4), arg2, 0x2::clock::timestamp_ms(arg3));
        0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::event::emit_redeem_requested(0x2::object::id<Vault<T0, T1>>(arg0), 0x2::tx_context::sender(arg4), v1, v0, 0x2::clock::timestamp_ms(arg3));
    }

    fun store_new_request<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: address, arg2: 0x2::coin::Coin<LPToken<T0, T1>>, arg3: u64) : u64 {
        let v0 = arg0.redeem_queue.next_request_id;
        let v1 = RedeemRequest<T0, T1>{
            who             : arg1,
            shares          : 0x2::coin::into_balance<LPToken<T0, T1>>(arg2),
            request_time_ms : arg3,
        };
        0x2::table::add<u64, RedeemRequest<T0, T1>>(&mut arg0.redeem_queue.table, v0, v1);
        arg0.redeem_queue.next_request_id = arg0.redeem_queue.next_request_id + 1;
        v0
    }

    public fun total_deposit<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.total_deposit
    }

    public fun total_redeem_requests<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::table::length<u64, RedeemRequest<T0, T1>>(&arg0.redeem_queue.table)
    }

    public fun total_shares<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::balance::supply_value<LPToken<T0, T1>>(&arg0.lp_supply)
    }

    public(friend) fun update_interest_rate<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::global::VaultRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        accrue_interest<T0, T1>(arg0, arg1, arg3, arg4);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 - arg0.last_interest_rate_updated_time_ms >= 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::config::interest_rate_update_min_interval_ms(borrow_config<T0, T1>(arg0)), 0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::error::rate_update_too_frequent());
        arg0.last_interest_rate_updated_time_ms = v0;
        arg0.interest_rate_ms = arg2;
        0x130bbd92b2d054c0969347f45292e9559051ec60dcf157bcc0c1aaefee27a35b::event::emit_interest_rate_updated(0x2::object::id<Vault<T0, T1>>(arg0), arg0.interest_rate_ms, arg2, 0x2::clock::timestamp_ms(arg3));
    }

    // decompiled from Move bytecode v7
}

