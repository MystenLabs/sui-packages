module 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::flash {
    struct FlashTicket<phantom T0> {
        vault_id: 0x2::object::ID,
        book_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        sequence: u64,
        notional_quote: u64,
        min_profit_quote: u64,
        ref_price: u64,
        deadline_ms: u64,
    }

    public fun allowance<T0>(arg0: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::strategy::StrategyBook<T0>, arg1: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::LotusConfig, arg2: 0x2::object::ID) : (bool, u64, u64) {
        let v0 = 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::strategy::policy<T0>(arg0, arg2);
        let v1 = if (0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::strategy::policy_may_flash(&v0)) {
            if (!0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::strategy::policy_paused(&v0)) {
                0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::is_product_active(arg1, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::product_trade())
            } else {
                false
            }
        } else {
            false
        };
        (v1, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::strategy::policy_max_flash_notional(&v0), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::strategy::policy_min_flash_profit_bps(&v0))
    }

    public fun open<T0>(arg0: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::Vault<T0>, arg1: &mut 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::strategy::StrategyBook<T0>, arg2: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::VaultTradeCap<T0>, arg3: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::LotusConfig, arg4: u64, arg5: 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::price::PriceReceipt, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock) : FlashTicket<T0> {
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::assert_product_active(arg3, arg4, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::product_trade());
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::assert_active_vault<T0>(arg0, arg3, arg4);
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::strategy::assert_strategy_book<T0>(arg1, arg0);
        assert!(arg6 > 0, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::flash_zero_notional());
        let v0 = 0x2::clock::timestamp_ms(arg9);
        assert!(v0 <= arg8, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::flash_deadline());
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::strategy::assert_provider_active<T0>(arg1, arg0, arg2, v0);
        let v1 = 0x2::object::id<0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::VaultTradeCap<T0>>(arg2);
        let (v2, _, v4, v5, v6, _) = 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::price::consume(arg5);
        assert!(v2 == 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::id<T0>(arg0), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::price_receipt_mismatch());
        assert!(v4 == v1, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::price_receipt_mismatch());
        assert!(arg7 >= profit_floor(arg6, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::strategy::charge_flash<T0>(arg1, v1, arg6, v0)), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::flash_profit_floor());
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::events::emit_flash_opened(0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::id<T0>(arg0), v1, v5, arg6, arg7, v6, arg8);
        FlashTicket<T0>{
            vault_id         : 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::id<T0>(arg0),
            book_id          : 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::strategy::strategy_book_id<T0>(arg1),
            cap_id           : v1,
            sequence         : v5,
            notional_quote   : arg6,
            min_profit_quote : arg7,
            ref_price        : v6,
            deadline_ms      : arg8,
        }
    }

    public fun profit_floor(arg0: u64, arg1: u64) : u64 {
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::math::bps(arg0, arg1)
    }

    public fun settle<T0>(arg0: &mut 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::Vault<T0>, arg1: FlashTicket<T0>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) {
        let FlashTicket {
            vault_id         : v0,
            book_id          : _,
            cap_id           : v2,
            sequence         : v3,
            notional_quote   : v4,
            min_profit_quote : v5,
            ref_price        : _,
            deadline_ms      : v7,
        } = arg1;
        assert!(v0 == 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::id<T0>(arg0), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::flash_ticket_mismatch());
        assert!(0x2::clock::timestamp_ms(arg3) <= v7, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::flash_deadline());
        let v8 = 0x2::balance::value<T0>(&arg2);
        assert!(v8 >= v5, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::flash_profit_floor());
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::put_quote<T0>(arg0, arg2);
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::events::emit_flash_settled(0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::id<T0>(arg0), v2, v3, v4, v5, v8);
    }

    public fun ticket_cap_id<T0>(arg0: &FlashTicket<T0>) : 0x2::object::ID {
        arg0.cap_id
    }

    public fun ticket_deadline_ms<T0>(arg0: &FlashTicket<T0>) : u64 {
        arg0.deadline_ms
    }

    public fun ticket_min_profit_quote<T0>(arg0: &FlashTicket<T0>) : u64 {
        arg0.min_profit_quote
    }

    public fun ticket_notional_quote<T0>(arg0: &FlashTicket<T0>) : u64 {
        arg0.notional_quote
    }

    public fun ticket_ref_price<T0>(arg0: &FlashTicket<T0>) : u64 {
        arg0.ref_price
    }

    public fun ticket_sequence<T0>(arg0: &FlashTicket<T0>) : u64 {
        arg0.sequence
    }

    public fun ticket_vault_id<T0>(arg0: &FlashTicket<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    // decompiled from Move bytecode v7
}

