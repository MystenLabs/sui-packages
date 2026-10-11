module 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::strategy {
    struct CapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ReduceTicket {
        vault: 0x2::object::ID,
        collateral_withdrawn: u64,
        debt_repaid: u64,
        rate: u64,
    }

    struct ReduceFinished has copy, drop {
        vault: 0x2::object::ID,
        path: u8,
        collateral: u64,
        debt_repaid: u64,
        proceeds: u64,
    }

    struct LeveredUp has copy, drop {
        vault: 0x2::object::ID,
        principal: u64,
        flash: u64,
        receipt_minted: u64,
        refund: u64,
    }

    struct ImportTicket {
        vault: 0x2::object::ID,
        flash: u64,
    }

    public fun deposit<T0, T1, T2>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::deposit<T0, T1, T2>(arg0, arg2, 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::get_vault_rate<T0, T1>(arg1), 0x2::clock::timestamp_ms(arg3), arg4)
    }

    public fun deposit_receipt<T0, T1, T2, T3>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T1, T2>, arg2: 0x2::coin::Coin<T2>, arg3: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg4: &0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_app::LeverageApp, arg5: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg6: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_delegate::deposit<T0, T2, T1>(arg3, arg4, arg5, cap_ref<T1, T2, T3>(arg0), arg2, arg6, arg7, arg8);
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::deposit_receipt<T1, T2, T3>(arg0, 1, 0x2::coin::value<T2>(&arg2), 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::get_vault_rate<T1, T2>(arg1), 0x2::clock::timestamp_ms(arg7), arg8)
    }

    public fun request_withdraw<T0, T1, T2>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg2: 0x2::coin::Coin<T2>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::WithdrawTicket {
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::request_withdraw<T0, T1, T2>(arg0, arg2, 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::get_vault_rate<T0, T1>(arg1), 0x2::clock::timestamp_ms(arg3), arg4)
    }

    public fun withdraw<T0, T1, T2>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg2: 0x2::coin::Coin<T2>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::withdraw<T0, T1, T2>(arg0, arg2, arg3, 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::get_vault_rate<T0, T1>(arg1), 0x2::clock::timestamp_ms(arg4), arg5)
    }

    public fun attach_obligation<T0, T1, T2, T3>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>, arg1: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::AdminCap, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg3: &0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_app::LeverageApp, arg4: &0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_market::LeverageMarket, arg5: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::uid_mut<T1, T2, T3>(arg0);
        let v1 = CapKey{dummy_field: false};
        assert!(!0x2::dynamic_object_field::exists<CapKey>(v0, v1), 100);
        let v2 = CapKey{dummy_field: false};
        0x2::dynamic_object_field::add<CapKey, 0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_obligation::LeverageMarketOwnerCap>(v0, v2, 0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_obligation::open_obligation<T0>(arg2, arg3, arg4, arg5, arg6));
    }

    public fun begin_import<T0, T1, T2, T3>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>, arg1: u64, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg3: &0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_app::LeverageApp, arg4: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg5: &mut 0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_market::LeverageMarket, arg6: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_repay::LeverageHotPotato<T0, T1>, 0x2::coin::Coin<T1>, ImportTicket) {
        let v0 = cap_mut<T1, T2, T3>(arg0);
        let (v1, v2) = 0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_swap_borrow::request_leverage<T0, T2, T1>(arg2, arg3, arg4, arg5, v0, 0x2::coin::zero<T1>(arg8), arg1, arg6, arg7, arg8);
        let v3 = v2;
        let v4 = ImportTicket{
            vault : 0x2::object::id<0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>>(arg0),
            flash : 0x2::coin::value<T1>(&v3),
        };
        (v1, v3, v4)
    }

    public fun begin_reduce<T0, T1, T2, T3>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>, arg1: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::KeeperCap, arg2: u8, arg3: u64, arg4: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg5: &0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_app::LeverageApp, arg6: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg7: &mut 0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_market::LeverageMarket, arg8: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg9: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg10: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T1, T2>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_reduce_to_borrow_coin::LeverageReduceAsBorrowPotato<T0, T1>, 0x2::coin::Coin<T2>, ReduceTicket) {
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::assert_keeper<T1, T2, T3>(arg0, arg1);
        assert!(arg2 > 0 && arg2 <= 100, 104);
        let (v0, v1) = 0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_reduce_to_borrow_coin::request_reduce_size<T0, T2, T1>(arg4, arg5, arg6, cap_ref<T1, T2, T3>(arg0), arg7, arg2, arg3, arg9, arg11, arg8, arg12);
        let v2 = v1;
        let v3 = ReduceTicket{
            vault                : 0x2::object::id<0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>>(arg0),
            collateral_withdrawn : 0x2::coin::value<T2>(&v2),
            debt_repaid          : arg3,
            rate                 : 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::get_vault_rate<T1, T2>(arg10),
        };
        (v0, v2, v3)
    }

    fun cap_mut<T0, T1, T2>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>) : &mut 0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_obligation::LeverageMarketOwnerCap {
        let v0 = 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::uid_mut<T0, T1, T2>(arg0);
        let v1 = CapKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<CapKey>(v0, v1), 101);
        let v2 = CapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<CapKey, 0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_obligation::LeverageMarketOwnerCap>(v0, v2)
    }

    fun cap_ref<T0, T1, T2>(arg0: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>) : &0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_obligation::LeverageMarketOwnerCap {
        let v0 = 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::uid<T0, T1, T2>(arg0);
        let v1 = CapKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists<CapKey>(v0, v1), 101);
        let v2 = CapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<CapKey, 0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_obligation::LeverageMarketOwnerCap>(v0, v2)
    }

    fun ceil_bps(arg0: u64, arg1: u64) : u64 {
        ((((arg0 as u128) * (arg1 as u128) + (10000 as u128) - 1) / (10000 as u128)) as u64)
    }

    public fun claim_rewards<T0, T1, T2, T3, T4>(arg0: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T2, T3, T4>, arg1: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::KeeperCap, arg2: u8, arg3: u64, arg4: &0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_app::LeverageApp, arg5: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg6: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::assert_keeper<T2, T3, T4>(arg0, arg1);
        0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_delegate::claim_liquidity_minging_rewards<T0, T3, T1>(arg4, arg5, arg6, cap_ref<T2, T3, T4>(arg0), arg2, arg3, arg7, arg8);
    }

    public fun finish_import<T0, T1, T2, T3>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>, arg1: 0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_repay::LeverageHotPotato<T0, T1>, arg2: 0x2::coin::Coin<T2>, arg3: ImportTicket, arg4: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg5: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg6: &mut 0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_market::LeverageMarket, arg7: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg8: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg9: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T1, T2>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        let ImportTicket {
            vault : v0,
            flash : v1,
        } = arg3;
        assert!(v0 == 0x2::object::id<0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>>(arg0), 103);
        let v2 = 0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_swap_borrow::complete_leverage<T0, T2, T1>(arg4, arg5, arg6, cap_ref<T1, T2, T3>(arg0), arg1, arg2, 0x1::option::none<0x1::string::String>(), arg7, arg8, arg10, arg11);
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::put_pending<T1, T2, T3>(arg0, 0x2::coin::into_balance<T1>(v2));
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::record_import<T1, T2, T3>(arg0, 1, 0x2::coin::value<T2>(&arg2), v1 + ceil_bps(v1, 1) - 0x2::coin::value<T1>(&v2), 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::get_vault_rate<T1, T2>(arg9), 0x2::clock::timestamp_ms(arg10), arg11)
    }

    public fun finish_reduce_redeem<T0, T1, T2, T3>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>, arg1: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::KeeperCap, arg2: 0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_reduce_to_borrow_coin::LeverageReduceAsBorrowPotato<T0, T1>, arg3: 0x2::coin::Coin<T2>, arg4: ReduceTicket, arg5: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg6: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg7: &mut 0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_market::LeverageMarket, arg8: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg9: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg10: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T1, T2>, arg11: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::assert_keeper<T1, T2, T3>(arg0, arg1);
        let ReduceTicket {
            vault                : v0,
            collateral_withdrawn : v1,
            debt_repaid          : v2,
            rate                 : v3,
        } = arg4;
        assert!(v0 == 0x2::object::id<0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>>(arg0), 103);
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::put_buffer<T1, T2, T3>(arg0, 0x2::coin::into_balance<T1>(0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_reduce_to_borrow_coin::complete_reduce<T0, T1>(arg5, arg6, arg7, cap_ref<T1, T2, T3>(arg0), arg2, 0x2::coin::from_balance<T1>(0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::take_buffer<T1, T2, T3>(arg0, v2 + ceil_bps(v2, 10)), arg13), 0x1::option::none<0x1::string::String>(), arg9, arg12, arg8, arg13)));
        let v4 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::redeem_shares<T1, T2>(arg10, arg11, 0x2::coin::into_balance<T2>(arg3), 0x2::object::id_address<0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>>(arg0), arg12, arg13);
        let (_, _, _, v8, _, _) = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::decode_withdrawal_request(&v4);
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::add_redeeming<T1, T2, T3>(arg0, v8);
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::record_reduce<T1, T2, T3>(arg0, 1, v1, v2, v3, 0x2::clock::timestamp_ms(arg12));
        let v11 = ReduceFinished{
            vault       : v0,
            path        : 1,
            collateral  : v1,
            debt_repaid : v2,
            proceeds    : v8,
        };
        0x2::event::emit<ReduceFinished>(v11);
    }

    public fun finish_reduce_swapped<T0, T1, T2, T3>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>, arg1: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::KeeperCap, arg2: 0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_reduce_to_borrow_coin::LeverageReduceAsBorrowPotato<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: ReduceTicket, arg5: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg6: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg7: &mut 0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_market::LeverageMarket, arg8: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg9: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::assert_keeper<T1, T2, T3>(arg0, arg1);
        let ReduceTicket {
            vault                : v0,
            collateral_withdrawn : v1,
            debt_repaid          : v2,
            rate                 : v3,
        } = arg4;
        assert!(v0 == 0x2::object::id<0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>>(arg0), 103);
        assert!((0x2::coin::value<T1>(&arg3) as u128) >= 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::receipt_value(v1, v3) * ((10000 - 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::max_exit_slippage_bps<T1, T2, T3>(arg0)) as u128) / (10000 as u128), 102);
        let v4 = 0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_reduce_to_borrow_coin::complete_reduce<T0, T1>(arg5, arg6, arg7, cap_ref<T1, T2, T3>(arg0), arg2, arg3, 0x1::option::none<0x1::string::String>(), arg9, arg10, arg8, arg11);
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::put_buffer<T1, T2, T3>(arg0, 0x2::coin::into_balance<T1>(v4));
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::record_reduce<T1, T2, T3>(arg0, 1, v1, v2, v3, 0x2::clock::timestamp_ms(arg10));
        let v5 = ReduceFinished{
            vault       : v0,
            path        : 0,
            collateral  : v1,
            debt_repaid : v2,
            proceeds    : 0x2::coin::value<T1>(&v4),
        };
        0x2::event::emit<ReduceFinished>(v5);
    }

    public fun lever_up<T0, T1, T2, T3>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>, arg1: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::KeeperCap, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg6: &0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_app::LeverageApp, arg7: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg8: &mut 0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_market::LeverageMarket, arg9: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg10: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg11: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T1, T2>, arg12: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::assert_keeper<T1, T2, T3>(arg0, arg1);
        let v0 = 0x2::coin::from_balance<T1>(0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::take_pending<T1, T2, T3>(arg0, arg2), arg14);
        let v1 = cap_mut<T1, T2, T3>(arg0);
        let (v2, v3) = 0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_swap_borrow::request_leverage<T0, T2, T1>(arg5, arg6, arg7, arg8, v1, v0, arg3, arg10, arg13, arg14);
        let v4 = v3;
        let v5 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::deposit_asset_v2<T1, T2>(arg11, arg12, 0x2::coin::into_balance<T1>(v4), arg4, arg13, arg14);
        let v6 = 0x2::coin::value<T2>(&v5);
        let v7 = 0x42a1a418bf977d5306aa783288eebbc2e3ca9200b533fba7feda521e60d199e::leverage_swap_borrow::complete_leverage<T0, T2, T1>(arg5, arg7, arg8, cap_ref<T1, T2, T3>(arg0), v2, v5, 0x1::option::none<0x1::string::String>(), arg9, arg10, arg13, arg14);
        let v8 = 0x2::coin::value<T1>(&v7);
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::put_pending<T1, T2, T3>(arg0, 0x2::coin::into_balance<T1>(v7));
        let v9 = 0x2::coin::value<T1>(&v4) - arg2;
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::record_lever_up<T1, T2, T3>(arg0, 1, v6, v9 + ceil_bps(v9, 1) - v8, 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::get_vault_rate<T1, T2>(arg11), 0x2::clock::timestamp_ms(arg13));
        let v10 = LeveredUp{
            vault          : 0x2::object::id<0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>>(arg0),
            principal      : arg2,
            flash          : v9,
            receipt_minted : v6,
            refund         : v8,
        };
        0x2::event::emit<LeveredUp>(v10);
    }

    public fun receive_redemption<T0, T1, T2>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>, arg1: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::KeeperCap, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) {
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::assert_keeper<T0, T1, T2>(arg0, arg1);
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::settle_redemption<T0, T1, T2>(arg0, 0x2::coin::into_balance<T0>(0x2::transfer::public_receive<0x2::coin::Coin<T0>>(0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::uid_mut<T0, T1, T2>(arg0), arg2)));
    }

    // decompiled from Move bytecode v7
}

