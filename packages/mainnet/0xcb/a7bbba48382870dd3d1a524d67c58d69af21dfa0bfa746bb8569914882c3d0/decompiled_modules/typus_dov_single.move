module 0xcba7bbba48382870dd3d1a524d67c58d69af21dfa0bfa746bb8569914882c3d0::typus_dov_single {
    struct TYPUS_DOV_SINGLE has drop {
        dummy_field: bool,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        num_of_vault: u64,
        authority: 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::authority::Authority,
        fee_pool: 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::balance_pool::BalancePool,
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
        authority: 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::authority::Authority,
    }

    struct Info has copy, drop, store {
        index: u64,
        option_type: u64,
        period: u8,
        activation_ts_ms: u64,
        expiration_ts_ms: u64,
        deposit_token: 0x1::type_name::TypeName,
        bid_token: 0x1::type_name::TypeName,
        oracle_token: 0x1::type_name::TypeName,
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
        deposit_fee_bp: u64,
        deposit_fee_share_bp: u64,
        deposit_shared_fee_pool: 0x1::option::Option<vector<u8>>,
        bid_fee_bp: u64,
        deposit_incentive_bp: u64,
        bid_incentive_bp: u64,
        auction_delay_ts_ms: u64,
        auction_duration_ts_ms: u64,
        capacity: u64,
        leverage: u64,
        risk_level: u64,
        has_next: bool,
        active_vault_config: VaultConfig,
        warmup_vault_config: VaultConfig,
        deposit_receipt_display_name: 0x1::string::String,
        deposit_receipt_display_description: 0x1::string::String,
        deposit_receipt_display_image_url: 0x1::string::String,
        bid_receipt_display_name: 0x1::string::String,
        bid_receipt_display_description: 0x1::string::String,
        bid_receipt_display_image_url: 0x1::string::String,
        u64_padding: vector<u64>,
        bcs_padding: vector<u8>,
    }

    struct PayoffConfig has copy, drop, store {
        strike_bp: u64,
        weight: u64,
        is_buyer: bool,
        strike: 0x1::option::Option<u64>,
    }

    struct VaultConfig has copy, drop, store {
        payoff_configs: vector<PayoffConfig>,
        strike_increment: u64,
        decay_speed: u64,
        initial_price: u64,
        final_price: u64,
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
    }

    struct DeliveryInfo has copy, drop, store {
        delivery_price: u64,
        delivery_size: u64,
        bidder_bid_value: u64,
        bidder_fee: u64,
        incentive_bid_value: u64,
        incentive_fee: u64,
        ts_ms: u64,
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
    }

    struct AddAuthorizedUser has copy, drop {
        signer: address,
        users: vector<address>,
    }

    struct RemoveAuthorizedUser has copy, drop {
        signer: address,
        users: vector<address>,
    }

    struct AddPortfolioVaultAuthorizedUser has copy, drop {
        signer: address,
        index: u64,
        users: vector<address>,
    }

    struct RemovePortfolioVaultAuthorizedUser has copy, drop {
        signer: address,
        index: u64,
        users: vector<address>,
    }

    struct NewPortfolioVault has copy, drop {
        signer: address,
        index: u64,
        info: Info,
        config: Config,
    }

    struct UpdateConfig has copy, drop {
        signer: address,
        index: u64,
        oracle_id_change_log: vector<address>,
        deposit_lot_size_change_log: vector<u64>,
        bid_lot_size_change_log: vector<u64>,
        min_deposit_size_change_log: vector<u64>,
        min_bid_size_change_log: vector<u64>,
        deposit_fee_bp_change_log: vector<u64>,
        deposit_fee_share_bp_change_log: vector<u64>,
        deposit_shared_fee_pool_change_log: vector<0x1::option::Option<vector<u8>>>,
        bid_fee_bp_change_log: vector<u64>,
        deposit_incentive_bp_change_log: vector<u64>,
        bid_incentive_bp_change_log: vector<u64>,
        auction_delay_ts_ms_change_log: vector<u64>,
        auction_duration_ts_ms_change_log: vector<u64>,
        capacity_change_log: vector<u64>,
        leverage_change_log: vector<u64>,
        risk_level_change_log: vector<u64>,
        deposit_receipt_display_name_change_log: vector<0x1::string::String>,
        deposit_receipt_display_description_change_log: vector<0x1::string::String>,
        deposit_receipt_display_image_url_change_log: vector<0x1::string::String>,
        bid_receipt_display_name_change_log: vector<0x1::string::String>,
        bid_receipt_display_description_change_log: vector<0x1::string::String>,
        bid_receipt_display_image_url_change_log: vector<0x1::string::String>,
    }

    struct UpdateActiveVaultConfig has copy, drop {
        signer: address,
        index: u64,
        previous: VaultConfig,
        current: VaultConfig,
    }

    struct UpdateWarmupVaultConfig has copy, drop {
        signer: address,
        index: u64,
        previous: VaultConfig,
        current: VaultConfig,
    }

    struct Incentivise has copy, drop {
        signer: address,
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct Activate has copy, drop {
        signer: address,
        index: u64,
        round: u64,
        amount: u64,
        size: u64,
        oracle_price: u64,
        oracle_price_decimal: u64,
    }

    struct NewAuction has copy, drop {
        signer: address,
        index: u64,
        round: u64,
        start_ts_ms: u64,
        end_ts_ms: u64,
        size: u64,
        oracle_price: u64,
        oracle_price_decimal: u64,
        vault_config: VaultConfig,
    }

    struct Delivery has copy, drop {
        signer: address,
        index: u64,
        round: u64,
        delivery_price: u64,
        delivery_size: u64,
        bidder_bid_value: u64,
        bidder_fee: u64,
        incentive_bid_value: u64,
        incentive_fee: u64,
    }

    struct Recoup has copy, drop {
        signer: address,
        index: u64,
        round: u64,
        active_amount: u64,
        deactivating_amount: u64,
    }

    struct Settle has copy, drop {
        signer: address,
        index: u64,
        round: u64,
        oracle_price: u64,
        oracle_price_decimal: u64,
        settle_balance: u64,
        settled_balance: u64,
        share_price: u64,
        share_price_decimal: u64,
    }

    struct Close has copy, drop {
        signer: address,
        index: u64,
    }

    struct TerminateVault has copy, drop {
        signer: address,
        index: u64,
    }

    struct TerminateAuction has copy, drop {
        signer: address,
        index: u64,
    }

    struct Deposit has copy, drop {
        signer: address,
        index: u64,
        amount: u64,
    }

    struct Withdraw has copy, drop {
        signer: address,
        index: u64,
        amount: u64,
    }

    struct Unsubscribe has copy, drop {
        signer: address,
        index: u64,
        amount: u64,
    }

    struct Claim has copy, drop {
        signer: address,
        index: u64,
        amount: u64,
    }

    struct Harvest has copy, drop {
        signer: address,
        index: u64,
        amount: u64,
        fee_amount: u64,
    }

    struct Compound has copy, drop {
        signer: address,
        index: u64,
        amount: u64,
    }

    struct Redeem has copy, drop {
        signer: address,
        index: u64,
        amount: u64,
    }

    struct NewBid has copy, drop {
        signer: address,
        index: u64,
        bid_index: u64,
        price: u64,
        size: u64,
        bidder_balance: u64,
        incentive_balance: u64,
        ts_ms: u64,
    }

    struct Refund has copy, drop {
        signer: address,
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct Exercise has copy, drop {
        signer: address,
        index: u64,
        amount: u64,
    }

    struct ExerciseI has copy, drop {
        signer: address,
        index: u64,
        amount: u64,
        incentive_amount: u64,
    }

    struct UserShare has drop {
        index: u64,
        active_share: u64,
        deactivating_share: u64,
        inactive_share: u64,
        warmup_share: u64,
        premium_share: u64,
        incentive_share: u64,
    }

    public(friend) entry fun add_authorized_user(arg0: &mut Registry, arg1: vector<address>, arg2: &0x2::tx_context::TxContext) {
        version_check(arg0);
        0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::authority::verify(&arg0.authority, arg2);
        while (!0x1::vector::is_empty<address>(&arg1)) {
            0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::authority::add_authorized_user(&mut arg0.authority, 0x1::vector::pop_back<address>(&mut arg1), arg2);
        };
        let v0 = AddAuthorizedUser{
            signer : 0x2::tx_context::sender(arg2),
            users  : 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::authority::whitelist(&arg0.authority),
        };
        0x2::event::emit<AddAuthorizedUser>(v0);
    }

    public(friend) entry fun remove_authorized_user(arg0: &mut Registry, arg1: vector<address>, arg2: &0x2::tx_context::TxContext) {
        version_check(arg0);
        0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::authority::verify(&arg0.authority, arg2);
        while (!0x1::vector::is_empty<address>(&arg1)) {
            0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::authority::remove_authorized_user(&mut arg0.authority, 0x1::vector::pop_back<address>(&mut arg1), arg2);
        };
        let v0 = RemoveAuthorizedUser{
            signer : 0x2::tx_context::sender(arg2),
            users  : 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::authority::whitelist(&arg0.authority),
        };
        0x2::event::emit<RemoveAuthorizedUser>(v0);
    }

    public(friend) entry fun delivery<T0, T1, T2>(arg0: &mut Registry, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let (v0, v1, v2, v3, v4, v5) = delivery_<T0, T1>(arg0, arg1, arg2, arg3);
        let v6 = get_portfolio_vault(&arg0.portfolio_vault_registry, arg1);
        portfolio_token_check<T0, T1, T2>(v6);
        0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::authority::verify(&v6.authority, arg3);
        let v7 = Delivery{
            signer              : 0x2::tx_context::sender(arg3),
            index               : arg1,
            round               : v6.info.round,
            delivery_price      : v0,
            delivery_size       : v1,
            bidder_bid_value    : v2,
            bidder_fee          : v3,
            incentive_bid_value : v4,
            incentive_fee       : v5,
        };
        0x2::event::emit<Delivery>(v7);
    }

    public(friend) entry fun new_bid<T0, T1, T2>(arg0: &mut Registry, arg1: u64, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = &mut arg0.portfolio_vault_registry;
        let v1 = get_mut_portfolio_vault(v0, arg1);
        portfolio_token_check<T0, T1, T2>(v1);
        validate_amount(arg3, v1.config.bid_lot_size, v1.config.min_bid_size);
        let v2 = &mut arg0.bid_vault_registry;
        let v3 = get_mut_bid_vault(v2, arg1);
        let v4 = &mut arg0.auction_registry;
        let v5 = get_mut_auction(v4, arg1);
        if (0x1::option::is_none<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::dutch::Auction>(v5)) {
            abort 3
        };
        let v6 = 0;
        let v7 = 0x2::balance::zero<T1>();
        if (v1.config.bid_incentive_bp > 0 && 0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T1>())) {
            let (_, _, v10, v11) = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::dutch::get_bid_info(0x1::option::borrow<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::dutch::Auction>(v5), arg3, v6, 0x2::clock::timestamp_ms(arg4));
            let v12 = ((((v10 + v11) as u128) * (v1.config.bid_incentive_bp as u128) / 10000) as u64);
            let v13 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.id, 0x1::type_name::get<T1>());
            let v14 = get_u64_padding_value(&v1.config.u64_padding, 0);
            let v15 = if (0x2::balance::value<T1>(v13) > v12) {
                if (v14 >= v12) {
                    0x2::balance::join<T1>(&mut v7, 0x2::balance::split<T1>(v13, v12));
                    v12
                } else {
                    0x2::balance::join<T1>(&mut v7, 0x2::balance::split<T1>(v13, v14));
                    v14
                }
            } else if (v14 >= 0x2::balance::value<T1>(v13)) {
                0x2::balance::join<T1>(&mut v7, 0x2::balance::withdraw_all<T1>(v13));
                0x2::balance::value<T1>(v13)
            } else {
                0x2::balance::join<T1>(&mut v7, 0x2::balance::split<T1>(v13, v14));
                v14
            };
            let v16 = &mut v1.config.u64_padding;
            set_u64_padding_value(v16, 0, v14 - v15);
        };
        let (v17, v18, v19, v20, v21, v22, _) = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::dutch::new_bid<T1>(0x1::option::borrow_mut<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::dutch::Auction>(v5), arg3, arg2, v7, v6, arg4, arg5);
        0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::new_bid(v3, v19, arg5);
        let v24 = NewBid{
            signer            : 0x2::tx_context::sender(arg5),
            index             : arg1,
            bid_index         : v17,
            price             : v18,
            size              : v19,
            bidder_balance    : v20,
            incentive_balance : v21,
            ts_ms             : v22,
        };
        0x2::event::emit<NewBid>(v24);
    }

    public(friend) entry fun update_auction_config(arg0: &mut Registry, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: bool, arg12: &0x2::clock::Clock, arg13: &0x2::tx_context::TxContext) {
        let v0 = &mut arg0.portfolio_vault_registry;
        0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::authority::verify(&get_mut_portfolio_vault(v0, arg1).authority, arg13);
        let v1 = &mut arg0.auction_registry;
        let v2 = get_mut_auction(v1, arg1);
        if (0x1::option::is_some<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::dutch::Auction>(v2)) {
            0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::dutch::update_auction_config(0x1::option::borrow_mut<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::dutch::Auction>(v2), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        };
    }

    public(friend) entry fun activate<T0, T1, T2>(arg0: &mut Registry, arg1: u64, arg2: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let (v0, v1, v2, v3) = activate_<T0>(arg0, arg1, arg2, arg3, arg4);
        let v4 = get_portfolio_vault(&arg0.portfolio_vault_registry, arg1);
        portfolio_token_check<T0, T1, T2>(v4);
        0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::authority::verify(&v4.authority, arg4);
        let v5 = Activate{
            signer               : 0x2::tx_context::sender(arg4),
            index                : arg1,
            round                : v4.info.round,
            amount               : v0,
            size                 : v1,
            oracle_price         : v2,
            oracle_price_decimal : v3,
        };
        0x2::event::emit<Activate>(v5);
    }

    public(friend) entry fun claim<T0, T1, T2>(arg0: &mut Registry, arg1: u64, arg2: vector<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::TypusDepositReceipt>, arg3: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        portfolio_token_check<T0, T1, T2>(get_portfolio_vault(&arg0.portfolio_vault_registry, arg1));
        let v0 = &mut arg0.deposit_vault_registry;
        let v1 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::claim<T0>(get_mut_deposit_vault(v0, arg1), arg2, arg3);
        if (v1 == 0) {
            abort 32
        };
        let v2 = Claim{
            signer : 0x2::tx_context::sender(arg3),
            index  : arg1,
            amount : v1,
        };
        0x2::event::emit<Claim>(v2);
    }

    public(friend) entry fun compound<T0, T1, T2>(arg0: &mut Registry, arg1: u64, arg2: vector<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::TypusDepositReceipt>, arg3: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        portfolio_token_check<T0, T1, T2>(get_portfolio_vault(&arg0.portfolio_vault_registry, arg1));
        let v0 = &mut arg0.deposit_vault_registry;
        let v1 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::compound<T0>(get_mut_deposit_vault(v0, arg1), arg2, arg3);
        if (v1 == 0) {
            abort 32
        };
        check_capacity(arg0, arg1);
        let v2 = Compound{
            signer : 0x2::tx_context::sender(arg3),
            index  : arg1,
            amount : v1,
        };
        0x2::event::emit<Compound>(v2);
    }

    public(friend) entry fun deposit<T0, T1, T2>(arg0: &mut Registry, arg1: u64, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: vector<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::TypusDepositReceipt>, arg5: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = get_portfolio_vault(&arg0.portfolio_vault_registry, arg1);
        portfolio_token_check<T0, T1, T2>(v0);
        validate_amount(arg3, v0.config.deposit_lot_size, v0.config.min_deposit_size);
        let v1 = &mut arg0.deposit_vault_registry;
        check_capacity(arg0, arg1);
        let v2 = Deposit{
            signer : 0x2::tx_context::sender(arg5),
            index  : arg1,
            amount : 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::deposit<T0>(get_mut_deposit_vault(v1, arg1), arg2, arg3, arg4, arg5),
        };
        0x2::event::emit<Deposit>(v2);
    }

    public(friend) entry fun exercise<T0, T1, T2>(arg0: &mut Registry, arg1: u64, arg2: vector<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::TypusBidReceipt>, arg3: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        portfolio_token_check<T0, T1, T2>(get_portfolio_vault(&arg0.portfolio_vault_registry, arg1));
        let v0 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::get_bid_receipt_vid(0x1::vector::borrow<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::TypusBidReceipt>(&arg2, 0));
        let v1 = Exercise{
            signer : 0x2::tx_context::sender(arg3),
            index  : arg1,
            amount : 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::exercise<T0>(0x2::dynamic_field::borrow_mut<address, 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::BidVault>(&mut arg0.bid_vault_registry, 0x2::object::id_to_address(&v0)), arg2, arg3),
        };
        0x2::event::emit<Exercise>(v1);
    }

    public(friend) entry fun exercise_i<T0, T1, T2, T3>(arg0: &mut Registry, arg1: u64, arg2: vector<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::TypusBidReceipt>, arg3: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        portfolio_token_check<T0, T1, T2>(get_portfolio_vault(&arg0.portfolio_vault_registry, arg1));
        let v0 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::get_bid_receipt_vid(0x1::vector::borrow<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::TypusBidReceipt>(&arg2, 0));
        let (v1, v2) = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::exercise_i<T0, T3>(0x2::dynamic_field::borrow_mut<address, 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::BidVault>(&mut arg0.bid_vault_registry, 0x2::object::id_to_address(&v0)), arg2, arg3);
        let v3 = ExerciseI{
            signer           : 0x2::tx_context::sender(arg3),
            index            : arg1,
            amount           : v1,
            incentive_amount : v2,
        };
        0x2::event::emit<ExerciseI>(v3);
    }

    public(friend) entry fun harvest<T0, T1, T2>(arg0: &mut Registry, arg1: u64, arg2: vector<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::TypusDepositReceipt>, arg3: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        portfolio_token_check<T0, T1, T2>(get_portfolio_vault(&arg0.portfolio_vault_registry, arg1));
        let v0 = &mut arg0.deposit_vault_registry;
        let (v1, v2) = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::harvest<T1>(&mut arg0.fee_pool, get_mut_deposit_vault(v0, arg1), arg2, arg3);
        if (v1 == 0) {
            abort 32
        };
        let v3 = Harvest{
            signer     : 0x2::tx_context::sender(arg3),
            index      : arg1,
            amount     : v1,
            fee_amount : v2,
        };
        0x2::event::emit<Harvest>(v3);
    }

    public(friend) entry fun recoup<T0, T1, T2>(arg0: &mut Registry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let (v0, v1) = recoup_<T0>(arg0, arg1, arg2);
        let v2 = get_portfolio_vault(&arg0.portfolio_vault_registry, arg1);
        portfolio_token_check<T0, T1, T2>(v2);
        0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::authority::verify(&v2.authority, arg2);
        let v3 = Recoup{
            signer              : 0x2::tx_context::sender(arg2),
            index               : arg1,
            round               : v2.info.round,
            active_amount       : v0,
            deactivating_amount : v1,
        };
        0x2::event::emit<Recoup>(v3);
    }

    public(friend) entry fun redeem<T0, T1, T2, T3>(arg0: &mut Registry, arg1: u64, arg2: vector<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::TypusDepositReceipt>, arg3: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        portfolio_token_check<T0, T1, T2>(get_portfolio_vault(&arg0.portfolio_vault_registry, arg1));
        let v0 = &mut arg0.deposit_vault_registry;
        let v1 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::redeem<T3>(get_mut_deposit_vault(v0, arg1), arg2, arg3);
        if (v1 == 0) {
            abort 32
        };
        let v2 = Redeem{
            signer : 0x2::tx_context::sender(arg3),
            index  : arg1,
            amount : v1,
        };
        0x2::event::emit<Redeem>(v2);
    }

    public(friend) entry fun settle<T0, T1, T2>(arg0: &mut Registry, arg1: u64, arg2: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let (v0, v1, v2, v3, v4, v5) = settle_<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        let v6 = get_portfolio_vault(&arg0.portfolio_vault_registry, arg1);
        portfolio_token_check<T0, T1, T2>(v6);
        oracle_check(v6, arg2);
        0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::authority::verify(&v6.authority, arg4);
        let v7 = Settle{
            signer               : 0x2::tx_context::sender(arg4),
            index                : arg1,
            round                : v6.info.round,
            oracle_price         : v0,
            oracle_price_decimal : v1,
            settle_balance       : v2,
            settled_balance      : v3,
            share_price          : v4,
            share_price_decimal  : v5,
        };
        0x2::event::emit<Settle>(v7);
    }

    public(friend) entry fun unsubscribe<T0, T1, T2>(arg0: &mut Registry, arg1: u64, arg2: vector<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::TypusDepositReceipt>, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        portfolio_token_check<T0, T1, T2>(get_portfolio_vault(&arg0.portfolio_vault_registry, arg1));
        let v0 = &mut arg0.deposit_vault_registry;
        let v1 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::unsubscribe<T0>(get_mut_deposit_vault(v0, arg1), arg2, arg3, arg4);
        if (v1 == 0) {
            abort 32
        };
        let v2 = Unsubscribe{
            signer : 0x2::tx_context::sender(arg4),
            index  : arg1,
            amount : v1,
        };
        0x2::event::emit<Unsubscribe>(v2);
    }

    public(friend) entry fun withdraw<T0, T1, T2>(arg0: &mut Registry, arg1: u64, arg2: vector<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::TypusDepositReceipt>, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        portfolio_token_check<T0, T1, T2>(get_portfolio_vault(&arg0.portfolio_vault_registry, arg1));
        let v0 = &mut arg0.deposit_vault_registry;
        let v1 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::withdraw<T0>(get_mut_deposit_vault(v0, arg1), arg2, arg3, arg4);
        if (v1 == 0) {
            abort 32
        };
        let v2 = Withdraw{
            signer : 0x2::tx_context::sender(arg4),
            index  : arg1,
            amount : v1,
        };
        0x2::event::emit<Withdraw>(v2);
    }

    fun activate_<T0>(arg0: &mut Registry, arg1: u64, arg2: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64) {
        let v0 = &mut arg0.portfolio_vault_registry;
        let v1 = get_mut_portfolio_vault(v0, arg1);
        let v2 = &mut arg0.deposit_vault_registry;
        let v3 = get_mut_deposit_vault(v2, arg1);
        assert!(0x2::clock::timestamp_ms(arg3) >= v1.info.activation_ts_ms, 28);
        assert!(v1.info.status % 5 == 0, 6);
        let (v4, v5) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price(arg2, arg3);
        v1.info.round = v1.info.round + 1;
        v1.config.active_vault_config = v1.config.warmup_vault_config;
        let v6 = &mut v1.config.active_vault_config.payoff_configs;
        set_strike(v6, v4, v1.config.active_vault_config.strike_increment, v1.info.option_type);
        let v7 = calculate_max_auction_size(v1.info.o_token_decimal, v1.config.leverage, 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::active_share_supply(v3) + 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::deactivating_share_supply(v3), calculate_max_loss_per_unit(v1.info.option_type, v4, v5, v1.info.d_token_decimal, v1.info.o_token_decimal, v1.config.active_vault_config.payoff_configs, 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::utils::multiplier(2)), v1.config.bid_lot_size);
        let v8 = OracleInfo{
            price   : v4,
            decimal : v5,
        };
        v1.info.oracle_info = v8;
        let v9 = DeliveryInfos{
            round                     : v1.info.round,
            max_size                  : v7,
            total_delivery_size       : 0,
            total_bidder_bid_value    : 0,
            total_bidder_fee          : 0,
            total_incentive_bid_value : 0,
            total_incentive_fee       : 0,
            delivery_info             : 0x1::vector::empty<DeliveryInfo>(),
        };
        v1.info.delivery_infos = v9;
        if (v7 > 0) {
            v1.info.status = 1;
        } else {
            v1.info.status = 4;
        };
        (0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::activate<T0>(v3, v1.config.has_next, arg4), v7, v4, v5)
    }

    public(friend) entry fun add_portfolio_vault_authorized_user(arg0: &mut Registry, arg1: u64, arg2: vector<address>, arg3: &0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = &mut arg0.portfolio_vault_registry;
        let v1 = get_mut_portfolio_vault(v0, arg1);
        0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::authority::verify(&v1.authority, arg3);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::authority::add_authorized_user(&mut v1.authority, 0x1::vector::pop_back<address>(&mut arg2), arg3);
        };
        let v2 = AddPortfolioVaultAuthorizedUser{
            signer : 0x2::tx_context::sender(arg3),
            index  : arg1,
            users  : 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::authority::whitelist(&v1.authority),
        };
        0x2::event::emit<AddPortfolioVaultAuthorizedUser>(v2);
    }

    fun calculate_max_auction_size(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        ((((0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::utils::multiplier(arg0) * arg1) as u128) * (arg2 as u128) / (arg3 as u128) / (0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::utils::multiplier(2) as u128)) as u64) / arg4 * arg4
    }

    fun calculate_max_loss_per_unit(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: vector<PayoffConfig>, arg6: u64) : u64 {
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
            assert!(0x1::option::is_some<u64>(&v4.strike), 30);
            let v5 = 0x1::option::borrow<u64>(&v4.strike);
            if (!0x1::vector::contains<u64>(&v0, v5)) {
                0x1::vector::push_back<u64>(&mut v0, *v5);
            };
            v3 = v3 + 1;
        };
        let v6 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::i64::zero();
        while (!0x1::vector::is_empty<u64>(&v0)) {
            let v7 = calculate_portfolio_payoff_by_price(arg0, 0x1::vector::pop_back<u64>(&mut v0), arg2, arg3, arg5, arg6, 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::utils::multiplier(arg4), arg4);
            if (0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::i64::compare(&v6, &v7) == 2) {
                v6 = v7;
            };
        };
        assert!(0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::i64::is_neg(&v6), 16);
        let v8 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::i64::neg(&v6);
        let v9 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::i64::as_u64(&v8);
        assert!(v9 > 0, 16);
        v9
    }

    fun calculate_option_payoff(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg0 % 2 == 0) {
            if (arg1 >= arg3) {
                (((0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::utils::multiplier(arg2) as u128) * ((arg1 - arg3) as u128) / (arg1 as u128)) as u64)
            } else {
                0
            }
        } else {
            assert!(arg0 % 2 == 1, 19);
            if (arg1 <= arg3) {
                arg3 - arg1
            } else {
                0
            }
        }
    }

    fun calculate_portfolio_payoff_by_price(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: vector<PayoffConfig>, arg5: u64, arg6: u64, arg7: u64) : 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::i64::I64 {
        let v0 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::i64::zero();
        while (!0x1::vector::is_empty<PayoffConfig>(&arg4)) {
            let v1 = 0x1::vector::pop_back<PayoffConfig>(&mut arg4);
            assert!(0x1::option::is_some<u64>(&v1.strike), 30);
            let v2 = if (v1.is_buyer) {
                0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::i64::from(1)
            } else {
                0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::i64::neg_from(1)
            };
            let v3 = v2;
            let v4 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::i64::from((((calculate_option_payoff(arg0, arg1, arg2, *0x1::option::borrow<u64>(&v1.strike)) as u128) * (0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::utils::multiplier(arg3) as u128) / (0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::utils::multiplier(arg2) as u128)) as u64));
            let v5 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::i64::mul(&v4, &v3);
            let v6 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::i64::from(v1.weight);
            let v7 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::i64::mul(&v5, &v6);
            let v8 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::i64::from(arg5);
            let v9 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::i64::mul(&v7, &v8);
            let v10 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::i64::from(0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::utils::multiplier(2));
            let v11 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::i64::div(&v9, &v10);
            let v12 = &v0;
            v0 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::i64::add(v12, &v11);
        };
        let v13 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::i64::abs(&v0);
        if (0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::i64::is_neg(&v0)) {
            0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::i64::neg_from((((0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::i64::as_u64(&v13) as u128) * (arg6 as u128) / (0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::utils::multiplier(arg7) as u128)) as u64))
        } else {
            0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::i64::from((((0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::i64::as_u64(&v13) as u128) * (arg6 as u128) / (0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::utils::multiplier(arg7) as u128)) as u64))
        }
    }

    fun calculate_strike(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = arg0 * arg1 / 10000;
        if (v0 % arg2 == 0) {
            return v0
        };
        v0 / arg2 * arg2 + arg2
    }

    fun check_capacity(arg0: &Registry, arg1: u64) {
        let v0 = get_deposit_vault(&arg0.deposit_vault_registry, arg1);
        assert!(0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::active_share_supply(v0) + 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::warmup_share_supply(v0) <= get_portfolio_vault(&arg0.portfolio_vault_registry, arg1).config.capacity, 26);
    }

    fun check_dutch_auction_settings(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 >= arg1 && arg1 > 0, 9);
        assert!(arg2 >= 300000, 8);
    }

    public(friend) entry fun close<T0, T1, T2>(arg0: &mut Registry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = &mut arg0.portfolio_vault_registry;
        let v1 = get_mut_portfolio_vault(v0, arg1);
        portfolio_token_check<T0, T1, T2>(v1);
        v1.config.has_next = false;
        let v2 = Close{
            signer : 0x2::tx_context::sender(arg2),
            index  : arg1,
        };
        0x2::event::emit<Close>(v2);
    }

    fun create_payoff_configs(arg0: vector<u64>, arg1: vector<u64>, arg2: vector<bool>) : vector<PayoffConfig> {
        assert!(0x1::vector::length<u64>(&arg0) > 0, 22);
        assert!(0x1::vector::length<u64>(&arg0) == 0x1::vector::length<u64>(&arg1), 22);
        assert!(0x1::vector::length<u64>(&arg1) == 0x1::vector::length<bool>(&arg2), 22);
        let v0 = 0x1::vector::empty<PayoffConfig>();
        while (!0x1::vector::is_empty<u64>(&arg0)) {
            let v1 = PayoffConfig{
                strike_bp : 0x1::vector::pop_back<u64>(&mut arg0),
                weight    : 0x1::vector::pop_back<u64>(&mut arg1),
                is_buyer  : 0x1::vector::pop_back<bool>(&mut arg2),
                strike    : 0x1::option::none<u64>(),
            };
            0x1::vector::push_back<PayoffConfig>(&mut v0, v1);
        };
        v0
    }

    fun delivery_<T0, T1>(arg0: &mut Registry, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64, u64) {
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
        let v10 = get_mut_auction(v9, arg1);
        assert!(v1.info.status == 2, 6);
        let (v11, v12, v13, v14, v15, v16, v17, v18) = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::dutch::delivery<T1>(v8, v7, 0x1::option::extract<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::dutch::Auction>(v10), arg2, arg3);
        let v19 = v12;
        v1.info.delivery_infos.total_delivery_size = v1.info.delivery_infos.total_delivery_size + v14;
        v1.info.delivery_infos.total_bidder_bid_value = v1.info.delivery_infos.total_bidder_bid_value + v15;
        v1.info.delivery_infos.total_bidder_fee = v1.info.delivery_infos.total_bidder_fee + v16;
        v1.info.delivery_infos.total_incentive_bid_value = v1.info.delivery_infos.total_incentive_bid_value + v17;
        v1.info.delivery_infos.total_incentive_fee = v1.info.delivery_infos.total_incentive_fee + v18;
        let v20 = DeliveryInfo{
            delivery_price      : v13,
            delivery_size       : v14,
            bidder_bid_value    : v15,
            bidder_fee          : v16,
            incentive_bid_value : v17,
            incentive_fee       : v18,
            ts_ms               : 0x2::clock::timestamp_ms(arg2),
        };
        0x1::vector::push_back<DeliveryInfo>(&mut v1.info.delivery_infos.delivery_info, v20);
        let v21 = if (v1.config.deposit_incentive_bp > 0 && 0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T1>())) {
            let v22 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.id, 0x1::type_name::get<T1>());
            let v23 = 0x2::balance::value<T1>(v22);
            let v24 = get_u64_padding_value(&v1.config.u64_padding, 0);
            let v25 = if (0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::utils::match_types<T0, T1>()) {
                ((((0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::active_balance<T0>(v3) + 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::deactivating_balance<T0>(v3)) as u128) * (v14 as u128) / (v1.info.delivery_infos.max_size as u128) * (v1.config.deposit_incentive_bp as u128) / 10000) as u64)
            } else if (v1.info.option_type % 2 == 0) {
                (((((((0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::active_balance<T0>(v3) + 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::deactivating_balance<T0>(v3)) as u128) * (v14 as u128) / (v1.info.delivery_infos.max_size as u128) * (v1.config.deposit_incentive_bp as u128) / 10000) as u64) as u128) * (v1.info.oracle_info.price as u128) / (0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::utils::multiplier(v1.info.oracle_info.decimal) as u128) * (0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::utils::multiplier(v1.info.b_token_decimal) as u128) / (0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::utils::multiplier(v1.info.d_token_decimal) as u128)) as u64)
            } else {
                (((((((0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::active_balance<T0>(v3) + 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::deactivating_balance<T0>(v3)) as u128) * (v14 as u128) / (v1.info.delivery_infos.max_size as u128) * (v1.config.deposit_incentive_bp as u128) / 10000) as u64) as u128) * (0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::utils::multiplier(v1.info.oracle_info.decimal) as u128) / (v1.info.oracle_info.price as u128) * (0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::utils::multiplier(v1.info.b_token_decimal) as u128) / (0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::utils::multiplier(v1.info.d_token_decimal) as u128)) as u64)
            };
            let v26 = if (v25 > v23) {
                if (v23 > v24) {
                    0x2::balance::split<T1>(v22, v24)
                } else {
                    0x2::balance::withdraw_all<T1>(v22)
                }
            } else if (v25 > v24) {
                0x2::balance::split<T1>(v22, v24)
            } else {
                0x2::balance::split<T1>(v22, v25)
            };
            let v27 = v26;
            let v28 = &mut v1.config.u64_padding;
            set_u64_padding_value(v28, 0, v24 - 0x2::balance::value<T1>(&v27));
            v27
        } else {
            0x2::balance::zero<T1>()
        };
        0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::delivery_b<T0, T1>(v3, v5, v11, v21, arg3);
        if (0x2::balance::value<T1>(&v19) > 0) {
            let v29 = &mut v1.config.u64_padding;
            set_u64_padding_value(v29, 0, get_u64_padding_value(&v1.config.u64_padding, 0) + 0x2::balance::value<T1>(&v19));
            0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.id, 0x1::type_name::get<T1>()), v19);
        } else {
            0x2::balance::destroy_zero<T1>(v19);
        };
        if (v1.info.delivery_infos.max_size - v1.info.delivery_infos.total_delivery_size > 0) {
            v1.info.status = 3;
        } else {
            v1.info.status = 4;
        };
        (v13, v14, v15, v16, v17, v18)
    }

    fun get_auction(arg0: &0x2::object::UID, arg1: u64) : &0x1::option::Option<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::dutch::Auction> {
        0x2::dynamic_field::borrow<u64, 0x1::option::Option<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::dutch::Auction>>(arg0, arg1)
    }

    public(friend) fun get_auction_bcs(arg0: &Registry, arg1: vector<u64>) : vector<vector<u8>> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        while (!0x1::vector::is_empty<u64>(&arg1)) {
            0x1::vector::push_back<vector<u8>>(&mut v0, 0x1::bcs::to_bytes<0x1::option::Option<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::dutch::Auction>>(get_auction(&arg0.auction_registry, 0x1::vector::pop_back<u64>(&mut arg1))));
        };
        v0
    }

    fun get_bid_vault(arg0: &0x2::object::UID, arg1: u64) : &0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::BidVault {
        0x2::dynamic_field::borrow<u64, 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::BidVault>(arg0, arg1)
    }

    public(friend) fun get_deposit_shares_bcs(arg0: &Registry, arg1: vector<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::TypusDepositReceipt>) : vector<vector<u8>> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        while (!0x1::vector::is_empty<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::TypusDepositReceipt>(&arg1)) {
            let v1 = 0x1::vector::empty<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::TypusDepositReceipt>();
            let v2 = 0x1::vector::pop_back<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::TypusDepositReceipt>(&mut arg1);
            let v3 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::get_deposit_receipt_index(&v2);
            0x1::vector::push_back<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::TypusDepositReceipt>(&mut v1, v2);
            while (!0x1::vector::is_empty<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::TypusDepositReceipt>(&arg1)) {
                if (0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::get_deposit_receipt_index(0x1::vector::borrow<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::TypusDepositReceipt>(&arg1, 0x1::vector::length<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::TypusDepositReceipt>(&arg1) - 1)) != v3) {
                    break
                };
                0x1::vector::push_back<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::TypusDepositReceipt>(&mut v1, 0x1::vector::pop_back<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::TypusDepositReceipt>(&mut arg1));
            };
            let (v4, v5, v6, v7, v8, v9) = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::summarize_deposit_shares(get_deposit_vault(&arg0.deposit_vault_registry, v3), v1);
            let v10 = UserShare{
                index              : v3,
                active_share       : v4,
                deactivating_share : v5,
                inactive_share     : v6,
                warmup_share       : v7,
                premium_share      : v8,
                incentive_share    : v9,
            };
            0x1::vector::push_back<vector<u8>>(&mut v0, 0x1::bcs::to_bytes<UserShare>(&v10));
        };
        0x1::vector::destroy_empty<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::TypusDepositReceipt>(arg1);
        v0
    }

    fun get_deposit_vault(arg0: &0x2::object::UID, arg1: u64) : &0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::DepositVault {
        0x2::dynamic_field::borrow<u64, 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::DepositVault>(arg0, arg1)
    }

    fun get_mut_auction(arg0: &mut 0x2::object::UID, arg1: u64) : &mut 0x1::option::Option<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::dutch::Auction> {
        0x2::dynamic_field::borrow_mut<u64, 0x1::option::Option<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::dutch::Auction>>(arg0, arg1)
    }

    fun get_mut_bid_vault(arg0: &mut 0x2::object::UID, arg1: u64) : &mut 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::BidVault {
        0x2::dynamic_field::borrow_mut<u64, 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::BidVault>(arg0, arg1)
    }

    fun get_mut_deposit_vault(arg0: &mut 0x2::object::UID, arg1: u64) : &mut 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::DepositVault {
        0x2::dynamic_field::borrow_mut<u64, 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::DepositVault>(arg0, arg1)
    }

    fun get_mut_portfolio_vault(arg0: &mut 0x2::object::UID, arg1: u64) : &mut PortfolioVault {
        0x2::dynamic_object_field::borrow_mut<u64, PortfolioVault>(arg0, arg1)
    }

    fun get_mut_refund_vault<T0>(arg0: &mut 0x2::object::UID) : &mut 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::RefundVault {
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::RefundVault>(arg0, 0x1::type_name::get<T0>())
    }

    fun get_portfolio_vault(arg0: &0x2::object::UID, arg1: u64) : &PortfolioVault {
        0x2::dynamic_object_field::borrow<u64, PortfolioVault>(arg0, arg1)
    }

    fun get_u64_padding_value(arg0: &vector<u64>, arg1: u64) : u64 {
        if (0x1::vector::length<u64>(arg0) > arg1) {
            return *0x1::vector::borrow<u64>(arg0, arg1)
        };
        0
    }

    public(friend) fun get_vault_data_bcs(arg0: &Registry, arg1: vector<u64>) : vector<vector<u8>> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        while (!0x1::vector::is_empty<u64>(&arg1)) {
            let v1 = 0x1::vector::pop_back<u64>(&mut arg1);
            let v2 = 0x1::vector::empty<u8>();
            0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<PortfolioVault>(get_portfolio_vault(&arg0.portfolio_vault_registry, v1)));
            0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::DepositVault>(get_deposit_vault(&arg0.deposit_vault_registry, v1)));
            0x1::vector::push_back<vector<u8>>(&mut v0, v2);
        };
        v0
    }

    public(friend) entry fun incentivise<T0>(arg0: &mut Registry, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T0>())) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::type_name::get<T0>()), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::type_name::get<T0>(), 0x2::coin::into_balance<T0>(arg1));
        };
        let v0 = Incentivise{
            signer : 0x2::tx_context::sender(arg2),
            token  : 0x1::type_name::get<T0>(),
            amount : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<Incentivise>(v0);
    }

    fun init(arg0: TYPUS_DOV_SINGLE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<TYPUS_DOV_SINGLE>(arg0, arg1);
        new_registry_(arg1);
    }

    public(friend) entry fun new_auction<T0, T1, T2>(arg0: &mut Registry, arg1: u64, arg2: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let (v0, v1, v2, v3, v4, v5) = new_auction_<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        let v6 = get_portfolio_vault(&arg0.portfolio_vault_registry, arg1);
        portfolio_token_check<T0, T1, T2>(v6);
        oracle_check(v6, arg2);
        0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::authority::verify(&v6.authority, arg4);
        let v7 = NewAuction{
            signer               : 0x2::tx_context::sender(arg4),
            index                : arg1,
            round                : v6.info.round,
            start_ts_ms          : v0,
            end_ts_ms            : v1,
            size                 : v2,
            oracle_price         : v3,
            oracle_price_decimal : v4,
            vault_config         : v5,
        };
        0x2::event::emit<NewAuction>(v7);
    }

    fun new_auction_<T0, T1>(arg0: &mut Registry, arg1: u64, arg2: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64, VaultConfig) {
        let v0 = &mut arg0.portfolio_vault_registry;
        let v1 = get_mut_portfolio_vault(v0, arg1);
        let v2 = &mut arg0.auction_registry;
        let v3 = get_mut_auction(v2, arg1);
        assert!(0x1::option::is_none<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::dutch::Auction>(v3), 1);
        assert!(v1.info.status == 1 || v1.info.status == 3, 6);
        let (v4, v5) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price(arg2, arg3);
        let v6 = v1.info.activation_ts_ms + v1.config.auction_delay_ts_ms;
        let v7 = v6 + v1.config.auction_duration_ts_ms;
        let v8 = v1.info.delivery_infos.max_size - v1.info.delivery_infos.total_delivery_size;
        0x1::option::fill<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::dutch::Auction>(v3, 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::dutch::new<T1>(arg1, v6, v7, v8, v1.config.active_vault_config.decay_speed, v1.config.active_vault_config.initial_price, v1.config.active_vault_config.final_price, v1.config.bid_fee_bp, v1.config.bid_incentive_bp, v1.info.b_token_decimal, v1.info.o_token_decimal, false, arg4));
        if (!0x2::dynamic_field::exists_<u64>(&arg0.bid_vault_registry, arg1)) {
            0x2::dynamic_field::add<u64, 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::BidVault>(&mut arg0.bid_vault_registry, arg1, 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::new_bid_vault<T0, T1>(v1.info.index, v1.config.bid_receipt_display_name, v1.config.bid_receipt_display_description, v1.config.bid_receipt_display_image_url, arg4));
        };
        v1.info.status = 2;
        (v6, v7, v8, v4, v5, v1.config.active_vault_config)
    }

    public(friend) entry fun new_portfolio_vault<T0, T1, T2>(arg0: &mut Registry, arg1: u64, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: bool, arg23: vector<u64>, arg24: vector<u64>, arg25: vector<bool>, arg26: u64, arg27: u64, arg28: u64, arg29: u64, arg30: vector<address>, arg31: 0x1::string::String, arg32: 0x1::string::String, arg33: 0x1::string::String, arg34: 0x1::string::String, arg35: 0x1::string::String, arg36: 0x1::string::String, arg37: &0x2::clock::Clock, arg38: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::authority::verify(&arg0.authority, arg38);
        let (v0, v1, v2) = new_portfolio_vault_<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, create_payoff_configs(arg23, arg24, arg25), arg26, arg27, arg28, arg29, arg30, arg31, arg32, arg33, arg34, arg35, arg36, arg37, arg38);
        let v3 = NewPortfolioVault{
            signer : 0x2::tx_context::sender(arg38),
            index  : v0,
            info   : v1,
            config : v2,
        };
        0x2::event::emit<NewPortfolioVault>(v3);
    }

    fun new_portfolio_vault_<T0, T1, T2>(arg0: &mut Registry, arg1: u64, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: bool, arg23: vector<PayoffConfig>, arg24: u64, arg25: u64, arg26: u64, arg27: u64, arg28: vector<address>, arg29: 0x1::string::String, arg30: 0x1::string::String, arg31: 0x1::string::String, arg32: 0x1::string::String, arg33: 0x1::string::String, arg34: 0x1::string::String, arg35: &0x2::clock::Clock, arg36: &mut 0x2::tx_context::TxContext) : (u64, Info, Config) {
        let v0 = 0x2::clock::timestamp_ms(arg35);
        assert!(arg6 >= v0, 7);
        assert!(arg7 > v0, 14);
        check_dutch_auction_settings(arg26, arg27, arg18);
        if (arg2 == 0) {
            assert!(arg7 - arg6 == 86400000, 14);
        } else if (arg2 == 1) {
            assert!(arg7 - arg6 == 604800000, 14);
        } else {
            assert!(arg2 == 2, 23);
            assert!(arg7 - arg6 == 2419200000 || arg7 - arg6 == 3024000000, 14);
        };
        assert!(arg9 > 0, 12);
        assert!(arg11 >= arg9, 18);
        assert!(arg10 > 0, 10);
        assert!(arg12 >= arg10, 17);
        let (v1, v2) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_price(arg8, arg35);
        let v3 = arg0.num_of_vault;
        let v4 = VaultConfig{
            payoff_configs   : arg23,
            strike_increment : arg24,
            decay_speed      : arg25,
            initial_price    : arg26,
            final_price      : arg27,
        };
        let v5 = OracleInfo{
            price   : v1,
            decimal : v2,
        };
        let v6 = DeliveryInfos{
            round                     : 0,
            max_size                  : 0,
            total_delivery_size       : 0,
            total_bidder_bid_value    : 0,
            total_bidder_fee          : 0,
            total_incentive_bid_value : 0,
            total_incentive_fee       : 0,
            delivery_info             : 0x1::vector::empty<DeliveryInfo>(),
        };
        let v7 = Info{
            index            : v3,
            option_type      : arg1,
            period           : arg2,
            activation_ts_ms : arg6,
            expiration_ts_ms : arg7,
            deposit_token    : 0x1::type_name::get<T0>(),
            bid_token        : 0x1::type_name::get<T1>(),
            oracle_token     : 0x1::type_name::get<T2>(),
            d_token_decimal  : arg3,
            b_token_decimal  : arg4,
            o_token_decimal  : arg5,
            creator          : 0x2::tx_context::sender(arg36),
            create_ts_ms     : v0,
            round            : 0,
            status           : 0,
            oracle_info      : v5,
            delivery_infos   : v6,
            settlement_info  : 0x1::option::none<SettlementInfo>(),
            u64_padding      : 0x1::vector::empty<u64>(),
            bcs_padding      : 0x1::vector::empty<u8>(),
        };
        let v8 = Config{
            oracle_id                           : 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg8),
            deposit_lot_size                    : arg9,
            bid_lot_size                        : arg10,
            min_deposit_size                    : arg11,
            min_bid_size                        : arg12,
            deposit_fee_bp                      : arg13,
            deposit_fee_share_bp                : 0,
            deposit_shared_fee_pool             : 0x1::option::none<vector<u8>>(),
            bid_fee_bp                          : arg14,
            deposit_incentive_bp                : arg15,
            bid_incentive_bp                    : arg16,
            auction_delay_ts_ms                 : arg17,
            auction_duration_ts_ms              : arg18,
            capacity                            : arg19,
            leverage                            : arg20,
            risk_level                          : arg21,
            has_next                            : arg22,
            active_vault_config                 : v4,
            warmup_vault_config                 : v4,
            deposit_receipt_display_name        : arg29,
            deposit_receipt_display_description : arg30,
            deposit_receipt_display_image_url   : arg31,
            bid_receipt_display_name            : arg32,
            bid_receipt_display_description     : arg33,
            bid_receipt_display_image_url       : arg34,
            u64_padding                         : 0x1::vector::empty<u64>(),
            bcs_padding                         : 0x1::vector::empty<u8>(),
        };
        let v9 = PortfolioVault{
            id        : 0x2::object::new(arg36),
            info      : v7,
            config    : v8,
            authority : 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::authority::new(arg28, arg36),
        };
        0x2::dynamic_object_field::add<u64, PortfolioVault>(&mut arg0.portfolio_vault_registry, v3, v9);
        0x2::dynamic_field::add<u64, 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::DepositVault>(&mut arg0.deposit_vault_registry, v3, 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::new_deposit_vault<T0, T1>(v3, arg13, arg29, arg30, arg31, arg36));
        if (!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.refund_vault_registry, 0x1::type_name::get<T1>())) {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::RefundVault>(&mut arg0.refund_vault_registry, 0x1::type_name::get<T1>(), 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::new_refund_vault<T1>(arg36));
        };
        0x2::dynamic_field::add<u64, 0x1::option::Option<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::dutch::Auction>>(&mut arg0.auction_registry, v3, 0x1::option::none<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::dutch::Auction>());
        arg0.num_of_vault = arg0.num_of_vault + 1;
        (v3, v7, v8)
    }

    fun new_registry_(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id                         : 0x2::object::new(arg0),
            num_of_vault               : 0,
            authority                  : 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::authority::new(0x1::vector::singleton<address>(0x2::tx_context::sender(arg0)), arg0),
            fee_pool                   : 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::balance_pool::new(0x1::vector::singleton<address>(@0xb90d6bddf3df46fc5590d412d062c00145dfae1d31446c0f206c61edf02ef5ba), arg0),
            portfolio_vault_registry   : 0x2::object::new(arg0),
            deposit_vault_registry     : 0x2::object::new(arg0),
            auction_registry           : 0x2::object::new(arg0),
            bid_vault_registry         : 0x2::object::new(arg0),
            refund_vault_registry      : 0x2::object::new(arg0),
            additional_config_registry : 0x2::object::new(arg0),
            version                    : 1,
            transaction_suspended      : false,
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    fun oracle_check(arg0: &PortfolioVault, arg1: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle) {
        assert!(arg0.config.oracle_id == 0x2::object::id_address<0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle>(arg1), 21);
    }

    fun portfolio_token_check<T0, T1, T2>(arg0: &PortfolioVault) {
        assert!(0x1::type_name::get<T0>() == arg0.info.deposit_token, 13);
        assert!(0x1::type_name::get<T1>() == arg0.info.bid_token, 11);
        assert!(0x1::type_name::get<T2>() == arg0.info.oracle_token, 20);
    }

    fun recoup_<T0>(arg0: &mut Registry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = &mut arg0.portfolio_vault_registry;
        let v1 = get_mut_portfolio_vault(v0, arg1);
        let v2 = &mut arg0.deposit_vault_registry;
        let v3 = get_mut_deposit_vault(v2, arg1);
        assert!(v1.info.status == 3, 6);
        v1.info.status = 4;
        0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::recoup<T0>(v3, ((((0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::active_share_supply(v3) + 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::deactivating_share_supply(v3)) as u128) * ((v1.info.delivery_infos.max_size - v1.info.delivery_infos.total_delivery_size) as u128) / (v1.info.delivery_infos.max_size as u128)) as u64), arg2)
    }

    public(friend) entry fun refund<T0>(arg0: &mut Registry, arg1: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = &mut arg0.refund_vault_registry;
        let v1 = Refund{
            signer : 0x2::tx_context::sender(arg1),
            token  : 0x1::type_name::get<T0>(),
            amount : 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::take_refund<T0>(get_mut_refund_vault<T0>(v0), arg1),
        };
        0x2::event::emit<Refund>(v1);
    }

    public(friend) entry fun remove_portfolio_vault_authorized_user(arg0: &mut Registry, arg1: u64, arg2: vector<address>, arg3: &0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = &mut arg0.portfolio_vault_registry;
        let v1 = get_mut_portfolio_vault(v0, arg1);
        0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::authority::verify(&v1.authority, arg3);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::authority::remove_authorized_user(&mut v1.authority, 0x1::vector::pop_back<address>(&mut arg2), arg3);
        };
        let v2 = RemovePortfolioVaultAuthorizedUser{
            signer : 0x2::tx_context::sender(arg3),
            index  : arg1,
            users  : 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::authority::whitelist(&v1.authority),
        };
        0x2::event::emit<RemovePortfolioVaultAuthorizedUser>(v2);
    }

    public(friend) entry fun resume_transaction(arg0: &mut Registry, arg1: &0x2::tx_context::TxContext) {
        0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::authority::verify(&arg0.authority, arg1);
        arg0.transaction_suspended = false;
    }

    public(friend) entry fun set_available_incentive_amount(arg0: &mut Registry, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = &mut arg0.portfolio_vault_registry;
        let v1 = get_mut_portfolio_vault(v0, arg1);
        0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::authority::verify(&v1.authority, arg3);
        let v2 = &mut v1.config.u64_padding;
        set_u64_padding_value(v2, 0, arg2);
    }

    fun set_strike(arg0: &mut vector<PayoffConfig>, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = 0x1::vector::length<PayoffConfig>(arg0);
        while (v0 > 0) {
            let v1 = 0x1::vector::borrow_mut<PayoffConfig>(arg0, v0 - 1);
            let v2 = calculate_strike(arg1, v1.strike_bp, arg2);
            let v3 = if (arg3 % 2 == 1 && v2 > arg2) {
                v2 - arg2
            } else {
                v2
            };
            0x1::option::fill<u64>(&mut v1.strike, v3);
            v0 = v0 - 1;
        };
    }

    fun set_u64_padding_value(arg0: &mut vector<u64>, arg1: u64, arg2: u64) {
        while (0x1::vector::length<u64>(arg0) < arg1 + 1) {
            0x1::vector::push_back<u64>(arg0, 0);
        };
        *0x1::vector::borrow_mut<u64>(arg0, arg1) = arg2;
    }

    fun settle_<T0, T1>(arg0: &mut Registry, arg1: u64, arg2: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64, u64) {
        let v0 = &mut arg0.portfolio_vault_registry;
        let v1 = get_mut_portfolio_vault(v0, arg1);
        let v2 = &mut arg0.deposit_vault_registry;
        let v3 = get_mut_deposit_vault(v2, arg1);
        let v4 = &mut arg0.bid_vault_registry;
        let v5 = get_mut_bid_vault(v4, arg1);
        assert!(0x2::clock::timestamp_ms(arg3) >= v1.info.expiration_ts_ms, 29);
        assert!(v1.info.status == 4, 6);
        v1.info.status = 5;
        let (v6, v7) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::get_twap_price(arg2, arg3);
        let v8 = calculate_portfolio_payoff_by_price(v1.info.option_type, v6, v7, v1.info.d_token_decimal, v1.config.active_vault_config.payoff_configs, 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::utils::multiplier(2), v1.info.delivery_infos.total_delivery_size, v1.info.o_token_decimal);
        let v9 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::active_balance<T0>(v3) + 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::deactivating_balance<T0>(v3);
        let v10 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::i64::from(v9);
        let v11 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::i64::add(&v10, &v8);
        let v12 = if (v9 != 0) {
            (((0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::utils::multiplier(8) as u128) * (0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::i64::as_u64(&v11) as u128) / (v9 as u128)) as u64)
        } else {
            0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::utils::multiplier(8)
        };
        let v13 = 8;
        0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::settle<T0, T1>(v3, v5, v12, v13, arg4);
        let v14 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::active_balance<T0>(v3) + 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::deactivating_balance<T0>(v3);
        let v15 = SettlementInfo{
            round                : v1.info.round,
            oracle_price         : v6,
            oracle_price_decimal : v7,
            settle_balance       : v9,
            settled_balance      : v14,
            share_price          : v12,
            share_price_decimal  : v13,
            ts_ms                : 0x2::clock::timestamp_ms(arg3),
        };
        v1.info.settlement_info = 0x1::option::some<SettlementInfo>(v15);
        v1.info.activation_ts_ms = v1.info.expiration_ts_ms;
        if (v1.info.period == 0) {
            v1.info.expiration_ts_ms = v1.info.expiration_ts_ms + 86400000;
        } else if (v1.info.period == 1) {
            v1.info.expiration_ts_ms = v1.info.expiration_ts_ms + 604800000;
        } else if (v1.info.period == 2) {
            let (_, v17, _) = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::utils::get_date_from_ts(v1.info.expiration_ts_ms / 1000 + 2419200);
            let (_, v20, _) = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::utils::get_date_from_ts(v1.info.expiration_ts_ms / 1000 + 3024000);
            if (v17 != v20) {
                v1.info.expiration_ts_ms = v1.info.expiration_ts_ms + 2419200000;
            } else {
                v1.info.expiration_ts_ms = v1.info.expiration_ts_ms + 3024000000;
            };
        };
        let v22 = 0x2::dynamic_field::remove<u64, 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::BidVault>(&mut arg0.bid_vault_registry, arg1);
        0x2::dynamic_field::add<address, 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::BidVault>(&mut arg0.bid_vault_registry, 0x2::object::id_address<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::BidVault>(&v22), v22);
        (v6, v7, v9, v14, v12, v13)
    }

    public(friend) entry fun suspend_transaction(arg0: &mut Registry, arg1: &0x2::tx_context::TxContext) {
        0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::authority::verify(&arg0.authority, arg1);
        arg0.transaction_suspended = true;
    }

    public(friend) entry fun terminate_auction<T0, T1, T2>(arg0: &mut Registry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = &mut arg0.portfolio_vault_registry;
        let v1 = get_mut_portfolio_vault(v0, arg1);
        portfolio_token_check<T0, T1, T2>(v1);
        0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::authority::verify(&v1.authority, arg2);
        let v2 = &mut arg0.auction_registry;
        let v3 = get_mut_auction(v2, arg1);
        let v4 = &mut arg0.refund_vault_registry;
        let v5 = 0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::dutch::terminate<T1>(0x1::option::extract<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::dutch::Auction>(v3), get_mut_refund_vault<T1>(v4), arg2);
        if (0x2::balance::value<T1>(&v5) > 0) {
            0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.id, 0x1::type_name::get<T1>()), v5);
        } else {
            0x2::balance::destroy_zero<T1>(v5);
        };
        let v6 = TerminateAuction{
            signer : 0x2::tx_context::sender(arg2),
            index  : arg1,
        };
        0x2::event::emit<TerminateAuction>(v6);
    }

    public(friend) entry fun terminate_vault<T0, T1, T2>(arg0: &mut Registry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = &mut arg0.portfolio_vault_registry;
        portfolio_token_check<T0, T1, T2>(get_mut_portfolio_vault(v0, arg1));
        let v1 = &mut arg0.deposit_vault_registry;
        0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::terminate<T0>(get_mut_deposit_vault(v1, arg1), arg2);
        let v2 = TerminateVault{
            signer : 0x2::tx_context::sender(arg2),
            index  : arg1,
        };
        0x2::event::emit<TerminateVault>(v2);
    }

    public(friend) entry fun update_active_vault_config(arg0: &mut Registry, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = &mut arg0.portfolio_vault_registry;
        let v1 = get_mut_portfolio_vault(v0, arg1);
        0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::authority::verify(&v1.authority, arg6);
        check_dutch_auction_settings(arg4, arg5, v1.config.auction_duration_ts_ms);
        assert!(0x1::option::is_none<0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::dutch::Auction>(get_auction(&arg0.auction_registry, arg1)), 1);
        v1.config.active_vault_config.strike_increment = arg2;
        v1.config.active_vault_config.decay_speed = arg3;
        v1.config.active_vault_config.initial_price = arg4;
        v1.config.active_vault_config.final_price = arg5;
        let v2 = UpdateActiveVaultConfig{
            signer   : 0x2::tx_context::sender(arg6),
            index    : arg1,
            previous : v1.config.active_vault_config,
            current  : v1.config.active_vault_config,
        };
        0x2::event::emit<UpdateActiveVaultConfig>(v2);
    }

    public(friend) entry fun update_config(arg0: &mut Registry, arg1: u64, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: 0x1::option::Option<vector<u8>>, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: 0x1::string::String, arg19: 0x1::string::String, arg20: 0x1::string::String, arg21: 0x1::string::String, arg22: 0x1::string::String, arg23: 0x1::string::String, arg24: &0x2::tx_context::TxContext) {
        version_check(arg0);
        assert!(arg3 > 0, 12);
        assert!(arg5 >= arg3, 18);
        assert!(arg4 > 0, 10);
        assert!(arg6 >= arg4, 17);
        let v0 = &mut arg0.portfolio_vault_registry;
        let v1 = get_mut_portfolio_vault(v0, arg1);
        0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::authority::verify(&v1.authority, arg24);
        let v2 = &mut arg0.deposit_vault_registry;
        let v3 = get_mut_deposit_vault(v2, arg1);
        0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::update_fee(v3, arg7, arg24);
        0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::vault::update_deposit_receipt_display(v3, arg18, arg19, arg20);
        if (arg8 > 0) {
            abort 15
        };
        let v4 = 0x1::vector::singleton<address>(v1.config.oracle_id);
        let v5 = 0x1::vector::singleton<u64>(v1.config.deposit_lot_size);
        let v6 = 0x1::vector::singleton<u64>(v1.config.bid_lot_size);
        let v7 = 0x1::vector::singleton<u64>(v1.config.min_deposit_size);
        let v8 = 0x1::vector::singleton<u64>(v1.config.min_bid_size);
        let v9 = 0x1::vector::singleton<u64>(v1.config.deposit_fee_bp);
        let v10 = 0x1::vector::singleton<u64>(v1.config.deposit_fee_share_bp);
        let v11 = 0x1::vector::singleton<0x1::option::Option<vector<u8>>>(v1.config.deposit_shared_fee_pool);
        let v12 = 0x1::vector::singleton<u64>(v1.config.bid_fee_bp);
        let v13 = 0x1::vector::singleton<u64>(v1.config.deposit_incentive_bp);
        let v14 = 0x1::vector::singleton<u64>(v1.config.bid_incentive_bp);
        let v15 = 0x1::vector::singleton<u64>(v1.config.auction_delay_ts_ms);
        let v16 = 0x1::vector::singleton<u64>(v1.config.auction_duration_ts_ms);
        let v17 = 0x1::vector::singleton<u64>(v1.config.capacity);
        let v18 = 0x1::vector::singleton<u64>(v1.config.leverage);
        let v19 = 0x1::vector::singleton<u64>(v1.config.risk_level);
        let v20 = 0x1::vector::singleton<0x1::string::String>(v1.config.deposit_receipt_display_name);
        let v21 = 0x1::vector::singleton<0x1::string::String>(v1.config.deposit_receipt_display_description);
        let v22 = 0x1::vector::singleton<0x1::string::String>(v1.config.deposit_receipt_display_image_url);
        let v23 = 0x1::vector::singleton<0x1::string::String>(v1.config.bid_receipt_display_name);
        let v24 = 0x1::vector::singleton<0x1::string::String>(v1.config.bid_receipt_display_description);
        let v25 = 0x1::vector::singleton<0x1::string::String>(v1.config.bid_receipt_display_image_url);
        v1.config.oracle_id = arg2;
        0x1::vector::push_back<address>(&mut v4, arg2);
        v1.config.deposit_lot_size = arg3;
        0x1::vector::push_back<u64>(&mut v5, arg3);
        v1.config.bid_lot_size = arg4;
        0x1::vector::push_back<u64>(&mut v6, arg4);
        v1.config.min_deposit_size = arg5;
        0x1::vector::push_back<u64>(&mut v7, arg5);
        v1.config.min_bid_size = arg6;
        0x1::vector::push_back<u64>(&mut v8, arg6);
        v1.config.deposit_fee_bp = arg7;
        0x1::vector::push_back<u64>(&mut v9, arg7);
        v1.config.deposit_fee_share_bp = arg8;
        0x1::vector::push_back<u64>(&mut v10, arg8);
        v1.config.deposit_shared_fee_pool = arg9;
        0x1::vector::push_back<0x1::option::Option<vector<u8>>>(&mut v11, arg9);
        v1.config.bid_fee_bp = arg10;
        0x1::vector::push_back<u64>(&mut v12, arg10);
        v1.config.deposit_incentive_bp = arg11;
        0x1::vector::push_back<u64>(&mut v13, arg11);
        v1.config.bid_incentive_bp = arg12;
        0x1::vector::push_back<u64>(&mut v14, arg12);
        v1.config.auction_delay_ts_ms = arg13;
        0x1::vector::push_back<u64>(&mut v15, arg13);
        v1.config.auction_duration_ts_ms = arg14;
        0x1::vector::push_back<u64>(&mut v16, arg14);
        v1.config.capacity = arg15;
        0x1::vector::push_back<u64>(&mut v17, arg15);
        v1.config.leverage = arg16;
        0x1::vector::push_back<u64>(&mut v18, arg16);
        v1.config.risk_level = arg17;
        0x1::vector::push_back<u64>(&mut v19, arg17);
        v1.config.deposit_receipt_display_name = arg18;
        0x1::vector::push_back<0x1::string::String>(&mut v20, arg18);
        v1.config.deposit_receipt_display_description = arg19;
        0x1::vector::push_back<0x1::string::String>(&mut v21, arg19);
        v1.config.deposit_receipt_display_image_url = arg20;
        0x1::vector::push_back<0x1::string::String>(&mut v22, arg20);
        v1.config.bid_receipt_display_name = arg21;
        0x1::vector::push_back<0x1::string::String>(&mut v23, arg21);
        v1.config.bid_receipt_display_description = arg22;
        0x1::vector::push_back<0x1::string::String>(&mut v24, arg22);
        v1.config.bid_receipt_display_image_url = arg23;
        0x1::vector::push_back<0x1::string::String>(&mut v25, arg23);
        let v26 = UpdateConfig{
            signer                                         : 0x2::tx_context::sender(arg24),
            index                                          : arg1,
            oracle_id_change_log                           : v4,
            deposit_lot_size_change_log                    : v5,
            bid_lot_size_change_log                        : v6,
            min_deposit_size_change_log                    : v7,
            min_bid_size_change_log                        : v8,
            deposit_fee_bp_change_log                      : v9,
            deposit_fee_share_bp_change_log                : v10,
            deposit_shared_fee_pool_change_log             : v11,
            bid_fee_bp_change_log                          : v12,
            deposit_incentive_bp_change_log                : v13,
            bid_incentive_bp_change_log                    : v14,
            auction_delay_ts_ms_change_log                 : v15,
            auction_duration_ts_ms_change_log              : v16,
            capacity_change_log                            : v17,
            leverage_change_log                            : v18,
            risk_level_change_log                          : v19,
            deposit_receipt_display_name_change_log        : v20,
            deposit_receipt_display_description_change_log : v21,
            deposit_receipt_display_image_url_change_log   : v22,
            bid_receipt_display_name_change_log            : v23,
            bid_receipt_display_description_change_log     : v24,
            bid_receipt_display_image_url_change_log       : v25,
        };
        0x2::event::emit<UpdateConfig>(v26);
    }

    public(friend) entry fun update_warmup_vault_config(arg0: &mut Registry, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = &mut arg0.portfolio_vault_registry;
        let v1 = get_mut_portfolio_vault(v0, arg1);
        0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::authority::verify(&v1.authority, arg6);
        check_dutch_auction_settings(arg4, arg5, v1.config.auction_duration_ts_ms);
        v1.config.warmup_vault_config.strike_increment = arg2;
        v1.config.warmup_vault_config.decay_speed = arg3;
        v1.config.warmup_vault_config.initial_price = arg4;
        v1.config.warmup_vault_config.final_price = arg5;
        let v2 = UpdateWarmupVaultConfig{
            signer   : 0x2::tx_context::sender(arg6),
            index    : arg1,
            previous : v1.config.warmup_vault_config,
            current  : v1.config.warmup_vault_config,
        };
        0x2::event::emit<UpdateWarmupVaultConfig>(v2);
    }

    public(friend) entry fun upgrade_registry(arg0: &mut Registry, arg1: &0x2::tx_context::TxContext) {
        0x752d6e4e573b9d31296df011e9bd79b618ccc3ff483f213c8bce8ce6dcbaad0b::authority::verify(&arg0.authority, arg1);
        assert!(1 > arg0.version, 24);
        arg0.version = 1;
    }

    fun validate_amount(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 >= arg1 && arg0 % arg1 == 0, 25);
        assert!(arg0 >= arg2, 27);
    }

    fun version_check(arg0: &Registry) {
        assert!(1 == arg0.version, 24);
        assert!(!arg0.transaction_suspended, 31);
    }

    // decompiled from Move bytecode v6
}

