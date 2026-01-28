module 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events {
    struct RoleAuthorized<phantom T0> has copy, drop, store {
        pos0: address,
    }

    struct RoleDeauthorized<phantom T0> has copy, drop, store {
        pos0: address,
    }

    struct MintRedeemEnabled has copy, drop, store {
        dummy_field: bool,
    }

    struct MintRedeemDisabled has copy, drop, store {
        dummy_field: bool,
    }

    struct GlobalCoinPauseEnabled has copy, drop, store {
        dummy_field: bool,
    }

    struct GlobalCoinPauseDisabled has copy, drop, store {
        dummy_field: bool,
    }

    struct CollateralEnabled<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct CollateralAdded<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct CollateralDisabled<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct CollateralLimitsUpdated<phantom T0> has copy, drop, store {
        pos0: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::Limits,
    }

    struct CollateralRemoved<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct CollateralFeesUpdated<phantom T0> has copy, drop, store {
        pos0: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_fee::CollateralFee,
    }

    struct CollateralCustodyTransfer<phantom T0> has copy, drop, store {
        amount: u64,
        custodian: address,
    }

    struct CollateralCustodianAddressUpdated<phantom T0> has copy, drop, store {
        pos0: address,
    }

    struct CollateralOracleMinPriceUpdated<phantom T0> has copy, drop, store {
        pos0: u64,
    }

    struct CollateralOracleMaxPriceUpdated<phantom T0> has copy, drop, store {
        pos0: u64,
    }

    struct CollateralOracleMaxAgeUpdated<phantom T0> has copy, drop, store {
        pos0: u64,
    }

    struct CollateralOracleIdUpdated<phantom T0> has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct OracleFeedAdded has copy, drop, store {
        pos0: 0x2::object::ID,
        pos1: 0x1::string::String,
        pos2: vector<u8>,
    }

    struct OracleFeedRemoved has copy, drop, store {
        pos0: 0x2::object::ID,
        pos1: 0x1::string::String,
    }

    struct OraclePythConfidenceBpsUpdated has copy, drop, store {
        pos0: 0x2::object::ID,
        pos1: u16,
    }

    struct OracleMinimumSourcesUpdated has copy, drop, store {
        pos0: 0x2::object::ID,
        pos1: u8,
    }

    struct OracleMinPriceUpdated has copy, drop, store {
        pos0: 0x2::object::ID,
        pos1: u64,
    }

    struct OracleMaxPriceUpdated has copy, drop, store {
        pos0: 0x2::object::ID,
        pos1: u64,
    }

    struct OracleMaxAgeUpdated has copy, drop, store {
        pos0: 0x2::object::ID,
        pos1: u64,
    }

    struct OraclePriceTooSmall has copy, drop, store {
        oracle_id: 0x2::object::ID,
        identifier: 0x1::string::String,
        price: u64,
    }

    struct OraclePriceTooLarge has copy, drop, store {
        oracle_id: 0x2::object::ID,
        identifier: 0x1::string::String,
        price: u64,
    }

    struct OraclePriceStale has copy, drop, store {
        oracle_id: 0x2::object::ID,
        identifier: 0x1::string::String,
    }

    struct PythConfidenceNotValid has copy, drop, store {
        oracle_id: 0x2::object::ID,
    }

    struct EpochLimitsUpdated has copy, drop, store {
        pos0: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::Limit,
    }

    struct PeriodLimitsUpdated has copy, drop, store {
        pos0: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::Limit,
    }

    struct DefaultBenefactorEpochLimitsUpdated has copy, drop, store {
        pos0: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::Limit,
    }

    struct DefaultBenefactorPeriodLimitsUpdated has copy, drop, store {
        pos0: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::Limit,
    }

    struct EpochDurationUpdated has copy, drop, store {
        old_duration_ms: u64,
        new_duration_ms: u64,
    }

    struct PeriodDurationUpdated has copy, drop, store {
        old_duration_ms: u64,
        new_duration_ms: u64,
    }

    struct PegPriceUpdated has copy, drop, store {
        pos0: u64,
    }

    struct BenefactorEnabled has copy, drop, store {
        pos0: address,
    }

    struct BenefactorDisabled has copy, drop, store {
        pos0: address,
    }

    struct BenefactorConfigUpdated has copy, drop, store {
        pos0: address,
    }

    struct BenefactorAdded has copy, drop, store {
        pos0: address,
    }

    struct BenefactorRemoved has copy, drop, store {
        pos0: address,
    }

    struct AddressAddedToDenylist has copy, drop, store {
        pos0: address,
    }

    struct AddressRemovedFromDenylist has copy, drop, store {
        pos0: address,
    }

    struct OrderExecuted<phantom T0> has copy, drop, store {
        is_mint: bool,
        benefactor: address,
        amount_in: u64,
        amount_out: u64,
        fee_bps: u16,
        fee_is_charged: bool,
        nonce: 0x1::string::String,
        expiry_ms: u64,
        min_amount_out: u64,
    }

    struct OraclePriceCommitted has copy, drop, store {
        oracle_id: 0x2::object::ID,
        identifier: 0x1::string::String,
        price: u64,
        timestamp_ms: u64,
    }

    struct AggregatedOraclePrice has copy, drop, store {
        oracle_id: 0x2::object::ID,
        price: u64,
        earliest_timestamp_ms: u64,
    }

    public(friend) fun emit_address_added_to_denylist(arg0: address) {
        let v0 = AddressAddedToDenylist{pos0: arg0};
        0x2::event::emit<AddressAddedToDenylist>(v0);
    }

    public(friend) fun emit_address_removed_from_denylist(arg0: address) {
        let v0 = AddressRemovedFromDenylist{pos0: arg0};
        0x2::event::emit<AddressRemovedFromDenylist>(v0);
    }

    public(friend) fun emit_aggregated_oracle_price(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = AggregatedOraclePrice{
            oracle_id             : arg0,
            price                 : arg1,
            earliest_timestamp_ms : arg2,
        };
        0x2::event::emit<AggregatedOraclePrice>(v0);
    }

    public(friend) fun emit_benefactor_added(arg0: address) {
        let v0 = BenefactorAdded{pos0: arg0};
        0x2::event::emit<BenefactorAdded>(v0);
    }

    public(friend) fun emit_benefactor_config_updated(arg0: address) {
        let v0 = BenefactorConfigUpdated{pos0: arg0};
        0x2::event::emit<BenefactorConfigUpdated>(v0);
    }

    public(friend) fun emit_benefactor_disabled(arg0: address) {
        let v0 = BenefactorDisabled{pos0: arg0};
        0x2::event::emit<BenefactorDisabled>(v0);
    }

    public(friend) fun emit_benefactor_enabled(arg0: address) {
        let v0 = BenefactorEnabled{pos0: arg0};
        0x2::event::emit<BenefactorEnabled>(v0);
    }

    public(friend) fun emit_benefactor_removed(arg0: address) {
        let v0 = BenefactorRemoved{pos0: arg0};
        0x2::event::emit<BenefactorRemoved>(v0);
    }

    public(friend) fun emit_collateral_added<T0>() {
        let v0 = CollateralAdded<T0>{dummy_field: false};
        0x2::event::emit<CollateralAdded<T0>>(v0);
    }

    public(friend) fun emit_collateral_custodian_address_updated<T0>(arg0: address) {
        let v0 = CollateralCustodianAddressUpdated<T0>{pos0: arg0};
        0x2::event::emit<CollateralCustodianAddressUpdated<T0>>(v0);
    }

    public(friend) fun emit_collateral_default_fees_updated<T0>(arg0: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_fee::CollateralFee) {
        let v0 = CollateralFeesUpdated<T0>{pos0: arg0};
        0x2::event::emit<CollateralFeesUpdated<T0>>(v0);
    }

    public(friend) fun emit_collateral_disabled<T0>() {
        let v0 = CollateralDisabled<T0>{dummy_field: false};
        0x2::event::emit<CollateralDisabled<T0>>(v0);
    }

    public(friend) fun emit_collateral_enabled<T0>() {
        let v0 = CollateralEnabled<T0>{dummy_field: false};
        0x2::event::emit<CollateralEnabled<T0>>(v0);
    }

    public(friend) fun emit_collateral_limits_updated<T0>(arg0: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limits::Limits) {
        let v0 = CollateralLimitsUpdated<T0>{pos0: arg0};
        0x2::event::emit<CollateralLimitsUpdated<T0>>(v0);
    }

    public(friend) fun emit_collateral_oracle_id_updated<T0>(arg0: 0x2::object::ID) {
        let v0 = CollateralOracleIdUpdated<T0>{pos0: arg0};
        0x2::event::emit<CollateralOracleIdUpdated<T0>>(v0);
    }

    public(friend) fun emit_collateral_oracle_max_age_updated<T0>(arg0: u64) {
        let v0 = CollateralOracleMaxAgeUpdated<T0>{pos0: arg0};
        0x2::event::emit<CollateralOracleMaxAgeUpdated<T0>>(v0);
    }

    public(friend) fun emit_collateral_oracle_max_price_updated<T0>(arg0: u64) {
        let v0 = CollateralOracleMaxPriceUpdated<T0>{pos0: arg0};
        0x2::event::emit<CollateralOracleMaxPriceUpdated<T0>>(v0);
    }

    public(friend) fun emit_collateral_oracle_min_price_updated<T0>(arg0: u64) {
        let v0 = CollateralOracleMinPriceUpdated<T0>{pos0: arg0};
        0x2::event::emit<CollateralOracleMinPriceUpdated<T0>>(v0);
    }

    public(friend) fun emit_collateral_removed<T0>() {
        let v0 = CollateralRemoved<T0>{dummy_field: false};
        0x2::event::emit<CollateralRemoved<T0>>(v0);
    }

    public(friend) fun emit_custody_transfer<T0>(arg0: u64, arg1: address) {
        let v0 = CollateralCustodyTransfer<T0>{
            amount    : arg0,
            custodian : arg1,
        };
        0x2::event::emit<CollateralCustodyTransfer<T0>>(v0);
    }

    public(friend) fun emit_default_benefactor_epoch_limits_updated(arg0: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::Limit) {
        let v0 = DefaultBenefactorEpochLimitsUpdated{pos0: arg0};
        0x2::event::emit<DefaultBenefactorEpochLimitsUpdated>(v0);
    }

    public(friend) fun emit_default_benefactor_period_limits_updated(arg0: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::Limit) {
        let v0 = DefaultBenefactorPeriodLimitsUpdated{pos0: arg0};
        0x2::event::emit<DefaultBenefactorPeriodLimitsUpdated>(v0);
    }

    public(friend) fun emit_epoch_duration_updated(arg0: u64, arg1: u64) {
        let v0 = EpochDurationUpdated{
            old_duration_ms : arg0,
            new_duration_ms : arg1,
        };
        0x2::event::emit<EpochDurationUpdated>(v0);
    }

    public(friend) fun emit_epoch_limits_updated(arg0: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::Limit) {
        let v0 = EpochLimitsUpdated{pos0: arg0};
        0x2::event::emit<EpochLimitsUpdated>(v0);
    }

    public(friend) fun emit_global_coin_pause_disabled() {
        let v0 = GlobalCoinPauseDisabled{dummy_field: false};
        0x2::event::emit<GlobalCoinPauseDisabled>(v0);
    }

    public(friend) fun emit_global_coin_pause_enabled() {
        let v0 = GlobalCoinPauseEnabled{dummy_field: false};
        0x2::event::emit<GlobalCoinPauseEnabled>(v0);
    }

    public(friend) fun emit_mint_redeem_disabled() {
        let v0 = MintRedeemDisabled{dummy_field: false};
        0x2::event::emit<MintRedeemDisabled>(v0);
    }

    public(friend) fun emit_mint_redeem_enabled() {
        let v0 = MintRedeemEnabled{dummy_field: false};
        0x2::event::emit<MintRedeemEnabled>(v0);
    }

    public(friend) fun emit_oracle_feed_added(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: vector<u8>) {
        let v0 = OracleFeedAdded{
            pos0 : arg0,
            pos1 : arg1,
            pos2 : arg2,
        };
        0x2::event::emit<OracleFeedAdded>(v0);
    }

    public(friend) fun emit_oracle_feed_removed(arg0: 0x2::object::ID, arg1: 0x1::string::String) {
        let v0 = OracleFeedRemoved{
            pos0 : arg0,
            pos1 : arg1,
        };
        0x2::event::emit<OracleFeedRemoved>(v0);
    }

    public(friend) fun emit_oracle_max_age_updated(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = OracleMaxAgeUpdated{
            pos0 : arg0,
            pos1 : arg1,
        };
        0x2::event::emit<OracleMaxAgeUpdated>(v0);
    }

    public(friend) fun emit_oracle_max_price_updated(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = OracleMaxPriceUpdated{
            pos0 : arg0,
            pos1 : arg1,
        };
        0x2::event::emit<OracleMaxPriceUpdated>(v0);
    }

    public(friend) fun emit_oracle_min_price_updated(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = OracleMinPriceUpdated{
            pos0 : arg0,
            pos1 : arg1,
        };
        0x2::event::emit<OracleMinPriceUpdated>(v0);
    }

    public(friend) fun emit_oracle_minimum_sources_updated(arg0: 0x2::object::ID, arg1: u8) {
        let v0 = OracleMinimumSourcesUpdated{
            pos0 : arg0,
            pos1 : arg1,
        };
        0x2::event::emit<OracleMinimumSourcesUpdated>(v0);
    }

    public(friend) fun emit_oracle_price_committed(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: u64) {
        let v0 = OraclePriceCommitted{
            oracle_id    : arg0,
            identifier   : arg1,
            price        : arg2,
            timestamp_ms : arg3,
        };
        0x2::event::emit<OraclePriceCommitted>(v0);
    }

    public(friend) fun emit_oracle_price_stale(arg0: 0x2::object::ID, arg1: 0x1::string::String) {
        let v0 = OraclePriceStale{
            oracle_id  : arg0,
            identifier : arg1,
        };
        0x2::event::emit<OraclePriceStale>(v0);
    }

    public(friend) fun emit_oracle_price_too_large(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64) {
        let v0 = OraclePriceTooLarge{
            oracle_id  : arg0,
            identifier : arg1,
            price      : arg2,
        };
        0x2::event::emit<OraclePriceTooLarge>(v0);
    }

    public(friend) fun emit_oracle_price_too_small(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64) {
        let v0 = OraclePriceTooSmall{
            oracle_id  : arg0,
            identifier : arg1,
            price      : arg2,
        };
        0x2::event::emit<OraclePriceTooSmall>(v0);
    }

    public(friend) fun emit_oracle_pyth_confidence_bps_updated(arg0: 0x2::object::ID, arg1: u16) {
        let v0 = OraclePythConfidenceBpsUpdated{
            pos0 : arg0,
            pos1 : arg1,
        };
        0x2::event::emit<OraclePythConfidenceBpsUpdated>(v0);
    }

    public(friend) fun emit_order_executed<T0>(arg0: bool, arg1: address, arg2: u64, arg3: u64, arg4: u16, arg5: bool, arg6: 0x1::string::String, arg7: u64, arg8: u64) {
        let v0 = OrderExecuted<T0>{
            is_mint        : arg0,
            benefactor     : arg1,
            amount_in      : arg2,
            amount_out     : arg3,
            fee_bps        : arg4,
            fee_is_charged : arg5,
            nonce          : arg6,
            expiry_ms      : arg7,
            min_amount_out : arg8,
        };
        0x2::event::emit<OrderExecuted<T0>>(v0);
    }

    public(friend) fun emit_peg_price_updated(arg0: u64) {
        let v0 = PegPriceUpdated{pos0: arg0};
        0x2::event::emit<PegPriceUpdated>(v0);
    }

    public(friend) fun emit_period_duration_updated(arg0: u64, arg1: u64) {
        let v0 = PeriodDurationUpdated{
            old_duration_ms : arg0,
            new_duration_ms : arg1,
        };
        0x2::event::emit<PeriodDurationUpdated>(v0);
    }

    public(friend) fun emit_period_limits_updated(arg0: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::limit::Limit) {
        let v0 = PeriodLimitsUpdated{pos0: arg0};
        0x2::event::emit<PeriodLimitsUpdated>(v0);
    }

    public(friend) fun emit_pyth_confidence_not_valid(arg0: 0x2::object::ID) {
        let v0 = PythConfidenceNotValid{oracle_id: arg0};
        0x2::event::emit<PythConfidenceNotValid>(v0);
    }

    public(friend) fun emit_role_authorized<T0>(arg0: address) {
        let v0 = RoleAuthorized<T0>{pos0: arg0};
        0x2::event::emit<RoleAuthorized<T0>>(v0);
    }

    public(friend) fun emit_role_deauthorized<T0>(arg0: address) {
        let v0 = RoleDeauthorized<T0>{pos0: arg0};
        0x2::event::emit<RoleDeauthorized<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

