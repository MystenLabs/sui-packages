module 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::vault {
    struct RedeemRequest<phantom T0, phantom T1> has store {
        requester: address,
        recipient: address,
        shares: 0x2::balance::Balance<LPToken<T0, T1>>,
        request_time_ms: u64,
    }

    struct RedeemQueue<phantom T0, phantom T1> has store {
        table: 0x2::table::Table<u64, RedeemRequest<T0, T1>>,
        next_request_id: u64,
    }

    struct LPToken<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        idle_liquidity: 0x2::balance::Balance<T1>,
        lp_supply: 0x2::balance::Supply<LPToken<T0, T1>>,
        total_deposit: u64,
        redeem_queue: RedeemQueue<T0, T1>,
        interest_rate_ms: u64,
        last_interest_rate_updated_time_ms: u64,
        last_interest_updated_time_ms: u64,
        config: 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::config::VaultConfig,
        liquidity_miner_admin: 0xf97c8e0837131b4fc9f29eddfce7e9790bae9ceec1d7d465eddfea521a661f6b::liquidity_miner::AdminCap,
        liquidity_miner_id: 0x2::object::ID,
        wishes: 0x2::bag::Bag,
        fee_earned: 0x2::balance::Balance<LPToken<T0, T1>>,
        version: u16,
    }

    fun accrue_interest<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = arg0.last_interest_updated_time_ms;
        let v1 = 0x2::clock::timestamp_ms(arg1);
        if (v1 == v0) {
            return
        };
        assert!(v1 > v0, 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::error::clock_went_backwards());
        let v2 = arg0.total_deposit;
        let v3 = (arg0.interest_rate_ms as u256) * ((v1 - v0) as u256) * (v2 as u256) / (0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::math::wad() as u256);
        assert!(v3 <= 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::math::u64_max() - (v2 as u256), 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::error::interest_overflow());
        let v4 = (v3 as u64);
        let v5 = 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::math::mul_div(v4, 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::config::performance_fee_bps(borrow_config<T0, T1>(arg0)), 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::math::max_bps());
        let v6 = v2 + v4 - v5;
        let v7 = 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::math::convert_to_shares(v5, v6, total_shares<T0, T1>(arg0));
        if (v7 != 0) {
            let v8 = 0x2::balance::increase_supply<LPToken<T0, T1>>(&mut arg0.lp_supply, v7);
            bank_performance_fee<T0, T1>(arg0, v8);
        };
        arg0.total_deposit = v6 + v5;
        arg0.last_interest_updated_time_ms = v1;
        0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::event::emit_interest_accrued(0x2::object::id<Vault<T0, T1>>(arg0), v2, arg0.total_deposit, v7, v1);
    }

    public(friend) fun bank_performance_fee<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<LPToken<T0, T1>>) {
        0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::event::emit_fee_earned(0x2::object::id<Vault<T0, T1>>(arg0), 0x1::type_name::with_defining_ids<LPToken<T0, T1>>(), 0x2::balance::value<LPToken<T0, T1>>(&arg1), 0x2::balance::join<LPToken<T0, T1>>(&mut arg0.fee_earned, arg1));
    }

    public(friend) fun borrow_config<T0, T1>(arg0: &Vault<T0, T1>) : &0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::config::VaultConfig {
        &arg0.config
    }

    public(friend) fun borrow_config_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : &mut 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::config::VaultConfig {
        &mut arg0.config
    }

    public(friend) fun borrow_wishes_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : &mut 0x2::bag::Bag {
        &mut arg0.wishes
    }

    public fun deposit<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LPToken<T0, T1>> {
        ensure_version_matches<T0, T1>(arg0);
        0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::config::ensure_not_circuit_breaked(&arg0.config);
        assert!(!0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::config::pause_deposit(&arg0.config), 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::error::deposit_paused());
        accrue_interest<T0, T1>(arg0, arg2);
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 >= 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::config::min_per_deposit(&arg0.config), 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::error::deposit_too_small());
        let v1 = 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::math::convert_to_shares(v0, arg0.total_deposit, total_shares<T0, T1>(arg0));
        assert!(v1 != 0, 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::error::zero_shares_not_allowed());
        arg0.total_deposit = arg0.total_deposit + v0;
        assert!(arg0.total_deposit <= 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::config::max_total_deposit(&arg0.config), 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::error::max_total_deposit_exceeded());
        0x2::balance::join<T1>(&mut arg0.idle_liquidity, 0x2::coin::into_balance<T1>(arg1));
        let v2 = 0x2::coin::from_balance<LPToken<T0, T1>>(0x2::balance::increase_supply<LPToken<T0, T1>>(&mut arg0.lp_supply, v1), arg3);
        0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::event::emit_deposit(0x2::object::id<Vault<T0, T1>>(arg0), 0x2::tx_context::sender(arg3), v0, 0x2::coin::value<LPToken<T0, T1>>(&v2), 0x2::clock::timestamp_ms(arg2));
        v2
    }

    public(friend) fun dump_performance_fee<T0, T1>(arg0: &mut Vault<T0, T1>) : 0x2::balance::Balance<LPToken<T0, T1>> {
        0x2::balance::split<LPToken<T0, T1>>(&mut arg0.fee_earned, 0x2::balance::value<LPToken<T0, T1>>(&arg0.fee_earned))
    }

    public(friend) fun empty_liquidity<T0, T1>(arg0: &mut Vault<T0, T1>) : 0x2::balance::Balance<T1> {
        0x2::balance::split<T1>(&mut arg0.idle_liquidity, 0x2::balance::value<T1>(&arg0.idle_liquidity))
    }

    public fun ensure_version_matches<T0, T1>(arg0: &Vault<T0, T1>) {
        assert!(arg0.version == 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::config::current_version(), 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::error::version_mismatch());
    }

    public(friend) fun fulfill_redeem<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: address, arg3: &0x2::clock::Clock) : (u64, u64) {
        accrue_interest<T0, T1>(arg0, arg3);
        assert!(0x2::table::contains<u64, RedeemRequest<T0, T1>>(&arg0.redeem_queue.table, arg1), 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::error::request_not_match());
        let RedeemRequest {
            requester       : _,
            recipient       : v1,
            shares          : v2,
            request_time_ms : _,
        } = 0x2::table::remove<u64, RedeemRequest<T0, T1>>(&mut arg0.redeem_queue.table, arg1);
        let v4 = v2;
        assert!(v1 == arg2, 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::error::request_not_match());
        let v5 = 0x2::balance::value<LPToken<T0, T1>>(&v4);
        let v6 = 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::math::convert_to_assets(v5, arg0.total_deposit, total_shares<T0, T1>(arg0));
        0x2::balance::decrease_supply<LPToken<T0, T1>>(&mut arg0.lp_supply, v4);
        arg0.total_deposit = arg0.total_deposit - v6;
        (v6, v5)
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

    public(friend) fun new_vault<T0, T1>(arg0: &mut 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::global::VaultGlobalConfig, arg1: 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::config::VaultParams, arg2: 0x2::object::ID, arg3: 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::config::FeeStructure, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID) {
        let (v0, v1) = 0xf97c8e0837131b4fc9f29eddfce7e9790bae9ceec1d7d465eddfea521a661f6b::liquidity_miner::new_liquidity_miner<LPToken<T0, T1>>(arg6);
        let v2 = v0;
        let v3 = 0x2::object::id<0xf97c8e0837131b4fc9f29eddfce7e9790bae9ceec1d7d465eddfea521a661f6b::liquidity_miner::LiquidityMiner<LPToken<T0, T1>>>(&v2);
        0x2::transfer::public_share_object<0xf97c8e0837131b4fc9f29eddfce7e9790bae9ceec1d7d465eddfea521a661f6b::liquidity_miner::LiquidityMiner<LPToken<T0, T1>>>(v2);
        let v4 = RedeemQueue<T0, T1>{
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
            config                             : 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::config::new_vault_config(arg1, arg3, arg4, arg2, arg5),
            liquidity_miner_admin              : v1,
            liquidity_miner_id                 : v3,
            wishes                             : 0x2::bag::new(arg6),
            fee_earned                         : 0x2::balance::zero<LPToken<T0, T1>>(),
            version                            : 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::config::current_version(),
        };
        let v7 = 0x2::object::id<Vault<T0, T1>>(&v6);
        0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::global::register<T0, T1>(arg0, v7, arg6);
        0x2::transfer::share_object<Vault<T0, T1>>(v6);
        (v7, v3)
    }

    public fun request_redeem<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<LPToken<T0, T1>>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg3);
        request_redeem_to_recipient<T0, T1>(arg0, arg1, v0, arg2, arg3)
    }

    public fun request_redeem_to_recipient<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<LPToken<T0, T1>>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        ensure_version_matches<T0, T1>(arg0);
        0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::config::ensure_not_circuit_breaked(&arg0.config);
        assert!(!0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::config::pause_redeem(&arg0.config), 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::error::redeem_paused());
        accrue_interest<T0, T1>(arg0, arg3);
        let v0 = 0x2::coin::value<LPToken<T0, T1>>(&arg1);
        assert!(v0 != 0, 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::error::no_zero_share_redeem());
        assert!(0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::math::convert_to_assets(v0, arg0.total_deposit, total_shares<T0, T1>(arg0)) >= 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::config::min_per_redeem(&arg0.config), 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::error::redeem_too_small());
        let v1 = store_new_request<T0, T1>(arg0, 0x2::tx_context::sender(arg4), arg2, arg1, 0x2::clock::timestamp_ms(arg3));
        0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::event::emit_redeem_requested(0x2::object::id<Vault<T0, T1>>(arg0), 0x2::tx_context::sender(arg4), arg2, v1, v0, 0x2::clock::timestamp_ms(arg3));
        v1
    }

    public(friend) fun set_version<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u16) {
        arg0.version = arg1;
    }

    fun store_new_request<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: address, arg2: address, arg3: 0x2::coin::Coin<LPToken<T0, T1>>, arg4: u64) : u64 {
        let v0 = arg0.redeem_queue.next_request_id;
        let v1 = RedeemRequest<T0, T1>{
            requester       : arg1,
            recipient       : arg2,
            shares          : 0x2::coin::into_balance<LPToken<T0, T1>>(arg3),
            request_time_ms : arg4,
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

    public(friend) fun update_fee<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::config::FeeStructure, arg2: &0x2::clock::Clock) {
        accrue_interest<T0, T1>(arg0, arg2);
        let v0 = borrow_config_mut<T0, T1>(arg0);
        0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::config::set_fees(v0, arg1);
        0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::event::emit_fee_updated(0x2::object::id<Vault<T0, T1>>(arg0), arg1, 0x2::clock::timestamp_ms(arg2));
    }

    public(friend) fun update_interest_rate<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) {
        accrue_interest<T0, T1>(arg0, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 - arg0.last_interest_rate_updated_time_ms >= 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::config::interest_rate_update_min_interval_ms(borrow_config<T0, T1>(arg0)), 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::error::rate_update_too_frequent());
        arg0.last_interest_rate_updated_time_ms = v0;
        arg0.interest_rate_ms = arg1;
        0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::event::emit_interest_rate_updated(0x2::object::id<Vault<T0, T1>>(arg0), arg0.interest_rate_ms, arg1, 0x2::clock::timestamp_ms(arg2));
    }

    public fun version<T0, T1>(arg0: &Vault<T0, T1>) : u16 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

