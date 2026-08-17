module 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::oracle {
    struct SourceConfig has copy, drop, store {
        enabled: bool,
        max_age_ms: u64,
        weight: u64,
        accepted: u64,
        rejected: u64,
    }

    struct OracleAggregator<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        scale: u64,
        min_sources: u8,
        max_spread_bps: u64,
        min_price: u64,
        max_price: u64,
        sources: vector<SourceConfig>,
        last_price: u64,
        last_observed_ms: u64,
        aggregations: u64,
        paused: bool,
    }

    struct Quorum {
        aggregator_id: 0x2::object::ID,
        scale: u64,
        prices: vector<u64>,
        source_mask: u32,
        oldest_ts_ms: u64,
        started_ms: u64,
    }

    struct AggregatePrice {
        aggregator_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        price: u64,
        scale: u64,
        sources_used: u8,
        source_mask: u32,
        spread_bps: u64,
        observed_ms: u64,
    }

    public fun abandon(arg0: Quorum) {
        let Quorum {
            aggregator_id : _,
            scale         : _,
            prices        : _,
            source_mask   : _,
            oldest_ts_ms  : _,
            started_ms    : _,
        } = arg0;
    }

    public fun aggregations<T0, T1>(arg0: &OracleAggregator<T0, T1>) : u64 {
        arg0.aggregations
    }

    public fun aggregator_id<T0, T1>(arg0: &OracleAggregator<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun aggregator_last_observed_ms<T0, T1>(arg0: &OracleAggregator<T0, T1>) : u64 {
        arg0.last_observed_ms
    }

    public fun aggregator_last_price<T0, T1>(arg0: &OracleAggregator<T0, T1>) : u64 {
        arg0.last_price
    }

    public fun aggregator_max_price<T0, T1>(arg0: &OracleAggregator<T0, T1>) : u64 {
        arg0.max_price
    }

    public fun aggregator_min_price<T0, T1>(arg0: &OracleAggregator<T0, T1>) : u64 {
        arg0.min_price
    }

    public fun aggregator_scale<T0, T1>(arg0: &OracleAggregator<T0, T1>) : u64 {
        arg0.scale
    }

    public fun aggregator_vault_id<T0, T1>(arg0: &OracleAggregator<T0, T1>) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun assert_aggregator<T0, T1>(arg0: &OracleAggregator<T0, T1>, arg1: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::vault::Vault<T1>, arg2: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::LotusConfig) {
        assert!(arg0.vault_id == 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::vault::id<T1>(arg1), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::oracle_mismatch());
        assert!(arg0.config_id == 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::id(arg2), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::oracle_mismatch());
    }

    public fun assert_catalog_source(arg0: u8) {
        assert!(is_catalog_source(arg0), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::oracle_source_unknown());
    }

    public fun begin<T0, T1>(arg0: &OracleAggregator<T0, T1>, arg1: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::LotusConfig, arg2: u64, arg3: &0x2::clock::Clock) : Quorum {
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::assert_product_active(arg1, arg2, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::product_oracle());
        assert!(arg0.config_id == 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::id(arg1), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::oracle_mismatch());
        assert!(!arg0.paused, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::oracle_source_disabled());
        Quorum{
            aggregator_id : 0x2::object::uid_to_inner(&arg0.id),
            scale         : arg0.scale,
            prices        : 0x1::vector::empty<u64>(),
            source_mask   : 0,
            oldest_ts_ms  : 0,
            started_ms    : 0x2::clock::timestamp_ms(arg3),
        }
    }

    public fun configure_source<T0, T1>(arg0: &mut OracleAggregator<T0, T1>, arg1: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::vault::Vault<T1>, arg2: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::vault::VaultAdminCap<T1>, arg3: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::LotusConfig, arg4: u64, arg5: u8, arg6: bool, arg7: u64, arg8: u64) {
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::assert_governance_active(arg3, arg4);
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::vault::assert_admin<T1>(arg1, arg2);
        assert_aggregator<T0, T1>(arg0, arg1, arg3);
        assert_catalog_source(arg5);
        if (arg6) {
            assert!(arg7 > 0, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::oracle_bad_param());
            assert!(arg7 <= 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::guard_max_age_ms_ceiling(0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::price_guard_config(arg3)), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::oracle_bad_param());
        };
        let v0 = 0x1::vector::borrow_mut<SourceConfig>(&mut arg0.sources, ((arg5 - 1) as u64));
        v0.enabled = arg6;
        v0.max_age_ms = arg7;
        v0.weight = arg8;
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::events::emit_oracle_source_configured(0x2::object::uid_to_inner(&arg0.id), arg5, arg6, arg7, arg8);
    }

    public(friend) fun consume_aggregate(arg0: AggregatePrice) : (0x2::object::ID, 0x2::object::ID, u64, u64, u8, u32, u64) {
        let AggregatePrice {
            aggregator_id : v0,
            vault_id      : v1,
            price         : v2,
            scale         : v3,
            sources_used  : v4,
            source_mask   : v5,
            spread_bps    : _,
            observed_ms   : v7,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v7)
    }

    public fun create_aggregator<T0, T1>(arg0: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::vault::Vault<T1>, arg1: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::vault::VaultAdminCap<T1>, arg2: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::LotusConfig, arg3: u64, arg4: u64, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        share_aggregator<T0, T1>(new_aggregator<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9));
    }

    public fun discard_aggregate(arg0: AggregatePrice) {
        let AggregatePrice {
            aggregator_id : _,
            vault_id      : _,
            price         : _,
            scale         : _,
            sources_used  : _,
            source_mask   : _,
            spread_bps    : _,
            observed_ms   : _,
        } = arg0;
    }

    fun empty_source() : SourceConfig {
        SourceConfig{
            enabled    : false,
            max_age_ms : 0,
            weight     : 0,
            accepted   : 0,
            rejected   : 0,
        }
    }

    public fun enabled_source_count<T0, T1>(arg0: &OracleAggregator<T0, T1>) : u8 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<SourceConfig>(&arg0.sources)) {
            if (0x1::vector::borrow<SourceConfig>(&arg0.sources, v1).enabled) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun finalize<T0, T1>(arg0: &mut OracleAggregator<T0, T1>, arg1: Quorum, arg2: &0x2::clock::Clock) : AggregatePrice {
        let Quorum {
            aggregator_id : v0,
            scale         : v1,
            prices        : v2,
            source_mask   : v3,
            oldest_ts_ms  : v4,
            started_ms    : _,
        } = arg1;
        let v6 = v2;
        assert!(v0 == 0x2::object::uid_to_inner(&arg0.id), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::oracle_mismatch());
        let v7 = 0x1::vector::length<u64>(&v6);
        assert!(v7 > 0, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::oracle_no_samples());
        assert!(v7 >= (arg0.min_sources as u64), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::oracle_quorum());
        let v8 = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::deviation_bps(*0x1::vector::borrow<u64>(&v6, v7 - 1), *0x1::vector::borrow<u64>(&v6, 0));
        assert!(v8 <= arg0.max_spread_bps, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::oracle_spread());
        let v9 = median(&v6);
        let v10 = 0x2::clock::timestamp_ms(arg2);
        arg0.last_price = v9;
        arg0.last_observed_ms = v10;
        arg0.aggregations = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::add(arg0.aggregations, 1);
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::events::emit_oracle_aggregated(v0, v9, v1, (v7 as u8), v3, v8, v4, v10);
        AggregatePrice{
            aggregator_id : v0,
            vault_id      : arg0.vault_id,
            price         : v9,
            scale         : v1,
            sources_used  : (v7 as u8),
            source_mask   : v3,
            spread_bps    : v8,
            observed_ms   : v10,
        }
    }

    fun insert_sorted(arg0: &mut vector<u64>, arg1: u64) {
        let v0 = 0x1::vector::length<u64>(arg0);
        let v1 = 0;
        while (v1 < v0 && *0x1::vector::borrow<u64>(arg0, v1) <= arg1) {
            v1 = v1 + 1;
        };
        0x1::vector::push_back<u64>(arg0, arg1);
        while (v0 > v1) {
            0x1::vector::swap<u64>(arg0, v0, v0 - 1);
            v0 = v0 - 1;
        };
    }

    public fun is_catalog_source(arg0: u8) : bool {
        arg0 >= 1 && arg0 <= 4
    }

    public fun is_paused<T0, T1>(arg0: &OracleAggregator<T0, T1>) : bool {
        arg0.paused
    }

    public fun max_source_decimals() : u8 {
        30
    }

    public fun max_spread_bps<T0, T1>(arg0: &OracleAggregator<T0, T1>) : u64 {
        arg0.max_spread_bps
    }

    fun median(arg0: &vector<u64>) : u64 {
        let v0 = 0x1::vector::length<u64>(arg0);
        if (v0 % 2 == 1) {
            *0x1::vector::borrow<u64>(arg0, v0 / 2)
        } else {
            let v2 = *0x1::vector::borrow<u64>(arg0, v0 / 2 - 1);
            v2 + (*0x1::vector::borrow<u64>(arg0, v0 / 2) - v2) / 2
        }
    }

    public fun min_sources<T0, T1>(arg0: &OracleAggregator<T0, T1>) : u8 {
        arg0.min_sources
    }

    public fun name_of(arg0: u8) : vector<u8> {
        assert_catalog_source(arg0);
        if (arg0 == 1) {
            b"pyth"
        } else if (arg0 == 2) {
            b"switchboard"
        } else if (arg0 == 3) {
            b"supra"
        } else {
            b"lotus_signed"
        }
    }

    public fun new_aggregator<T0, T1>(arg0: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::vault::Vault<T1>, arg1: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::vault::VaultAdminCap<T1>, arg2: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::LotusConfig, arg3: u64, arg4: u64, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : OracleAggregator<T0, T1> {
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::assert_governance_active(arg2, arg3);
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::vault::assert_admin<T1>(arg0, arg1);
        assert!(0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::vault::config_id<T1>(arg0) == 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::id(arg2), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::vault_mismatch());
        assert!(arg4 > 0, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::price_bad_scale());
        assert!(arg5 >= 1 && arg5 <= 4, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::oracle_bad_param());
        assert!(arg6 > 0 && arg6 <= 10000, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::oracle_bad_param());
        assert!(arg7 > 0 && arg8 >= arg7, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::oracle_bad_param());
        let v0 = 0x1::vector::empty<SourceConfig>();
        let v1 = 0;
        while (v1 < 4) {
            0x1::vector::push_back<SourceConfig>(&mut v0, empty_source());
            v1 = v1 + 1;
        };
        OracleAggregator<T0, T1>{
            id               : 0x2::object::new(arg9),
            config_id        : 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::id(arg2),
            vault_id         : 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::vault::id<T1>(arg0),
            scale            : arg4,
            min_sources      : arg5,
            max_spread_bps   : arg6,
            min_price        : arg7,
            max_price        : arg8,
            sources          : v0,
            last_price       : 0,
            last_observed_ms : 0,
            aggregations     : 0,
            paused           : false,
        }
    }

    public fun normalize_decimals(arg0: u128, arg1: u8, arg2: u64) : u64 {
        assert!(arg2 > 0, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::price_bad_scale());
        assert!(arg1 <= 30, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::oracle_bad_param());
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg1) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        let v2 = (arg0 as u256) * (arg2 as u256) / v0;
        assert!(v2 <= 18446744073709551615, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::overflow());
        (v2 as u64)
    }

    public fun price(arg0: &AggregatePrice) : u64 {
        arg0.price
    }

    public fun price_aggregator_id(arg0: &AggregatePrice) : 0x2::object::ID {
        arg0.aggregator_id
    }

    public fun price_observed_ms(arg0: &AggregatePrice) : u64 {
        arg0.observed_ms
    }

    public fun price_scale(arg0: &AggregatePrice) : u64 {
        arg0.scale
    }

    public fun price_source_mask(arg0: &AggregatePrice) : u32 {
        arg0.source_mask
    }

    public fun price_sources_used(arg0: &AggregatePrice) : u8 {
        arg0.sources_used
    }

    public fun price_spread_bps(arg0: &AggregatePrice) : u64 {
        arg0.spread_bps
    }

    public fun price_vault_id(arg0: &AggregatePrice) : 0x2::object::ID {
        arg0.vault_id
    }

    public(friend) fun push_sample<T0, T1>(arg0: &mut OracleAggregator<T0, T1>, arg1: &mut Quorum, arg2: u8, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        assert_catalog_source(arg2);
        assert!(arg1.aggregator_id == 0x2::object::uid_to_inner(&arg0.id), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::oracle_mismatch());
        assert!(!quorum_has_source(arg1, arg2), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::oracle_duplicate_source());
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x1::vector::borrow_mut<SourceConfig>(&mut arg0.sources, ((arg2 - 1) as u64));
        let v2 = if (!v1.enabled) {
            1
        } else if (arg4 > v0 || 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::add(arg4, v1.max_age_ms) < v0) {
            2
        } else if (arg3 < arg0.min_price || arg3 > arg0.max_price) {
            3
        } else {
            0
        };
        if (v2 != 0) {
            v1.rejected = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::add(v1.rejected, 1);
            0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::events::emit_oracle_sample_rejected(0x2::object::uid_to_inner(&arg0.id), arg2, arg3, v2);
            return
        };
        v1.accepted = 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::math::add(v1.accepted, 1);
        let v3 = &mut arg1.prices;
        insert_sorted(v3, arg3);
        arg1.source_mask = arg1.source_mask | source_mask(arg2);
        if (arg1.oldest_ts_ms == 0 || arg4 < arg1.oldest_ts_ms) {
            arg1.oldest_ts_ms = arg4;
        };
    }

    public fun quorum_has_source(arg0: &Quorum, arg1: u8) : bool {
        arg0.source_mask & source_mask(arg1) != 0
    }

    public fun quorum_scale(arg0: &Quorum) : u64 {
        arg0.scale
    }

    public fun quorum_size(arg0: &Quorum) : u64 {
        0x1::vector::length<u64>(&arg0.prices)
    }

    public fun quorum_source_mask(arg0: &Quorum) : u32 {
        arg0.source_mask
    }

    public fun reject_disabled() : u8 {
        1
    }

    public fun reject_out_of_bounds() : u8 {
        3
    }

    public fun reject_stale() : u8 {
        2
    }

    public fun set_bounds<T0, T1>(arg0: &mut OracleAggregator<T0, T1>, arg1: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::vault::Vault<T1>, arg2: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::vault::VaultAdminCap<T1>, arg3: u64, arg4: u64) {
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::vault::assert_admin<T1>(arg1, arg2);
        assert!(arg0.vault_id == 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::vault::id<T1>(arg1), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::oracle_mismatch());
        assert!(arg3 > 0 && arg4 >= arg3, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::oracle_bad_param());
        arg0.min_price = arg3;
        arg0.max_price = arg4;
    }

    public fun set_paused<T0, T1>(arg0: &mut OracleAggregator<T0, T1>, arg1: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::vault::Vault<T1>, arg2: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::vault::VaultAdminCap<T1>, arg3: bool) {
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::vault::assert_admin<T1>(arg1, arg2);
        assert!(arg0.vault_id == 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::vault::id<T1>(arg1), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::oracle_mismatch());
        arg0.paused = arg3;
    }

    public fun set_threshold<T0, T1>(arg0: &mut OracleAggregator<T0, T1>, arg1: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::vault::Vault<T1>, arg2: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::vault::VaultAdminCap<T1>, arg3: &0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::LotusConfig, arg4: u64, arg5: u8, arg6: u64) {
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::config::assert_governance_active(arg3, arg4);
        0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::vault::assert_admin<T1>(arg1, arg2);
        assert_aggregator<T0, T1>(arg0, arg1, arg3);
        assert!(arg5 >= 1 && arg5 <= 4, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::oracle_bad_param());
        assert!(arg6 > 0 && arg6 <= 10000, 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::oracle_bad_param());
        assert!(arg5 <= enabled_source_count<T0, T1>(arg0), 0xbaac71ca31fe804138df7928426a3c785cb8944514c6e4265fe03e13d001c509::errors::oracle_bad_param());
        arg0.min_sources = arg5;
        arg0.max_spread_bps = arg6;
    }

    public fun share_aggregator<T0, T1>(arg0: OracleAggregator<T0, T1>) {
        0x2::transfer::share_object<OracleAggregator<T0, T1>>(arg0);
    }

    public fun source_config<T0, T1>(arg0: &OracleAggregator<T0, T1>, arg1: u8) : SourceConfig {
        assert_catalog_source(arg1);
        *0x1::vector::borrow<SourceConfig>(&arg0.sources, ((arg1 - 1) as u64))
    }

    public fun source_count() : u8 {
        4
    }

    public fun source_lotus_signed() : u8 {
        4
    }

    public fun source_mask(arg0: u8) : u32 {
        assert_catalog_source(arg0);
        1 << arg0 - 1
    }

    public fun source_pyth() : u8 {
        1
    }

    public fun source_supra() : u8 {
        3
    }

    public fun source_switchboard() : u8 {
        2
    }

    public fun src_accepted(arg0: &SourceConfig) : u64 {
        arg0.accepted
    }

    public fun src_enabled(arg0: &SourceConfig) : bool {
        arg0.enabled
    }

    public fun src_max_age_ms(arg0: &SourceConfig) : u64 {
        arg0.max_age_ms
    }

    public fun src_rejected(arg0: &SourceConfig) : u64 {
        arg0.rejected
    }

    public fun src_weight(arg0: &SourceConfig) : u64 {
        arg0.weight
    }

    // decompiled from Move bytecode v7
}

