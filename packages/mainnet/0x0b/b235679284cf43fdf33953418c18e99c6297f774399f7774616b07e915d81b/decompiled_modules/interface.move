module 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::interface {
    public fun create_assistant_cap(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::authority::Capability<0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::authority::ADMIN>, arg1: &mut 0x2::tx_context::TxContext) : 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::authority::Capability<0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::authority::ASSISTANT> {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::authority::create_assistant_cap(arg1)
    }

    public fun delete_assistant_cap(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::authority::Capability<0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::authority::ADMIN>, arg1: 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::authority::Capability<0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::authority::ASSISTANT>) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::authority::delete_assistant_cap(arg1);
    }

    public fun add_yield<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg1: &mut 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::account::Account<T1>, arg2: 0x2::coin::Coin<T1>) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::add_yield<T0, T1>(arg0, arg1, arg2);
    }

    public fun admin_pause_vault_for_force_withdraw<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::authority::Capability<0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::authority::ASSISTANT>, arg1: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg2: &0x2::clock::Clock, arg3: address) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::admin_pause_vault_for_force_withdraw<T0, T1>(arg1, arg2, arg3);
    }

    public fun admin_start_force_withdraw_session_for_address<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::authority::Capability<0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::authority::ASSISTANT>, arg1: 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg2: 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::account::Account<T1>, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg4: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg5: address, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::WithdrawSession<T0, T1> {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::start_force_withdraw_session<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun allocate_collateral_to_position<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::VaultOwnerCap<T0>, arg1: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg2: &mut 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::account::Account<T1>, arg3: &mut 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::clearing_house::ClearingHouse<T1>, arg4: &0x2::clock::Clock, arg5: u64) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::perpetuals_api::allocate_collateral_to_position<T0, T1>(arg1, arg2, arg3, arg4, arg5);
    }

    public fun cancel_orders<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::VaultOwnerCap<T0>, arg1: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg2: &0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::account::Account<T1>, arg3: &mut 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::clearing_house::ClearingHouse<T1>, arg4: &0x2::clock::Clock, arg5: &vector<u128>) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::perpetuals_api::cancel_orders<T0, T1>(arg1, arg2, arg3, arg4, arg5);
    }

    public fun create_market_position<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::VaultOwnerCap<T0>, arg1: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg2: &0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::account::Account<T1>, arg3: &mut 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::clearing_house::ClearingHouse<T1>) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::perpetuals_api::create_market_position<T0, T1>(arg1, arg2, arg3);
    }

    public fun create_stop_order_ticket<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::VaultOwnerCap<T0>, arg1: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg2: &0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::account::Account<T1>, arg3: &0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::registry::Registry, arg4: vector<address>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::perpetuals_api::create_stop_order_ticket<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun create_vault<T0, T1>(arg0: &mut 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::registry::Registry, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: 0x2::coin::TreasuryCap<T0>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg5: u64, arg6: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg7: &0x2::clock::Clock, arg8: u64, arg9: u256, arg10: u64, arg11: 0x2::coin::Coin<T1>, arg12: 0x1::ascii::String, arg13: 0x1::ascii::String, arg14: 0x1::option::Option<0x1::ascii::String>, arg15: 0x1::option::Option<0x1::ascii::String>, arg16: 0x1::option::Option<0x1::ascii::String>, arg17: 0x1::option::Option<vector<0x1::ascii::String>>, arg18: 0x1::option::Option<vector<0x1::ascii::String>>, arg19: &mut 0x2::tx_context::TxContext) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::create_vault<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19);
    }

    public fun create_withdraw_request<T0, T1>(arg0: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg1: 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::UserLpCoin<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::create_withdraw_request<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun deallocate_collateral_from_position<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::VaultOwnerCap<T0>, arg1: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg2: &mut 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::account::Account<T1>, arg3: &mut 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::clearing_house::ClearingHouse<T1>, arg4: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg5: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg6: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg7: &0x2::clock::Clock, arg8: 0x1::option::Option<u64>) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::perpetuals_api::deallocate_collateral_from_position<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun delete_stop_order_ticket<T0, T1>(arg0: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::perpetuals_api::delete_stop_order_ticket<T0, T1>(arg0, arg1, arg2)
    }

    public fun edit_stop_order_ticket_details<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::VaultOwnerCap<T0>, arg1: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg2: &0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::account::Account<T1>, arg3: 0x2::object::ID, arg4: vector<u8>) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::perpetuals_api::edit_stop_order_ticket_details<T0, T1>(arg1, arg2, arg3, arg4);
    }

    public fun edit_stop_order_ticket_executors<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::VaultOwnerCap<T0>, arg1: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg2: &0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::account::Account<T1>, arg3: 0x2::object::ID, arg4: vector<address>) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::perpetuals_api::edit_stop_order_ticket_executors<T0, T1>(arg1, arg2, arg3, arg4);
    }

    public fun end_deposit_session<T0, T1>(arg0: 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::DepositSession<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::UserLpCoin<T0> {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::end_deposit_session<T0, T1>(arg0, arg1, arg2)
    }

    public fun end_perpetuals_session<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::VaultOwnerCap<T0>, arg1: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg2: &mut 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::account::Account<T1>, arg3: 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::clearing_house::SessionHotPotato<T1>, arg4: 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::perpetuals_api::VaultsSessionHotPotato, arg5: bool) : 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::clearing_house::ClearingHouse<T1> {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::perpetuals_api::end_perpetuals_session<T0, T1>(arg1, arg2, arg3, arg4, arg5)
    }

    public fun end_withdraw_session<T0, T1>(arg0: 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::WithdrawSession<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::end_withdraw_session<T0, T1>(arg0, arg1)
    }

    public fun end_withdraw_session_and_transfer_to_recipient<T0, T1>(arg0: 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::WithdrawSession<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::end_withdraw_session_and_transfer_to_recipient<T0, T1>(arg0, arg1);
    }

    public fun join<T0>(arg0: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::UserLpCoin<T0>, arg1: 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::UserLpCoin<T0>) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::join_user_lp_coin<T0>(arg0, arg1);
    }

    public fun liquidate<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::VaultOwnerCap<T0>, arg1: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg2: &mut 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::account::Account<T1>, arg3: 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::clearing_house::ClearingHouse<T1>, arg4: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg5: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg6: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg7: &0x2::clock::Clock, arg8: u64, arg9: &vector<u128>, arg10: &0x2::tx_context::TxContext) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::perpetuals_api::liquidate<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun liquidate_session<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::VaultOwnerCap<T0>, arg1: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg2: &mut 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::clearing_house::SessionHotPotato<T1>, arg3: u64, arg4: &vector<u128>) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::perpetuals_api::liquidate_session<T0, T1>(arg1, arg2, arg3, arg4);
    }

    public fun pause_vault_for_force_withdraw<T0, T1>(arg0: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::pause_vault_for_force_withdraw<T0, T1>(arg0, arg1, 0x2::tx_context::sender(arg2));
    }

    public fun place_limit_order<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::VaultOwnerCap<T0>, arg1: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg2: &mut 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::account::Account<T1>, arg3: 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::clearing_house::ClearingHouse<T1>, arg4: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg5: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg6: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg7: &0x2::clock::Clock, arg8: bool, arg9: u64, arg10: u64, arg11: u64, arg12: bool, arg13: 0x1::option::Option<u64>, arg14: &0x2::tx_context::TxContext) : 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::clearing_house::ClearingHouse<T1> {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::perpetuals_api::place_limit_order<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14)
    }

    public fun place_limit_order_session<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::VaultOwnerCap<T0>, arg1: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg2: &mut 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::clearing_house::SessionHotPotato<T1>, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: 0x1::option::Option<u64>) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::perpetuals_api::place_limit_order_session<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun place_market_order<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::VaultOwnerCap<T0>, arg1: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg2: &mut 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::account::Account<T1>, arg3: 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::clearing_house::ClearingHouse<T1>, arg4: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg5: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg6: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg7: &0x2::clock::Clock, arg8: bool, arg9: u64, arg10: bool, arg11: &0x2::tx_context::TxContext) : 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::clearing_house::ClearingHouse<T1> {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::perpetuals_api::place_market_order<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    public fun place_market_order_session<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::VaultOwnerCap<T0>, arg1: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg2: &mut 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::clearing_house::SessionHotPotato<T1>, arg3: bool, arg4: u64, arg5: bool) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::perpetuals_api::place_market_order_session<T0, T1>(arg1, arg2, arg3, arg4, arg5);
    }

    public fun place_stop_order_sltp<T0, T1>(arg0: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg1: 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::clearing_house::ClearingHouse<T1>, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg4: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg5: &0x2::clock::Clock, arg6: 0x2::object::ID, arg7: &mut 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::account::Account<T1>, arg8: 0x1::option::Option<u64>, arg9: bool, arg10: 0x1::option::Option<u256>, arg11: 0x1::option::Option<u256>, arg12: bool, arg13: u64, arg14: u64, arg15: u64, arg16: vector<u8>, arg17: 0x1::option::Option<0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::clearing_house::IntegratorInfo>, arg18: &mut 0x2::tx_context::TxContext) : (0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::clearing_house::SessionSummary, 0x2::coin::Coin<0x2::sui::SUI>, 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::clearing_house::ClearingHouse<T1>) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::perpetuals_api::place_stop_order_sltp<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18)
    }

    public fun place_stop_order_standalone<T0, T1>(arg0: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg1: 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::clearing_house::ClearingHouse<T1>, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg4: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg5: &0x2::clock::Clock, arg6: 0x2::object::ID, arg7: &mut 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::account::Account<T1>, arg8: 0x1::option::Option<u64>, arg9: bool, arg10: u256, arg11: bool, arg12: bool, arg13: u64, arg14: u64, arg15: u64, arg16: bool, arg17: vector<u8>, arg18: 0x1::option::Option<0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::clearing_house::IntegratorInfo>, arg19: &mut 0x2::tx_context::TxContext) : (0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::clearing_house::SessionSummary, 0x2::coin::Coin<0x2::sui::SUI>, 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::clearing_house::ClearingHouse<T1>) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::perpetuals_api::place_stop_order_standalone<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19)
    }

    public fun process_clearing_house_for_deposit<T0, T1>(arg0: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::DepositSession<T0, T1>, arg1: 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::clearing_house::ClearingHouse<T1>, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg4: &0x2::clock::Clock) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::process_clearing_house_for_deposit<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun process_clearing_house_for_force_withdraw<T0, T1>(arg0: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::WithdrawSession<T0, T1>, arg1: 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::clearing_house::ClearingHouse<T1>, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg4: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg5: &0x2::clock::Clock, arg6: u64, arg7: &vector<u128>, arg8: &0x2::tx_context::TxContext) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::process_clearing_house_for_force_withdraw<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun process_clearing_house_for_withdraw<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::VaultOwnerCap<T0>, arg1: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::WithdrawSession<T0, T1>, arg2: 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::clearing_house::ClearingHouse<T1>, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg4: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg5: &0x2::clock::Clock) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::process_clearing_house_for_withdraw<T0, T1>(arg1, arg2, arg3, arg4, arg5);
    }

    public fun remove_withdraw_request<T0, T1>(arg0: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::UserLpCoin<T0> {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::remove_withdraw_request<T0, T1>(arg0, arg1)
    }

    public fun resume_vault_for_force_withdraw<T0, T1>(arg0: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg1: &0x2::clock::Clock) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::resume_vault_for_force_withdraw<T0, T1>(arg0, arg1);
    }

    public fun set_curator_logo_url<T0>(arg0: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::metadata::VaultMetadata<T0>, arg1: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::VaultOwnerCap<T0>, arg2: 0x1::ascii::String) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::metadata::set_curator_logo_url<T0>(arg0, arg2);
    }

    public fun set_curator_name<T0>(arg0: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::metadata::VaultMetadata<T0>, arg1: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::VaultOwnerCap<T0>, arg2: 0x1::ascii::String) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::metadata::set_curator_name<T0>(arg0, arg2);
    }

    public fun set_curator_url<T0>(arg0: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::metadata::VaultMetadata<T0>, arg1: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::VaultOwnerCap<T0>, arg2: 0x1::ascii::String) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::metadata::set_curator_url<T0>(arg0, arg2);
    }

    public fun set_deposit_session_sender<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::authority::Capability<0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::authority::ASSISTANT>, arg1: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::DepositSession<T0, T1>, arg2: address) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::set_deposit_session_sender<T0, T1>(arg1, arg2);
    }

    public fun set_description<T0>(arg0: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::metadata::VaultMetadata<T0>, arg1: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::VaultOwnerCap<T0>, arg2: 0x1::ascii::String) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::metadata::set_description<T0>(arg0, arg2);
    }

    public fun set_extra_field<T0>(arg0: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::metadata::VaultMetadata<T0>, arg1: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::VaultOwnerCap<T0>, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::metadata::set_extra_field<T0>(arg0, arg2, arg3);
    }

    public fun set_name<T0>(arg0: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::metadata::VaultMetadata<T0>, arg1: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::VaultOwnerCap<T0>, arg2: 0x1::ascii::String) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::metadata::set_name<T0>(arg0, arg2);
    }

    public fun set_new_withdraw_request_slippage<T0, T1>(arg0: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::set_new_withdraw_request_slippage<T0, T1>(arg0, arg1, arg2);
    }

    public fun set_position_initial_margin_ratio<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::VaultOwnerCap<T0>, arg1: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg2: &0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::account::Account<T1>, arg3: &mut 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::clearing_house::ClearingHouse<T1>, arg4: u256) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::perpetuals_api::set_position_initial_margin_ratio<T0, T1>(arg1, arg2, arg3, arg4);
    }

    public fun set_vault_total_deposited_collateral<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::authority::Capability<0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::authority::ASSISTANT>, arg1: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg2: u64) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::set_vault_total_deposited_collateral<T0, T1>(arg1, arg2);
    }

    public fun split<T0>(arg0: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::UserLpCoin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::UserLpCoin<T0> {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::split_user_lp_coin<T0>(arg0, arg1, arg2)
    }

    public fun start_deposit_session<T0, T1>(arg0: 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg1: 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::account::Account<T1>, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::tx_context::TxContext) : 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::DepositSession<T0, T1> {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::start_deposit_session<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun start_force_withdraw_session<T0, T1>(arg0: 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg1: 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::account::Account<T1>, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::WithdrawSession<T0, T1> {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::start_force_withdraw_session<T0, T1>(arg0, arg1, arg2, arg3, 0x2::tx_context::sender(arg5), arg4)
    }

    public fun start_owner_process_withdraw_request<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::VaultOwnerCap<T0>, arg1: 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg2: 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::account::Account<T1>, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg4: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg5: &0x2::clock::Clock, arg6: address) : 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::WithdrawSession<T0, T1> {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::start_owner_process_withdraw_request<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun start_owner_withdraw_session<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::VaultOwnerCap<T0>, arg1: 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg2: 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::account::Account<T1>, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg4: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg5: 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::UserLpCoin<T0>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::WithdrawSession<T0, T1> {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::start_owner_withdraw_session<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun start_perpetuals_session<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::VaultOwnerCap<T0>, arg1: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg2: &0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::account::Account<T1>, arg3: 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::clearing_house::ClearingHouse<T1>, arg4: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg5: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg6: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : (0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::clearing_house::SessionHotPotato<T1>, 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::perpetuals_api::VaultsSessionHotPotato) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::perpetuals_api::start_perpetuals_session<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    entry fun update_collateral_pfs_info<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::authority::Capability<0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::authority::ASSISTANT>, arg1: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg2: &0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::registry::Registry) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::update_collateral_pfs_info<T0, T1>(arg1, arg2);
    }

    entry fun update_collateral_pfs_tolerance<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::authority::Capability<0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::authority::ASSISTANT>, arg1: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg2: u64) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::update_collateral_pfs_tolerance<T0, T1>(arg1, arg2);
    }

    public fun update_force_withdraw_delay<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::VaultOwnerCap<T0>, arg1: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg2: u64) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::update_force_withdraw_delay<T0, T1>(arg1, arg2);
    }

    public fun update_lock_period<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::VaultOwnerCap<T0>, arg1: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg2: u64) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::update_lock_period<T0, T1>(arg1, arg2);
    }

    public fun update_max_markets_in_vault<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::VaultOwnerCap<T0>, arg1: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg2: u64) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::update_max_markets_in_vault<T0, T1>(arg1, arg2);
    }

    public fun update_max_pending_orders_per_position<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::VaultOwnerCap<T0>, arg1: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg2: u64) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::update_max_pending_orders_per_position<T0, T1>(arg1, arg2);
    }

    public fun update_max_total_deposited_collateral<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::VaultOwnerCap<T0>, arg1: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg2: u64) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::update_max_total_deposited_collateral<T0, T1>(arg1, arg2);
    }

    entry fun update_min_force_withdraw_position_usd<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::authority::Capability<0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::authority::ASSISTANT>, arg1: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg2: u256) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::update_min_force_withdraw_position_usd<T0, T1>(arg1, arg2);
    }

    entry fun update_min_pause_vault_for_force_withdraw_frequency_ms<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::authority::Capability<0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::authority::ASSISTANT>, arg1: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg2: u64) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::update_min_pause_vault_for_force_withdraw_frequency_ms<T0, T1>(arg1, arg2);
    }

    public fun update_owner_fee_rate<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::VaultOwnerCap<T0>, arg1: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg2: u256) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::update_owner_fee_rate<T0, T1>(arg1, arg2);
    }

    entry fun update_vault_version<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::authority::Capability<0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::authority::ASSISTANT>, arg1: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>) {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::update_vault_version<T0, T1>(arg1);
    }

    public fun withdraw_fees<T0, T1>(arg0: &0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::VaultOwnerCap<T0>, arg1: &mut 0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::Vault<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xbb235679284cf43fdf33953418c18e99c6297f774399f7774616b07e915d81b::vault::withdraw_fees<T0, T1>(arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

