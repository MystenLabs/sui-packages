module 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry {
    struct FeeConfig has copy, drop, store {
        mint_fee_bps: u16,
        redeem_fee_bps: u16,
        streaming_fee_bps_per_year: u16,
        performance_fee_bps: u16,
    }

    struct IndexRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        methodology_hash: vector<u8>,
        next_methodology_hash: vector<u8>,
        methodology_unlock_ts_ms: u64,
        paused: bool,
        operator: address,
        allowed_routers: vector<address>,
        max_leg_slippage_bps: u16,
        max_oracle_deviation_bps: u16,
        max_notional_per_leg_usd_micro: u64,
        tvl_cap_usd_micro: u64,
        fees: FeeConfig,
    }

    public fun add_allowed_router(arg0: &mut IndexRegistry, arg1: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::admin::AdminCap, arg2: address) {
        if (0x1::vector::contains<address>(&arg0.allowed_routers, &arg2)) {
            return
        };
        assert!(0x1::vector::length<address>(&arg0.allowed_routers) < 32, 16);
        0x1::vector::push_back<address>(&mut arg0.allowed_routers, arg2);
        0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::emit_router_added(0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::new_router_added(0x2::object::uid_to_inner(&arg0.id), arg2));
    }

    public fun allowed_routers(arg0: &IndexRegistry) : vector<address> {
        arg0.allowed_routers
    }

    public fun apply_methodology(arg0: &mut IndexRegistry, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.methodology_unlock_ts_ms, 9);
        assert!(0x1::vector::length<u8>(&arg0.next_methodology_hash) == 32, 11);
        let v0 = arg0.next_methodology_hash;
        arg0.methodology_hash = v0;
        arg0.next_methodology_hash = b"";
        arg0.methodology_unlock_ts_ms = 0;
        0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::emit_methodology_applied(0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::new_methodology_applied(0x2::object::uid_to_inner(&arg0.id), v0, 0x2::clock::timestamp_ms(arg1)));
    }

    public fun create(arg0: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::admin::AdminCap, arg1: vector<u8>, arg2: address, arg3: vector<address>, arg4: u16, arg5: u16, arg6: u64, arg7: u64, arg8: u16, arg9: u16, arg10: u16, arg11: u16, arg12: &mut 0x2::tx_context::TxContext) : IndexRegistry {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 11);
        assert!(0x1::vector::length<address>(&arg3) <= 32, 16);
        assert!(arg4 <= 10000, 11);
        assert!(arg5 <= 10000, 11);
        assert!(arg8 <= 200, 11);
        assert!(arg9 <= 200, 11);
        assert!(arg10 <= 500, 11);
        assert!(arg11 <= 3000, 11);
        let v0 = FeeConfig{
            mint_fee_bps               : arg8,
            redeem_fee_bps             : arg9,
            streaming_fee_bps_per_year : arg10,
            performance_fee_bps        : arg11,
        };
        IndexRegistry{
            id                             : 0x2::object::new(arg12),
            version                        : 1,
            methodology_hash               : arg1,
            next_methodology_hash          : b"",
            methodology_unlock_ts_ms       : 0,
            paused                         : false,
            operator                       : arg2,
            allowed_routers                : arg3,
            max_leg_slippage_bps           : arg4,
            max_oracle_deviation_bps       : arg5,
            max_notional_per_leg_usd_micro : arg6,
            tvl_cap_usd_micro              : arg7,
            fees                           : v0,
        }
    }

    public fun is_paused(arg0: &IndexRegistry) : bool {
        arg0.paused
    }

    public fun is_router_allowed(arg0: &IndexRegistry, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.allowed_routers, &arg1)
    }

    public fun max_leg_slippage_bps(arg0: &IndexRegistry) : u16 {
        arg0.max_leg_slippage_bps
    }

    public fun max_notional_per_leg_usd_micro(arg0: &IndexRegistry) : u64 {
        arg0.max_notional_per_leg_usd_micro
    }

    public fun max_oracle_deviation_bps(arg0: &IndexRegistry) : u16 {
        arg0.max_oracle_deviation_bps
    }

    public fun methodology_hash(arg0: &IndexRegistry) : vector<u8> {
        arg0.methodology_hash
    }

    public fun methodology_unlock_ts_ms(arg0: &IndexRegistry) : u64 {
        arg0.methodology_unlock_ts_ms
    }

    public fun mint_fee_bps(arg0: &IndexRegistry) : u16 {
        arg0.fees.mint_fee_bps
    }

    public fun next_methodology_hash(arg0: &IndexRegistry) : vector<u8> {
        arg0.next_methodology_hash
    }

    public fun operator(arg0: &IndexRegistry) : address {
        arg0.operator
    }

    public fun pause(arg0: &mut IndexRegistry, arg1: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::admin::GuardianCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        arg0.paused = true;
        0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::emit_pause_changed(0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::new_pause_changed(0x2::object::uid_to_inner(&arg0.id), true, 0x2::tx_context::sender(arg3), 0x2::clock::timestamp_ms(arg2)));
    }

    public fun performance_fee_bps(arg0: &IndexRegistry) : u16 {
        arg0.fees.performance_fee_bps
    }

    public fun propose_methodology(arg0: &mut IndexRegistry, arg1: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::admin::AdminCap, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 11);
        let v0 = 0x2::clock::timestamp_ms(arg3) + 86400000;
        arg0.next_methodology_hash = arg2;
        arg0.methodology_unlock_ts_ms = v0;
        0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::emit_methodology_proposed(0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::new_methodology_proposed(0x2::object::uid_to_inner(&arg0.id), arg2, v0));
    }

    public fun redeem_fee_bps(arg0: &IndexRegistry) : u16 {
        arg0.fees.redeem_fee_bps
    }

    public fun remove_allowed_router(arg0: &mut IndexRegistry, arg1: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::admin::AdminCap, arg2: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.allowed_routers, &arg2);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.allowed_routers, v1);
            0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::emit_router_removed(0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::new_router_removed(0x2::object::uid_to_inner(&arg0.id), arg2));
        };
    }

    public fun rotate_operator(arg0: &mut IndexRegistry, arg1: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::admin::AdminCap, arg2: address) {
        arg0.operator = arg2;
        0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::emit_operator_rotated(0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::new_operator_rotated(0x2::object::uid_to_inner(&arg0.id), arg0.operator, arg2));
    }

    public fun share(arg0: IndexRegistry) {
        0x2::transfer::share_object<IndexRegistry>(arg0);
    }

    public fun streaming_fee_bps_per_year(arg0: &IndexRegistry) : u16 {
        arg0.fees.streaming_fee_bps_per_year
    }

    public fun tvl_cap_usd_micro(arg0: &IndexRegistry) : u64 {
        arg0.tvl_cap_usd_micro
    }

    public fun unpause(arg0: &mut IndexRegistry, arg1: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::admin::GuardianCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        arg0.paused = false;
        0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::emit_pause_changed(0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::events::new_pause_changed(0x2::object::uid_to_inner(&arg0.id), false, 0x2::tx_context::sender(arg3), 0x2::clock::timestamp_ms(arg2)));
    }

    public fun version(arg0: &IndexRegistry) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

