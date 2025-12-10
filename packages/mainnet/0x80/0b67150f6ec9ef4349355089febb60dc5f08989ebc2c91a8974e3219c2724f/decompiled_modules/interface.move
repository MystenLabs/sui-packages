module 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::interface {
    public fun cancel_orders<T0, T1>(arg0: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::VaultOwnerCap<T0>, arg1: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg2: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>, arg3: &vector<u128>) {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::perpetuals_api::cancel_orders<T0, T1>(arg1, arg2, arg3);
    }

    public fun create_market_position<T0, T1>(arg0: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::VaultOwnerCap<T0>, arg1: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg2: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>) {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::perpetuals_api::create_market_position<T0, T1>(arg1, arg2);
    }

    public fun create_stop_order_ticket<T0, T1>(arg0: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::VaultOwnerCap<T0>, arg1: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg2: &0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::registry::Registry, arg3: vector<address>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::perpetuals_api::create_stop_order_ticket<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun create_vault<T0, T1>(arg0: 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::CreateVaultCap<T0>, arg1: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::registry::Registry, arg2: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg3: u64, arg4: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg5: &0x2::clock::Clock, arg6: 0x1::string::String, arg7: u64, arg8: u256, arg9: u64, arg10: 0x2::coin::Coin<T1>, arg11: &mut 0x2::tx_context::TxContext) {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::create_vault<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun create_vault_cap<T0: drop>(arg0: T0, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::create_vault_cap<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun create_withdraw_request<T0, T1>(arg0: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg1: 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::UserLpCoin<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::create_withdraw_request<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun delete_stop_order_ticket<T0, T1>(arg0: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::perpetuals_api::delete_stop_order_ticket<T0, T1>(arg0, arg1, arg2)
    }

    public fun deposit_into_perpetuals<T0, T1>(arg0: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::VaultOwnerCap<T0>, arg1: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg2: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::Account<T1>, arg3: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::perpetuals_api::deposit_into_perpetuals<T0, T1>(arg1, arg2, arg3, arg4, arg5);
    }

    public fun edit_stop_order_ticket_details<T0, T1>(arg0: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::VaultOwnerCap<T0>, arg1: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg2: 0x2::object::ID, arg3: vector<u8>) {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::perpetuals_api::edit_stop_order_ticket_details<T0, T1>(arg1, arg2, arg3);
    }

    public fun edit_stop_order_ticket_executors<T0, T1>(arg0: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::VaultOwnerCap<T0>, arg1: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg2: 0x2::object::ID, arg3: vector<address>) {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::perpetuals_api::edit_stop_order_ticket_executors<T0, T1>(arg1, arg2, arg3);
    }

    public fun end_deposit_session<T0, T1>(arg0: 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::DepositSession<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::UserLpCoin<T0> {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::end_deposit_session<T0, T1>(arg0, arg1, arg2)
    }

    public fun end_perpetuals_session<T0, T1>(arg0: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::VaultOwnerCap<T0>, arg1: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg2: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::Account<T1>, arg3: 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::SessionHotPotato<T1>, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1> {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::perpetuals_api::end_perpetuals_session<T0, T1>(arg1, arg2, arg3, arg4, arg5)
    }

    public fun end_withdraw_session<T0, T1>(arg0: 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::WithdrawSession<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::end_withdraw_session<T0, T1>(arg0, arg1);
    }

    public fun join_user_lp_coin<T0>(arg0: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::UserLpCoin<T0>, arg1: 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::UserLpCoin<T0>) {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::join_user_lp_coin<T0>(arg0, arg1);
    }

    public fun liquidate<T0, T1>(arg0: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::VaultOwnerCap<T0>, arg1: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg2: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::Account<T1>, arg3: 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>, arg4: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg5: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg6: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg7: &0x2::clock::Clock, arg8: u64, arg9: &vector<u128>, arg10: &0x2::tx_context::TxContext) {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::perpetuals_api::liquidate<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun liquidate_session<T0, T1>(arg0: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::VaultOwnerCap<T0>, arg1: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg2: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::SessionHotPotato<T1>, arg3: u64, arg4: &vector<u128>) {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::perpetuals_api::liquidate_session<T0, T1>(arg1, arg2, arg3, arg4);
    }

    public fun place_limit_order<T0, T1>(arg0: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::VaultOwnerCap<T0>, arg1: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg2: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::Account<T1>, arg3: 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>, arg4: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg5: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg6: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg7: &0x2::clock::Clock, arg8: bool, arg9: u64, arg10: u64, arg11: u64, arg12: bool, arg13: 0x1::option::Option<u64>, arg14: &0x2::tx_context::TxContext) : 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1> {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::perpetuals_api::place_limit_order<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14)
    }

    public fun place_limit_order_session<T0, T1>(arg0: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::VaultOwnerCap<T0>, arg1: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg2: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::SessionHotPotato<T1>, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: 0x1::option::Option<u64>) {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::perpetuals_api::place_limit_order_session<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun place_market_order<T0, T1>(arg0: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::VaultOwnerCap<T0>, arg1: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg2: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::Account<T1>, arg3: 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>, arg4: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg5: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg6: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg7: &0x2::clock::Clock, arg8: bool, arg9: u64, arg10: bool, arg11: &0x2::tx_context::TxContext) : 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1> {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::perpetuals_api::place_market_order<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    public fun place_market_order_session<T0, T1>(arg0: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::VaultOwnerCap<T0>, arg1: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg2: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::SessionHotPotato<T1>, arg3: bool, arg4: u64, arg5: bool) {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::perpetuals_api::place_market_order_session<T0, T1>(arg1, arg2, arg3, arg4, arg5);
    }

    public fun place_stop_order_sltp<T0, T1>(arg0: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg1: 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>, arg2: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg3: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg4: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg5: &0x2::clock::Clock, arg6: 0x2::object::ID, arg7: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::Account<T1>, arg8: 0x1::option::Option<u64>, arg9: bool, arg10: 0x1::option::Option<u256>, arg11: 0x1::option::Option<u256>, arg12: bool, arg13: u64, arg14: u64, arg15: u64, arg16: vector<u8>, arg17: 0x1::option::Option<0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::IntegratorInfo>, arg18: &mut 0x2::tx_context::TxContext) : (0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::SessionSummary, 0x2::coin::Coin<0x2::sui::SUI>, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>) {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::perpetuals_api::place_stop_order_sltp<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18)
    }

    public fun place_stop_order_standalone<T0, T1>(arg0: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg1: 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>, arg2: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg3: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg4: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg5: &0x2::clock::Clock, arg6: 0x2::object::ID, arg7: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::Account<T1>, arg8: 0x1::option::Option<u64>, arg9: bool, arg10: u256, arg11: bool, arg12: bool, arg13: u64, arg14: u64, arg15: u64, arg16: bool, arg17: vector<u8>, arg18: 0x1::option::Option<0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::IntegratorInfo>, arg19: &mut 0x2::tx_context::TxContext) : (0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::SessionSummary, 0x2::coin::Coin<0x2::sui::SUI>, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>) {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::perpetuals_api::place_stop_order_standalone<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19)
    }

    public fun process_clearing_house_for_deposit<T0, T1>(arg0: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::DepositSession<T0, T1>, arg1: 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>, arg2: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg3: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg4: &0x2::clock::Clock) {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::process_clearing_house_for_deposit<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun process_clearing_house_for_force_withdraw<T0, T1>(arg0: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::WithdrawSession<T0, T1>, arg1: 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>, arg2: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg3: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg4: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg5: &0x2::clock::Clock, arg6: u64, arg7: &vector<u128>, arg8: &0x2::tx_context::TxContext) {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::process_clearing_house_for_force_withdraw<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun process_clearing_house_for_withdraw<T0, T1>(arg0: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::VaultOwnerCap<T0>, arg1: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::WithdrawSession<T0, T1>, arg2: 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>, arg3: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg4: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg5: &0x2::clock::Clock) {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::process_clearing_house_for_withdraw<T0, T1>(arg1, arg2, arg3, arg4, arg5);
    }

    public fun remove_withdraw_request<T0, T1>(arg0: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::UserLpCoin<T0> {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::remove_withdraw_request<T0, T1>(arg0, arg1)
    }

    public fun set_deposit_session_sender<T0, T1>(arg0: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::AdminCap, arg1: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::DepositSession<T0, T1>, arg2: address) {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::set_deposit_session_sender<T0, T1>(arg1, arg2);
    }

    public fun set_new_withdraw_request_slippage<T0, T1>(arg0: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::set_new_withdraw_request_slippage<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun set_position_initial_margin_ratio<T0, T1>(arg0: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::VaultOwnerCap<T0>, arg1: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg2: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>, arg3: u256) {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::perpetuals_api::set_position_initial_margin_ratio<T0, T1>(arg1, arg2, arg3);
    }

    public fun set_vault_total_deposited_collateral<T0, T1>(arg0: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::AdminCap, arg1: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg2: u64) {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::set_vault_total_deposited_collateral<T0, T1>(arg1, arg2);
    }

    public fun start_deposit_session<T0, T1>(arg0: 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg1: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg2: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::tx_context::TxContext) : 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::DepositSession<T0, T1> {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::start_deposit_session<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun start_force_withdraw_session<T0, T1>(arg0: 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg1: 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::Account<T1>, arg2: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg3: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::WithdrawSession<T0, T1> {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::start_force_withdraw_session<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun start_owner_withdraw_session<T0, T1>(arg0: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::VaultOwnerCap<T0>, arg1: 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg2: 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::Account<T1>, arg3: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg4: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg5: &0x2::clock::Clock, arg6: address, arg7: &0x2::tx_context::TxContext) : 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::WithdrawSession<T0, T1> {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::start_owner_withdraw_session<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun start_perpetuals_session<T0, T1>(arg0: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::VaultOwnerCap<T0>, arg1: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg2: 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>, arg3: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg4: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg5: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::SessionHotPotato<T1> {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::perpetuals_api::start_perpetuals_session<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    entry fun update_collateral_pfs_info<T0, T1>(arg0: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::AdminCap, arg1: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg2: &0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::registry::Registry) {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::update_collateral_pfs_info<T0, T1>(arg1, arg2);
    }

    entry fun update_collateral_pfs_tolerance<T0, T1>(arg0: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::AdminCap, arg1: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg2: u64) {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::update_collateral_pfs_tolerance<T0, T1>(arg1, arg2);
    }

    public fun update_force_withdraw_delay<T0, T1>(arg0: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::VaultOwnerCap<T0>, arg1: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg2: &0x2::clock::Clock, arg3: u64) {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::update_force_withdraw_delay<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun update_lock_period<T0, T1>(arg0: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::VaultOwnerCap<T0>, arg1: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg2: &0x2::clock::Clock, arg3: u64) {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::update_lock_period<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun update_max_markets_in_vault<T0, T1>(arg0: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::VaultOwnerCap<T0>, arg1: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg2: &0x2::clock::Clock, arg3: u64) {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::update_max_markets_in_vault<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun update_max_pending_orders_per_position<T0, T1>(arg0: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::VaultOwnerCap<T0>, arg1: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg2: &0x2::clock::Clock, arg3: u64) {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::update_max_pending_orders_per_position<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun update_max_total_deposited_collateral<T0, T1>(arg0: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::VaultOwnerCap<T0>, arg1: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg2: &0x2::clock::Clock, arg3: u64) {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::update_max_total_deposited_collateral<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun update_owner_fee_rate<T0, T1>(arg0: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::VaultOwnerCap<T0>, arg1: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg2: &0x2::clock::Clock, arg3: u256) {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::update_owner_fee_rate<T0, T1>(arg0, arg1, arg2, arg3);
    }

    entry fun update_vault_version<T0, T1>(arg0: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::AdminCap, arg1: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>) {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::update_vault_version<T0, T1>(arg1);
    }

    public fun withdraw_fees<T0, T1>(arg0: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::VaultOwnerCap<T0>, arg1: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::withdraw_fees<T0, T1>(arg1, arg2, arg3)
    }

    public fun withdraw_from_perpetuals<T0, T1>(arg0: &0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::VaultOwnerCap<T0>, arg1: &mut 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::vault::Vault<T0, T1>, arg2: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::account::Account<T1>, arg3: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T1>, arg4: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg5: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg6: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg7: &0x2::clock::Clock, arg8: 0x1::option::Option<u64>, arg9: &mut 0x2::tx_context::TxContext) {
        0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::perpetuals_api::withdraw_from_perpetuals<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    // decompiled from Move bytecode v6
}

