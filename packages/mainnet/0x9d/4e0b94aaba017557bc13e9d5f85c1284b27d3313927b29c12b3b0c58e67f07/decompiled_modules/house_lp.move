module 0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::house_lp {
    struct HouseLP<phantom T0> has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        total_shares: u128,
        protocol_fee_bps: u64,
        hwm_price_ray: u128,
        protocol_shares: u128,
        lock_duration_ms: u64,
        max_exposure_bps: u64,
        tvl_cap: u64,
        pending_fee_bps: u64,
        pending_fee_effective_at_ms: u64,
    }

    struct HousePosition<phantom T0> has store, key {
        id: 0x2::object::UID,
        house_lp_id: 0x2::object::ID,
        shares: u128,
        locked_until_ms: u64,
    }

    public entry fun admin_redeem_protocol_shares<T0>(arg0: &0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::AdminCap, arg1: &mut 0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::Vault<T0>, arg2: &mut HouseLP<T0>, arg3: u128, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::Vault<T0>>(arg1) == arg2.vault_id, 501);
        let v0 = house_equity<T0>(arg1);
        crystallize_fee<T0>(arg2, v0);
        assert!(arg3 > 0 && arg3 <= arg2.protocol_shares, 504);
        let v1 = mul_div_floor(arg3, (v0 as u128) + 1, arg2.total_shares + 1000);
        assert!(v1 <= 18446744073709551615, 509);
        let v2 = (v1 as u64);
        assert!(v2 > 0, 506);
        arg2.total_shares = arg2.total_shares - arg3;
        arg2.protocol_shares = arg2.protocol_shares - arg3;
        0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::events::emit_house_redeem(0x2::object::id<HouseLP<T0>>(arg2), arg2.vault_id, arg4, arg3, v2, arg2.total_shares, house_equity<T0>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::take_for_lp_redeem<T0>(arg1, v2, arg5), arg4);
    }

    public entry fun admin_seed_genesis<T0>(arg0: &0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::AdminCap, arg1: &0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::Vault<T0>, arg2: &mut HouseLP<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = seed_genesis_inner<T0>(arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<HousePosition<T0>>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun apply_protocol_fee_bps<T0>(arg0: &0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::AdminCap, arg1: &mut HouseLP<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.pending_fee_effective_at_ms != 0, 514);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.pending_fee_effective_at_ms, 515);
        let v0 = arg1.pending_fee_bps;
        assert!(v0 <= 2000, 513);
        arg1.protocol_fee_bps = v0;
        arg1.pending_fee_bps = 0;
        arg1.pending_fee_effective_at_ms = 0;
        0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::events::emit_house_config_changed(0x2::object::id<HouseLP<T0>>(arg1), b"protocol_fee_bps", arg1.protocol_fee_bps, v0, 0x2::tx_context::sender(arg3));
    }

    public(friend) fun assert_within_exposure<T0>(arg0: &HouseLP<T0>, arg1: &0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::Vault<T0>, arg2: u64) {
        if (arg0.max_exposure_bps == 0) {
            return
        };
        assert!(0x2::object::id<0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::Vault<T0>>(arg1) == arg0.vault_id, 501);
        assert!((arg2 as u128) <= mul_div_floor((house_equity<T0>(arg1) as u128), (arg0.max_exposure_bps as u128), (10000 as u128)), 508);
    }

    public fun assets_for_shares<T0>(arg0: &HouseLP<T0>, arg1: &0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::Vault<T0>, arg2: u128) : u64 {
        let v0 = mul_div_floor(arg2, (house_equity<T0>(arg1) as u128) + 1, arg0.total_shares + 1000);
        assert!(v0 <= 18446744073709551615, 509);
        (v0 as u64)
    }

    public entry fun create_house_lp<T0>(arg0: &0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::AdminCap, arg1: &0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::Vault<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 2000, 513);
        assert!(arg4 <= 10000, 511);
        let v0 = HouseLP<T0>{
            id                          : 0x2::object::new(arg6),
            vault_id                    : 0x2::object::id<0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::Vault<T0>>(arg1),
            total_shares                : 0,
            protocol_fee_bps            : arg2,
            hwm_price_ray               : 0,
            protocol_shares             : 0,
            lock_duration_ms            : arg3,
            max_exposure_bps            : arg4,
            tvl_cap                     : arg5,
            pending_fee_bps             : 0,
            pending_fee_effective_at_ms : 0,
        };
        0x2::transfer::share_object<HouseLP<T0>>(v0);
    }

    fun crystallize_fee<T0>(arg0: &mut HouseLP<T0>, arg1: u64) {
        let v0 = price_ray<T0>(arg0, arg1);
        if (arg0.total_shares == 0) {
            arg0.hwm_price_ray = v0;
            return
        };
        if (v0 <= arg0.hwm_price_ray) {
            return
        };
        if (arg0.protocol_fee_bps == 0) {
            arg0.hwm_price_ray = v0;
            return
        };
        let v1 = mul_div_floor(mul_div_floor(v0 - arg0.hwm_price_ray, arg0.total_shares, 1000000000), (arg0.protocol_fee_bps as u128), (10000 as u128));
        if (v1 == 0) {
            arg0.hwm_price_ray = v0;
            return
        };
        let v2 = mul_div_floor(v1, arg0.total_shares + 1000, (arg1 as u128) + 1);
        arg0.total_shares = arg0.total_shares + v2;
        arg0.protocol_shares = arg0.protocol_shares + v2;
        arg0.hwm_price_ray = price_ray<T0>(arg0, arg1);
        0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::events::emit_house_fee_crystallized(0x2::object::id<HouseLP<T0>>(arg0), arg0.vault_id, v2, arg0.protocol_shares, arg0.hwm_price_ray);
    }

    public entry fun deposit_as_house<T0>(arg0: &mut 0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::Vault<T0>, arg1: &mut HouseLP<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = deposit_as_house_inner<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<HousePosition<T0>>(v0, 0x2::tx_context::sender(arg4));
    }

    fun deposit_as_house_inner<T0>(arg0: &mut 0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::Vault<T0>, arg1: &mut HouseLP<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : HousePosition<T0> {
        assert!(0x2::object::id<0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::Vault<T0>>(arg0) == arg1.vault_id, 501);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 500);
        let v1 = house_equity<T0>(arg0);
        crystallize_fee<T0>(arg1, v1);
        if (arg1.tvl_cap > 0) {
            assert!((v1 as u128) + (v0 as u128) <= (arg1.tvl_cap as u128), 507);
        };
        let v2 = mul_div_floor((v0 as u128), arg1.total_shares + 1000, (v1 as u128) + 1);
        assert!(v2 > 0, 505);
        0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::deposit<T0>(arg0, arg2, arg4);
        arg1.total_shares = arg1.total_shares + v2;
        let v3 = 0x2::clock::timestamp_ms(arg3) + arg1.lock_duration_ms;
        let v4 = HousePosition<T0>{
            id              : 0x2::object::new(arg4),
            house_lp_id     : 0x2::object::id<HouseLP<T0>>(arg1),
            shares          : v2,
            locked_until_ms : v3,
        };
        0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::events::emit_house_deposit(0x2::object::id<HouseLP<T0>>(arg1), arg1.vault_id, 0x2::tx_context::sender(arg4), v0, v2, arg1.total_shares, house_equity<T0>(arg0), v3, 0x2::object::id<HousePosition<T0>>(&v4));
        v4
    }

    public fun fee_increase_timelock_ms() : u64 {
        172800000
    }

    public fun house_equity<T0>(arg0: &0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::Vault<T0>) : u64 {
        let v0 = 0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::balance_value<T0>(arg0);
        let v1 = 0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::p2p_escrowed<T0>(arg0);
        if (v0 > v1) {
            v0 - v1
        } else {
            0
        }
    }

    public fun hwm_price_ray<T0>(arg0: &HouseLP<T0>) : u128 {
        arg0.hwm_price_ray
    }

    public fun lock_duration_ms<T0>(arg0: &HouseLP<T0>) : u64 {
        arg0.lock_duration_ms
    }

    public fun max_exposure_bps<T0>(arg0: &HouseLP<T0>) : u64 {
        arg0.max_exposure_bps
    }

    public fun max_protocol_fee_bps() : u64 {
        2000
    }

    fun mul_div_floor(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 > 0, 510);
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= 340282366920938463463374607431768211455, 509);
        (v0 as u128)
    }

    public fun pending_fee_bps<T0>(arg0: &HouseLP<T0>) : u64 {
        arg0.pending_fee_bps
    }

    public fun pending_fee_effective_at_ms<T0>(arg0: &HouseLP<T0>) : u64 {
        arg0.pending_fee_effective_at_ms
    }

    public fun position_house_lp_id<T0>(arg0: &HousePosition<T0>) : 0x2::object::ID {
        arg0.house_lp_id
    }

    public fun position_locked_until_ms<T0>(arg0: &HousePosition<T0>) : u64 {
        arg0.locked_until_ms
    }

    public fun position_shares<T0>(arg0: &HousePosition<T0>) : u128 {
        arg0.shares
    }

    public fun price_ray<T0>(arg0: &HouseLP<T0>, arg1: u64) : u128 {
        mul_div_floor((arg1 as u128) + 1, 1000000000, arg0.total_shares + 1000)
    }

    public fun protocol_fee_bps<T0>(arg0: &HouseLP<T0>) : u64 {
        arg0.protocol_fee_bps
    }

    public fun protocol_shares<T0>(arg0: &HouseLP<T0>) : u128 {
        arg0.protocol_shares
    }

    fun redeem_core<T0>(arg0: &mut 0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::Vault<T0>, arg1: &mut HouseLP<T0>, arg2: &mut HousePosition<T0>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::object::id<0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::Vault<T0>>(arg0) == arg1.vault_id, 501);
        assert!(arg2.house_lp_id == 0x2::object::id<HouseLP<T0>>(arg1), 502);
        assert!(0x2::clock::timestamp_ms(arg4) >= arg2.locked_until_ms, 503);
        assert!(arg3 > 0 && arg3 <= arg2.shares, 504);
        let v0 = house_equity<T0>(arg0);
        crystallize_fee<T0>(arg1, v0);
        let v1 = mul_div_floor(arg3, (v0 as u128) + 1, arg1.total_shares + 1000);
        assert!(v1 <= 18446744073709551615, 509);
        let v2 = (v1 as u64);
        assert!(v2 > 0, 506);
        arg1.total_shares = arg1.total_shares - arg3;
        arg2.shares = arg2.shares - arg3;
        0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::events::emit_house_redeem(0x2::object::id<HouseLP<T0>>(arg1), arg1.vault_id, 0x2::tx_context::sender(arg5), arg3, v2, arg1.total_shares, house_equity<T0>(arg0));
        0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::take_for_lp_redeem<T0>(arg0, v2, arg5)
    }

    public entry fun redeem_house_all<T0>(arg0: &mut 0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::Vault<T0>, arg1: &mut HouseLP<T0>, arg2: HousePosition<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg2;
        let v1 = redeem_core<T0>(arg0, arg1, v0, arg2.shares, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg4));
        let HousePosition {
            id              : v2,
            house_lp_id     : _,
            shares          : _,
            locked_until_ms : _,
        } = arg2;
        0x2::object::delete(v2);
    }

    public entry fun redeem_house_partial<T0>(arg0: &mut 0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::Vault<T0>, arg1: &mut HouseLP<T0>, arg2: &mut HousePosition<T0>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = redeem_core<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg5));
    }

    fun seed_genesis_inner<T0>(arg0: &0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::Vault<T0>, arg1: &mut HouseLP<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : HousePosition<T0> {
        assert!(0x2::object::id<0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::Vault<T0>>(arg0) == arg1.vault_id, 501);
        assert!(arg1.total_shares == 0, 512);
        let v0 = house_equity<T0>(arg0);
        assert!(v0 > 0, 500);
        let v1 = (v0 as u128) * 1000;
        arg1.total_shares = v1;
        arg1.hwm_price_ray = price_ray<T0>(arg1, v0);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = HousePosition<T0>{
            id              : 0x2::object::new(arg3),
            house_lp_id     : 0x2::object::id<HouseLP<T0>>(arg1),
            shares          : v1,
            locked_until_ms : v2,
        };
        0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::events::emit_house_deposit(0x2::object::id<HouseLP<T0>>(arg1), arg1.vault_id, 0x2::tx_context::sender(arg3), v0, v1, arg1.total_shares, v0, v2, 0x2::object::id<HousePosition<T0>>(&v3));
        v3
    }

    public entry fun set_lock_duration_ms<T0>(arg0: &0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::AdminCap, arg1: &mut HouseLP<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        arg1.lock_duration_ms = arg2;
        0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::events::emit_house_config_changed(0x2::object::id<HouseLP<T0>>(arg1), b"lock_duration_ms", arg1.lock_duration_ms, arg2, 0x2::tx_context::sender(arg3));
    }

    public entry fun set_max_exposure_bps<T0>(arg0: &0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::AdminCap, arg1: &mut HouseLP<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2 <= 10000, 511);
        arg1.max_exposure_bps = arg2;
        0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::events::emit_house_config_changed(0x2::object::id<HouseLP<T0>>(arg1), b"max_exposure_bps", arg1.max_exposure_bps, arg2, 0x2::tx_context::sender(arg3));
    }

    public entry fun set_protocol_fee_bps<T0>(arg0: &0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::AdminCap, arg1: &mut HouseLP<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg2 <= 2000, 513);
        let v0 = arg1.protocol_fee_bps;
        if (arg2 <= v0) {
            arg1.protocol_fee_bps = arg2;
            arg1.pending_fee_bps = 0;
            arg1.pending_fee_effective_at_ms = 0;
            0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::events::emit_house_config_changed(0x2::object::id<HouseLP<T0>>(arg1), b"protocol_fee_bps", v0, arg2, 0x2::tx_context::sender(arg4));
        } else {
            arg1.pending_fee_bps = arg2;
            arg1.pending_fee_effective_at_ms = 0x2::clock::timestamp_ms(arg3) + 172800000;
            0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::events::emit_house_config_changed(0x2::object::id<HouseLP<T0>>(arg1), b"pending_fee_bps", v0, arg2, 0x2::tx_context::sender(arg4));
        };
    }

    public entry fun set_tvl_cap<T0>(arg0: &0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::AdminCap, arg1: &mut HouseLP<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        arg1.tvl_cap = arg2;
        0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::events::emit_house_config_changed(0x2::object::id<HouseLP<T0>>(arg1), b"tvl_cap", arg1.tvl_cap, arg2, 0x2::tx_context::sender(arg3));
    }

    public fun share_price_ray<T0>(arg0: &HouseLP<T0>, arg1: &0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::vault::Vault<T0>) : u128 {
        price_ray<T0>(arg0, house_equity<T0>(arg1))
    }

    public fun total_shares<T0>(arg0: &HouseLP<T0>) : u128 {
        arg0.total_shares
    }

    public fun tvl_cap<T0>(arg0: &HouseLP<T0>) : u64 {
        arg0.tvl_cap
    }

    public fun vault_id<T0>(arg0: &HouseLP<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    // decompiled from Move bytecode v7
}

