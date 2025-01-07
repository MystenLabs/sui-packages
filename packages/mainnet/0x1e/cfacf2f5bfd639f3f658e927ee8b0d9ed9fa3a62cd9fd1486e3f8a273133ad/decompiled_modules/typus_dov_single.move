module 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single {
    struct TYPUS_DOV_SINGLE has drop {
        dummy_field: bool,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        num_of_vault: u64,
        authority: 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::Authority,
        fee_pool: 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::balance_pool::BalancePool,
        portfolio_vault_registry: 0x2::object::UID,
        deposit_vault_registry: 0x2::object::UID,
        auction_registry: 0x2::object::UID,
        bid_vault_registry: 0x2::object::UID,
        refund_vault_registry: 0x2::object::UID,
        additional_config_registry: 0x2::object::UID,
        version: u64,
        transaction_suspended: bool,
    }

    struct PortfolioVault has store, key {
        id: 0x2::object::UID,
        info: Info,
        config: Config,
        authority: 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::Authority,
    }

    struct Info has copy, drop, store {
        index: u64,
        option_type: u64,
        period: u8,
        activation_ts_ms: u64,
        expiration_ts_ms: u64,
        deposit_token: 0x1::type_name::TypeName,
        bid_token: 0x1::type_name::TypeName,
        settlement_base: 0x1::type_name::TypeName,
        settlement_quote: 0x1::type_name::TypeName,
        settlement_base_name: 0x1::string::String,
        settlement_quote_name: 0x1::string::String,
        d_token_decimal: u64,
        b_token_decimal: u64,
        o_token_decimal: u64,
        creator: address,
        create_ts_ms: u64,
        round: u64,
        status: u64,
        oracle_info: OracleInfo,
        delivery_infos: DeliveryInfos,
        settlement_info: 0x1::option::Option<SettlementInfo>,
        u64_padding: vector<u64>,
        bcs_padding: vector<u8>,
    }

    struct Config has copy, drop, store {
        oracle_id: address,
        deposit_lot_size: u64,
        bid_lot_size: u64,
        min_deposit_size: u64,
        min_bid_size: u64,
        max_deposit_entry: u64,
        max_bid_entry: u64,
        deposit_fee_bp: u64,
        deposit_fee_share_bp: u64,
        deposit_shared_fee_pool: 0x1::option::Option<vector<u8>>,
        bid_fee_bp: u64,
        deposit_incentive_bp: u64,
        bid_incentive_bp: u64,
        auction_delay_ts_ms: u64,
        auction_duration_ts_ms: u64,
        recoup_delay_ts_ms: u64,
        capacity: u64,
        leverage: u64,
        risk_level: u64,
        has_next: bool,
        active_vault_config: VaultConfig,
        warmup_vault_config: VaultConfig,
        u64_padding: vector<u64>,
        bcs_padding: vector<u8>,
    }

    struct PayoffConfig has copy, drop, store {
        strike_bp: u64,
        weight: u64,
        is_buyer: bool,
        strike: 0x1::option::Option<u64>,
        u64_padding: vector<u64>,
    }

    struct VaultConfig has copy, drop, store {
        payoff_configs: vector<PayoffConfig>,
        strike_increment: u64,
        decay_speed: u64,
        initial_price: u64,
        final_price: u64,
        u64_padding: vector<u64>,
    }

    struct OracleInfo has copy, drop, store {
        price: u64,
        decimal: u64,
    }

    struct DeliveryInfos has copy, drop, store {
        round: u64,
        max_size: u64,
        total_delivery_size: u64,
        total_bidder_bid_value: u64,
        total_bidder_fee: u64,
        total_incentive_bid_value: u64,
        total_incentive_fee: u64,
        delivery_info: vector<DeliveryInfo>,
        u64_padding: vector<u64>,
    }

    struct DeliveryInfo has copy, drop, store {
        auction_type: u64,
        delivery_price: u64,
        delivery_size: u64,
        bidder_bid_value: u64,
        bidder_fee: u64,
        incentive_bid_value: u64,
        incentive_fee: u64,
        ts_ms: u64,
        u64_padding: vector<u64>,
    }

    struct SettlementInfo has copy, drop, store {
        round: u64,
        oracle_price: u64,
        oracle_price_decimal: u64,
        settle_balance: u64,
        settled_balance: u64,
        share_price: u64,
        share_price_decimal: u64,
        ts_ms: u64,
        u64_padding: vector<u64>,
    }

    struct AdditionalConfig has store, key {
        id: 0x2::object::UID,
    }

    struct ActivateEvent has copy, drop {
        signer: address,
        index: u64,
        round: u64,
        deposit_amount: u64,
        d_token_decimal: u64,
        contract_size: u64,
        o_token_decimal: u64,
        oracle_info: OracleInfo,
        u64_padding: vector<u64>,
    }

    struct NewAuctionEvent has copy, drop {
        signer: address,
        index: u64,
        round: u64,
        start_ts_ms: u64,
        end_ts_ms: u64,
        size: u64,
        vault_config: VaultConfig,
        oracle_info: OracleInfo,
        u64_padding: vector<u64>,
    }

    struct DeliveryEvent has copy, drop {
        signer: address,
        index: u64,
        round: u64,
        early: bool,
        delivery_price: u64,
        delivery_size: u64,
        o_token_decimal: u64,
        o_token: 0x1::type_name::TypeName,
        bidder_bid_value: u64,
        bidder_fee: u64,
        incentive_bid_value: u64,
        incentive_fee: u64,
        b_token_decimal: u64,
        b_token: 0x1::type_name::TypeName,
        depositor_incentive_value: u64,
        u64_padding: vector<u64>,
    }

    struct OtcEvent has copy, drop {
        signer: address,
        index: u64,
        round: u64,
        delivery_price: u64,
        delivery_size: u64,
        o_token_decimal: u64,
        bidder_bid_value: u64,
        bidder_fee: u64,
        incentive_bid_value: u64,
        incentive_fee: u64,
        b_token_decimal: u64,
        depositor_incentive_value: u64,
        u64_padding: vector<u64>,
    }

    struct RecoupEvent has copy, drop {
        signer: address,
        index: u64,
        round: u64,
        active_amount: u64,
        deactivating_amount: u64,
        d_token_decimal: u64,
        u64_padding: vector<u64>,
    }

    struct SettleEvent has copy, drop {
        signer: address,
        index: u64,
        round: u64,
        oracle_price: u64,
        oracle_price_decimal: u64,
        settle_balance: u64,
        settled_balance: u64,
        d_token_decimal: u64,
        d_token: 0x1::type_name::TypeName,
        share_price: u64,
        u64_padding: vector<u64>,
    }

    struct CloseEvent has copy, drop {
        signer: address,
        index: u64,
        round: u64,
        u64_padding: vector<u64>,
    }

    struct TerminateVaultEvent has copy, drop {
        signer: address,
        index: u64,
        round: u64,
        u64_padding: vector<u64>,
    }

    struct DropVaultEvent has copy, drop {
        signer: address,
        index: u64,
        round: u64,
        u64_padding: vector<u64>,
    }

    struct TerminateAuctionEvent has copy, drop {
        signer: address,
        index: u64,
        round: u64,
        u64_padding: vector<u64>,
    }

    struct DepositEvent has copy, drop {
        signer: address,
        index: u64,
        token: 0x1::type_name::TypeName,
        amount: u64,
        decimal: u64,
        oracle_info: OracleInfo,
        u64_padding: vector<u64>,
    }

    struct WithdrawEvent has copy, drop {
        signer: address,
        index: u64,
        token: 0x1::type_name::TypeName,
        amount: u64,
        decimal: u64,
        oracle_info: OracleInfo,
        u64_padding: vector<u64>,
    }

    struct UnsubscribeEvent has copy, drop {
        signer: address,
        index: u64,
        token: 0x1::type_name::TypeName,
        amount: u64,
        decimal: u64,
        oracle_info: OracleInfo,
        u64_padding: vector<u64>,
    }

    struct ClaimEvent has copy, drop {
        signer: address,
        index: u64,
        token: 0x1::type_name::TypeName,
        amount: u64,
        decimal: u64,
        oracle_info: OracleInfo,
        u64_padding: vector<u64>,
    }

    struct HarvestEvent has copy, drop {
        signer: address,
        index: u64,
        token: 0x1::type_name::TypeName,
        amount: u64,
        fee_amount: u64,
        decimal: u64,
        oracle_info: OracleInfo,
        u64_padding: vector<u64>,
    }

    struct CompoundEvent has copy, drop {
        signer: address,
        index: u64,
        token: 0x1::type_name::TypeName,
        amount: u64,
        decimal: u64,
        oracle_info: OracleInfo,
        u64_padding: vector<u64>,
    }

    struct RedeemEvent has copy, drop {
        signer: address,
        index: u64,
        token: 0x1::type_name::TypeName,
        amount: u64,
        oracle_info: OracleInfo,
        u64_padding: vector<u64>,
    }

    struct NewBidEvent has copy, drop {
        signer: address,
        index: u64,
        bid_index: u64,
        price: u64,
        size: u64,
        b_token: 0x1::type_name::TypeName,
        o_token: 0x1::type_name::TypeName,
        bidder_balance: u64,
        incentive_balance: u64,
        decimal: u64,
        ts_ms: u64,
        oracle_info: OracleInfo,
        u64_padding: vector<u64>,
    }

    struct TransferBidReceiptEvent has copy, drop {
        signer: address,
        index: u64,
        amount: u64,
        decimal: u64,
        recipient: address,
        oracle_info: OracleInfo,
        u64_padding: vector<u64>,
    }

    struct RefundEvent has copy, drop {
        signer: address,
        token: 0x1::type_name::TypeName,
        amount: u64,
        u64_padding: vector<u64>,
    }

    struct ExerciseEvent has copy, drop {
        signer: address,
        index: u64,
        token: 0x1::type_name::TypeName,
        amount: u64,
        decimal: u64,
        incentive_token: 0x1::option::Option<0x1::type_name::TypeName>,
        incentive_amount: u64,
        u64_padding: vector<u64>,
    }

    public(friend) fun activate_<T0, T1>(arg0: &mut Registry, arg1: u64, arg2: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = &mut arg0.portfolio_vault_registry;
        let v1 = get_mut_portfolio_vault(v0, arg1);
        let v2 = &mut arg0.deposit_vault_registry;
        let v3 = get_mut_deposit_vault(v2, arg1);
        assert!(0x2::clock::timestamp_ms(arg3) >= v1.info.activation_ts_ms, 28);
        assert!(v1.info.status % 5 == 0, 3);
        let (v4, v5) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price(arg2, arg3);
        let (_, v7, _, _) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_token(arg2);
        v1.info.round = v1.info.round + 1;
        v1.config.active_vault_config = v1.config.warmup_vault_config;
        let v10 = v1.config.active_vault_config.strike_increment;
        let v11 = 0x1::vector::empty<u64>();
        let v12 = 0x1::vector::length<PayoffConfig>(&v1.config.active_vault_config.payoff_configs);
        while (v12 > 0) {
            let v13 = 0x1::vector::borrow_mut<PayoffConfig>(&mut v1.config.active_vault_config.payoff_configs, v12 - 1);
            let v14 = calculate_strike(v4, v13.strike_bp, v10);
            let v15 = if (v1.info.option_type % 2 == 1 && v14 > v10) {
                v14 - v10
            } else {
                v14
            };
            0x1::option::fill<u64>(&mut v13.strike, v15);
            0x1::vector::push_back<u64>(&mut v11, v15);
            v12 = v12 - 1;
        };
        let v16 = calculate_max_auction_size(v1.info.o_token_decimal, v1.config.leverage, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::active_share_supply(v3) + 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::deactivating_share_supply(v3), calculate_max_loss_per_unit(v1.info.option_type, v4, v5, v1.info.d_token_decimal, v1.info.o_token_decimal, v1.config.active_vault_config.payoff_configs, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::multiplier(2)), v1.config.bid_lot_size);
        let v17 = OracleInfo{
            price   : v4,
            decimal : v5,
        };
        v1.info.oracle_info = v17;
        let v18 = DeliveryInfos{
            round                     : v1.info.round,
            max_size                  : v16,
            total_delivery_size       : 0,
            total_bidder_bid_value    : 0,
            total_bidder_fee          : 0,
            total_incentive_bid_value : 0,
            total_incentive_fee       : 0,
            delivery_info             : 0x1::vector::empty<DeliveryInfo>(),
            u64_padding               : 0x1::vector::empty<u64>(),
        };
        v1.info.delivery_infos = v18;
        if (v16 == 0 || 0x2::clock::timestamp_ms(arg3) >= v1.info.expiration_ts_ms) {
            v1.info.status = 4;
            let v19 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::active_share_supply(v3) + 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::deactivating_share_supply(v3);
            if (v19 > 0) {
                let (_, _) = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::recoup<T0>(v3, v19, arg4);
            };
        } else {
            v1.info.status = 1;
        };
        let v22 = v1.info.settlement_base_name;
        let (v23, v24, v25) = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::get_date_from_ts(v1.info.expiration_ts_ms / 1000);
        0x1::string::append_utf8(&mut v22, b"-");
        0x1::string::append_utf8(&mut v22, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::get_pad_2_number_string(v25));
        0x1::string::append_utf8(&mut v22, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::get_month_short_string(v24));
        0x1::string::append_utf8(&mut v22, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::get_pad_2_number_string(v23));
        if (v1.info.period == 3) {
            0x1::string::append_utf8(&mut v22, b"-");
            0x1::string::append_utf8(&mut v22, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::get_pad_2_number_string(v1.info.expiration_ts_ms % 86400000 / 3600000));
            0x1::string::append_utf8(&mut v22, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::get_pad_2_number_string(v1.info.expiration_ts_ms % 3600000 / 60000));
        } else {
            0x1::vector::reverse<u64>(&mut v11);
            while (!0x1::vector::is_empty<u64>(&v11)) {
                0x1::string::append_utf8(&mut v22, b"-");
                0x1::string::append_utf8(&mut v22, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::u64_to_bytes(0x1::vector::pop_back<u64>(&mut v11), v5));
            };
        };
        if (v1.info.option_type == 0) {
            0x1::string::append_utf8(&mut v22, b"-Call");
        } else if (v1.info.option_type == 1) {
            0x1::string::append_utf8(&mut v22, b"-Put");
        } else if (v1.info.option_type == 2) {
            0x1::string::append_utf8(&mut v22, b"-CallSpread");
        } else if (v1.info.option_type == 3) {
            0x1::string::append_utf8(&mut v22, b"-PutSpread");
        } else if (v1.info.option_type == 4) {
            0x1::string::append_utf8(&mut v22, b"-CappedCall");
        } else if (v1.info.option_type == 5) {
            0x1::string::append_utf8(&mut v22, b"-CappedPut");
        } else if (v1.info.option_type == 6) {
            if (0x1::ascii::into_bytes(v7) == b"USDT") {
                0x1::string::append_utf8(&mut v22, b"-UsdtCappedCall");
            } else if (0x1::ascii::into_bytes(v7) == b"USDC") {
                0x1::string::append_utf8(&mut v22, b"-UsdcCappedCall");
            } else {
                0x1::string::append_utf8(&mut v22, b"-UsdCappedCall");
            };
        };
        0x2::dynamic_object_field::add<u64, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::BidVault>(&mut arg0.bid_vault_registry, arg1, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::new_bid_vault<T0, T1>(v1.info.index, v22, arg4));
        (0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::activate<T0>(v3, v1.config.has_next, arg4), v16)
    }

    entry fun adjust_incentive_share_ratio<T0>(arg0: &mut Registry, arg1: u64) {
        let v0 = &mut arg0.deposit_vault_registry;
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::adjust_user_share_ratio<T0>(get_mut_deposit_vault(v0, arg1), 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::incentive_share_tag());
    }

    entry fun adjust_premium_share_ratio<T0>(arg0: &mut Registry, arg1: u64) {
        let v0 = &mut arg0.deposit_vault_registry;
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::adjust_user_share_ratio<T0>(get_mut_deposit_vault(v0, arg1), 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::premium_share_tag());
    }

    public(friend) fun auction_exists(arg0: &0x2::object::UID, arg1: u64) : bool {
        0x2::dynamic_object_field::exists_with_type<u64, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::dutch::Auction>(arg0, arg1)
    }

    public(friend) fun calculate_in_usd<T0>(arg0: &PortfolioVault, arg1: u64, arg2: bool) : u64 {
        let v0 = if (0x1::type_name::get<T0>() == arg0.info.deposit_token) {
            arg0.info.d_token_decimal
        } else {
            assert!(0x1::type_name::get<T0>() == arg0.info.bid_token, 21);
            arg0.info.b_token_decimal
        };
        if (0x1::type_name::get<T0>() != arg0.info.settlement_base) {
            let v2 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::multiplier(v0);
            if (arg2) {
                (arg1 - arg1 % v2) / v2 + 1
            } else {
                arg1 / v2
            }
        } else {
            let v3 = (0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::multiplier(v0) as u128) * (0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::multiplier(arg0.info.oracle_info.decimal) as u128);
            let v4 = (arg0.info.oracle_info.price as u128) * (arg1 as u128);
            if (arg2) {
                (((v4 - v4 % v3) / v3) as u64) + 1
            } else {
                ((v4 / v3) as u64)
            }
        }
    }

    public(friend) fun calculate_max_auction_size(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        ((((0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::multiplier(arg0) * arg1) as u128) * (arg2 as u128) / (arg3 as u128) / (0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::multiplier(2) as u128)) as u64) / arg4 * arg4
    }

    public(friend) fun calculate_max_loss_per_unit(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: vector<PayoffConfig>, arg6: u64) : u64 {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = if (arg1 / 100000 > 0) {
            arg1 / 100000
        } else {
            1
        };
        let v2 = if (arg1 < 18446744073709551615 / 100) {
            arg1 * 100
        } else {
            18446744073709551615
        };
        0x1::vector::push_back<u64>(&mut v0, v1);
        0x1::vector::push_back<u64>(&mut v0, v2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<PayoffConfig>(&arg5)) {
            let v4 = 0x1::vector::borrow<PayoffConfig>(&arg5, v3);
            assert!(0x1::option::is_some<u64>(&v4.strike), 31);
            let v5 = 0x1::option::borrow<u64>(&v4.strike);
            if (!0x1::vector::contains<u64>(&v0, v5)) {
                0x1::vector::push_back<u64>(&mut v0, *v5);
            };
            v3 = v3 + 1;
        };
        let v6 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::i64::zero();
        while (!0x1::vector::is_empty<u64>(&v0)) {
            let v7 = calculate_portfolio_payoff_by_price(arg0, 0x1::vector::pop_back<u64>(&mut v0), arg2, arg3, arg5, arg6, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::multiplier(arg4), arg4);
            if (0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::i64::compare(&v6, &v7) == 2) {
                v6 = v7;
            };
        };
        assert!(0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::i64::is_neg(&v6), 14);
        let v8 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::i64::neg(&v6);
        let v9 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::i64::as_u64(&v8);
        assert!(v9 > 0, 14);
        v9
    }

    public(friend) fun calculate_option_payoff(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg0 % 2 == 0 && arg0 != 6) {
            if (arg1 >= arg3) {
                (((0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::multiplier(arg2) as u128) * ((arg1 - arg3) as u128) / (arg1 as u128)) as u64)
            } else {
                0
            }
        } else if (arg0 % 2 == 1) {
            if (arg1 <= arg3) {
                arg3 - arg1
            } else {
                0
            }
        } else {
            assert!(arg0 == 6, 17);
            if (arg1 >= arg3) {
                arg1 - arg3
            } else {
                0
            }
        }
    }

    public(friend) fun calculate_portfolio_payoff_by_price(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: vector<PayoffConfig>, arg5: u64, arg6: u64, arg7: u64) : 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::i64::I64 {
        let v0 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::i64::zero();
        while (!0x1::vector::is_empty<PayoffConfig>(&arg4)) {
            let v1 = 0x1::vector::pop_back<PayoffConfig>(&mut arg4);
            assert!(0x1::option::is_some<u64>(&v1.strike), 31);
            let v2 = if (v1.is_buyer) {
                0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::i64::from(1)
            } else {
                0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::i64::neg_from(1)
            };
            let v3 = v2;
            let v4 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::i64::from((((calculate_option_payoff(arg0, arg1, arg2, *0x1::option::borrow<u64>(&v1.strike)) as u128) * (0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::multiplier(arg3) as u128) / (0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::multiplier(arg2) as u128)) as u64));
            let v5 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::i64::mul(&v4, &v3);
            let v6 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::i64::from(v1.weight);
            let v7 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::i64::mul(&v5, &v6);
            let v8 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::i64::from(arg5);
            let v9 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::i64::mul(&v7, &v8);
            let v10 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::i64::from(0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::multiplier(2));
            let v11 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::i64::div(&v9, &v10);
            let v12 = &v0;
            v0 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::i64::add(v12, &v11);
        };
        let v13 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::i64::abs(&v0);
        if (0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::i64::is_neg(&v0)) {
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::i64::neg_from((((0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::i64::as_u64(&v13) as u128) * (arg6 as u128) / (0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::multiplier(arg7) as u128)) as u64))
        } else {
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::i64::from((((0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::i64::as_u64(&v13) as u128) * (arg6 as u128) / (0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::multiplier(arg7) as u128)) as u64))
        }
    }

    public(friend) fun calculate_strike(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = arg0 * arg1 / 10000;
        if (v0 % arg2 == 0) {
            return v0
        };
        v0 / arg2 * arg2 + arg2
    }

    public(friend) fun close_(arg0: &mut Registry, arg1: u64) {
        let v0 = &mut arg0.portfolio_vault_registry;
        get_mut_portfolio_vault(v0, arg1).config.has_next = false;
        let v1 = &mut arg0.deposit_vault_registry;
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::close(get_mut_deposit_vault(v1, arg1));
    }

    entry fun create_additional_configs(arg0: &mut Registry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg0.num_of_vault) {
            if (portfolio_vault_exists(&arg0.portfolio_vault_registry, v0)) {
                if (!0x2::dynamic_object_field::exists_with_type<u64, AdditionalConfig>(&arg0.additional_config_registry, v0)) {
                    let v1 = AdditionalConfig{id: 0x2::object::new(arg1)};
                    0x2::dynamic_object_field::add<u64, AdditionalConfig>(&mut arg0.additional_config_registry, v0, v1);
                };
            };
            v0 = v0 + 1;
        };
    }

    public(friend) fun create_payoff_configs(arg0: vector<u64>, arg1: vector<u64>, arg2: vector<bool>) : vector<PayoffConfig> {
        assert!(0x1::vector::length<u64>(&arg0) > 0, 19);
        assert!(0x1::vector::length<u64>(&arg0) == 0x1::vector::length<u64>(&arg1), 19);
        assert!(0x1::vector::length<u64>(&arg1) == 0x1::vector::length<bool>(&arg2), 19);
        let v0 = 0x1::vector::empty<PayoffConfig>();
        while (!0x1::vector::is_empty<u64>(&arg0)) {
            let v1 = PayoffConfig{
                strike_bp   : 0x1::vector::pop_back<u64>(&mut arg0),
                weight      : 0x1::vector::pop_back<u64>(&mut arg1),
                is_buyer    : 0x1::vector::pop_back<bool>(&mut arg2),
                strike      : 0x1::option::none<u64>(),
                u64_padding : 0x1::vector::empty<u64>(),
            };
            0x1::vector::push_back<PayoffConfig>(&mut v0, v1);
        };
        v0
    }

    public(friend) fun create_scallop_spool_account_<T0>(arg0: &mut Registry, arg1: u64, arg2: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (address, address) {
        let v0 = &mut arg0.additional_config_registry;
        let v1 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::scallop::new_spool_account<T0>(arg2, arg3, arg4);
        0x2::dynamic_field::add<vector<u8>, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut get_mut_additional_config(v0, arg1).id, b"scallop_spool_account", v1);
        (0x2::object::id_address<0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool>(arg2), 0x2::object::id_address<0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&v1))
    }

    public(friend) fun delivery_<T0, T1, T2>(arg0: &mut Registry, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : vector<u64> {
        let v0 = &mut arg0.portfolio_vault_registry;
        let v1 = get_mut_portfolio_vault(v0, arg1);
        let v2 = &mut arg0.deposit_vault_registry;
        let v3 = get_mut_deposit_vault(v2, arg1);
        let v4 = &mut arg0.bid_vault_registry;
        let v5 = get_mut_bid_vault(v4, arg1);
        let v6 = &mut arg0.refund_vault_registry;
        let v7 = get_mut_refund_vault<T1>(v6);
        let v8 = &mut arg0.fee_pool;
        let v9 = &mut arg0.auction_registry;
        assert!(v1.info.status == 2, 3);
        let (v10, v11, v12, v13, v14, v15, v16, v17) = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::dutch::delivery<T1>(v8, v7, take_auction(v9, arg1), arg2, arg3, arg4);
        let v18 = v11;
        let v19 = v10;
        v1.info.delivery_infos.total_delivery_size = v1.info.delivery_infos.total_delivery_size + v13;
        v1.info.delivery_infos.total_bidder_bid_value = v1.info.delivery_infos.total_bidder_bid_value + v14;
        v1.info.delivery_infos.total_bidder_fee = v1.info.delivery_infos.total_bidder_fee + v15;
        v1.info.delivery_infos.total_incentive_bid_value = v1.info.delivery_infos.total_incentive_bid_value + v16;
        v1.info.delivery_infos.total_incentive_fee = v1.info.delivery_infos.total_incentive_fee + v17;
        let v20 = DeliveryInfo{
            auction_type        : 0,
            delivery_price      : v12,
            delivery_size       : v13,
            bidder_bid_value    : v14,
            bidder_fee          : v15,
            incentive_bid_value : v16,
            incentive_fee       : v17,
            ts_ms               : 0x2::clock::timestamp_ms(arg3),
            u64_padding         : 0x1::vector::empty<u64>(),
        };
        0x1::vector::push_back<DeliveryInfo>(&mut v1.info.delivery_infos.delivery_info, v20);
        let v21 = if (v1.config.deposit_incentive_bp > 0 && 0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.id, 0x1::type_name::get<T1>())) {
            let v22 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.id, 0x1::type_name::get<T1>());
            let v23 = 0x2::balance::value<T1>(v22);
            let v24 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::get_u64_padding_value(&v1.config.u64_padding, 0);
            let v25 = v1.info.option_type % 2 == 0 && v1.info.option_type != 6;
            let v26 = if (0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::match_types<T0, T1>()) {
                ((((0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::active_share_supply(v3) + 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::deactivating_share_supply(v3)) as u128) * (v1.config.deposit_incentive_bp as u128) / 10000 / (0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::multiplier(0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::get_u64_padding_value(&v1.config.u64_padding, 3)) as u128)) as u64)
            } else if (0x1::type_name::get<T1>() != v1.info.settlement_base && 0x1::type_name::get<T1>() != v1.info.settlement_quote) {
                ((((0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::active_share_supply(v3) + 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::deactivating_share_supply(v3)) as u128) * (v1.config.deposit_incentive_bp as u128) / 10000 / (0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::multiplier(0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::get_u64_padding_value(&v1.config.u64_padding, 3)) as u128)) as u64)
            } else if (v25) {
                (((((((0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::active_share_supply(v3) + 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::deactivating_share_supply(v3)) as u128) * (v1.config.deposit_incentive_bp as u128) / 10000 / (0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::multiplier(0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::get_u64_padding_value(&v1.config.u64_padding, 3)) as u128)) as u64) as u128) * (v1.info.oracle_info.price as u128) / (0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::multiplier(v1.info.oracle_info.decimal) as u128) * (0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::multiplier(v1.info.b_token_decimal) as u128) / (0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::multiplier(v1.info.d_token_decimal) as u128)) as u64)
            } else {
                (((((((0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::active_share_supply(v3) + 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::deactivating_share_supply(v3)) as u128) * (v1.config.deposit_incentive_bp as u128) / 10000 / (0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::multiplier(0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::get_u64_padding_value(&v1.config.u64_padding, 3)) as u128)) as u64) as u128) * (0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::multiplier(v1.info.oracle_info.decimal) as u128) / (v1.info.oracle_info.price as u128) * (0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::multiplier(v1.info.b_token_decimal) as u128) / (0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::multiplier(v1.info.d_token_decimal) as u128)) as u64)
            };
            let v27 = if (v26 > v23) {
                if (v23 > v24) {
                    v24
                } else {
                    0x2::balance::value<T1>(v22)
                }
            } else if (v26 > v24) {
                v24
            } else {
                v26
            };
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::set_u64_padding_value(&mut v1.config.u64_padding, 0, v24 - v27);
            v27
        } else {
            0
        };
        let v28 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::get_u64_padding_value(&v1.config.u64_padding, 2);
        if (v21 == 0 && v28 == 0) {
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::delivery<T0, T1>(v3, v5, v19);
        } else if (0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::match_types<T1, T2>()) {
            let v29 = 0x2::balance::zero<T1>();
            if (v21 > 0) {
                0x2::balance::join<T1>(&mut v29, 0x2::balance::split<T1>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.id, 0x1::type_name::get<T1>()), v21));
            };
            if (v28 > 0) {
                let v30 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut v1.id, 0x1::type_name::get<T1>());
                0x2::balance::join<T1>(&mut v29, 0x2::balance::split<T1>(v30, v28));
                let v31 = if (v28 < 0x2::balance::value<T1>(v30)) {
                    v28
                } else {
                    0x2::balance::value<T1>(v30)
                };
                0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::set_u64_padding_value(&mut v1.config.u64_padding, 2, v31);
            };
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::delivery_b<T0, T1>(v3, v5, v19, v29, arg4);
        } else {
            if (v21 > 0) {
                0x2::balance::join<T1>(&mut v19, 0x2::balance::split<T1>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.id, 0x1::type_name::get<T1>()), v21));
            };
            let v32 = if (v28 > 0) {
                let v33 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut v1.id, 0x1::type_name::get<T2>());
                let v34 = if (v28 < 0x2::balance::value<T2>(v33)) {
                    v28
                } else {
                    0x2::balance::value<T2>(v33)
                };
                0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::set_u64_padding_value(&mut v1.config.u64_padding, 2, v34);
                0x2::balance::split<T2>(v33, v28)
            } else {
                0x2::balance::zero<T2>()
            };
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::delivery_i<T0, T1, T2>(v3, v5, v19, v32, arg4);
        };
        if (0x2::balance::value<T1>(&v18) > 0) {
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::set_u64_padding_value(&mut v1.config.u64_padding, 0, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::get_u64_padding_value(&v1.config.u64_padding, 0) + 0x2::balance::value<T1>(&v18));
            0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.id, 0x1::type_name::get<T1>()), v18);
        } else {
            0x2::balance::destroy_zero<T1>(v18);
        };
        if (v1.info.delivery_infos.max_size - v1.info.delivery_infos.total_delivery_size > 0) {
            v1.info.status = 3;
        } else {
            v1.info.status = 4;
        };
        let v35 = 0x1::vector::empty<u64>();
        let v36 = &mut v35;
        0x1::vector::push_back<u64>(v36, v12);
        0x1::vector::push_back<u64>(v36, v13);
        0x1::vector::push_back<u64>(v36, v14);
        0x1::vector::push_back<u64>(v36, v15);
        0x1::vector::push_back<u64>(v36, v16);
        0x1::vector::push_back<u64>(v36, v17);
        0x1::vector::push_back<u64>(v36, v21);
        0x1::vector::push_back<u64>(v36, v28);
        0x1::vector::push_back<u64>(v36, v1.config.deposit_incentive_bp);
        0x1::vector::push_back<u64>(v36, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::get_u64_padding_value(&v1.config.u64_padding, 3));
        0x1::vector::push_back<u64>(v36, v1.config.bid_incentive_bp);
        v35
    }

    public(friend) fun deposit_scallop_<T0>(arg0: &mut Registry, arg1: u64, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : vector<u64> {
        let v0 = get_portfolio_vault(&arg0.portfolio_vault_registry, arg1);
        assert!(v0.info.status != 4 && v0.info.status != 5, 3);
        assert!(0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::get_u64_padding_value(&v0.config.u64_padding, 1) == 1, 36);
        let v1 = &mut arg0.deposit_vault_registry;
        let v2 = get_mut_deposit_vault(v1, arg1);
        let v3 = &mut arg0.additional_config_registry;
        let v4 = get_mut_additional_config(v3, arg1);
        assert!(0x2::dynamic_field::exists_with_type<vector<u8>, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&v4.id, b"scallop_spool_account"), 38);
        let v5 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::scallop::deposit<T0>(v2, arg2, arg3, arg4, 0x2::dynamic_field::borrow_mut<vector<u8>, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut v4.id, b"scallop_spool_account"), arg5, arg6);
        0x1::vector::push_back<u64>(&mut v5, v0.info.round);
        v5
    }

    public(friend) fun drop_<T0, T1>(arg0: &mut Registry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let PortfolioVault {
            id        : v0,
            info      : _,
            config    : _,
            authority : v3,
        } = 0x2::dynamic_object_field::remove<u64, PortfolioVault>(&mut arg0.portfolio_vault_registry, arg1);
        let v4 = v3;
        0x2::object::delete(v0);
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::add_authorized_user(&mut v4, 0x2::tx_context::sender(arg2));
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::destroy(v4, arg2);
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::drop_deposit_vault<T0, T1>(0x2::dynamic_object_field::remove<u64, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::DepositVault>(&mut arg0.deposit_vault_registry, arg1));
    }

    public(friend) fun emit_activate_event(arg0: &Registry, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = get_portfolio_vault(&arg0.portfolio_vault_registry, arg1);
        let v1 = ActivateEvent{
            signer          : 0x2::tx_context::sender(arg4),
            index           : arg1,
            round           : v0.info.round,
            deposit_amount  : arg2,
            d_token_decimal : v0.info.d_token_decimal,
            contract_size   : arg3,
            o_token_decimal : v0.info.o_token_decimal,
            oracle_info     : v0.info.oracle_info,
            u64_padding     : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<ActivateEvent>(v1);
    }

    public(friend) fun emit_claim_event(arg0: &PortfolioVault, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = ClaimEvent{
            signer      : 0x2::tx_context::sender(arg2),
            index       : arg0.info.index,
            token       : arg0.info.deposit_token,
            amount      : arg1,
            decimal     : arg0.info.d_token_decimal,
            oracle_info : arg0.info.oracle_info,
            u64_padding : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<ClaimEvent>(v0);
    }

    public(friend) fun emit_close_event(arg0: &Registry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = CloseEvent{
            signer      : 0x2::tx_context::sender(arg2),
            index       : arg1,
            round       : get_portfolio_vault(&arg0.portfolio_vault_registry, arg1).info.round,
            u64_padding : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<CloseEvent>(v0);
    }

    public(friend) fun emit_compound_event(arg0: &PortfolioVault, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, arg2);
        0x1::vector::push_back<u64>(v1, arg3);
        let v2 = CompoundEvent{
            signer      : 0x2::tx_context::sender(arg4),
            index       : arg0.info.index,
            token       : arg0.info.bid_token,
            amount      : arg1,
            decimal     : arg0.info.d_token_decimal,
            oracle_info : arg0.info.oracle_info,
            u64_padding : v0,
        };
        0x2::event::emit<CompoundEvent>(v2);
    }

    public(friend) fun emit_delivery_event(arg0: &Registry, arg1: u64, arg2: bool, arg3: vector<u64>, arg4: &0x2::tx_context::TxContext) {
        let v0 = get_portfolio_vault(&arg0.portfolio_vault_registry, arg1);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, 0x1::vector::pop_back<u64>(&mut arg3));
        0x1::vector::push_back<u64>(v2, v0.info.delivery_infos.max_size);
        0x1::vector::push_back<u64>(v2, 0x1::vector::pop_back<u64>(&mut arg3));
        0x1::vector::push_back<u64>(v2, 0x1::vector::pop_back<u64>(&mut arg3));
        0x1::vector::push_back<u64>(v2, 0x1::vector::pop_back<u64>(&mut arg3));
        let v3 = DeliveryEvent{
            signer                    : 0x2::tx_context::sender(arg4),
            index                     : arg1,
            round                     : v0.info.round,
            early                     : arg2,
            delivery_price            : 0x1::vector::pop_back<u64>(&mut arg3),
            delivery_size             : 0x1::vector::pop_back<u64>(&mut arg3),
            o_token_decimal           : v0.info.o_token_decimal,
            o_token                   : v0.info.settlement_base,
            bidder_bid_value          : 0x1::vector::pop_back<u64>(&mut arg3),
            bidder_fee                : 0x1::vector::pop_back<u64>(&mut arg3),
            incentive_bid_value       : 0x1::vector::pop_back<u64>(&mut arg3),
            incentive_fee             : 0x1::vector::pop_back<u64>(&mut arg3),
            b_token_decimal           : v0.info.b_token_decimal,
            b_token                   : v0.info.bid_token,
            depositor_incentive_value : 0x1::vector::pop_back<u64>(&mut arg3),
            u64_padding               : v1,
        };
        0x2::event::emit<DeliveryEvent>(v3);
    }

    public(friend) fun emit_deposit_event(arg0: &PortfolioVault, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = DepositEvent{
            signer      : 0x2::tx_context::sender(arg2),
            index       : arg0.info.index,
            token       : arg0.info.deposit_token,
            amount      : arg1,
            decimal     : arg0.info.d_token_decimal,
            oracle_info : arg0.info.oracle_info,
            u64_padding : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    public(friend) fun emit_drop_vault_event(arg0: &Registry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = DropVaultEvent{
            signer      : 0x2::tx_context::sender(arg2),
            index       : arg1,
            round       : get_portfolio_vault(&arg0.portfolio_vault_registry, arg1).info.round,
            u64_padding : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<DropVaultEvent>(v0);
    }

    public(friend) fun emit_exercise_event(arg0: &PortfolioVault, arg1: u64, arg2: u64, arg3: 0x1::option::Option<0x1::type_name::TypeName>, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, arg2);
        let v1 = ExerciseEvent{
            signer           : 0x2::tx_context::sender(arg5),
            index            : arg0.info.index,
            token            : arg0.info.deposit_token,
            amount           : arg1,
            decimal          : arg0.info.d_token_decimal,
            incentive_token  : arg3,
            incentive_amount : arg4,
            u64_padding      : v0,
        };
        0x2::event::emit<ExerciseEvent>(v1);
    }

    public(friend) fun emit_harvest_event(arg0: &PortfolioVault, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, arg3);
        let v1 = HarvestEvent{
            signer      : 0x2::tx_context::sender(arg4),
            index       : arg0.info.index,
            token       : arg0.info.bid_token,
            amount      : arg1,
            fee_amount  : arg2,
            decimal     : arg0.info.b_token_decimal,
            oracle_info : arg0.info.oracle_info,
            u64_padding : v0,
        };
        0x2::event::emit<HarvestEvent>(v1);
    }

    public(friend) fun emit_new_auction_event(arg0: &Registry, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        let v0 = get_portfolio_vault(&arg0.portfolio_vault_registry, arg1);
        let v1 = NewAuctionEvent{
            signer       : 0x2::tx_context::sender(arg5),
            index        : arg1,
            round        : v0.info.round,
            start_ts_ms  : arg2,
            end_ts_ms    : arg3,
            size         : arg4,
            vault_config : v0.config.active_vault_config,
            oracle_info  : v0.info.oracle_info,
            u64_padding  : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<NewAuctionEvent>(v1);
    }

    public(friend) fun emit_new_bid_event(arg0: &PortfolioVault, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        let v0 = NewBidEvent{
            signer            : 0x2::tx_context::sender(arg7),
            index             : arg0.info.index,
            bid_index         : arg1,
            price             : arg2,
            size              : arg3,
            b_token           : arg0.info.bid_token,
            o_token           : arg0.info.settlement_base,
            bidder_balance    : arg4,
            incentive_balance : arg5,
            decimal           : arg0.info.b_token_decimal,
            ts_ms             : arg6,
            oracle_info       : arg0.info.oracle_info,
            u64_padding       : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<NewBidEvent>(v0);
    }

    public(friend) fun emit_otc_event(arg0: &Registry, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::tx_context::TxContext) {
        let v0 = get_portfolio_vault(&arg0.portfolio_vault_registry, arg1);
        let v1 = OtcEvent{
            signer                    : 0x2::tx_context::sender(arg9),
            index                     : arg1,
            round                     : v0.info.round,
            delivery_price            : arg2,
            delivery_size             : arg3,
            o_token_decimal           : v0.info.o_token_decimal,
            bidder_bid_value          : arg4,
            bidder_fee                : arg5,
            incentive_bid_value       : arg6,
            incentive_fee             : arg7,
            b_token_decimal           : v0.info.b_token_decimal,
            depositor_incentive_value : arg8,
            u64_padding               : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<OtcEvent>(v1);
    }

    public(friend) fun emit_recoup_event(arg0: &Registry, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = get_portfolio_vault(&arg0.portfolio_vault_registry, arg1);
        let v1 = RecoupEvent{
            signer              : 0x2::tx_context::sender(arg4),
            index               : arg1,
            round               : v0.info.round,
            active_amount       : arg2,
            deactivating_amount : arg3,
            d_token_decimal     : v0.info.d_token_decimal,
            u64_padding         : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<RecoupEvent>(v1);
    }

    public(friend) fun emit_redeem_event(arg0: &PortfolioVault, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, arg3);
        0x1::vector::push_back<u64>(v1, arg4);
        let v2 = RedeemEvent{
            signer      : 0x2::tx_context::sender(arg5),
            index       : arg0.info.index,
            token       : arg1,
            amount      : arg2,
            oracle_info : arg0.info.oracle_info,
            u64_padding : v0,
        };
        0x2::event::emit<RedeemEvent>(v2);
    }

    public(friend) fun emit_refund_event(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = RefundEvent{
            signer      : 0x2::tx_context::sender(arg2),
            token       : arg0,
            amount      : arg1,
            u64_padding : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<RefundEvent>(v0);
    }

    public(friend) fun emit_settle_event(arg0: &Registry, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        let v0 = get_portfolio_vault(&arg0.portfolio_vault_registry, arg1);
        let v1 = SettleEvent{
            signer               : 0x2::tx_context::sender(arg7),
            index                : arg1,
            round                : v0.info.round,
            oracle_price         : arg2,
            oracle_price_decimal : arg3,
            settle_balance       : arg4,
            settled_balance      : arg5,
            d_token_decimal      : v0.info.d_token_decimal,
            d_token              : v0.info.deposit_token,
            share_price          : arg6,
            u64_padding          : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<SettleEvent>(v1);
    }

    public(friend) fun emit_termiante_vault_event(arg0: &Registry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = TerminateVaultEvent{
            signer      : 0x2::tx_context::sender(arg2),
            index       : arg1,
            round       : get_portfolio_vault(&arg0.portfolio_vault_registry, arg1).info.round,
            u64_padding : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<TerminateVaultEvent>(v0);
    }

    public(friend) fun emit_terminate_auction_event(arg0: &Registry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = TerminateAuctionEvent{
            signer      : 0x2::tx_context::sender(arg2),
            index       : arg1,
            round       : get_portfolio_vault(&arg0.portfolio_vault_registry, arg1).info.round,
            u64_padding : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<TerminateAuctionEvent>(v0);
    }

    public(friend) fun emit_transfer_bid_receipt_event(arg0: &PortfolioVault, arg1: u64, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let v0 = TransferBidReceiptEvent{
            signer      : 0x2::tx_context::sender(arg3),
            index       : arg0.info.index,
            amount      : arg1,
            decimal     : arg0.info.o_token_decimal,
            recipient   : arg2,
            oracle_info : arg0.info.oracle_info,
            u64_padding : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<TransferBidReceiptEvent>(v0);
    }

    public(friend) fun emit_unsubscribe_event(arg0: &PortfolioVault, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = UnsubscribeEvent{
            signer      : 0x2::tx_context::sender(arg2),
            index       : arg0.info.index,
            token       : arg0.info.deposit_token,
            amount      : arg1,
            decimal     : arg0.info.d_token_decimal,
            oracle_info : arg0.info.oracle_info,
            u64_padding : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<UnsubscribeEvent>(v0);
    }

    public(friend) fun emit_withdraw_event(arg0: &PortfolioVault, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = WithdrawEvent{
            signer      : 0x2::tx_context::sender(arg2),
            index       : arg0.info.index,
            token       : arg0.info.deposit_token,
            amount      : arg1,
            decimal     : arg0.info.d_token_decimal,
            oracle_info : arg0.info.oracle_info,
            u64_padding : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    public(friend) fun fixed_incentivise_<T0>(arg0: &mut Registry, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u64) : u64 {
        let v0 = &mut arg0.portfolio_vault_registry;
        let v1 = get_mut_portfolio_vault(v0, arg1);
        let v2 = &mut arg0.deposit_vault_registry;
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::update_deposit_vault_incentive_token<T0>(get_mut_deposit_vault(v2, arg1));
        if (0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&v1.id, 0x1::type_name::get<T0>())) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, 0x1::type_name::get<T0>()), 0x2::coin::into_balance<T0>(arg2));
        } else {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, 0x1::type_name::get<T0>(), 0x2::coin::into_balance<T0>(arg2));
        };
        let v3 = 0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&v1.id, 0x1::type_name::get<T0>()));
        let v4 = if (arg3 < v3) {
            arg3
        } else {
            v3
        };
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::set_u64_padding_value(&mut v1.config.u64_padding, 2, v4);
        0x2::coin::value<T0>(&arg2)
    }

    public(friend) fun get_additional_config(arg0: &0x2::object::UID, arg1: u64) : &AdditionalConfig {
        0x2::dynamic_object_field::borrow<u64, AdditionalConfig>(arg0, arg1)
    }

    public(friend) fun get_auction(arg0: &0x2::object::UID, arg1: u64) : &0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::dutch::Auction {
        assert!(auction_exists(arg0, arg1), 1);
        0x2::dynamic_object_field::borrow<u64, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::dutch::Auction>(arg0, arg1)
    }

    public(friend) fun get_bid_vault(arg0: &0x2::object::UID, arg1: u64) : &0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::BidVault {
        0x2::dynamic_object_field::borrow<u64, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::BidVault>(arg0, arg1)
    }

    public(friend) fun get_bid_vault_by_id_or_index(arg0: &0x2::object::UID, arg1: &0x2::object::ID, arg2: u64) : &0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::BidVault {
        if (0x2::dynamic_object_field::exists_with_type<address, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::BidVault>(arg0, 0x2::object::id_to_address(arg1))) {
            0x2::dynamic_object_field::borrow<address, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::BidVault>(arg0, 0x2::object::id_to_address(arg1))
        } else {
            get_bid_vault(arg0, arg2)
        }
    }

    public(friend) fun get_deposit_vault(arg0: &0x2::object::UID, arg1: u64) : &0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::DepositVault {
        0x2::dynamic_object_field::borrow<u64, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::DepositVault>(arg0, arg1)
    }

    public(friend) fun get_mut_additional_config(arg0: &mut 0x2::object::UID, arg1: u64) : &mut AdditionalConfig {
        0x2::dynamic_object_field::borrow_mut<u64, AdditionalConfig>(arg0, arg1)
    }

    public(friend) fun get_mut_auction(arg0: &mut 0x2::object::UID, arg1: u64) : &mut 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::dutch::Auction {
        assert!(auction_exists(arg0, arg1), 1);
        0x2::dynamic_object_field::borrow_mut<u64, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::dutch::Auction>(arg0, arg1)
    }

    public(friend) fun get_mut_bid_vault(arg0: &mut 0x2::object::UID, arg1: u64) : &mut 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::BidVault {
        0x2::dynamic_object_field::borrow_mut<u64, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::BidVault>(arg0, arg1)
    }

    public(friend) fun get_mut_bid_vault_by_id(arg0: &mut 0x2::object::UID, arg1: &0x2::object::ID) : &mut 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::BidVault {
        0x2::dynamic_object_field::borrow_mut<address, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::BidVault>(arg0, 0x2::object::id_to_address(arg1))
    }

    public(friend) fun get_mut_bid_vault_by_id_or_index(arg0: &mut 0x2::object::UID, arg1: &0x2::object::ID, arg2: u64) : &mut 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::BidVault {
        if (0x2::dynamic_object_field::exists_with_type<address, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::BidVault>(arg0, 0x2::object::id_to_address(arg1))) {
            0x2::dynamic_object_field::borrow_mut<address, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::BidVault>(arg0, 0x2::object::id_to_address(arg1))
        } else {
            get_mut_bid_vault(arg0, arg2)
        }
    }

    public(friend) fun get_mut_deposit_vault(arg0: &mut 0x2::object::UID, arg1: u64) : &mut 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::DepositVault {
        0x2::dynamic_object_field::borrow_mut<u64, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::DepositVault>(arg0, arg1)
    }

    public(friend) fun get_mut_portfolio_vault(arg0: &mut 0x2::object::UID, arg1: u64) : &mut PortfolioVault {
        0x2::dynamic_object_field::borrow_mut<u64, PortfolioVault>(arg0, arg1)
    }

    public(friend) fun get_mut_portfolio_vault_authority(arg0: &mut PortfolioVault) : &mut 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::Authority {
        &mut arg0.authority
    }

    public(friend) fun get_mut_refund_vault<T0>(arg0: &mut 0x2::object::UID) : &mut 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::RefundVault {
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::RefundVault>(arg0, 0x1::type_name::get<T0>())
    }

    public(friend) fun get_mut_registry_inner(arg0: &mut Registry) : (&mut 0x2::object::UID, &mut u64, &mut 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::Authority, &mut 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::balance_pool::BalancePool, &mut 0x2::object::UID, &mut 0x2::object::UID, &mut 0x2::object::UID, &mut 0x2::object::UID, &mut 0x2::object::UID, &mut 0x2::object::UID, &mut u64, &mut bool) {
        (&mut arg0.id, &mut arg0.num_of_vault, &mut arg0.authority, &mut arg0.fee_pool, &mut arg0.portfolio_vault_registry, &mut arg0.deposit_vault_registry, &mut arg0.auction_registry, &mut arg0.bid_vault_registry, &mut arg0.refund_vault_registry, &mut arg0.additional_config_registry, &mut arg0.version, &mut arg0.transaction_suspended)
    }

    public(friend) fun get_mut_scallop_spool_account<T0>(arg0: &mut Registry, arg1: u64) : &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>> {
        let v0 = &mut arg0.additional_config_registry;
        0x2::dynamic_field::borrow_mut<vector<u8>, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut get_mut_additional_config(v0, arg1).id, b"scallop_spool_account")
    }

    public(friend) fun get_new_bid_incentive_balance<T0>(arg0: &mut 0x2::object::UID, arg1: &mut PortfolioVault, arg2: &0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::dutch::Auction, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::zero<T0>();
        if (arg1.config.bid_incentive_bp > 0 && 0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, 0x1::type_name::get<T0>())) {
            let (_, _, v3, v4) = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::dutch::get_bid_info(arg2, arg3, arg4, 0x2::clock::timestamp_ms(arg5));
            let v5 = ((((v3 + v4) as u128) * (arg1.config.bid_incentive_bp as u128) / 10000) as u64);
            let v6 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, 0x1::type_name::get<T0>());
            let v7 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::get_u64_padding_value(&arg1.config.u64_padding, 0);
            let v8 = if (0x2::balance::value<T0>(v6) > v5) {
                if (v7 >= v5) {
                    0x2::balance::join<T0>(&mut v0, 0x2::balance::split<T0>(v6, v5));
                    v5
                } else {
                    0x2::balance::join<T0>(&mut v0, 0x2::balance::split<T0>(v6, v7));
                    v7
                }
            } else if (v7 >= 0x2::balance::value<T0>(v6)) {
                0x2::balance::join<T0>(&mut v0, 0x2::balance::withdraw_all<T0>(v6));
                0x2::balance::value<T0>(v6)
            } else {
                0x2::balance::join<T0>(&mut v0, 0x2::balance::split<T0>(v6, v7));
                v7
            };
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::set_u64_padding_value(&mut arg1.config.u64_padding, 0, v7 - v8);
        };
        v0
    }

    public(friend) fun get_otc_incentive_balance<T0>(arg0: &mut 0x2::object::UID, arg1: &mut PortfolioVault, arg2: u64, arg3: u64, arg4: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0x2::balance::zero<T0>();
        let v2 = 0x2::balance::zero<T0>();
        if (0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, 0x1::type_name::get<T0>())) {
            let v3 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, 0x1::type_name::get<T0>());
            let v4 = &mut v0;
            let v5 = request_incentive<T0>(v3, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::get_u64_padding_value(&arg1.config.u64_padding, 0), arg2, v4);
            let v6 = &mut v1;
            let v7 = request_incentive<T0>(v3, v5, arg3, v6);
            let v8 = &mut v2;
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::set_u64_padding_value(&mut arg1.config.u64_padding, 0, request_incentive<T0>(v3, v7, arg4, v8));
        };
        (v0, v1, v2)
    }

    public(friend) fun get_portfolio_vault(arg0: &0x2::object::UID, arg1: u64) : &PortfolioVault {
        0x2::dynamic_object_field::borrow<u64, PortfolioVault>(arg0, arg1)
    }

    public(friend) fun get_portfolio_vault_authority(arg0: &PortfolioVault) : &0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::Authority {
        &arg0.authority
    }

    public(friend) fun get_refund_vault<T0>(arg0: &0x2::object::UID) : &0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::RefundVault {
        0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::RefundVault>(arg0, 0x1::type_name::get<T0>())
    }

    public(friend) fun get_registry_inner(arg0: &Registry) : (&0x2::object::UID, &u64, &0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::Authority, &0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::balance_pool::BalancePool, &0x2::object::UID, &0x2::object::UID, &0x2::object::UID, &0x2::object::UID, &0x2::object::UID, &0x2::object::UID, &u64, &bool) {
        (&arg0.id, &arg0.num_of_vault, &arg0.authority, &arg0.fee_pool, &arg0.portfolio_vault_registry, &arg0.deposit_vault_registry, &arg0.auction_registry, &arg0.bid_vault_registry, &arg0.refund_vault_registry, &arg0.additional_config_registry, &arg0.version, &arg0.transaction_suspended)
    }

    public(friend) fun get_scallop_deposit_amount<T0>(arg0: &Registry, arg1: u64) : u64 {
        let v0 = get_additional_config(&arg0.additional_config_registry, arg1);
        if (0x2::dynamic_field::exists_<vector<u8>>(&v0.id, b"scallop_spool_account")) {
            0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::stake_amount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::dynamic_field::borrow<vector<u8>, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&v0.id, b"scallop_spool_account"))
        } else {
            0
        }
    }

    public(friend) fun get_version() : u64 {
        16
    }

    public(friend) fun incentivise_<T0>(arg0: &mut Registry, arg1: 0x2::coin::Coin<T0>) : u64 {
        if (0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.id, 0x1::type_name::get<T0>())) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::type_name::get<T0>()), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::type_name::get<T0>(), 0x2::coin::into_balance<T0>(arg1));
        };
        0x2::coin::value<T0>(&arg1)
    }

    fun init(arg0: TYPUS_DOV_SINGLE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<TYPUS_DOV_SINGLE>(arg0, arg1);
        new_registry_(arg1);
    }

    public(friend) fun new_auction_<T0>(arg0: &mut Registry, arg1: u64, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = &mut arg0.portfolio_vault_registry;
        let v1 = get_mut_portfolio_vault(v0, arg1);
        assert!(!auction_exists(&arg0.auction_registry, arg1), 0);
        assert!(v1.info.status == 1 || v1.info.status == 3, 3);
        let v2 = v1.info.activation_ts_ms + 0x1::option::get_with_default<u64>(&arg2, v1.config.auction_delay_ts_ms);
        assert!(v2 < v1.info.expiration_ts_ms, 5);
        let v3 = v2 + 0x1::option::get_with_default<u64>(&arg3, v1.config.auction_duration_ts_ms);
        let v4 = v1.info.delivery_infos.max_size - v1.info.delivery_infos.total_delivery_size;
        0x2::dynamic_object_field::add<u64, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::dutch::Auction>(&mut arg0.auction_registry, arg1, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::dutch::new<T0>(arg1, v2, v3, v4, v1.config.active_vault_config.decay_speed, v1.config.active_vault_config.initial_price, v1.config.active_vault_config.final_price, v1.config.bid_fee_bp, v1.config.bid_incentive_bp, v1.info.b_token_decimal, v1.info.o_token_decimal, false, arg4));
        v1.info.status = 2;
        (v2, v3, v4)
    }

    public(friend) fun new_portfolio_vault_<T0, T1>(arg0: &mut Registry, arg1: u64, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: u64, arg25: bool, arg26: vector<PayoffConfig>, arg27: u64, arg28: u64, arg29: u64, arg30: u64, arg31: vector<address>, arg32: &0x2::clock::Clock, arg33: &mut 0x2::tx_context::TxContext) : (u64, Info, Config) {
        let v0 = 0x2::clock::timestamp_ms(arg32);
        assert!(arg6 >= v0, 4);
        assert!(arg7 > arg6, 12);
        validate_dutch_auction_settings(arg29, arg30, arg20);
        if (arg2 == 0) {
            assert!(arg7 - arg6 == 86400000, 12);
        } else if (arg2 == 1) {
            assert!(arg7 - arg6 == 604800000, 12);
        } else if (arg2 == 2) {
            assert!(arg7 - arg6 == 2419200000 || arg7 - arg6 == 3024000000, 12);
        } else if (arg2 == 3) {
            assert!(arg7 - arg6 == 3600000, 12);
        } else {
            assert!(arg2 == 4, 20);
            assert!(arg7 - arg6 == 600000, 12);
        };
        assert!(arg9 > 0, 10);
        assert!(arg11 >= arg9, 16);
        assert!(arg10 > 0, 8);
        assert!(arg12 >= arg10, 15);
        let (v1, v2) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price(arg8, arg32);
        let (v3, v4, v5, v6) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_token(arg8);
        let v7 = arg0.num_of_vault;
        let v8 = VaultConfig{
            payoff_configs   : arg26,
            strike_increment : arg27,
            decay_speed      : arg28,
            initial_price    : arg29,
            final_price      : arg30,
            u64_padding      : 0x1::vector::empty<u64>(),
        };
        let v9 = OracleInfo{
            price   : v1,
            decimal : v2,
        };
        let v10 = DeliveryInfos{
            round                     : 0,
            max_size                  : 0,
            total_delivery_size       : 0,
            total_bidder_bid_value    : 0,
            total_bidder_fee          : 0,
            total_incentive_bid_value : 0,
            total_incentive_fee       : 0,
            delivery_info             : 0x1::vector::empty<DeliveryInfo>(),
            u64_padding               : 0x1::vector::empty<u64>(),
        };
        let v11 = Info{
            index                 : v7,
            option_type           : arg1,
            period                : arg2,
            activation_ts_ms      : arg6,
            expiration_ts_ms      : arg7,
            deposit_token         : 0x1::type_name::get<T0>(),
            bid_token             : 0x1::type_name::get<T1>(),
            settlement_base       : v5,
            settlement_quote      : v6,
            settlement_base_name  : 0x1::string::from_ascii(v3),
            settlement_quote_name : 0x1::string::from_ascii(v4),
            d_token_decimal       : arg3,
            b_token_decimal       : arg4,
            o_token_decimal       : arg5,
            creator               : 0x2::tx_context::sender(arg33),
            create_ts_ms          : v0,
            round                 : 0,
            status                : 0,
            oracle_info           : v9,
            delivery_infos        : v10,
            settlement_info       : 0x1::option::none<SettlementInfo>(),
            u64_padding           : 0x1::vector::empty<u64>(),
            bcs_padding           : 0x1::vector::empty<u8>(),
        };
        let v12 = Config{
            oracle_id               : 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg8),
            deposit_lot_size        : arg9,
            bid_lot_size            : arg10,
            min_deposit_size        : arg11,
            min_bid_size            : arg12,
            max_deposit_entry       : arg13,
            max_bid_entry           : arg14,
            deposit_fee_bp          : arg15,
            deposit_fee_share_bp    : 0,
            deposit_shared_fee_pool : 0x1::option::none<vector<u8>>(),
            bid_fee_bp              : arg16,
            deposit_incentive_bp    : arg17,
            bid_incentive_bp        : arg18,
            auction_delay_ts_ms     : arg19,
            auction_duration_ts_ms  : arg20,
            recoup_delay_ts_ms      : arg21,
            capacity                : arg22,
            leverage                : arg23,
            risk_level              : arg24,
            has_next                : arg25,
            active_vault_config     : v8,
            warmup_vault_config     : v8,
            u64_padding             : 0x1::vector::empty<u64>(),
            bcs_padding             : 0x1::vector::empty<u8>(),
        };
        let v13 = PortfolioVault{
            id        : 0x2::object::new(arg33),
            info      : v11,
            config    : v12,
            authority : 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::new(arg31, arg33),
        };
        0x2::dynamic_object_field::add<u64, PortfolioVault>(&mut arg0.portfolio_vault_registry, v7, v13);
        let v14 = 0x1::string::from_ascii(v3);
        if (arg2 == 0) {
            0x1::string::append_utf8(&mut v14, b"-Daily");
        } else if (arg2 == 1) {
            0x1::string::append_utf8(&mut v14, b"-Weekly");
        } else if (arg2 == 2) {
            0x1::string::append_utf8(&mut v14, b"-Monthly");
        } else if (arg2 == 3) {
            0x1::string::append_utf8(&mut v14, b"-Hourly");
        } else if (arg2 == 4) {
            0x1::string::append_utf8(&mut v14, b"-10 Minutely");
        };
        if (arg1 == 0) {
            0x1::string::append_utf8(&mut v14, b"-Call");
        } else if (arg1 == 1) {
            0x1::string::append_utf8(&mut v14, b"-Put");
        } else if (arg1 == 2) {
            0x1::string::append_utf8(&mut v14, b"-CallSpread");
        } else if (arg1 == 3) {
            0x1::string::append_utf8(&mut v14, b"-PutSpread");
        } else if (arg1 == 4) {
            0x1::string::append_utf8(&mut v14, b"-CappedCall");
        } else if (arg1 == 5) {
            0x1::string::append_utf8(&mut v14, b"-CappedPut");
        } else if (arg1 == 6) {
            if (0x1::ascii::into_bytes(v4) == b"USDT") {
                0x1::string::append_utf8(&mut v14, b"-UsdtCappedCall");
            } else if (0x1::ascii::into_bytes(v4) == b"USDC") {
                0x1::string::append_utf8(&mut v14, b"-UsdcCappedCall");
            } else {
                0x1::string::append_utf8(&mut v14, b"-UsdCappedCall");
            };
        };
        0x2::dynamic_object_field::add<u64, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::DepositVault>(&mut arg0.deposit_vault_registry, v7, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::new_deposit_vault<T0, T1>(v7, arg15, v14, arg33));
        let v15 = AdditionalConfig{id: 0x2::object::new(arg33)};
        0x2::dynamic_object_field::add<u64, AdditionalConfig>(&mut arg0.additional_config_registry, v7, v15);
        if (!0x2::dynamic_object_field::exists_with_type<0x1::type_name::TypeName, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::RefundVault>(&arg0.refund_vault_registry, 0x1::type_name::get<T1>())) {
            0x2::dynamic_object_field::add<0x1::type_name::TypeName, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::RefundVault>(&mut arg0.refund_vault_registry, 0x1::type_name::get<T1>(), 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::new_refund_vault<T1>(arg33));
        };
        arg0.num_of_vault = arg0.num_of_vault + 1;
        (v7, v11, v12)
    }

    public(friend) fun new_registry_(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id                         : 0x2::object::new(arg0),
            num_of_vault               : 0,
            authority                  : 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::new(0x1::vector::singleton<address>(0x2::tx_context::sender(arg0)), arg0),
            fee_pool                   : 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::balance_pool::new(0x1::vector::singleton<address>(0x2::tx_context::sender(arg0)), arg0),
            portfolio_vault_registry   : 0x2::object::new(arg0),
            deposit_vault_registry     : 0x2::object::new(arg0),
            auction_registry           : 0x2::object::new(arg0),
            bid_vault_registry         : 0x2::object::new(arg0),
            refund_vault_registry      : 0x2::object::new(arg0),
            additional_config_registry : 0x2::object::new(arg0),
            version                    : 16,
            transaction_suspended      : false,
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public(friend) fun operation_check(arg0: &Registry) {
        assert!(!arg0.transaction_suspended, 34);
    }

    public(friend) fun oracle_check(arg0: &Registry, arg1: u64, arg2: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle) {
        assert!(get_portfolio_vault(&arg0.portfolio_vault_registry, arg1).config.oracle_id == 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg2), 18);
    }

    public(friend) fun otc_<T0, T1>(arg0: &mut Registry, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2::balance::Balance<T1>, arg5: 0x2::balance::Balance<T1>, arg6: 0x2::balance::Balance<T1>, arg7: 0x2::balance::Balance<T1>, arg8: 0x2::balance::Balance<T1>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.portfolio_vault_registry;
        let v1 = get_mut_portfolio_vault(v0, arg1);
        let v2 = &mut arg0.deposit_vault_registry;
        let v3 = get_mut_deposit_vault(v2, arg1);
        let v4 = &mut arg0.bid_vault_registry;
        let v5 = get_mut_bid_vault(v4, arg1);
        assert!(!auction_exists(&arg0.auction_registry, arg1), 0);
        assert!(v1.info.status == 1 || v1.info.status == 3, 3);
        assert!((((arg2 as u128) * (arg3 as u128) / (0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::multiplier(v1.info.o_token_decimal) as u128)) as u64) <= 0x2::balance::value<T1>(&arg4) + 0x2::balance::value<T1>(&arg6), 2);
        let v6 = 0x2::balance::value<T1>(&arg5);
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::balance_pool::put<T1>(&mut arg0.fee_pool, arg5);
        let v7 = 0x2::balance::value<T1>(&arg7);
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::balance_pool::put<T1>(&mut arg0.fee_pool, arg7);
        let v8 = 0x2::balance::value<T1>(&arg4);
        let v9 = 0x2::balance::value<T1>(&arg6);
        0x2::balance::join<T1>(&mut arg4, arg6);
        v1.info.delivery_infos.total_delivery_size = v1.info.delivery_infos.total_delivery_size + arg3;
        v1.info.delivery_infos.total_bidder_bid_value = v1.info.delivery_infos.total_bidder_bid_value + v8;
        v1.info.delivery_infos.total_bidder_fee = v1.info.delivery_infos.total_bidder_fee + v6;
        v1.info.delivery_infos.total_incentive_bid_value = v1.info.delivery_infos.total_incentive_bid_value + v9;
        v1.info.delivery_infos.total_incentive_fee = v1.info.delivery_infos.total_incentive_fee + v7;
        let v10 = DeliveryInfo{
            auction_type        : 1,
            delivery_price      : arg2,
            delivery_size       : arg3,
            bidder_bid_value    : v8,
            bidder_fee          : v6,
            incentive_bid_value : v9,
            incentive_fee       : v7,
            ts_ms               : 0x2::clock::timestamp_ms(arg9),
            u64_padding         : 0x1::vector::empty<u64>(),
        };
        0x1::vector::push_back<DeliveryInfo>(&mut v1.info.delivery_infos.delivery_info, v10);
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::new_bid(v5, arg3, arg10);
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::delivery_b<T0, T1>(v3, v5, arg4, arg8, arg10);
        if (v1.info.delivery_infos.total_delivery_size == v1.info.delivery_infos.max_size) {
            v1.info.status = 4;
        };
    }

    public(friend) fun portfolio_vault_exists(arg0: &0x2::object::UID, arg1: u64) : bool {
        0x2::dynamic_object_field::exists_with_type<u64, PortfolioVault>(arg0, arg1)
    }

    public(friend) fun portfolio_vault_token_check<T0, T1>(arg0: &Registry, arg1: u64) {
        let v0 = get_portfolio_vault(&arg0.portfolio_vault_registry, arg1);
        assert!(0x1::type_name::get<T0>() == v0.info.deposit_token, 11);
        assert!(0x1::type_name::get<T1>() == v0.info.bid_token, 9);
    }

    public(friend) fun recoup_<T0>(arg0: &mut Registry, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : (u64, u64) {
        assert!(get_scallop_deposit_amount<T0>(arg0, arg1) == 0, 37);
        let v0 = &mut arg0.portfolio_vault_registry;
        let v1 = get_mut_portfolio_vault(v0, arg1);
        let v2 = &mut arg0.deposit_vault_registry;
        let v3 = get_mut_deposit_vault(v2, arg1);
        assert!(0x2::clock::timestamp_ms(arg2) >= v1.info.activation_ts_ms + v1.config.recoup_delay_ts_ms, 30);
        assert!(v1.info.status == 3, 3);
        v1.info.status = 4;
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::recoup<T0>(v3, ((((0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::active_share_supply(v3) + 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::deactivating_share_supply(v3)) as u128) * ((v1.info.delivery_infos.max_size - v1.info.delivery_infos.total_delivery_size) as u128) / (v1.info.delivery_infos.max_size as u128)) as u64), arg3)
    }

    public(friend) fun refund_vault_exists<T0>(arg0: &0x2::object::UID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x1::type_name::TypeName, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::RefundVault>(arg0, 0x1::type_name::get<T0>())
    }

    public(friend) fun request_incentive<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::balance::Balance<T0>) : u64 {
        let v0 = if (arg1 >= arg2) {
            arg2
        } else {
            arg1
        };
        if (0x2::balance::value<T0>(arg0) > v0) {
            arg1 = arg1 - v0;
            0x2::balance::join<T0>(arg3, 0x2::balance::split<T0>(arg0, arg2));
        } else {
            arg1 = arg1 - 0x2::balance::value<T0>(arg0);
            0x2::balance::join<T0>(arg3, 0x2::balance::withdraw_all<T0>(arg0));
        };
        arg1
    }

    public(friend) fun resume_transaction_(arg0: &mut Registry) {
        assert!(arg0.transaction_suspended, 32);
        arg0.transaction_suspended = false;
    }

    public(friend) fun set_available_incentive_amount_(arg0: &mut Registry, arg1: u64, arg2: u64) : u64 {
        let v0 = &mut arg0.portfolio_vault_registry;
        let v1 = get_mut_portfolio_vault(v0, arg1);
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::set_u64_padding_value(&mut v1.config.u64_padding, 0, arg2);
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::get_u64_padding_value(&v1.config.u64_padding, 0)
    }

    public(friend) fun set_enable_scallop_flag_(arg0: &mut Registry, arg1: u64, arg2: bool) {
        let v0 = &mut arg0.portfolio_vault_registry;
        if (arg2) {
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::set_u64_padding_value(&mut get_mut_portfolio_vault(v0, arg1).config.u64_padding, 1, 1);
        } else {
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::set_u64_padding_value(&mut get_mut_portfolio_vault(v0, arg1).config.u64_padding, 1, 0);
        };
    }

    public(friend) fun settle_<T0, T1>(arg0: &mut Registry, arg1: u64, arg2: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64) {
        assert!(get_scallop_deposit_amount<T0>(arg0, arg1) == 0, 37);
        let v0 = &mut arg0.portfolio_vault_registry;
        let v1 = get_mut_portfolio_vault(v0, arg1);
        let v2 = &mut arg0.deposit_vault_registry;
        let v3 = get_mut_deposit_vault(v2, arg1);
        let v4 = &mut arg0.bid_vault_registry;
        let v5 = get_mut_bid_vault(v4, arg1);
        assert!(0x2::clock::timestamp_ms(arg3) >= v1.info.expiration_ts_ms, 29);
        assert!(v1.info.status == 4, 3);
        v1.info.status = 5;
        let (v6, v7) = if (v1.info.period == 1 || v1.info.period == 2) {
            0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_twap_price(arg2, arg3)
        } else {
            0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price(arg2, arg3)
        };
        let v8 = calculate_portfolio_payoff_by_price(v1.info.option_type, v6, v7, v1.info.d_token_decimal, v1.config.active_vault_config.payoff_configs, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::multiplier(2), v1.info.delivery_infos.total_delivery_size, v1.info.o_token_decimal);
        let v9 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::active_balance<T0>(v3) + 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::deactivating_balance<T0>(v3);
        let v10 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::i64::from(v9);
        let v11 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::i64::add(&v10, &v8);
        let v12 = if (v9 != 0) {
            (((0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::multiplier(8) as u128) * (0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::i64::as_u64(&v11) as u128) / (v9 as u128)) as u64)
        } else {
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::multiplier(8)
        };
        let v13 = 8;
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::settle<T0, T1>(v3, v5, v12, v13, arg4);
        let v14 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::active_balance<T0>(v3) + 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::inactive_balance<T0>(v3) - 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::inactive_balance<T0>(v3);
        let v15 = SettlementInfo{
            round                : v1.info.round,
            oracle_price         : v6,
            oracle_price_decimal : v7,
            settle_balance       : v9,
            settled_balance      : v14,
            share_price          : v12,
            share_price_decimal  : v13,
            ts_ms                : 0x2::clock::timestamp_ms(arg3),
            u64_padding          : 0x1::vector::empty<u64>(),
        };
        v1.info.settlement_info = 0x1::option::some<SettlementInfo>(v15);
        v1.info.activation_ts_ms = v1.info.expiration_ts_ms;
        if (v1.info.period == 0) {
            v1.info.expiration_ts_ms = v1.info.expiration_ts_ms + 86400000;
        } else if (v1.info.period == 1) {
            v1.info.expiration_ts_ms = v1.info.expiration_ts_ms + 604800000;
        } else if (v1.info.period == 2) {
            let (_, v17, _) = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::get_date_from_ts(v1.info.expiration_ts_ms / 1000 + 2419200);
            let (_, v20, _) = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::get_date_from_ts(v1.info.expiration_ts_ms / 1000 + 3024000);
            if (v17 != v20) {
                v1.info.expiration_ts_ms = v1.info.expiration_ts_ms + 2419200000;
            } else {
                v1.info.expiration_ts_ms = v1.info.expiration_ts_ms + 3024000000;
            };
        } else if (v1.info.period == 3) {
            v1.info.expiration_ts_ms = v1.info.expiration_ts_ms + 3600000;
        } else if (v1.info.period == 4) {
            v1.info.expiration_ts_ms = v1.info.expiration_ts_ms + 600000;
        };
        let v22 = 0x2::dynamic_object_field::remove<u64, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::BidVault>(&mut arg0.bid_vault_registry, arg1);
        if (0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::bid_share_supply(&v22) == 0) {
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::drop_bid_vault<T0>(v22);
        } else {
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::set_bid_vault_u64_padding_value(&mut v22, 0, v6);
            0x2::dynamic_object_field::add<address, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::BidVault>(&mut arg0.bid_vault_registry, 0x2::object::id_address<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::BidVault>(&v22), v22);
        };
        (v6, v7, v9, v14, v12)
    }

    public(friend) fun suspend_transaction_(arg0: &mut Registry) {
        assert!(!arg0.transaction_suspended, 33);
        arg0.transaction_suspended = true;
    }

    public(friend) fun take_auction(arg0: &mut 0x2::object::UID, arg1: u64) : 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::dutch::Auction {
        assert!(auction_exists(arg0, arg1), 1);
        0x2::dynamic_object_field::remove<u64, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::dutch::Auction>(arg0, arg1)
    }

    public(friend) fun terminate_<T0>(arg0: &mut Registry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = &mut arg0.portfolio_vault_registry;
        let v1 = get_mut_portfolio_vault(v0, arg1);
        v1.config.has_next = false;
        v1.info.status = 5;
        let v2 = &mut arg0.deposit_vault_registry;
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::terminate<T0>(get_mut_deposit_vault(v2, arg1), arg2);
    }

    public(friend) fun update_active_vault_config_(arg0: &mut Registry, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (VaultConfig, VaultConfig) {
        let v0 = &mut arg0.portfolio_vault_registry;
        let v1 = get_mut_portfolio_vault(v0, arg1);
        validate_dutch_auction_settings(arg4, arg5, v1.config.auction_duration_ts_ms);
        v1.config.active_vault_config.strike_increment = arg2;
        v1.config.active_vault_config.decay_speed = arg3;
        v1.config.active_vault_config.initial_price = arg4;
        v1.config.active_vault_config.final_price = arg5;
        (v1.config.active_vault_config, v1.config.active_vault_config)
    }

    public(friend) fun update_auction_config_(arg0: &mut Registry, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: bool, arg12: &0x2::clock::Clock, arg13: &0x2::tx_context::TxContext) {
        let v0 = &mut arg0.auction_registry;
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::dutch::update_auction_config(get_mut_auction(v0, arg1), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public(friend) fun update_config_(arg0: &mut Registry, arg1: u64, arg2: 0x1::option::Option<address>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<u64>, arg10: 0x1::option::Option<u64>, arg11: 0x1::option::Option<0x1::option::Option<vector<u8>>>, arg12: 0x1::option::Option<u64>, arg13: 0x1::option::Option<u64>, arg14: 0x1::option::Option<u64>, arg15: 0x1::option::Option<u64>, arg16: 0x1::option::Option<u64>, arg17: 0x1::option::Option<u64>, arg18: 0x1::option::Option<u64>, arg19: 0x1::option::Option<u64>, arg20: 0x1::option::Option<u64>, arg21: 0x1::option::Option<u64>, arg22: &0x2::tx_context::TxContext) : (Config, Config) {
        let v0 = &mut arg0.portfolio_vault_registry;
        let v1 = get_mut_portfolio_vault(v0, arg1);
        let v2 = &mut arg0.deposit_vault_registry;
        let v3 = get_mut_deposit_vault(v2, arg1);
        if (0x1::option::is_some<u64>(&arg9)) {
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::update_fee(v3, 0x1::option::destroy_some<u64>(arg9), arg22);
        };
        if (0x1::option::is_some<u64>(&arg10)) {
            abort 13
        };
        if (0x1::option::is_some<address>(&arg2)) {
            v1.config.oracle_id = 0x1::option::destroy_some<address>(arg2);
        };
        if (0x1::option::is_some<u64>(&arg3)) {
            v1.config.deposit_lot_size = 0x1::option::destroy_some<u64>(arg3);
        };
        if (0x1::option::is_some<u64>(&arg4)) {
            v1.config.bid_lot_size = 0x1::option::destroy_some<u64>(arg4);
        };
        if (0x1::option::is_some<u64>(&arg5)) {
            v1.config.min_deposit_size = 0x1::option::destroy_some<u64>(arg5);
        };
        if (0x1::option::is_some<u64>(&arg6)) {
            v1.config.min_bid_size = 0x1::option::destroy_some<u64>(arg6);
        };
        if (0x1::option::is_some<u64>(&arg7)) {
            v1.config.max_deposit_entry = 0x1::option::destroy_some<u64>(arg7);
        };
        if (0x1::option::is_some<u64>(&arg8)) {
            v1.config.max_bid_entry = 0x1::option::destroy_some<u64>(arg8);
        };
        if (0x1::option::is_some<u64>(&arg9)) {
            v1.config.deposit_fee_bp = 0x1::option::destroy_some<u64>(arg9);
        };
        if (0x1::option::is_some<u64>(&arg10)) {
            v1.config.deposit_fee_share_bp = 0x1::option::destroy_some<u64>(arg10);
        };
        if (0x1::option::is_some<0x1::option::Option<vector<u8>>>(&arg11)) {
            v1.config.deposit_shared_fee_pool = 0x1::option::destroy_some<0x1::option::Option<vector<u8>>>(arg11);
        };
        if (0x1::option::is_some<u64>(&arg12)) {
            v1.config.bid_fee_bp = 0x1::option::destroy_some<u64>(arg12);
        };
        if (0x1::option::is_some<u64>(&arg13)) {
            v1.config.deposit_incentive_bp = 0x1::option::destroy_some<u64>(arg13);
        };
        if (0x1::option::is_some<u64>(&arg14)) {
            v1.config.bid_incentive_bp = 0x1::option::destroy_some<u64>(arg14);
        };
        if (0x1::option::is_some<u64>(&arg15)) {
            v1.config.auction_delay_ts_ms = 0x1::option::destroy_some<u64>(arg15);
        };
        if (0x1::option::is_some<u64>(&arg16)) {
            v1.config.auction_duration_ts_ms = 0x1::option::destroy_some<u64>(arg16);
        };
        if (0x1::option::is_some<u64>(&arg17)) {
            v1.config.recoup_delay_ts_ms = 0x1::option::destroy_some<u64>(arg17);
        };
        if (0x1::option::is_some<u64>(&arg18)) {
            v1.config.capacity = 0x1::option::destroy_some<u64>(arg18);
        };
        if (0x1::option::is_some<u64>(&arg19)) {
            v1.config.leverage = 0x1::option::destroy_some<u64>(arg19);
        };
        if (0x1::option::is_some<u64>(&arg20)) {
            v1.config.risk_level = 0x1::option::destroy_some<u64>(arg20);
        };
        if (0x1::option::is_some<u64>(&arg21)) {
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::set_u64_padding_value(&mut v1.config.u64_padding, 3, 0x1::option::destroy_some<u64>(arg21));
        };
        (v1.config, v1.config)
    }

    public(friend) fun update_strike_(arg0: &mut Registry, arg1: u64, arg2: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg3: &0x2::clock::Clock) : (u64, u64, VaultConfig) {
        let (v0, v1) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price(arg2, arg3);
        let (_, v3, _, _) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_token(arg2);
        let v6 = &mut arg0.portfolio_vault_registry;
        let v7 = get_mut_portfolio_vault(v6, arg1);
        let v8 = 0x1::vector::empty<u64>();
        let v9 = v7.config.active_vault_config.strike_increment;
        if (v7.info.option_type == 0 || v7.info.option_type == 1) {
            let v10 = 0x1::vector::borrow_mut<PayoffConfig>(&mut v7.config.active_vault_config.payoff_configs, 0);
            let v11 = calculate_strike(v0, v10.strike_bp, v9);
            let v12 = if (v7.info.option_type % 2 == 1 && v11 > v9) {
                v11 - v9
            } else {
                v11
            };
            0x1::option::swap<u64>(&mut v10.strike, v12);
            0x1::vector::push_back<u64>(&mut v8, v12);
        } else if (v7.info.option_type == 2 || v7.info.option_type == 4 || v7.info.option_type == 6) {
            let v13 = 0x1::vector::borrow_mut<PayoffConfig>(&mut v7.config.active_vault_config.payoff_configs, 1);
            let v14 = 0x1::option::destroy_some<u64>(v13.strike);
            let v15 = calculate_strike(v0, v13.strike_bp, v9);
            0x1::option::swap<u64>(&mut v13.strike, v15);
            0x1::vector::push_back<u64>(&mut v8, v15);
            let v16 = 0x1::vector::borrow_mut<PayoffConfig>(&mut v7.config.active_vault_config.payoff_configs, 0);
            let v17 = v15 + 0x1::option::destroy_some<u64>(v16.strike) - v14;
            0x1::option::swap<u64>(&mut v16.strike, v17);
            0x1::vector::push_back<u64>(&mut v8, v17);
        } else if (v7.info.option_type == 3 || v7.info.option_type == 5) {
            let v18 = 0x1::vector::borrow_mut<PayoffConfig>(&mut v7.config.active_vault_config.payoff_configs, 0);
            let v19 = 0x1::option::destroy_some<u64>(v18.strike);
            let v20 = calculate_strike(v0, v18.strike_bp, v9);
            let v21 = if (v20 > v9) {
                v20 - v9
            } else {
                v20
            };
            0x1::option::swap<u64>(&mut v18.strike, v21);
            0x1::vector::push_back<u64>(&mut v8, v21);
            let v22 = 0x1::vector::borrow_mut<PayoffConfig>(&mut v7.config.active_vault_config.payoff_configs, 1);
            let v23 = v21 - v19 - 0x1::option::destroy_some<u64>(v22.strike);
            0x1::option::swap<u64>(&mut v22.strike, v23);
            0x1::vector::push_back<u64>(&mut v8, v23);
        } else {
            let v24 = 0x1::vector::length<PayoffConfig>(&v7.config.active_vault_config.payoff_configs);
            while (v24 > 0) {
                let v25 = 0x1::vector::borrow_mut<PayoffConfig>(&mut v7.config.active_vault_config.payoff_configs, v24 - 1);
                let v26 = calculate_strike(v0, v25.strike_bp, v9);
                let v27 = if (v7.info.option_type % 2 == 1 && v26 > v9) {
                    v26 - v9
                } else {
                    v26
                };
                0x1::option::swap<u64>(&mut v25.strike, v27);
                0x1::vector::push_back<u64>(&mut v8, v27);
                v24 = v24 - 1;
            };
        };
        if (v7.info.period == 3) {
            let v28 = &mut arg0.bid_vault_registry;
            let v29 = v7.info.settlement_base_name;
            let (v30, v31, v32) = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::get_date_from_ts(v7.info.expiration_ts_ms / 1000);
            0x1::string::append_utf8(&mut v29, b"-");
            0x1::string::append_utf8(&mut v29, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::get_pad_2_number_string(v32));
            0x1::string::append_utf8(&mut v29, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::get_month_short_string(v31));
            0x1::string::append_utf8(&mut v29, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::get_pad_2_number_string(v30));
            0x1::string::append_utf8(&mut v29, b"-");
            0x1::string::append_utf8(&mut v29, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::get_pad_2_number_string(v7.info.expiration_ts_ms % 86400000 / 3600000));
            0x1::string::append_utf8(&mut v29, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::get_pad_2_number_string(v7.info.expiration_ts_ms % 3600000 / 60000));
            0x1::vector::reverse<u64>(&mut v8);
            while (!0x1::vector::is_empty<u64>(&v8)) {
                0x1::string::append_utf8(&mut v29, b"-");
                0x1::string::append_utf8(&mut v29, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::u64_to_bytes(0x1::vector::pop_back<u64>(&mut v8), v1));
            };
            if (v7.info.option_type == 0) {
                0x1::string::append_utf8(&mut v29, b"-Call");
            } else if (v7.info.option_type == 1) {
                0x1::string::append_utf8(&mut v29, b"-Put");
            } else if (v7.info.option_type == 2) {
                0x1::string::append_utf8(&mut v29, b"-CallSpread");
            } else if (v7.info.option_type == 3) {
                0x1::string::append_utf8(&mut v29, b"-PutSpread");
            } else if (v7.info.option_type == 4) {
                0x1::string::append_utf8(&mut v29, b"-CappedCall");
            } else if (v7.info.option_type == 5) {
                0x1::string::append_utf8(&mut v29, b"-CappedPut");
            } else if (v7.info.option_type == 6) {
                if (0x1::ascii::into_bytes(v3) == b"USDT") {
                    0x1::string::append_utf8(&mut v29, b"-UsdtCappedCall");
                } else if (0x1::ascii::into_bytes(v3) == b"USDC") {
                    0x1::string::append_utf8(&mut v29, b"-UsdcCappedCall");
                } else {
                    0x1::string::append_utf8(&mut v29, b"-UsdCappedCall");
                };
            };
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::update_bid_receipt_display(get_mut_bid_vault(v28, arg1), v29);
        };
        let v33 = v7.config.active_vault_config;
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::set_u64_padding_value(&mut v33.u64_padding, 0, v7.info.round);
        (v0, v1, v33)
    }

    public(friend) fun update_warmup_vault_config_(arg0: &mut Registry, arg1: u64, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<bool>, arg5: u64, arg6: u64, arg7: u64, arg8: u64) : (VaultConfig, VaultConfig) {
        let v0 = &mut arg0.portfolio_vault_registry;
        let v1 = get_mut_portfolio_vault(v0, arg1);
        validate_dutch_auction_settings(arg7, arg8, v1.config.auction_duration_ts_ms);
        v1.config.warmup_vault_config.payoff_configs = create_payoff_configs(arg2, arg3, arg4);
        v1.config.warmup_vault_config.strike_increment = arg5;
        v1.config.warmup_vault_config.decay_speed = arg6;
        v1.config.warmup_vault_config.initial_price = arg7;
        v1.config.warmup_vault_config.final_price = arg8;
        (v1.config.warmup_vault_config, v1.config.warmup_vault_config)
    }

    public(friend) fun validate_amount(arg0: u64) {
        assert!(arg0 > 0, 35);
    }

    public(friend) fun validate_bid_amount(arg0: &PortfolioVault, arg1: &0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::dutch::Auction, arg2: u64) {
        assert!(arg2 >= arg0.config.bid_lot_size && arg2 % arg0.config.bid_lot_size == 0, 23);
        assert!(arg2 >= arg0.config.min_bid_size, 27);
        assert!(arg0.config.max_bid_entry == 0 || 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::dutch::bid_index(arg1) < arg0.config.max_bid_entry, 24);
    }

    public(friend) fun validate_capacity(arg0: &Registry, arg1: u64) {
        let v0 = get_portfolio_vault(&arg0.portfolio_vault_registry, arg1);
        let v1 = get_deposit_vault(&arg0.deposit_vault_registry, arg1);
        assert!(0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::active_share_supply(v1) + 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::warmup_share_supply(v1) <= v0.config.capacity, 26);
        let v2 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::get_deposit_shares(v1);
        assert!(v0.config.max_deposit_entry == 0 || 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::length<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::DepositShare>(v2) <= v0.config.max_deposit_entry, 25);
    }

    public(friend) fun validate_deposit_amount(arg0: &PortfolioVault, arg1: u64) {
        assert!(arg1 >= arg0.config.deposit_lot_size && arg1 % arg0.config.deposit_lot_size == 0, 23);
        assert!(arg1 >= arg0.config.min_deposit_size, 27);
    }

    public(friend) fun validate_dutch_auction_settings(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 >= arg1 && arg1 > 0, 7);
        assert!(arg2 >= 60000, 6);
    }

    public(friend) fun validate_portfolio_authority(arg0: &Registry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::double_verify(&arg0.authority, &get_portfolio_vault(&arg0.portfolio_vault_registry, arg1).authority, arg2);
    }

    public(friend) fun validate_registry_authority(arg0: &Registry, arg1: &0x2::tx_context::TxContext) {
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::verify(&arg0.authority, arg1);
    }

    public(friend) fun validate_registry_upgradability(arg0: &Registry, arg1: &0x2::tx_context::TxContext) {
        assert!(16 > arg0.version, 22);
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::authority::verify(&arg0.authority, arg1);
    }

    public(friend) fun version_check(arg0: &Registry) {
        assert!(16 >= arg0.version, 22);
    }

    public(friend) fun withdraw_fixed_incentive_<T0>(arg0: &mut Registry, arg1: u64, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = &mut arg0.portfolio_vault_registry;
        let v1 = get_mut_portfolio_vault(v0, arg1);
        if (0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&v1.id, 0x1::type_name::get<T0>())) {
            let v3 = if (0x1::option::is_some<u64>(&arg2)) {
                let v4 = 0x1::option::borrow<u64>(&arg2);
                let v5 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, 0x1::type_name::get<T0>());
                let v6 = if (*v4 > 0x2::balance::value<T0>(v5)) {
                    0x2::balance::value<T0>(v5)
                } else {
                    *v4
                };
                0x2::balance::split<T0>(v5, v6)
            } else {
                let v7 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, 0x1::type_name::get<T0>());
                0x2::balance::split<T0>(v7, 0x2::balance::value<T0>(v7))
            };
            0x2::coin::from_balance<T0>(v3, arg3)
        } else {
            0x2::coin::zero<T0>(arg3)
        }
    }

    public(friend) fun withdraw_incentive_<T0>(arg0: &mut Registry, arg1: 0x1::option::Option<u64>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.id, 0x1::type_name::get<T0>())) {
            let v1 = if (0x1::option::is_some<u64>(&arg1)) {
                let v2 = 0x1::option::borrow<u64>(&arg1);
                let v3 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::type_name::get<T0>());
                let v4 = if (*v2 > 0x2::balance::value<T0>(v3)) {
                    0x2::balance::value<T0>(v3)
                } else {
                    *v2
                };
                0x2::balance::split<T0>(v3, v4)
            } else {
                let v5 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::type_name::get<T0>());
                0x2::balance::split<T0>(v5, 0x2::balance::value<T0>(v5))
            };
            0x2::coin::from_balance<T0>(v1, arg2)
        } else {
            0x2::coin::zero<T0>(arg2)
        }
    }

    public(friend) fun withdraw_xxx_scallop_<T0>(arg0: &mut Registry, arg1: u64, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg5: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<u64> {
        let v0 = &mut arg0.deposit_vault_registry;
        let v1 = get_mut_deposit_vault(v0, arg1);
        let v2 = &mut arg0.additional_config_registry;
        let v3 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::scallop::withdraw_xxx<T0>(&mut arg0.fee_pool, v1, 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::type_name::get<T0>()), arg2, arg3, arg4, arg5, 0x2::dynamic_field::borrow_mut<vector<u8>, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut get_mut_additional_config(v2, arg1).id, b"scallop_spool_account"), arg6, arg7);
        0x1::vector::push_back<u64>(&mut v3, get_portfolio_vault(&arg0.portfolio_vault_registry, arg1).info.round);
        v3
    }

    public(friend) fun withdraw_xyx_scallop_<T0>(arg0: &mut Registry, arg1: u64, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg5: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<u64> {
        let v0 = &mut arg0.deposit_vault_registry;
        let v1 = get_mut_deposit_vault(v0, arg1);
        let v2 = &mut arg0.additional_config_registry;
        let v3 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::scallop::withdraw_xyx<T0>(&mut arg0.fee_pool, v1, 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::type_name::get<T0>()), arg2, arg3, arg4, arg5, 0x2::dynamic_field::borrow_mut<vector<u8>, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut get_mut_additional_config(v2, arg1).id, b"scallop_spool_account"), arg6, arg7);
        0x1::vector::push_back<u64>(&mut v3, get_portfolio_vault(&arg0.portfolio_vault_registry, arg1).info.round);
        v3
    }

    public(friend) fun withdraw_xyy_scallop_<T0, T1>(arg0: &mut Registry, arg1: u64, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg5: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<u64> {
        let v0 = &mut arg0.deposit_vault_registry;
        let v1 = get_mut_deposit_vault(v0, arg1);
        let v2 = &mut arg0.additional_config_registry;
        let v3 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::scallop::withdraw_xyy<T0, T1>(&mut arg0.fee_pool, v1, 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::type_name::get<T0>()), arg2, arg3, arg4, arg5, 0x2::dynamic_field::borrow_mut<vector<u8>, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut get_mut_additional_config(v2, arg1).id, b"scallop_spool_account"), arg6, arg7);
        0x1::vector::push_back<u64>(&mut v3, get_portfolio_vault(&arg0.portfolio_vault_registry, arg1).info.round);
        v3
    }

    public(friend) fun withdraw_xyz_scallop_<T0, T1>(arg0: &mut Registry, arg1: u64, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg5: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<u64> {
        let v0 = &mut arg0.deposit_vault_registry;
        let v1 = get_mut_deposit_vault(v0, arg1);
        let v2 = &mut arg0.additional_config_registry;
        let v3 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::scallop::withdraw_xyz<T0, T1>(&mut arg0.fee_pool, v1, 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::type_name::get<T0>()), arg2, arg3, arg4, arg5, 0x2::dynamic_field::borrow_mut<vector<u8>, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut get_mut_additional_config(v2, arg1).id, b"scallop_spool_account"), arg6, arg7);
        0x1::vector::push_back<u64>(&mut v3, get_portfolio_vault(&arg0.portfolio_vault_registry, arg1).info.round);
        v3
    }

    // decompiled from Move bytecode v6
}

