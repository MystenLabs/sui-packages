module 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events {
    struct AdminCapTransferred has copy, drop {
        admin: address,
    }

    struct AssetSupported has copy, drop {
        eds_id: 0x2::object::ID,
        asset: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bank::Asset,
        sequence_number: u128,
    }

    struct AssetSynced has copy, drop {
        eds_id: 0x2::object::ID,
        ids_id: 0x2::object::ID,
        asset_symbol: 0x1::string::String,
        sequence_number: u128,
    }

    struct InternalDataStoreCreated has copy, drop {
        id: 0x2::object::ID,
        sequencer: address,
        sequence_number: u128,
    }

    struct AssetBankDeposit has copy, drop {
        eds_id: 0x2::object::ID,
        asset: 0x1::string::String,
        from: address,
        to: address,
        amount: u64,
        nonce: u128,
        sequence_number: u128,
    }

    struct Deposit has copy, drop {
        eds: 0x2::object::ID,
        ids: 0x2::object::ID,
        account: address,
        asset: 0x1::string::String,
        amount: u64,
        assets: vector<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::DepositedAsset>,
        sequence_hash: vector<u8>,
        nonce: u128,
        eds_sequence_number: u128,
        ids_sequence_number: u128,
    }

    struct TaintedAssetRemoved has copy, drop {
        eds: 0x2::object::ID,
        ids: 0x2::object::ID,
        from: address,
        to: address,
        asset: 0x1::string::String,
        amount: u64,
        nonce: u128,
        sequence_hash: vector<u8>,
        eds_sequence_number: u128,
        ids_sequence_number: u128,
    }

    struct Withdraw has copy, drop {
        eds: 0x2::object::ID,
        ids: 0x2::object::ID,
        account: address,
        asset: 0x1::string::String,
        amount: u64,
        assets: vector<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::DepositedAsset>,
        sequence_hash: vector<u8>,
        eds_sequence_number: u128,
        ids_sequence_number: u128,
    }

    struct PerpetualUpdate has copy, drop {
        eds_id: 0x2::object::ID,
        perpetual: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::Perpetual,
        sequence_number: u128,
    }

    struct PerpetualSynced has copy, drop {
        ids_id: 0x2::object::ID,
        perpetual: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::Perpetual,
        sequence_number: u128,
    }

    struct UserAuthorized has copy, drop {
        account: address,
        user: address,
        authorized: bool,
        sequence_number: u128,
    }

    struct AuthorizedAccountsUpdated has copy, drop {
        account: address,
        previous_authorized_accounts: vector<address>,
        current_authorized_accounts: vector<address>,
        sequence_number: u128,
    }

    struct OraclePriceUpdate has copy, drop {
        perpetuals: vector<0x1::string::String>,
        prices: vector<u64>,
        sequence_number: u128,
    }

    struct Trader has copy, drop, store {
        address: address,
        order_hash: vector<u8>,
        position: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Position,
        assets: vector<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::DepositedAsset>,
        fee_asset: 0x1::string::String,
        fee_usd_qty: u64,
        fee_token_qty: u64,
    }

    struct TradeExecuted has copy, drop {
        market: 0x1::string::String,
        maker: Trader,
        taker: Trader,
        fill_quantity: u64,
        fill_price: u64,
        taker_side: 0x1::string::String,
        taker_gas_fee: u64,
        sequence_hash: vector<u8>,
        sequence_number: u128,
    }

    struct LiquidationExecuted has copy, drop {
        market: 0x1::string::String,
        hash: vector<u8>,
        liquidatee_address: address,
        liquidator_address: address,
        liquidatee_position: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Position,
        liquidator_position: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Position,
        liquidatee_assets: vector<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::DepositedAsset>,
        liquidator_assets: vector<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::DepositedAsset>,
        quantity: u64,
        liq_purchase_price: u64,
        bankruptcy_price: u64,
        oracle_price: u64,
        liquidator_side: 0x1::string::String,
        premium_or_debt: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::Number,
        insurance_pool_premium_portion: u64,
        sequence_hash: vector<u8>,
        sequence_number: u128,
    }

    struct MarginAdjusted has copy, drop {
        account: address,
        amount: u64,
        added: bool,
        position: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Position,
        assets: vector<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::DepositedAsset>,
        sequence_hash: vector<u8>,
        sequence_number: u128,
    }

    struct LeverageAdjusted has copy, drop {
        account: address,
        position: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Position,
        assets: vector<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::DepositedAsset>,
        sequence_hash: vector<u8>,
        sequence_number: u128,
    }

    struct EDSOperatorUpdated has copy, drop {
        store: 0x2::object::ID,
        operator_type: 0x1::string::String,
        previous_operator: address,
        new_operator: address,
        sequence_number: u128,
    }

    struct OperatorSynced has copy, drop {
        store: 0x2::object::ID,
        operator_type: 0x1::string::String,
        previous_operator: address,
        new_operator: address,
        sequence_number: u128,
    }

    struct FundingRateUpdated has copy, drop {
        market: 0x1::string::String,
        timestamp: u64,
        rate: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::Number,
        sequence_number: u128,
    }

    struct TablePruned has copy, drop {
        type: u8,
        sequence_number: u128,
    }

    struct BankruptLiquidatorAuthorizedEvent has copy, drop {
        account: address,
        authorized: bool,
        sequence_number: u128,
    }

    struct FeeTierUpdatedEvent has copy, drop {
        account: address,
        maker: u64,
        taker: u64,
        applied: bool,
        sequence_number: u128,
    }

    struct AccountTypeUpdatedEvent has copy, drop {
        account: address,
        is_institution: bool,
        sequence_number: u128,
    }

    struct GasFeeUpdatedEvent has copy, drop {
        ids: 0x2::object::ID,
        gas_fee: u64,
        sequence_number: u128,
    }

    struct GasPoolUpdatedEvent has copy, drop {
        ids: 0x2::object::ID,
        previous_gas_pool: address,
        current_gas_pool: address,
        sequence_number: u128,
    }

    struct ADLExecuted has copy, drop {
        market: 0x1::string::String,
        hash: vector<u8>,
        maker_address: address,
        taker_address: address,
        maker_position: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Position,
        taker_position: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Position,
        maker_assets: vector<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::DepositedAsset>,
        taker_assets: vector<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::DepositedAsset>,
        quantity: u64,
        bankruptcy_price: u64,
        oracle_price: u64,
        taker_side: 0x1::string::String,
        sequence_hash: vector<u8>,
        sequence_number: u128,
    }

    struct ADLExecutedV2 has copy, drop {
        market: 0x1::string::String,
        hash: vector<u8>,
        maker_address: address,
        taker_address: address,
        maker_position: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Position,
        taker_position: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Position,
        maker_assets: vector<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::DepositedAsset>,
        taker_assets: vector<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::DepositedAsset>,
        quantity: u64,
        bankruptcy_price: u64,
        oracle_price: u64,
        taker_side: 0x1::string::String,
        sequence_hash: vector<u8>,
        sequence_number: u128,
        execution_price: u64,
        adl_fee: u64,
    }

    struct PositionClosed has copy, drop {
        market: 0x1::string::String,
        account: address,
        hash: vector<u8>,
        position: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Position,
        assets: vector<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::DepositedAsset>,
        delisting_price: u64,
        sequence_hash: vector<u8>,
        sequence_number: u128,
    }

    struct FundingRateApplied has copy, drop {
        account: address,
        position: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Position,
        assets: vector<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::DepositedAsset>,
        funding_rate: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::FundingRate,
        funding_amount: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::Number,
        sequence_number: u128,
    }

    struct TEEPositionUpdated has copy, drop {
        account: address,
        new_position: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Position,
        old_position: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Position,
        sequence_hash: vector<u8>,
        sequence_number: u128,
    }

    struct TEEAssetsUpdated has copy, drop {
        account: address,
        symbol: 0x1::string::String,
        new_amount: u64,
        old_amount: u64,
        sequence_hash: vector<u8>,
        sequence_number: u128,
    }

    struct TEEAuthorizedAccountsUpdated has copy, drop {
        account: address,
        previous_authorized_accounts: vector<address>,
        current_authorized_accounts: vector<address>,
        sequence_hash: vector<u8>,
        sequence_number: u128,
    }

    struct TEETradeFeeUpdated has copy, drop {
        account: address,
        previous_trading_fee: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::TradeFee,
        current_trading_fee: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::TradeFee,
        sequence_hash: vector<u8>,
        sequence_number: u128,
    }

    struct TEEAccountTypeUpdated has copy, drop {
        account: address,
        previous_account_type: bool,
        current_account_type: bool,
        sequence_hash: vector<u8>,
        sequence_number: u128,
    }

    public(friend) fun emit_account_type_updated_event(arg0: address, arg1: bool, arg2: u128) {
        let v0 = AccountTypeUpdatedEvent{
            account         : arg0,
            is_institution  : arg1,
            sequence_number : arg2,
        };
        0x2::event::emit<AccountTypeUpdatedEvent>(v0);
    }

    public(friend) fun emit_adl_executed_event(arg0: 0x1::string::String, arg1: vector<u8>, arg2: address, arg3: address, arg4: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Position, arg5: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Position, arg6: vector<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::DepositedAsset>, arg7: vector<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::DepositedAsset>, arg8: u64, arg9: u64, arg10: u64, arg11: bool, arg12: vector<u8>, arg13: u128, arg14: u64, arg15: u64) {
        let v0 = if (arg11) {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::position_long()
        } else {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::position_short()
        };
        let v1 = ADLExecutedV2{
            market           : arg0,
            hash             : arg1,
            maker_address    : arg2,
            taker_address    : arg3,
            maker_position   : arg4,
            taker_position   : arg5,
            maker_assets     : arg6,
            taker_assets     : arg7,
            quantity         : arg8,
            bankruptcy_price : arg9,
            oracle_price     : arg10,
            taker_side       : v0,
            sequence_hash    : arg12,
            sequence_number  : arg13,
            execution_price  : arg14,
            adl_fee          : arg15,
        };
        0x2::event::emit<ADLExecutedV2>(v1);
    }

    public(friend) fun emit_admin_cap_transfer_event(arg0: address) {
        let v0 = AdminCapTransferred{admin: arg0};
        0x2::event::emit<AdminCapTransferred>(v0);
    }

    public(friend) fun emit_asset_bank_deposit_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: address, arg3: address, arg4: u64, arg5: u128, arg6: u128) {
        let v0 = AssetBankDeposit{
            eds_id          : arg0,
            asset           : arg1,
            from            : arg2,
            to              : arg3,
            amount          : arg4,
            nonce           : arg5,
            sequence_number : arg6,
        };
        0x2::event::emit<AssetBankDeposit>(v0);
    }

    public(friend) fun emit_asset_supported_event(arg0: 0x2::object::ID, arg1: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bank::Asset, arg2: u128) {
        let v0 = AssetSupported{
            eds_id          : arg0,
            asset           : arg1,
            sequence_number : arg2,
        };
        0x2::event::emit<AssetSupported>(v0);
    }

    public(friend) fun emit_asset_synced_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: u128) {
        let v0 = AssetSynced{
            eds_id          : arg0,
            ids_id          : arg1,
            asset_symbol    : arg2,
            sequence_number : arg3,
        };
        0x2::event::emit<AssetSynced>(v0);
    }

    public(friend) fun emit_authorized_accounts_updated_event(arg0: address, arg1: vector<address>, arg2: vector<address>, arg3: u128) {
        let v0 = AuthorizedAccountsUpdated{
            account                      : arg0,
            previous_authorized_accounts : arg1,
            current_authorized_accounts  : arg2,
            sequence_number              : arg3,
        };
        0x2::event::emit<AuthorizedAccountsUpdated>(v0);
    }

    public(friend) fun emit_bankrupt_liquidator_authorized_event(arg0: address, arg1: bool, arg2: u128) {
        let v0 = BankruptLiquidatorAuthorizedEvent{
            account         : arg0,
            authorized      : arg1,
            sequence_number : arg2,
        };
        0x2::event::emit<BankruptLiquidatorAuthorizedEvent>(v0);
    }

    public(friend) fun emit_delisted_market_position_closed_event(arg0: 0x1::string::String, arg1: vector<u8>, arg2: address, arg3: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Position, arg4: vector<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::DepositedAsset>, arg5: u64, arg6: vector<u8>, arg7: u128) {
        let v0 = PositionClosed{
            market          : arg0,
            account         : arg2,
            hash            : arg1,
            position        : arg3,
            assets          : arg4,
            delisting_price : arg5,
            sequence_hash   : arg6,
            sequence_number : arg7,
        };
        0x2::event::emit<PositionClosed>(v0);
    }

    public(friend) fun emit_deposit_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: 0x1::string::String, arg4: u64, arg5: vector<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::DepositedAsset>, arg6: vector<u8>, arg7: u128, arg8: u128, arg9: u128) {
        let v0 = Deposit{
            eds                 : arg0,
            ids                 : arg1,
            account             : arg2,
            asset               : arg3,
            amount              : arg4,
            assets              : arg5,
            sequence_hash       : arg6,
            nonce               : arg7,
            eds_sequence_number : arg8,
            ids_sequence_number : arg9,
        };
        0x2::event::emit<Deposit>(v0);
    }

    public(friend) fun emit_eds_operator_update(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: address, arg3: address, arg4: u128) {
        let v0 = EDSOperatorUpdated{
            store             : arg0,
            operator_type     : arg1,
            previous_operator : arg2,
            new_operator      : arg3,
            sequence_number   : arg4,
        };
        0x2::event::emit<EDSOperatorUpdated>(v0);
    }

    public(friend) fun emit_fee_tier_updated_event(arg0: address, arg1: u64, arg2: u64, arg3: bool, arg4: u128) {
        let v0 = FeeTierUpdatedEvent{
            account         : arg0,
            maker           : arg1,
            taker           : arg2,
            applied         : arg3,
            sequence_number : arg4,
        };
        0x2::event::emit<FeeTierUpdatedEvent>(v0);
    }

    public(friend) fun emit_funding_rate_applied_event(arg0: address, arg1: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Position, arg2: vector<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::DepositedAsset>, arg3: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::FundingRate, arg4: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::Number, arg5: u128) {
        let v0 = FundingRateApplied{
            account         : arg0,
            position        : arg1,
            assets          : arg2,
            funding_rate    : arg3,
            funding_amount  : arg4,
            sequence_number : arg5,
        };
        0x2::event::emit<FundingRateApplied>(v0);
    }

    public(friend) fun emit_funding_rate_update_event(arg0: 0x1::string::String, arg1: u64, arg2: bool, arg3: u64, arg4: u128) {
        let v0 = FundingRateUpdated{
            market          : arg0,
            timestamp       : arg3,
            rate            : 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::from(arg1, arg2),
            sequence_number : arg4,
        };
        0x2::event::emit<FundingRateUpdated>(v0);
    }

    public(friend) fun emit_gas_fee_updated_event(arg0: 0x2::object::ID, arg1: u64, arg2: u128) {
        let v0 = GasFeeUpdatedEvent{
            ids             : arg0,
            gas_fee         : arg1,
            sequence_number : arg2,
        };
        0x2::event::emit<GasFeeUpdatedEvent>(v0);
    }

    public(friend) fun emit_gas_pool_updated_event(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u128) {
        let v0 = GasPoolUpdatedEvent{
            ids               : arg0,
            previous_gas_pool : arg1,
            current_gas_pool  : arg2,
            sequence_number   : arg3,
        };
        0x2::event::emit<GasPoolUpdatedEvent>(v0);
    }

    public(friend) fun emit_internal_exchange_created_event(arg0: 0x2::object::ID, arg1: address, arg2: u128) {
        let v0 = InternalDataStoreCreated{
            id              : arg0,
            sequencer       : arg1,
            sequence_number : arg2,
        };
        0x2::event::emit<InternalDataStoreCreated>(v0);
    }

    public(friend) fun emit_leverage_adjusted_event(arg0: address, arg1: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Position, arg2: vector<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::DepositedAsset>, arg3: vector<u8>, arg4: u128) {
        let v0 = LeverageAdjusted{
            account         : arg0,
            position        : arg1,
            assets          : arg2,
            sequence_hash   : arg3,
            sequence_number : arg4,
        };
        0x2::event::emit<LeverageAdjusted>(v0);
    }

    public(friend) fun emit_liquidation_executed_event(arg0: 0x1::string::String, arg1: vector<u8>, arg2: address, arg3: address, arg4: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Position, arg5: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Position, arg6: vector<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::DepositedAsset>, arg7: vector<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::DepositedAsset>, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: bool, arg13: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::Number, arg14: u64, arg15: vector<u8>, arg16: u128) {
        let v0 = if (arg12) {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::position_long()
        } else {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::position_short()
        };
        let v1 = LiquidationExecuted{
            market                         : arg0,
            hash                           : arg1,
            liquidatee_address             : arg2,
            liquidator_address             : arg3,
            liquidatee_position            : arg4,
            liquidator_position            : arg5,
            liquidatee_assets              : arg6,
            liquidator_assets              : arg7,
            quantity                       : arg8,
            liq_purchase_price             : arg9,
            bankruptcy_price               : arg10,
            oracle_price                   : arg11,
            liquidator_side                : v0,
            premium_or_debt                : arg13,
            insurance_pool_premium_portion : arg14,
            sequence_hash                  : arg15,
            sequence_number                : arg16,
        };
        0x2::event::emit<LiquidationExecuted>(v1);
    }

    public(friend) fun emit_margin_adjusted_event(arg0: address, arg1: u64, arg2: bool, arg3: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Position, arg4: vector<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::DepositedAsset>, arg5: vector<u8>, arg6: u128) {
        let v0 = MarginAdjusted{
            account         : arg0,
            amount          : arg1,
            added           : arg2,
            position        : arg3,
            assets          : arg4,
            sequence_hash   : arg5,
            sequence_number : arg6,
        };
        0x2::event::emit<MarginAdjusted>(v0);
    }

    public(friend) fun emit_operator_synced_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: address, arg3: address, arg4: u128) {
        let v0 = OperatorSynced{
            store             : arg0,
            operator_type     : arg1,
            previous_operator : arg2,
            new_operator      : arg3,
            sequence_number   : arg4,
        };
        0x2::event::emit<OperatorSynced>(v0);
    }

    public(friend) fun emit_oracle_price_update_event(arg0: vector<0x1::string::String>, arg1: vector<u64>, arg2: u128) {
        let v0 = OraclePriceUpdate{
            perpetuals      : arg0,
            prices          : arg1,
            sequence_number : arg2,
        };
        0x2::event::emit<OraclePriceUpdate>(v0);
    }

    public(friend) fun emit_perpetual_synced_event(arg0: 0x2::object::ID, arg1: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::Perpetual, arg2: u128) {
        let v0 = PerpetualSynced{
            ids_id          : arg0,
            perpetual       : arg1,
            sequence_number : arg2,
        };
        0x2::event::emit<PerpetualSynced>(v0);
    }

    public(friend) fun emit_perpetual_update_event(arg0: 0x2::object::ID, arg1: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::Perpetual, arg2: u128) {
        let v0 = PerpetualUpdate{
            eds_id          : arg0,
            perpetual       : arg1,
            sequence_number : arg2,
        };
        0x2::event::emit<PerpetualUpdate>(v0);
    }

    public(friend) fun emit_removed_tainted_deposit_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: address, arg4: 0x1::string::String, arg5: u64, arg6: u128, arg7: vector<u8>, arg8: u128, arg9: u128) {
        let v0 = TaintedAssetRemoved{
            eds                 : arg0,
            ids                 : arg1,
            from                : arg2,
            to                  : arg3,
            asset               : arg4,
            amount              : arg5,
            nonce               : arg6,
            sequence_hash       : arg7,
            eds_sequence_number : arg8,
            ids_sequence_number : arg9,
        };
        0x2::event::emit<TaintedAssetRemoved>(v0);
    }

    public(friend) fun emit_table_pruned_event(arg0: u8, arg1: u128) {
        let v0 = TablePruned{
            type            : arg0,
            sequence_number : arg1,
        };
        0x2::event::emit<TablePruned>(v0);
    }

    public(friend) fun emit_tee_account_type_updated_event(arg0: address, arg1: bool, arg2: bool, arg3: vector<u8>, arg4: u128) {
        let v0 = TEEAccountTypeUpdated{
            account               : arg0,
            previous_account_type : arg1,
            current_account_type  : arg2,
            sequence_hash         : arg3,
            sequence_number       : arg4,
        };
        0x2::event::emit<TEEAccountTypeUpdated>(v0);
    }

    public(friend) fun emit_tee_assets_updated_event(arg0: address, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u128) {
        let v0 = TEEAssetsUpdated{
            account         : arg0,
            symbol          : arg1,
            new_amount      : arg3,
            old_amount      : arg2,
            sequence_hash   : arg4,
            sequence_number : arg5,
        };
        0x2::event::emit<TEEAssetsUpdated>(v0);
    }

    public(friend) fun emit_tee_authorized_accounts_updated_event(arg0: address, arg1: vector<address>, arg2: vector<address>, arg3: vector<u8>, arg4: u128) {
        let v0 = TEEAuthorizedAccountsUpdated{
            account                      : arg0,
            previous_authorized_accounts : arg1,
            current_authorized_accounts  : arg2,
            sequence_hash                : arg3,
            sequence_number              : arg4,
        };
        0x2::event::emit<TEEAuthorizedAccountsUpdated>(v0);
    }

    public(friend) fun emit_tee_position_update_event(arg0: address, arg1: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Position, arg2: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Position, arg3: vector<u8>, arg4: u128) {
        let v0 = TEEPositionUpdated{
            account         : arg0,
            new_position    : arg2,
            old_position    : arg1,
            sequence_hash   : arg3,
            sequence_number : arg4,
        };
        0x2::event::emit<TEEPositionUpdated>(v0);
    }

    public(friend) fun emit_tee_trade_fee_updated_event(arg0: address, arg1: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::TradeFee, arg2: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::TradeFee, arg3: vector<u8>, arg4: u128) {
        let v0 = TEETradeFeeUpdated{
            account              : arg0,
            previous_trading_fee : arg1,
            current_trading_fee  : arg2,
            sequence_hash        : arg3,
            sequence_number      : arg4,
        };
        0x2::event::emit<TEETradeFeeUpdated>(v0);
    }

    public(friend) fun emit_trade_executed_event(arg0: 0x1::string::String, arg1: address, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Position, arg6: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Position, arg7: vector<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::DepositedAsset>, arg8: vector<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::DepositedAsset>, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: u64, arg16: u64, arg17: bool, arg18: u64, arg19: vector<u8>, arg20: u128) {
        let v0 = Trader{
            address       : arg1,
            order_hash    : arg3,
            position      : arg5,
            assets        : arg7,
            fee_asset     : arg14,
            fee_usd_qty   : arg9,
            fee_token_qty : arg11,
        };
        let v1 = Trader{
            address       : arg2,
            order_hash    : arg4,
            position      : arg6,
            assets        : arg8,
            fee_asset     : arg13,
            fee_usd_qty   : arg10,
            fee_token_qty : arg12,
        };
        let v2 = if (arg17) {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::position_long()
        } else {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::position_short()
        };
        let v3 = TradeExecuted{
            market          : arg0,
            maker           : v0,
            taker           : v1,
            fill_quantity   : arg15,
            fill_price      : arg16,
            taker_side      : v2,
            taker_gas_fee   : arg18,
            sequence_hash   : arg19,
            sequence_number : arg20,
        };
        0x2::event::emit<TradeExecuted>(v3);
    }

    public(friend) fun emit_user_authorized_event(arg0: address, arg1: address, arg2: bool, arg3: u128) {
        let v0 = UserAuthorized{
            account         : arg0,
            user            : arg1,
            authorized      : arg2,
            sequence_number : arg3,
        };
        0x2::event::emit<UserAuthorized>(v0);
    }

    public(friend) fun emit_withdraw_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: 0x1::string::String, arg4: u64, arg5: vector<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::DepositedAsset>, arg6: vector<u8>, arg7: u128, arg8: u128) {
        let v0 = Withdraw{
            eds                 : arg0,
            ids                 : arg1,
            account             : arg2,
            asset               : arg3,
            amount              : arg4,
            assets              : arg5,
            sequence_hash       : arg6,
            eds_sequence_number : arg7,
            ids_sequence_number : arg8,
        };
        0x2::event::emit<Withdraw>(v0);
    }

    // decompiled from Move bytecode v6
}

