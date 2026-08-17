module 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::price {
    struct PriceFeed<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        base: 0x1::type_name::TypeName,
        quote: 0x1::type_name::TypeName,
        scale: u64,
        max_age_ms: u64,
        max_future_skew_ms: u64,
        max_deviation_bps: u64,
        min_price: u64,
        max_price: u64,
        last_price: u64,
        last_source_ts_ms: u64,
        last_sequence: u64,
        last_applied_ms: u64,
        observations: u64,
        paused: bool,
    }

    struct PriceReceipt {
        vault_id: 0x2::object::ID,
        feed_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        sequence: u64,
        price: u64,
        scale: u64,
        source_ts_ms: u64,
        applied_ms: u64,
    }

    public fun apply<T0, T1>(arg0: &mut PriceFeed<T0, T1>, arg1: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg2: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::StrategyBook<T1>, arg3: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultTradeCap<T1>, arg4: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock) : PriceReceipt {
        apply_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, decode_price(arg6, arg7, arg8), arg8, arg9)
    }

    public fun apply_aggregate<T0, T1>(arg0: &mut PriceFeed<T0, T1>, arg1: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg2: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::StrategyBook<T1>, arg3: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultTradeCap<T1>, arg4: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig, arg5: u64, arg6: 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::oracle::AggregatePrice, arg7: u64, arg8: &0x2::clock::Clock) : PriceReceipt {
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::assert_product_active(arg4, arg5, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::product_oracle());
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::assert_active_vault<T1>(arg1, arg4, arg5);
        assert_feed<T0, T1>(arg0, arg1, arg4);
        assert!(!arg0.paused, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_feed_paused());
        let v0 = 0x2::clock::timestamp_ms(arg8);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::assert_provider_active<T1>(arg2, arg1, arg3, v0);
        let v1 = 0x2::object::id<0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultTradeCap<T1>>(arg3);
        let (_, v3, v4, v5, _, _, v8) = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::oracle::consume_aggregate(arg6);
        assert!(v3 == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::id<T1>(arg1), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::oracle_mismatch());
        assert!(v5 == arg0.scale, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_bad_scale());
        assert!(arg7 > arg0.last_sequence, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_replay());
        assert!(v8 > arg0.last_source_ts_ms, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_replay());
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::consume_sequence<T1>(arg2, v1, arg7, v8);
        assert!(v4 > 0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_zero());
        assert!(v4 >= arg0.min_price && v4 <= arg0.max_price, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_out_of_bounds());
        let v9 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::deviation_bps(v4, arg0.last_price);
        if (arg0.last_price > 0) {
            assert!(v9 <= arg0.max_deviation_bps, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_deviation());
        };
        arg0.last_price = v4;
        arg0.last_sequence = arg7;
        arg0.last_source_ts_ms = v8;
        arg0.last_applied_ms = v0;
        arg0.observations = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::add(arg0.observations, 1);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::events::emit_price_applied(arg0.vault_id, 0x2::object::uid_to_inner(&arg0.id), v1, arg7, v4, v5, v8, v0, v9, arg0.observations);
        PriceReceipt{
            vault_id     : arg0.vault_id,
            feed_id      : 0x2::object::uid_to_inner(&arg0.id),
            cap_id       : v1,
            sequence     : arg7,
            price        : v4,
            scale        : v5,
            source_ts_ms : v8,
            applied_ms   : v0,
        }
    }

    public fun apply_clear<T0, T1>(arg0: &mut PriceFeed<T0, T1>, arg1: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg2: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::StrategyBook<T1>, arg3: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultTradeCap<T1>, arg4: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock) : PriceReceipt {
        apply_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    fun apply_internal<T0, T1>(arg0: &mut PriceFeed<T0, T1>, arg1: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg2: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::StrategyBook<T1>, arg3: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultTradeCap<T1>, arg4: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock) : PriceReceipt {
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::assert_product_active(arg4, arg5, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::product_oracle());
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::assert_active_vault<T1>(arg1, arg4, arg5);
        assert_feed<T0, T1>(arg0, arg1, arg4);
        assert!(!arg0.paused, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_feed_paused());
        let v0 = 0x2::clock::timestamp_ms(arg9);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::assert_provider_active<T1>(arg2, arg1, arg3, v0);
        let v1 = 0x2::object::id<0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultTradeCap<T1>>(arg3);
        assert!(arg6 > arg0.last_sequence, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_replay());
        assert!(arg8 > arg0.last_source_ts_ms, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_replay());
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::consume_sequence<T1>(arg2, v1, arg6, arg8);
        assert!(arg8 <= 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::add(v0, arg0.max_future_skew_ms), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_future_skew());
        assert!(0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::add(arg8, arg0.max_age_ms) >= v0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_stale());
        assert!(arg7 > 0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_zero());
        assert!(arg7 >= arg0.min_price && arg7 <= arg0.max_price, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_out_of_bounds());
        let v2 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::deviation_bps(arg7, arg0.last_price);
        if (arg0.last_price > 0) {
            assert!(v2 <= arg0.max_deviation_bps, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_deviation());
        };
        arg0.last_price = arg7;
        arg0.last_sequence = arg6;
        arg0.last_source_ts_ms = arg8;
        arg0.last_applied_ms = v0;
        arg0.observations = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::add(arg0.observations, 1);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::events::emit_price_applied(arg0.vault_id, 0x2::object::uid_to_inner(&arg0.id), v1, arg6, arg7, arg0.scale, arg8, v0, v2, arg0.observations);
        PriceReceipt{
            vault_id     : arg0.vault_id,
            feed_id      : 0x2::object::uid_to_inner(&arg0.id),
            cap_id       : v1,
            sequence     : arg6,
            price        : arg7,
            scale        : arg0.scale,
            source_ts_ms : arg8,
            applied_ms   : v0,
        }
    }

    public fun apply_observation<T0, T1>(arg0: &mut PriceFeed<T0, T1>, arg1: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg2: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::StrategyBook<T1>, arg3: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultTradeCap<T1>, arg4: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock) {
        discard(apply<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9), 0);
    }

    public fun assert_feed<T0, T1>(arg0: &PriceFeed<T0, T1>, arg1: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg2: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig) {
        assert!(arg0.vault_id == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::id<T1>(arg1), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_feed_mismatch());
        assert!(arg0.config_id == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::id(arg2), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_feed_mismatch());
    }

    public fun base_value_down(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 > 0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_zero());
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::mul_div(arg0, arg2, arg1)
    }

    public(friend) fun consume(arg0: PriceReceipt) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID, u64, u64, u64) {
        let PriceReceipt {
            vault_id     : v0,
            feed_id      : v1,
            cap_id       : v2,
            sequence     : v3,
            price        : v4,
            scale        : v5,
            source_ts_ms : _,
            applied_ms   : _,
        } = arg0;
        (v0, v1, v2, v3, v4, v5)
    }

    public fun create_feed<T0, T1>(arg0: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg1: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultAdminCap<T1>, arg2: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        share_feed<T0, T1>(new_feed<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10));
    }

    public fun decode_price(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg1 ^ mix(arg0, arg2)
    }

    public fun discard(arg0: PriceReceipt, arg1: u8) {
        let PriceReceipt {
            vault_id     : v0,
            feed_id      : v1,
            cap_id       : v2,
            sequence     : v3,
            price        : v4,
            scale        : _,
            source_ts_ms : _,
            applied_ms   : _,
        } = arg0;
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::events::emit_price_receipt_discarded(v0, v1, v2, v3, v4, arg1);
    }

    public fun discard_no_action() : u8 {
        1
    }

    public fun discard_observation_only() : u8 {
        0
    }

    public fun encode_price(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg1 ^ mix(arg0, arg2)
    }

    public fun feed_base<T0, T1>(arg0: &PriceFeed<T0, T1>) : 0x1::type_name::TypeName {
        arg0.base
    }

    public fun feed_id<T0, T1>(arg0: &PriceFeed<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun feed_max_age_ms<T0, T1>(arg0: &PriceFeed<T0, T1>) : u64 {
        arg0.max_age_ms
    }

    public fun feed_max_deviation_bps<T0, T1>(arg0: &PriceFeed<T0, T1>) : u64 {
        arg0.max_deviation_bps
    }

    public fun feed_max_future_skew_ms<T0, T1>(arg0: &PriceFeed<T0, T1>) : u64 {
        arg0.max_future_skew_ms
    }

    public fun feed_max_price<T0, T1>(arg0: &PriceFeed<T0, T1>) : u64 {
        arg0.max_price
    }

    public fun feed_min_price<T0, T1>(arg0: &PriceFeed<T0, T1>) : u64 {
        arg0.min_price
    }

    public fun feed_quote<T0, T1>(arg0: &PriceFeed<T0, T1>) : 0x1::type_name::TypeName {
        arg0.quote
    }

    public fun feed_scale<T0, T1>(arg0: &PriceFeed<T0, T1>) : u64 {
        arg0.scale
    }

    public fun feed_vault_id<T0, T1>(arg0: &PriceFeed<T0, T1>) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun is_feed_paused<T0, T1>(arg0: &PriceFeed<T0, T1>) : bool {
        arg0.paused
    }

    public fun last_applied_ms<T0, T1>(arg0: &PriceFeed<T0, T1>) : u64 {
        arg0.last_applied_ms
    }

    public fun last_price<T0, T1>(arg0: &PriceFeed<T0, T1>) : u64 {
        arg0.last_price
    }

    public fun last_sequence<T0, T1>(arg0: &PriceFeed<T0, T1>) : u64 {
        arg0.last_sequence
    }

    public fun last_source_ts_ms<T0, T1>(arg0: &PriceFeed<T0, T1>) : u64 {
        arg0.last_source_ts_ms
    }

    fun mix(arg0: u64, arg1: u64) : u64 {
        ((((arg0 as u128) * 11400714819323198485 % 18446744073709551616 + (arg1 as u128) * 13787848793156543929 % 18446744073709551616) % 18446744073709551616) as u64)
    }

    public fun new_feed<T0, T1>(arg0: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg1: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultAdminCap<T1>, arg2: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : PriceFeed<T0, T1> {
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::assert_governance_active(arg2, arg3);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::assert_admin<T1>(arg0, arg1);
        assert!(0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::config_id<T1>(arg0) == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::id(arg2), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::vault_mismatch());
        assert!(arg4 > 0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_bad_scale());
        validate_guards(arg2, arg5, arg6, arg7, arg8, arg9);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = PriceFeed<T0, T1>{
            id                 : 0x2::object::new(arg10),
            config_id          : 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::id(arg2),
            vault_id           : 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::id<T1>(arg0),
            base               : v0,
            quote              : v1,
            scale              : arg4,
            max_age_ms         : arg5,
            max_future_skew_ms : arg6,
            max_deviation_bps  : arg7,
            min_price          : arg8,
            max_price          : arg9,
            last_price         : 0,
            last_source_ts_ms  : 0,
            last_sequence      : 0,
            last_applied_ms    : 0,
            observations       : 0,
            paused             : false,
        };
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::events::emit_price_feed_created(0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::id<T1>(arg0), 0x2::object::uid_to_inner(&v2.id), v0, v1, arg4);
        v2
    }

    public fun observations<T0, T1>(arg0: &PriceFeed<T0, T1>) : u64 {
        arg0.observations
    }

    public fun quote_value_down(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_bad_scale());
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::mul_div(arg0, arg1, arg2)
    }

    public fun quote_value_up(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_bad_scale());
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::mul_div_ceil(arg0, arg1, arg2)
    }

    public fun receipt_applied_ms(arg0: &PriceReceipt) : u64 {
        arg0.applied_ms
    }

    public fun receipt_cap_id(arg0: &PriceReceipt) : 0x2::object::ID {
        arg0.cap_id
    }

    public fun receipt_feed_id(arg0: &PriceReceipt) : 0x2::object::ID {
        arg0.feed_id
    }

    public fun receipt_price(arg0: &PriceReceipt) : u64 {
        arg0.price
    }

    public fun receipt_scale(arg0: &PriceReceipt) : u64 {
        arg0.scale
    }

    public fun receipt_sequence(arg0: &PriceReceipt) : u64 {
        arg0.sequence
    }

    public fun receipt_source_ts_ms(arg0: &PriceReceipt) : u64 {
        arg0.source_ts_ms
    }

    public fun receipt_vault_id(arg0: &PriceReceipt) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun set_feed_paused<T0, T1>(arg0: &mut PriceFeed<T0, T1>, arg1: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg2: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultAdminCap<T1>, arg3: bool) {
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::assert_admin<T1>(arg1, arg2);
        assert!(arg0.vault_id == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::id<T1>(arg1), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_feed_mismatch());
        arg0.paused = arg3;
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::events::emit_price_feed_paused(0x2::object::uid_to_inner(&arg0.id), arg3);
    }

    public fun set_guards<T0, T1>(arg0: &mut PriceFeed<T0, T1>, arg1: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg2: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultAdminCap<T1>, arg3: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::assert_governance_active(arg3, arg4);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::assert_admin<T1>(arg1, arg2);
        assert_feed<T0, T1>(arg0, arg1, arg3);
        validate_guards(arg3, arg5, arg6, arg7, arg8, arg9);
        arg0.max_age_ms = arg5;
        arg0.max_future_skew_ms = arg6;
        arg0.max_deviation_bps = arg7;
        arg0.min_price = arg8;
        arg0.max_price = arg9;
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::events::emit_price_guards_updated(0x2::object::uid_to_inner(&arg0.id), arg5, arg6, arg7, arg8, arg9);
    }

    public fun share_feed<T0, T1>(arg0: PriceFeed<T0, T1>) {
        0x2::transfer::share_object<PriceFeed<T0, T1>>(arg0);
    }

    public fun submit_to_quorum<T0, T1>(arg0: &mut PriceFeed<T0, T1>, arg1: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg2: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::StrategyBook<T1>, arg3: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultTradeCap<T1>, arg4: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::oracle::OracleAggregator<T0, T1>, arg5: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::oracle::Quorum, arg6: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock) {
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::oracle::assert_aggregator<T0, T1>(arg4, arg1, arg6);
        assert!(0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::oracle::quorum_scale(arg5) == arg0.scale, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_bad_scale());
        let v0 = apply<T0, T1>(arg0, arg1, arg2, arg3, arg6, arg7, arg8, arg9, arg10, arg11);
        discard(v0, 0);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::oracle::push_sample<T0, T1>(arg4, arg5, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::oracle::source_lotus_signed(), v0.price, v0.source_ts_ms, arg11);
    }

    fun validate_guards(arg0: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::price_guard_config(arg0);
        assert!(arg1 > 0 && arg1 <= 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::guard_max_age_ms_ceiling(v0), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_bad_guard());
        assert!(arg2 <= 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::guard_max_future_skew_ms_ceiling(v0), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_bad_guard());
        assert!(arg3 > 0 && arg3 <= 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::guard_max_deviation_bps_ceiling(v0), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_bad_guard());
        assert!(arg4 > 0 && arg5 >= arg4, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_bad_guard());
    }

    // decompiled from Move bytecode v7
}

