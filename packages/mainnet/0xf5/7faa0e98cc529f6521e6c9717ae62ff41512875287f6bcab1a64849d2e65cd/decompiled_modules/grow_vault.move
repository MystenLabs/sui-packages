module 0xf57faa0e98cc529f6521e6c9717ae62ff41512875287f6bcab1a64849d2e65cd::grow_vault {
    struct GrowVault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T1>,
        perf_fee_bps: u64,
        management_fee_bps: u64,
        withdrawal_fee_bps: u64,
        debt: u64,
        anticipated_profits: u64,
        last_update_ms: u64,
        cooldown_time_ms: u64,
        last_fee_checkpoint_ms: u64,
        last_fee_checkpoint_sp: u64,
    }

    fun burn<T0, T1>(arg0: &mut GrowVault<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        0x2::coin::burn<T1>(&mut arg0.treasury_cap, arg1);
    }

    fun mint<T0, T1>(arg0: &mut GrowVault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::mint<T1>(&mut arg0.treasury_cap, arg1, arg2)
    }

    public fun anticipated_profits<T0, T1>(arg0: &GrowVault<T0, T1>) : u64 {
        arg0.anticipated_profits
    }

    fun compute_fees_internal<T0, T1>(arg0: &GrowVault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : (u64, u64, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg2) - arg0.last_fee_checkpoint_ms;
        if (v0 == 0) {
            return (0, 0, 0)
        };
        let v1 = share_price_internal(0x2::coin::total_supply<T1>(&arg0.treasury_cap), arg1);
        let v2 = 0x1::u64::max(arg0.last_fee_checkpoint_sp, v1) - arg0.last_fee_checkpoint_sp;
        if (v2 == 0) {
            return (0, 0, 0)
        };
        let v3 = v1 * arg0.management_fee_bps * v0 / 10000 / 31536000000;
        let v4 = v3;
        let v5 = v2 * arg0.perf_fee_bps / 10000;
        if (v3 + v5 > v2) {
            v4 = v2 - v5;
        };
        (v5 * arg1 / v1, v4 * arg1 / v1, v2)
    }

    public fun convert_to_assets<T0, T1>(arg0: u64, arg1: &GrowVault<T0, T1>, arg2: &0x2::clock::Clock) : u64 {
        convert_to_assets_internal(arg0, 0x2::coin::total_supply<T1>(&arg1.treasury_cap), total_assets<T0, T1>(arg1, arg2))
    }

    fun convert_to_assets_internal(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            arg0
        } else {
            arg0 * 1000000000 * arg2 / arg1 / 1000000000
        }
    }

    public fun convert_to_shares<T0, T1>(arg0: u64, arg1: &GrowVault<T0, T1>, arg2: &0x2::clock::Clock) : u64 {
        convert_to_shares_internal(arg0, 0x2::coin::total_supply<T1>(&arg1.treasury_cap), total_assets<T0, T1>(arg1, arg2))
    }

    fun convert_to_shares_internal(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            arg0
        } else {
            arg0 * 1000000000 * arg1 / arg2 / 1000000000
        }
    }

    public fun cooldown_time_ms<T0, T1>(arg0: &GrowVault<T0, T1>) : u64 {
        arg0.cooldown_time_ms
    }

    public(friend) fun create_vault<T0, T1>(arg0: 0x2::coin::TreasuryCap<T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 < 10000, 9223372238718500869);
        let v0 = GrowVault<T0, T1>{
            id                     : 0x2::object::new(arg5),
            treasury_cap           : arg0,
            perf_fee_bps           : arg1,
            management_fee_bps     : arg2,
            withdrawal_fee_bps     : arg3,
            debt                   : 0,
            anticipated_profits    : 0,
            last_update_ms         : 0,
            cooldown_time_ms       : arg4,
            last_fee_checkpoint_ms : 0,
            last_fee_checkpoint_sp : 1000000000,
        };
        0xf57faa0e98cc529f6521e6c9717ae62ff41512875287f6bcab1a64849d2e65cd::events::vault_created(0x2::object::id_address<GrowVault<T0, T1>>(&v0), 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>());
        0x2::transfer::share_object<GrowVault<T0, T1>>(v0);
    }

    public fun current_fees<T0, T1>(arg0: &GrowVault<T0, T1>, arg1: &0x2::clock::Clock) : (u64, u64, u64) {
        compute_fees_internal<T0, T1>(arg0, total_assets<T0, T1>(arg0, arg1), arg1)
    }

    public fun debt<T0, T1>(arg0: &GrowVault<T0, T1>) : u64 {
        arg0.debt
    }

    public fun finalize_deposit<T0, T1>(arg0: &mut GrowVault<T0, T1>, arg1: &mut 0xf260c8a53a573e65f289147a9072836e02e171290e94af391877cee2c913bc3a::session_flow::SessionFlow<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0xf57faa0e98cc529f6521e6c9717ae62ff41512875287f6bcab1a64849d2e65cd::version::Version, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xf57faa0e98cc529f6521e6c9717ae62ff41512875287f6bcab1a64849d2e65cd::version::assert_current_version(arg3);
        assert!(0xf260c8a53a573e65f289147a9072836e02e171290e94af391877cee2c913bc3a::session_flow::can_consoom<T0, T1>(arg1), 9223372384747257859);
        assert!(0xf260c8a53a573e65f289147a9072836e02e171290e94af391877cee2c913bc3a::session_flow::is_deposit<T0, T1>(arg1), 9223372389042094081);
        let v0 = 0xf260c8a53a573e65f289147a9072836e02e171290e94af391877cee2c913bc3a::session_flow::value<T0, T1>(arg1);
        let v1 = convert_to_shares_internal(v0, 0x2::coin::total_supply<T1>(&arg0.treasury_cap), total_assets<T0, T1>(arg0, arg2));
        arg0.debt = arg0.debt + v0;
        0xf57faa0e98cc529f6521e6c9717ae62ff41512875287f6bcab1a64849d2e65cd::events::deposit(0x2::object::id_address<GrowVault<T0, T1>>(arg0), v0, v1, 0x2::tx_context::sender(arg4));
        0xf260c8a53a573e65f289147a9072836e02e171290e94af391877cee2c913bc3a::session_flow::allow_consoom<T0, T1>(&arg0.id, arg1);
        mint<T0, T1>(arg0, v1, arg4)
    }

    public fun initiate_withdrawal<T0, T1>(arg0: &mut GrowVault<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &0xf57faa0e98cc529f6521e6c9717ae62ff41512875287f6bcab1a64849d2e65cd::version::Version) : 0xf260c8a53a573e65f289147a9072836e02e171290e94af391877cee2c913bc3a::session_flow::SessionFlow<T0, T1> {
        0xf57faa0e98cc529f6521e6c9717ae62ff41512875287f6bcab1a64849d2e65cd::version::assert_current_version(arg3);
        let v0 = convert_to_assets_internal(0x2::coin::value<T1>(&arg1), 0x2::coin::total_supply<T1>(&arg0.treasury_cap), total_assets<T0, T1>(arg0, arg2));
        let v1 = v0;
        burn<T0, T1>(arg0, arg1);
        if (arg0.withdrawal_fee_bps > 0) {
            v1 = v0 * (10000 - withdrawal_fee_bps<T0, T1>(arg0)) / 10000;
        };
        arg0.debt = arg0.debt - v1;
        0xf260c8a53a573e65f289147a9072836e02e171290e94af391877cee2c913bc3a::session_flow::create_session<T0, T1>(&arg0.id, 0xf260c8a53a573e65f289147a9072836e02e171290e94af391877cee2c913bc3a::session_flow::withdrawal_kind(), v1)
    }

    public fun last_fee_checkpoint_ms<T0, T1>(arg0: &GrowVault<T0, T1>) : u64 {
        arg0.last_fee_checkpoint_ms
    }

    public fun last_fee_checkpoint_sp<T0, T1>(arg0: &GrowVault<T0, T1>) : u64 {
        arg0.last_fee_checkpoint_sp
    }

    public fun last_update_ms<T0, T1>(arg0: &GrowVault<T0, T1>) : u64 {
        arg0.last_update_ms
    }

    public fun management_fee_bps<T0, T1>(arg0: &GrowVault<T0, T1>) : u64 {
        arg0.management_fee_bps
    }

    public fun mut_id<T0, T1>(arg0: &0x66c4cf6e3c354c3f94db0d0b5a4de306767928e24f13023fd7f374a3a0dc0719::admin::AdminCap, arg1: &mut GrowVault<T0, T1>) : &mut 0x2::object::UID {
        &mut arg1.id
    }

    public fun perf_fee_bps<T0, T1>(arg0: &GrowVault<T0, T1>) : u64 {
        arg0.perf_fee_bps
    }

    public fun share_price<T0, T1>(arg0: &GrowVault<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        share_price_internal(0x2::coin::total_supply<T1>(&arg0.treasury_cap), total_assets<T0, T1>(arg0, arg1))
    }

    fun share_price_internal(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            1000000000
        } else {
            arg1 * 1000000000 / arg0
        }
    }

    public fun take_fees<T0, T1>(arg0: &0x66c4cf6e3c354c3f94db0d0b5a4de306767928e24f13023fd7f374a3a0dc0719::admin::AdminCap, arg1: &mut GrowVault<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0xf57faa0e98cc529f6521e6c9717ae62ff41512875287f6bcab1a64849d2e65cd::version::Version, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xf57faa0e98cc529f6521e6c9717ae62ff41512875287f6bcab1a64849d2e65cd::version::assert_current_version(arg3);
        let v0 = total_assets<T0, T1>(arg1, arg2);
        let (v1, v2, v3) = compute_fees_internal<T0, T1>(arg1, v0, arg2);
        if (v3 == 0) {
            return 0x2::coin::zero<T1>(arg4)
        };
        let v4 = convert_to_shares_internal(v1 + v2, 0x2::coin::total_supply<T1>(&arg1.treasury_cap), v0);
        update_fee_checkpoint<T0, T1>(arg1, v0, arg2);
        0xf57faa0e98cc529f6521e6c9717ae62ff41512875287f6bcab1a64849d2e65cd::events::fees_taken(0x2::object::id_address<GrowVault<T0, T1>>(arg1), v1, v2, v4);
        mint<T0, T1>(arg1, v4, arg4)
    }

    public fun total_assets<T0, T1>(arg0: &GrowVault<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        arg0.debt - unrealized_gains<T0, T1>(arg0, arg1)
    }

    public fun treasury_cap<T0, T1>(arg0: &GrowVault<T0, T1>) : &0x2::coin::TreasuryCap<T1> {
        &arg0.treasury_cap
    }

    public fun unrealized_gains<T0, T1>(arg0: &GrowVault<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        if (arg0.last_update_ms + arg0.cooldown_time_ms > 0x2::clock::timestamp_ms(arg1)) {
            0
        } else {
            anticipated_profits<T0, T1>(arg0) - 1000000000 * anticipated_profits<T0, T1>(arg0) * (0x2::clock::timestamp_ms(arg1) - arg0.last_update_ms) / arg0.cooldown_time_ms / 1000000000
        }
    }

    public fun update_debt<T0, T1>(arg0: &0x66c4cf6e3c354c3f94db0d0b5a4de306767928e24f13023fd7f374a3a0dc0719::admin::AdminCap, arg1: &mut GrowVault<T0, T1>, arg2: u64, arg3: &0xf57faa0e98cc529f6521e6c9717ae62ff41512875287f6bcab1a64849d2e65cd::version::Version, arg4: &0x2::clock::Clock) {
        0xf57faa0e98cc529f6521e6c9717ae62ff41512875287f6bcab1a64849d2e65cd::version::assert_current_version(arg3);
        let v0 = unrealized_gains<T0, T1>(arg1, arg4);
        let v1 = arg1.debt;
        arg1.debt = arg2;
        let v2 = arg2 - 0x1::u64::min(v1, arg2);
        if (v2 > 0) {
            arg1.anticipated_profits = v2 + v0;
            arg1.last_update_ms = 0x2::clock::timestamp_ms(arg4);
        };
        0xf57faa0e98cc529f6521e6c9717ae62ff41512875287f6bcab1a64849d2e65cd::events::assets_updated(0x2::object::id_address<GrowVault<T0, T1>>(arg1), v1, arg2, v0);
    }

    fun update_fee_checkpoint<T0, T1>(arg0: &mut GrowVault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) {
        arg0.last_fee_checkpoint_ms = 0x2::clock::timestamp_ms(arg2);
        arg0.last_fee_checkpoint_sp = share_price_internal(arg1, 0x2::coin::total_supply<T1>(&arg0.treasury_cap));
    }

    public fun vault_id<T0, T1>(arg0: &GrowVault<T0, T1>) : &0x2::object::UID {
        &arg0.id
    }

    public fun withdrawal_fee_bps<T0, T1>(arg0: &GrowVault<T0, T1>) : u64 {
        arg0.withdrawal_fee_bps
    }

    // decompiled from Move bytecode v6
}

