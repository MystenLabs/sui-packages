module 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::perpetual {
    struct PerpetualCreationEvent has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        imr: u128,
        mmr: u128,
        makerFee: u128,
        takerFee: u128,
        insurancePoolRatio: u128,
        insurancePool: address,
        feePool: address,
        checks: 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::evaluator::TradeChecks,
        funding: 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::funding_rate::FundingRate,
    }

    struct InsurancePoolRatioUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        ratio: u128,
    }

    struct InsurancePoolAccountUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        account: address,
    }

    struct FeePoolAccountUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        account: address,
    }

    struct DelistEvent has copy, drop {
        id: 0x2::object::ID,
        delistingPrice: u128,
    }

    struct TradingPermissionStatusUpdate has copy, drop {
        status: bool,
    }

    struct MMRUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        mmr: u128,
    }

    struct IMRUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        imr: u128,
    }

    struct SpecialFeeEvent has copy, drop {
        perp: 0x2::object::ID,
        account: address,
        status: bool,
        makerFee: u128,
        takerFee: u128,
    }

    struct PriceOracleIdentifierUpdateEvent has copy, drop {
        perp: 0x2::object::ID,
        identifier: vector<u8>,
    }

    struct MakerFeeUpdateEvent has copy, drop {
        perp: 0x2::object::ID,
        makerFee: u128,
    }

    struct TakerFeeUpdateEvent has copy, drop {
        perp: 0x2::object::ID,
        takerFee: u128,
    }

    struct PriceFeedUpdateEvent has copy, drop {
        perp: 0x2::object::ID,
        price_feed: vector<u8>,
    }

    struct PerpetualNameUpdateEvent has copy, drop {
        perp: 0x2::object::ID,
        name: 0x1::string::String,
    }

    struct PreLaunchOraclePriceUpdateEvent has copy, drop {
        perp: 0x2::object::ID,
        price: u128,
    }

    struct Perpetual has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        imr: u128,
        mmr: u128,
        makerFee: u128,
        takerFee: u128,
        insurancePoolRatio: u128,
        insurancePool: address,
        feePool: address,
        delisted: bool,
        delistingPrice: u128,
        isTradingPermitted: bool,
        startTime: u64,
        checks: 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::evaluator::TradeChecks,
        positions: 0x2::table::Table<address, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::UserPosition>,
        specialFee: 0x2::table::Table<address, SpecialFee>,
        priceOracle: u128,
        funding: 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::funding_rate::FundingRate,
        priceIdentifierId: vector<u8>,
    }

    struct PerpetualV2 has key {
        id: 0x2::object::UID,
        version: u64,
        name: 0x1::string::String,
        imr: u128,
        mmr: u128,
        makerFee: u128,
        takerFee: u128,
        insurancePoolRatio: u128,
        insurancePool: address,
        feePool: address,
        delisted: bool,
        delistingPrice: u128,
        isTradingPermitted: bool,
        startTime: u64,
        checks: 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::evaluator::TradeChecks,
        positions: 0x2::table::Table<address, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::UserPosition>,
        specialFee: 0x2::table::Table<address, SpecialFee>,
        priceOracle: u128,
        funding: 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::funding_rate::FundingRate,
        priceIdentifierId: vector<u8>,
    }

    struct SpecialFee has copy, drop, store {
        status: bool,
        makerFee: u128,
        takerFee: u128,
    }

    public fun id(arg0: &Perpetual) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun initialize(arg0: vector<u8>, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: address, arg7: address, arg8: u128, arg9: u128, arg10: u128, arg11: u128, arg12: u128, arg13: u128, arg14: u128, arg15: u128, arg16: u128, arg17: u128, arg18: u64, arg19: vector<u128>, arg20: vector<u8>, arg21: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg21);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::evaluator::initialize(arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg19);
        let v3 = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::funding_rate::initialize(arg18, arg17);
        assert!(arg2 > 0, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::maintenance_margin_must_be_greater_than_zero());
        assert!(arg2 <= arg1, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::maintenance_margin_must_be_less_than_or_equal_to_imr());
        let v4 = PerpetualV2{
            id                 : v0,
            version            : 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(),
            name               : 0x1::string::utf8(arg0),
            imr                : arg1,
            mmr                : arg2,
            makerFee           : arg3,
            takerFee           : arg4,
            insurancePoolRatio : arg5,
            insurancePool      : arg6,
            feePool            : arg7,
            delisted           : false,
            delistingPrice     : 0,
            isTradingPermitted : true,
            startTime          : arg18,
            checks             : v2,
            positions          : 0x2::table::new<address, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::UserPosition>(arg21),
            specialFee         : 0x2::table::new<address, SpecialFee>(arg21),
            priceOracle        : 0,
            funding            : v3,
            priceIdentifierId  : arg20,
        };
        let v5 = PerpetualCreationEvent{
            id                 : v1,
            name               : v4.name,
            imr                : arg1,
            mmr                : arg2,
            makerFee           : arg3,
            takerFee           : arg4,
            insurancePoolRatio : arg5,
            insurancePool      : arg6,
            feePool            : arg7,
            checks             : v2,
            funding            : v3,
        };
        0x2::event::emit<PerpetualCreationEvent>(v5);
        0x2::transfer::share_object<PerpetualV2>(v4);
        v1
    }

    public entry fun set_max_oi_open(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: vector<u128>) {
    }

    public entry fun set_max_price(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: u128) {
    }

    public entry fun set_max_qty_limit(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: u128) {
    }

    public entry fun set_max_qty_market(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: u128) {
    }

    public entry fun set_min_price(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: u128) {
    }

    public entry fun set_min_qty(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: u128) {
    }

    public entry fun set_mtb_long(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: u128) {
    }

    public entry fun set_mtb_short(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: u128) {
    }

    public entry fun set_step_size(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: u128) {
    }

    public entry fun set_tick_size(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: u128) {
    }

    public entry fun set_funding_rate(arg0: &0x2::clock::Clock, arg1: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::CapabilitiesSafe, arg2: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::FundingRateCap, arg3: &mut Perpetual, arg4: u128, arg5: bool, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
    }

    public entry fun set_funding_time(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &0x2::clock::Clock, arg2: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::CapabilitiesSafeV2, arg3: &mut PerpetualV2, arg4: u64) {
        assert!(arg3.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::validate_safe_version(arg2);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::funding_rate::set_funding_time(&mut arg3.funding, arg4, 0x2::clock::timestamp_ms(arg1));
    }

    public entry fun set_max_allowed_funding_rate(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: u128) {
    }

    public fun checks(arg0: &Perpetual) : 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::evaluator::TradeChecks {
        arg0.checks
    }

    public fun checks_v2(arg0: &PerpetualV2) : 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::evaluator::TradeChecks {
        arg0.checks
    }

    public entry fun delist_perpetual(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: u128) {
    }

    public entry fun delist_perpetual_v2(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut PerpetualV2, arg2: u128) {
        assert!(arg1.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        let v0 = arg2 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint();
        assert!(!arg1.delisted, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::perpetual_has_been_already_de_listed());
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::evaluator::verify_price_checks(arg1.checks, v0);
        arg1.delisted = true;
        arg1.delistingPrice = v0;
        let v1 = DelistEvent{
            id             : 0x2::object::uid_to_inner(id_v2(arg1)),
            delistingPrice : v0,
        };
        0x2::event::emit<DelistEvent>(v1);
    }

    public fun delisted(arg0: &Perpetual) : bool {
        arg0.delisted
    }

    public fun delisted_v2(arg0: &PerpetualV2) : bool {
        arg0.delisted
    }

    public fun delistingPrice(arg0: &Perpetual) : u128 {
        arg0.delistingPrice
    }

    public fun delistingPrice_v2(arg0: &PerpetualV2) : u128 {
        arg0.delistingPrice
    }

    public fun feePool(arg0: &Perpetual) : address {
        arg0.feePool
    }

    public fun feePool_v2(arg0: &PerpetualV2) : address {
        arg0.feePool
    }

    public fun fundingRate(arg0: &Perpetual) : 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::funding_rate::FundingRate {
        arg0.funding
    }

    public fun fundingRate_v2(arg0: &PerpetualV2) : 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::funding_rate::FundingRate {
        arg0.funding
    }

    public fun get_accounts_vector(arg0: &PerpetualV2, arg1: 0x1::string::String) : vector<address> {
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, arg1)) {
            *0x2::dynamic_field::borrow<0x1::string::String, vector<address>>(&arg0.id, arg1)
        } else {
            0x1::vector::empty<address>()
        }
    }

    public fun get_fee(arg0: address, arg1: &Perpetual, arg2: bool) : u128 {
        0
    }

    public fun get_fee_v2(arg0: address, arg1: &PerpetualV2, arg2: bool) : u128 {
        let v0 = if (arg2) {
            arg1.makerFee
        } else {
            arg1.takerFee
        };
        let v1 = v0;
        if (0x2::table::contains<address, SpecialFee>(&arg1.specialFee, arg0)) {
            let v2 = 0x2::table::borrow<address, SpecialFee>(&arg1.specialFee, arg0);
            if (v2.status == true) {
                let v3 = if (arg2) {
                    v2.makerFee
                } else {
                    v2.takerFee
                };
                v1 = v3;
            };
        };
        v1
    }

    public fun get_non_liquidateable_accounts_key() : 0x1::string::String {
        0x1::string::utf8(b"non_liquidateable")
    }

    fun get_oracle_price_key() : 0x1::string::String {
        0x1::string::utf8(b"oracle_price")
    }

    fun get_pre_launch_status_key() : 0x1::string::String {
        0x1::string::utf8(b"pre_launch_status")
    }

    public fun get_user_position(arg0: &PerpetualV2, arg1: address) : 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::UserPosition {
        if (0x2::table::contains<address, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::UserPosition>(&arg0.positions, arg1)) {
            return *0x2::table::borrow<address, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::UserPosition>(&arg0.positions, arg1)
        };
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::initialize(0x2::object::uid_to_inner(&arg0.id), arg1)
    }

    public fun get_version(arg0: &PerpetualV2) : u64 {
        arg0.version
    }

    public fun get_whitelisted_liquidators_key() : 0x1::string::String {
        0x1::string::utf8(b"whitelisted_liquidators")
    }

    public fun globalIndex(arg0: &Perpetual) : 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::funding_rate::FundingIndex {
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::funding_rate::index(arg0.funding)
    }

    public fun globalIndex_v2(arg0: &PerpetualV2) : 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::funding_rate::FundingIndex {
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::funding_rate::index(arg0.funding)
    }

    public fun id_v2(arg0: &PerpetualV2) : &0x2::object::UID {
        &arg0.id
    }

    public fun imr(arg0: &Perpetual) : u128 {
        arg0.imr
    }

    public fun imr_v2(arg0: &PerpetualV2) : u128 {
        arg0.imr
    }

    entry fun increment_perpetual_version(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut PerpetualV2) {
        arg1.version = arg1.version + 1;
    }

    public fun insurancePool(arg0: &Perpetual) : address {
        arg0.insurancePool
    }

    public fun insurancePool_v2(arg0: &PerpetualV2) : address {
        arg0.insurancePool
    }

    public(friend) fun is_pre_launch_perpetual(arg0: &PerpetualV2) : bool {
        let v0 = get_pre_launch_status_key();
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            return *0x2::dynamic_field::borrow<0x1::string::String, bool>(&arg0.id, v0)
        };
        false
    }

    public fun is_trading_permitted(arg0: &mut Perpetual) : bool {
        arg0.isTradingPermitted
    }

    public fun is_trading_permitted_v2(arg0: &mut PerpetualV2) : bool {
        arg0.isTradingPermitted
    }

    public fun is_whitelisted_for_special_fee(arg0: &PerpetualV2, arg1: address) : bool {
        0x2::table::contains<address, SpecialFee>(&arg0.specialFee, arg1)
    }

    public fun makerFee(arg0: &Perpetual) : u128 {
        arg0.makerFee
    }

    public fun makerFee_v2(arg0: &PerpetualV2) : u128 {
        arg0.makerFee
    }

    public fun mmr(arg0: &Perpetual) : u128 {
        arg0.mmr
    }

    public fun mmr_v2(arg0: &PerpetualV2) : u128 {
        arg0.mmr
    }

    public fun name(arg0: &Perpetual) : &0x1::string::String {
        &arg0.name
    }

    public fun name_v2(arg0: &PerpetualV2) : &0x1::string::String {
        &arg0.name
    }

    public fun poolPercentage(arg0: &Perpetual) : u128 {
        arg0.insurancePoolRatio
    }

    public fun poolPercentage_v2(arg0: &PerpetualV2) : u128 {
        arg0.insurancePoolRatio
    }

    public(friend) fun positions(arg0: &mut PerpetualV2) : &mut 0x2::table::Table<address, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::UserPosition> {
        &mut arg0.positions
    }

    public fun priceIdenfitier(arg0: &Perpetual) : vector<u8> {
        arg0.priceIdentifierId
    }

    public fun priceIdenfitier_v2(arg0: &PerpetualV2) : vector<u8> {
        arg0.priceIdentifierId
    }

    public fun priceOracle(arg0: &Perpetual) : u128 {
        arg0.priceOracle
    }

    public fun priceOracle_v2(arg0: &PerpetualV2) : u128 {
        arg0.priceOracle
    }

    entry fun remove_empty_positions(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::CapabilitiesSafeV2, arg1: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeGuardianCap, arg2: &0x2::clock::Clock, arg3: &mut PerpetualV2, arg4: vector<address>) {
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::validate_safe_version(arg0);
        assert!(arg3.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::check_guardian_validity_v2(arg0, arg1);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::position::remove_empty_positions(positions(arg3), arg4, 0x2::clock::timestamp_ms(arg2));
    }

    public entry fun set_fee_pool_address(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: address) {
    }

    public entry fun set_fee_pool_address_v2<T0>(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::BankV2<T0>, arg2: &mut PerpetualV2, arg3: address) {
        assert!(arg2.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        assert!(arg3 != @0x0, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::address_cannot_be_zero());
        arg2.feePool = arg3;
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::initialize_account(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::mut_accounts_v2<T0>(arg1), arg2.feePool);
        let v0 = FeePoolAccountUpdateEvent{
            id      : 0x2::object::uid_to_inner(id_v2(arg2)),
            account : arg3,
        };
        0x2::event::emit<FeePoolAccountUpdateEvent>(v0);
    }

    public entry fun set_funding_rate_v2(arg0: &0x2::clock::Clock, arg1: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::CapabilitiesSafeV2, arg2: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::FundingRateCap, arg3: &mut PerpetualV2, arg4: u128, arg5: bool, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        assert!(arg3.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::validate_safe_version(arg1);
        update_oracle_price(arg3, arg6, arg0);
        let v0 = 0x2::object::uid_to_inner(&arg3.id);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::funding_rate::set_global_index(&mut arg3.funding, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::funding_rate::compute_new_global_index(arg0, arg3.funding, priceOracle_v2(arg3)), v0);
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::funding_rate::set_funding_rate(arg1, arg2, &mut arg3.funding, arg4 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint(), arg5, 0x2::clock::timestamp_ms(arg0), v0);
    }

    public entry fun set_initial_margin_required(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: u128) {
    }

    public entry fun set_initial_margin_required_v2(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut PerpetualV2, arg2: u128) {
        assert!(arg1.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        let v0 = arg2 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint();
        assert!(v0 >= arg1.mmr, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::initial_margin_must_be_greater_than_or_equal_to_mmr());
        arg1.imr = v0;
        let v1 = IMRUpdateEvent{
            id  : 0x2::object::uid_to_inner(id_v2(arg1)),
            imr : v0,
        };
        0x2::event::emit<IMRUpdateEvent>(v1);
    }

    public entry fun set_insurance_pool_address(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: address) {
    }

    public entry fun set_insurance_pool_address_v2<T0>(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::BankV2<T0>, arg2: &mut PerpetualV2, arg3: address) {
        assert!(arg2.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        assert!(arg3 != @0x0, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::address_cannot_be_zero());
        arg2.insurancePool = arg3;
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::initialize_account(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::margin_bank::mut_accounts_v2<T0>(arg1), arg2.insurancePool);
        let v0 = InsurancePoolAccountUpdateEvent{
            id      : 0x2::object::uid_to_inner(id_v2(arg2)),
            account : arg3,
        };
        0x2::event::emit<InsurancePoolAccountUpdateEvent>(v0);
    }

    public entry fun set_insurance_pool_percentage(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: u128) {
    }

    public entry fun set_insurance_pool_percentage_v2(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut PerpetualV2, arg2: u128) {
        assert!(arg1.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        let v0 = arg2 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint();
        assert!(v0 <= 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::can_not_be_greater_than_hundred_percent());
        arg1.insurancePoolRatio = v0;
        let v1 = InsurancePoolRatioUpdateEvent{
            id    : 0x2::object::uid_to_inner(id_v2(arg1)),
            ratio : v0,
        };
        0x2::event::emit<InsurancePoolRatioUpdateEvent>(v1);
    }

    public entry fun set_maintenance_margin_required(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: u128) {
    }

    public entry fun set_maintenance_margin_required_v2(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut PerpetualV2, arg2: u128) {
        assert!(arg1.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        let v0 = arg2 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint();
        assert!(v0 > 0, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::maintenance_margin_must_be_greater_than_zero());
        assert!(v0 <= arg1.imr, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::maintenance_margin_must_be_less_than_or_equal_to_imr());
        arg1.mmr = v0;
        let v1 = MMRUpdateEvent{
            id  : 0x2::object::uid_to_inner(id_v2(arg1)),
            mmr : v0,
        };
        0x2::event::emit<MMRUpdateEvent>(v1);
    }

    entry fun set_maker_fee(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut PerpetualV2, arg2: u128) {
        assert!(arg1.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        arg1.makerFee = arg2 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint();
        let v0 = MakerFeeUpdateEvent{
            perp     : 0x2::object::uid_to_inner(id_v2(arg1)),
            makerFee : arg1.makerFee,
        };
        0x2::event::emit<MakerFeeUpdateEvent>(v0);
    }

    public entry fun set_max_allowed_funding_rate_v2(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut PerpetualV2, arg2: u128) {
        assert!(arg1.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::funding_rate::set_max_allowed_funding_rate(&mut arg1.funding, arg2 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint(), 0x2::object::uid_to_inner(id_v2(arg1)));
    }

    public entry fun set_max_oi_open_v2(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut PerpetualV2, arg2: vector<u128>) {
        assert!(arg1.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::evaluator::set_max_oi_open(0x2::object::uid_to_inner(&arg1.id), &mut arg1.checks, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::to_1x9_vec(arg2));
    }

    public entry fun set_max_price_v2(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut PerpetualV2, arg2: u128) {
        assert!(arg1.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::evaluator::set_max_price(0x2::object::uid_to_inner(&arg1.id), &mut arg1.checks, arg2 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint());
    }

    public entry fun set_max_qty_limit_v2(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut PerpetualV2, arg2: u128) {
        assert!(arg1.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::evaluator::set_max_qty_limit(0x2::object::uid_to_inner(&arg1.id), &mut arg1.checks, arg2 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint());
    }

    public entry fun set_max_qty_market_v2(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut PerpetualV2, arg2: u128) {
        assert!(arg1.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::evaluator::set_max_qty_market(0x2::object::uid_to_inner(&arg1.id), &mut arg1.checks, arg2 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint());
    }

    public entry fun set_min_price_v2(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut PerpetualV2, arg2: u128) {
        assert!(arg1.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::evaluator::set_min_price(0x2::object::uid_to_inner(&arg1.id), &mut arg1.checks, arg2 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint());
    }

    public entry fun set_min_qty_v2(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut PerpetualV2, arg2: u128) {
        assert!(arg1.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::evaluator::set_min_qty(0x2::object::uid_to_inner(&arg1.id), &mut arg1.checks, arg2 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint());
    }

    public entry fun set_mtb_long_V2(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut PerpetualV2, arg2: u128) {
        assert!(arg1.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::evaluator::set_mtb_long(0x2::object::uid_to_inner(&arg1.id), &mut arg1.checks, arg2 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint());
    }

    public entry fun set_mtb_short_v2(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut PerpetualV2, arg2: u128) {
        assert!(arg1.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::evaluator::set_mtb_short(0x2::object::uid_to_inner(&arg1.id), &mut arg1.checks, arg2 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint());
    }

    entry fun set_non_liquidateable_account(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut PerpetualV2, arg2: address, arg3: bool) {
        if (update_accounts_in_provided_dynamic_key(arg1, arg2, arg3, get_non_liquidateable_accounts_key())) {
            0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::events::emit_non_liquidateable_account_update_event(0x2::object::id<PerpetualV2>(arg1), arg2, arg3);
        };
    }

    public entry fun set_oracle_price(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::CapabilitiesSafeV2, arg1: &mut PerpetualV2, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::validate_safe_version(arg0);
        assert!(is_pre_launch_perpetual(arg1), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::invalid_pre_launch_perpetual());
        assert!(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::verify_oracle_operator(arg0, 0x2::tx_context::sender(arg3)), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::invalid_oracle_operator());
        let v0 = get_oracle_price_key();
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg1.id, v0)) {
            *0x2::dynamic_field::borrow_mut<0x1::string::String, u128>(&mut arg1.id, v0) = arg2;
        } else {
            0x2::dynamic_field::add<0x1::string::String, u128>(&mut arg1.id, v0, arg2);
        };
        let v1 = PreLaunchOraclePriceUpdateEvent{
            perp  : 0x2::object::uid_to_inner(&arg1.id),
            price : arg2,
        };
        0x2::event::emit<PreLaunchOraclePriceUpdateEvent>(v1);
    }

    entry fun set_perpetual_name(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut PerpetualV2, arg2: vector<u8>) {
        assert!(arg1.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        arg1.name = 0x1::string::utf8(arg2);
        let v0 = PerpetualNameUpdateEvent{
            perp : 0x2::object::uid_to_inner(id_v2(arg1)),
            name : arg1.name,
        };
        0x2::event::emit<PerpetualNameUpdateEvent>(v0);
    }

    public entry fun set_pre_launch_status(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut PerpetualV2, arg2: bool) {
        assert!(arg1.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        let v0 = get_pre_launch_status_key();
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg1.id, v0)) {
            *0x2::dynamic_field::borrow_mut<0x1::string::String, bool>(&mut arg1.id, v0) = arg2;
        } else {
            0x2::dynamic_field::add<0x1::string::String, bool>(&mut arg1.id, v0, arg2);
        };
    }

    entry fun set_price_feed(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut PerpetualV2, arg2: vector<u8>) {
        assert!(arg1.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        arg1.priceIdentifierId = arg2;
        let v0 = PriceFeedUpdateEvent{
            perp       : 0x2::object::uid_to_inner(id_v2(arg1)),
            price_feed : arg2,
        };
        0x2::event::emit<PriceFeedUpdateEvent>(v0);
    }

    public entry fun set_price_oracle_identifier(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: vector<u8>) {
    }

    public entry fun set_price_oracle_identifier_v2(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut PerpetualV2, arg2: vector<u8>) {
        assert!(arg1.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        arg1.priceIdentifierId = arg2;
        let v0 = PriceOracleIdentifierUpdateEvent{
            perp       : 0x2::object::uid_to_inner(id_v2(arg1)),
            identifier : arg2,
        };
        0x2::event::emit<PriceOracleIdentifierUpdateEvent>(v0);
    }

    public entry fun set_special_fee(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: address, arg3: bool, arg4: u128, arg5: u128) {
    }

    public entry fun set_special_fee_v2(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut PerpetualV2, arg2: address, arg3: bool, arg4: u128, arg5: u128) {
        assert!(arg1.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        let v0 = SpecialFee{
            status   : arg3,
            makerFee : arg4 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint(),
            takerFee : arg5 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint(),
        };
        if (0x2::table::contains<address, SpecialFee>(&arg1.specialFee, arg2)) {
            *0x2::table::borrow_mut<address, SpecialFee>(&mut arg1.specialFee, arg2) = v0;
        } else {
            0x2::table::add<address, SpecialFee>(&mut arg1.specialFee, arg2, v0);
        };
        let v1 = SpecialFeeEvent{
            perp     : 0x2::object::uid_to_inner(id_v2(arg1)),
            account  : arg2,
            status   : arg3,
            makerFee : v0.makerFee,
            takerFee : v0.takerFee,
        };
        0x2::event::emit<SpecialFeeEvent>(v1);
    }

    public entry fun set_step_size_v2(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut PerpetualV2, arg2: u128) {
        assert!(arg1.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::evaluator::set_step_size(0x2::object::uid_to_inner(&arg1.id), &mut arg1.checks, arg2 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint());
    }

    entry fun set_taker_fee(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut PerpetualV2, arg2: u128) {
        assert!(arg1.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        arg1.takerFee = arg2 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint();
        let v0 = TakerFeeUpdateEvent{
            perp     : 0x2::object::uid_to_inner(id_v2(arg1)),
            takerFee : arg1.takerFee,
        };
        0x2::event::emit<TakerFeeUpdateEvent>(v0);
    }

    public entry fun set_tick_size_v2(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut PerpetualV2, arg2: u128) {
        assert!(arg1.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::evaluator::set_tick_size(0x2::object::uid_to_inner(&arg1.id), &mut arg1.checks, arg2 / 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_uint());
    }

    public entry fun set_trading_permit(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::CapabilitiesSafe, arg1: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeGuardianCap, arg2: &mut Perpetual, arg3: bool) {
    }

    public entry fun set_trading_permit_v2(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::CapabilitiesSafeV2, arg1: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeGuardianCap, arg2: &mut PerpetualV2, arg3: bool) {
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::validate_safe_version(arg0);
        assert!(arg2.version == 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::get_version(), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::object_version_mismatch());
        0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::check_guardian_validity_v2(arg0, arg1);
        arg2.isTradingPermitted = arg3;
        let v0 = TradingPermissionStatusUpdate{status: arg3};
        0x2::event::emit<TradingPermissionStatusUpdate>(v0);
    }

    entry fun set_whitelisted_liquidator(arg0: &0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::roles::ExchangeAdminCap, arg1: &mut PerpetualV2, arg2: address, arg3: bool) {
        if (update_accounts_in_provided_dynamic_key(arg1, arg2, arg3, get_whitelisted_liquidators_key())) {
            0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::events::emit_whitelisted_liquidator_update_event(0x2::object::id<PerpetualV2>(arg1), arg2, arg3);
        };
    }

    public fun startTime(arg0: &Perpetual) : u64 {
        arg0.startTime
    }

    public fun startTime_v2(arg0: &PerpetualV2) : u64 {
        arg0.startTime
    }

    public fun takerFee(arg0: &Perpetual) : u128 {
        arg0.takerFee
    }

    public fun takerFee_v2(arg0: &PerpetualV2) : u128 {
        arg0.takerFee
    }

    fun update_accounts_in_provided_dynamic_key(arg0: &mut PerpetualV2, arg1: address, arg2: bool, arg3: 0x1::string::String) : bool {
        assert!(is_pre_launch_perpetual(arg0), 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::invalid_pre_launch_perpetual());
        let v0 = if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, arg3)) {
            0x2::dynamic_field::borrow_mut<0x1::string::String, vector<address>>(&mut arg0.id, arg3)
        } else {
            let v1 = 0x1::vector::empty<address>();
            &mut v1
        };
        let (v2, v3) = 0x1::vector::index_of<address>(v0, &arg1);
        if (arg2 && !v2) {
            0x1::vector::push_back<address>(v0, arg1);
            true
        } else if (!arg2 && v2) {
            0x1::vector::remove<address>(v0, v3);
            true
        } else {
            false
        }
    }

    public(friend) fun update_oracle_price(arg0: &mut PerpetualV2, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) {
        assert!(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::get_price_identifier(arg1) == arg0.priceIdentifierId, 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::error::wrong_price_identifier());
        if (is_pre_launch_perpetual(arg0)) {
            arg0.priceOracle = *0x2::dynamic_field::borrow<0x1::string::String, u128>(&arg0.id, get_oracle_price_key());
        } else {
            arg0.priceOracle = 0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::base_div(0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::get_oracle_price_v2(arg1, arg2), (0x2::math::pow(10, (0xc9ba51116d85cfbb401043f5e0710ab582c4b9b04a139b7df223f8f06bb66fa5::library::get_oracle_base_v2(arg1, arg2) as u8)) as u128));
        };
    }

    // decompiled from Move bytecode v6
}

