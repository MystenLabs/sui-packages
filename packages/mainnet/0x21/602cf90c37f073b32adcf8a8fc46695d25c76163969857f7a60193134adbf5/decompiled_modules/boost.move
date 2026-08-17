module 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::boost {
    struct BoostTicket<phantom T0, phantom T1> {
        vault_id: 0x2::object::ID,
        controls_id: 0x2::object::ID,
        venue: u8,
        venue_kind: u8,
        cap_id: 0x2::object::ID,
        sequence: u64,
        principal_quote: u64,
        min_return_quote: u64,
        ref_price: u64,
        price_scale: u64,
        slippage_bps: u64,
        deadline_ms: u64,
    }

    fun assert_settlement<T0, T1>(arg0: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg1: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::VenueControls<T0, T1>, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: &0x2::clock::Clock) {
        assert!(arg2 == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::id<T1>(arg0), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::boost_ticket_mismatch());
        assert!(arg3 == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::controls_id<T0, T1>(arg1), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::boost_ticket_mismatch());
        assert!(0x2::clock::timestamp_ms(arg5) <= arg4, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::boost_deadline());
    }

    fun authorize<T0, T1>(arg0: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg1: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::VenueControls<T0, T1>, arg2: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::StrategyBook<T1>, arg3: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultTradeCap<T1>, arg4: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig, arg5: u64, arg6: 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::price::PriceReceipt, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock) : (0x2::object::ID, u64, u64, u64, u8, u64) {
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::assert_product_active(arg4, arg5, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::product_trade());
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::assert_active_vault<T1>(arg0, arg4, arg5);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::assert_controls<T0, T1>(arg1, arg0, arg4);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::assert_strategy_book<T1>(arg2, arg0);
        let v0 = 0x2::clock::timestamp_ms(arg11);
        assert!(v0 <= arg10, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::boost_deadline());
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::assert_provider_active<T1>(arg2, arg0, arg3, v0);
        let v1 = 0x2::object::id<0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultTradeCap<T1>>(arg3);
        let (v2, _, v4, v5, v6, v7) = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::price::consume(arg6);
        assert!(v2 == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::id<T1>(arg0), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_receipt_mismatch());
        assert!(v4 == v1, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::price_receipt_mismatch());
        let (v8, v9) = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::open_position<T0, T1>(arg1, arg4, arg7, arg8);
        let v10 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::min(0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::charge_notional<T1>(arg2, v1, arg7, arg8, v0), v9);
        assert!(arg9 >= slippage_floor(arg8, v10), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::slippage_exceeded());
        (v1, v5, v6, v7, v8, v10)
    }

    public fun can_route<T0>(arg0: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::StrategyBook<T0>, arg1: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig, arg2: 0x2::object::ID, arg3: u8) : bool {
        if (0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::is_product_active(arg1, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::product_trade())) {
            if (0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::is_venue_allowed(arg1, arg3)) {
                provider_venue_mask<T0>(arg0, arg2) & 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::venue_mask(arg3) != 0
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun dry_run_quote<T0, T1>(arg0: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg1: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::VenueControls<T0, T1>, arg2: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::StrategyBook<T1>, arg3: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultTradeCap<T1>, arg4: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig, arg5: u64, arg6: 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::price::PriceReceipt, arg7: u8, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock) {
        let (v0, v1) = open_quote<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg8, arg9, arg10);
        settle_quote<T0, T1>(arg0, arg1, v1, v0, arg10);
    }

    fun finish<T0, T1>(arg0: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg1: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::VenueControls<T0, T1>, arg2: u8, arg3: 0x2::object::ID, arg4: u64, arg5: 0x1::type_name::TypeName, arg6: u64, arg7: u64, arg8: u64) {
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::close_position<T0, T1>(arg1, arg2, arg7);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::strategy_settle_principal<T1>(arg0, arg7, arg8);
        let v0 = if (arg8 > arg7) {
            arg8 - arg7
        } else {
            0
        };
        let v1 = if (arg8 < arg7) {
            arg7 - arg8
        } else {
            0
        };
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::events::emit_boost_settled(0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::id<T1>(arg0), arg2, arg3, arg4, arg5, arg6, arg7, arg8, v0, v1);
    }

    public fun open_base<T0, T1>(arg0: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg1: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::VenueControls<T0, T1>, arg2: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::StrategyBook<T1>, arg3: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultTradeCap<T1>, arg4: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig, arg5: u64, arg6: 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::price::PriceReceipt, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, BoostTicket<T0, T1>) {
        assert!(arg8 > 0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::boost_zero_amount());
        let v0 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::price::quote_value_up(arg8, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::price::receipt_price(&arg6), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::price::receipt_scale(&arg6));
        assert!(v0 > 0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::boost_zero_amount());
        let (v1, v2, v3, v4, v5, v6) = authorize<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, v0, arg9, arg10, arg11);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::events::emit_boost_opened(0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::id<T1>(arg0), arg7, v1, v2, 0x1::type_name::with_defining_ids<T0>(), arg8, v0, arg9, v3, arg10);
        let v7 = BoostTicket<T0, T1>{
            vault_id         : 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::id<T1>(arg0),
            controls_id      : 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::controls_id<T0, T1>(arg1),
            venue            : arg7,
            venue_kind       : v5,
            cap_id           : v1,
            sequence         : v2,
            principal_quote  : v0,
            min_return_quote : arg9,
            ref_price        : v3,
            price_scale      : v4,
            slippage_bps     : v6,
            deadline_ms      : arg10,
        };
        (0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::strategy_take_aux<T1, T0>(arg0, arg8, v0), v7)
    }

    public fun open_quote<T0, T1>(arg0: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg1: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::VenueControls<T0, T1>, arg2: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::StrategyBook<T1>, arg3: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultTradeCap<T1>, arg4: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig, arg5: u64, arg6: 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::price::PriceReceipt, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock) : (0x2::balance::Balance<T1>, BoostTicket<T0, T1>) {
        assert!(arg8 > 0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::boost_zero_amount());
        let (v0, v1, v2, v3, v4, v5) = authorize<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::events::emit_boost_opened(0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::id<T1>(arg0), arg7, v0, v1, 0x1::type_name::with_defining_ids<T1>(), arg8, arg8, arg9, v2, arg10);
        let v6 = BoostTicket<T0, T1>{
            vault_id         : 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::id<T1>(arg0),
            controls_id      : 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::controls_id<T0, T1>(arg1),
            venue            : arg7,
            venue_kind       : v4,
            cap_id           : v0,
            sequence         : v1,
            principal_quote  : arg8,
            min_return_quote : arg9,
            ref_price        : v2,
            price_scale      : v3,
            slippage_bps     : v5,
            deadline_ms      : arg10,
        };
        (0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::strategy_take_quote<T1>(arg0, arg8), v6)
    }

    public fun preview<T0, T1>(arg0: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::VenueControls<T0, T1>, arg1: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::StrategyBook<T1>, arg2: 0x2::object::ID, arg3: u8, arg4: u64) : (u8, u64, u64) {
        let v0 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::control<T0, T1>(arg0, arg3);
        let v1 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::policy<T1>(arg1, arg2);
        let v2 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::min(0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::policy_max_slippage_bps(&v1), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::ctl_max_slippage_bps(&v0));
        (0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::kind_of(arg3), v2, slippage_floor(arg4, v2))
    }

    public fun provider_venue_mask<T0>(arg0: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::StrategyBook<T0>, arg1: 0x2::object::ID) : u32 {
        let v0 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::policy<T0>(arg0, arg1);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::strategy::policy_venue_mask(&v0)
    }

    public fun recognition_ceiling(arg0: u64, arg1: u64) : u64 {
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::add(arg0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::bps(arg0, arg1))
    }

    public fun settle_base<T0, T1>(arg0: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg1: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::VenueControls<T0, T1>, arg2: BoostTicket<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock) {
        let BoostTicket {
            vault_id         : v0,
            controls_id      : v1,
            venue            : v2,
            venue_kind       : _,
            cap_id           : v4,
            sequence         : v5,
            principal_quote  : v6,
            min_return_quote : v7,
            ref_price        : v8,
            price_scale      : v9,
            slippage_bps     : v10,
            deadline_ms      : v11,
        } = arg2;
        assert_settlement<T0, T1>(arg0, arg1, v0, v1, v11, arg4);
        let v12 = 0x2::balance::value<T0>(&arg3);
        let v13 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::min(0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::price::quote_value_down(v12, v8, v9), recognition_ceiling(v6, v10));
        assert!(v13 >= v7, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::boost_min_return());
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::strategy_put_aux<T1, T0>(arg0, arg3);
        finish<T0, T1>(arg0, arg1, v2, v4, v5, 0x1::type_name::with_defining_ids<T0>(), v12, v6, v13);
    }

    public fun settle_quote<T0, T1>(arg0: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg1: &mut 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::VenueControls<T0, T1>, arg2: BoostTicket<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock) {
        let BoostTicket {
            vault_id         : v0,
            controls_id      : v1,
            venue            : v2,
            venue_kind       : _,
            cap_id           : v4,
            sequence         : v5,
            principal_quote  : v6,
            min_return_quote : v7,
            ref_price        : _,
            price_scale      : _,
            slippage_bps     : _,
            deadline_ms      : v11,
        } = arg2;
        assert_settlement<T0, T1>(arg0, arg1, v0, v1, v11, arg4);
        let v12 = 0x2::balance::value<T1>(&arg3);
        assert!(v12 >= v7, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::boost_min_return());
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::strategy_put_quote<T1>(arg0, arg3);
        finish<T0, T1>(arg0, arg1, v2, v4, v5, 0x1::type_name::with_defining_ids<T1>(), v12, v6, v12);
    }

    public fun slippage_floor(arg0: u64, arg1: u64) : u64 {
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::sub(arg0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::bps(arg0, arg1))
    }

    public fun ticket_cap_id<T0, T1>(arg0: &BoostTicket<T0, T1>) : 0x2::object::ID {
        arg0.cap_id
    }

    public fun ticket_controls_id<T0, T1>(arg0: &BoostTicket<T0, T1>) : 0x2::object::ID {
        arg0.controls_id
    }

    public fun ticket_deadline_ms<T0, T1>(arg0: &BoostTicket<T0, T1>) : u64 {
        arg0.deadline_ms
    }

    public fun ticket_min_return_quote<T0, T1>(arg0: &BoostTicket<T0, T1>) : u64 {
        arg0.min_return_quote
    }

    public fun ticket_price_scale<T0, T1>(arg0: &BoostTicket<T0, T1>) : u64 {
        arg0.price_scale
    }

    public fun ticket_principal_quote<T0, T1>(arg0: &BoostTicket<T0, T1>) : u64 {
        arg0.principal_quote
    }

    public fun ticket_ref_price<T0, T1>(arg0: &BoostTicket<T0, T1>) : u64 {
        arg0.ref_price
    }

    public fun ticket_sequence<T0, T1>(arg0: &BoostTicket<T0, T1>) : u64 {
        arg0.sequence
    }

    public fun ticket_slippage_bps<T0, T1>(arg0: &BoostTicket<T0, T1>) : u64 {
        arg0.slippage_bps
    }

    public fun ticket_vault_id<T0, T1>(arg0: &BoostTicket<T0, T1>) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun ticket_venue<T0, T1>(arg0: &BoostTicket<T0, T1>) : u8 {
        arg0.venue
    }

    public fun ticket_venue_kind<T0, T1>(arg0: &BoostTicket<T0, T1>) : u8 {
        arg0.venue_kind
    }

    // decompiled from Move bytecode v7
}

