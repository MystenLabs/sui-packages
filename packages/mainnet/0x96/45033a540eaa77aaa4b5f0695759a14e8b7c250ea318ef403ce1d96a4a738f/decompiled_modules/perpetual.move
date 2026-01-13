module 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::perpetual {
    struct PerpetualCreationEvent has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        imr: u128,
        mmr: u128,
        maker_fee: u128,
        taker_fee: u128,
        fee_pool: address,
        gas_pool: address,
        start_time: u64,
        price_identifier_id: vector<u8>,
        checks: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::evaluator::TradeChecks,
        funding: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::FundingRate,
    }

    struct FeePoolAccountUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        account: address,
    }

    struct GasPoolAccountUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        account: address,
    }

    struct DelistEvent has copy, drop {
        id: 0x2::object::ID,
        delisting_price: u128,
    }

    struct TradingPermissionStatusUpdateEvent has copy, drop {
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
        maker_fee: u128,
        taker_fee: u128,
    }

    struct PriceOracleIdentifierUpdateEvent has copy, drop {
        perp: 0x2::object::ID,
        identifier: vector<u8>,
    }

    struct MakerFeeUpdateEvent has copy, drop {
        perp: 0x2::object::ID,
        maker_fee: u128,
    }

    struct TakerFeeUpdateEvent has copy, drop {
        perp: 0x2::object::ID,
        taker_fee: u128,
    }

    struct Perpetual has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        imr: u128,
        mmr: u128,
        maker_fee: u128,
        taker_fee: u128,
        insurance_fund: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::insurance_fund::InsuranceFund,
        fee_pool: address,
        gas_pool: address,
        delisted: bool,
        delisting_price: u128,
        is_trading_permitted: bool,
        start_time: u64,
        checks: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::evaluator::TradeChecks,
        positions: 0x2::table::Table<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>,
        special_fee: 0x2::table::Table<address, SpecialFee>,
        price_oracle: u128,
        funding: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::FundingRate,
        price_identifier_id: vector<u8>,
    }

    struct SpecialFee has copy, drop, store {
        status: bool,
        maker_fee: u128,
        taker_fee: u128,
    }

    public fun set_max_oi_open(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut Perpetual, arg3: vector<u128>) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::evaluator::set_max_oi_open(0x2::object::uid_to_inner(&arg2.id), &mut arg2.checks, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::to_1x9_vec(arg3));
    }

    public fun set_max_price(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut Perpetual, arg3: u128) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::evaluator::set_max_price(0x2::object::uid_to_inner(&arg2.id), &mut arg2.checks, arg3 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint());
    }

    public fun set_max_qty_limit(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut Perpetual, arg3: u128) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::evaluator::set_max_qty_limit(0x2::object::uid_to_inner(&arg2.id), &mut arg2.checks, arg3 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint());
    }

    public fun set_max_qty_market(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut Perpetual, arg3: u128) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::evaluator::set_max_qty_market(0x2::object::uid_to_inner(&arg2.id), &mut arg2.checks, arg3 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint());
    }

    public fun set_min_price(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut Perpetual, arg3: u128) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::evaluator::set_min_price(0x2::object::uid_to_inner(&arg2.id), &mut arg2.checks, arg3 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint());
    }

    public fun set_min_qty(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut Perpetual, arg3: u128) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::evaluator::set_min_qty(0x2::object::uid_to_inner(&arg2.id), &mut arg2.checks, arg3 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint());
    }

    public fun set_mtb_long(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut Perpetual, arg3: u128) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::evaluator::set_mtb_long(0x2::object::uid_to_inner(&arg2.id), &mut arg2.checks, arg3 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint());
    }

    public fun set_mtb_short(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut Perpetual, arg3: u128) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::evaluator::set_mtb_short(0x2::object::uid_to_inner(&arg2.id), &mut arg2.checks, arg3 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint());
    }

    public fun set_step_size(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut Perpetual, arg3: u128) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::evaluator::set_step_size(0x2::object::uid_to_inner(&arg2.id), &mut arg2.checks, arg3 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint());
    }

    public fun set_tick_size(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut Perpetual, arg3: u128) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::evaluator::set_tick_size(0x2::object::uid_to_inner(&arg2.id), &mut arg2.checks, arg3 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint());
    }

    public(friend) fun funding_rate(arg0: &Perpetual) : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::FundingRate {
        arg0.funding
    }

    public fun set_funding_rate(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x2::clock::Clock, arg2: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::FundingRateCap, arg3: &mut Perpetual, arg4: u128, arg5: bool, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_funding_rate_operator_validity(arg0, arg2);
        update_oracle_price(arg3, arg6, arg1);
        let v0 = 0x2::object::uid_to_inner(&arg3.id);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::set_global_index(&mut arg3.funding, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::compute_new_global_index(arg1, arg3.funding, price_oracle(arg3)), v0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::set_funding_rate(&mut arg3.funding, arg4 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(), arg5, 0x2::clock::timestamp_ms(arg1), v0);
    }

    public fun set_max_allowed_funding_rate(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut Perpetual, arg3: u128) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::set_max_allowed_funding_rate(&mut arg2.funding, arg3 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(), 0x2::object::uid_to_inner(id(arg2)));
    }

    public(friend) fun insurance_fund(arg0: &Perpetual) : &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::insurance_fund::InsuranceFund {
        &arg0.insurance_fund
    }

    public(friend) fun borrow_position(arg0: &Perpetual, arg1: address) : &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position {
        0x2::table::borrow<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(&arg0.positions, arg1)
    }

    public(friend) fun checks(arg0: &Perpetual) : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::evaluator::TradeChecks {
        arg0.checks
    }

    public(friend) fun create(arg0: vector<u8>, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: address, arg6: address, arg7: address, arg8: address, arg9: u128, arg10: u128, arg11: u128, arg12: u128, arg13: u128, arg14: u128, arg15: u128, arg16: u128, arg17: u128, arg18: u128, arg19: u64, arg20: vector<u128>, arg21: vector<u8>, arg22: u64, arg23: u128, arg24: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg24);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::evaluator::new_trade_checks(arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg20);
        let v3 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::initialize(arg19, arg18);
        assert!(arg2 > 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::maintenance_margin_must_be_greater_than_zero());
        assert!(arg2 <= arg1, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::maintenance_margin_must_be_less_than_or_equal_to_imr());
        let v4 = Perpetual{
            id                   : v0,
            name                 : 0x1::string::utf8(arg0),
            imr                  : arg1,
            mmr                  : arg2,
            maker_fee            : arg3,
            taker_fee            : arg4,
            insurance_fund       : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::insurance_fund::create_insurance_fund(v1, arg5, arg6, arg22, arg23),
            fee_pool             : arg7,
            gas_pool             : arg8,
            delisted             : false,
            delisting_price      : 0,
            is_trading_permitted : true,
            start_time           : arg19,
            checks               : v2,
            positions            : 0x2::table::new<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(arg24),
            special_fee          : 0x2::table::new<address, SpecialFee>(arg24),
            price_oracle         : 0,
            funding              : v3,
            price_identifier_id  : arg21,
        };
        let v5 = PerpetualCreationEvent{
            id                  : v1,
            name                : v4.name,
            imr                 : arg1,
            mmr                 : arg2,
            maker_fee           : arg3,
            taker_fee           : arg4,
            fee_pool            : arg7,
            gas_pool            : arg8,
            start_time          : arg19,
            price_identifier_id : arg21,
            checks              : v2,
            funding             : v3,
        };
        0x2::event::emit<PerpetualCreationEvent>(v5);
        0x2::transfer::share_object<Perpetual>(v4);
        v1
    }

    public fun delist_perpetual(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut Perpetual, arg3: u128) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        let v0 = arg3 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint();
        assert!(!arg2.delisted, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::perpetual_has_been_already_de_listed());
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::evaluator::verify_price_checks(arg2.checks, v0);
        arg2.delisted = true;
        arg2.delisting_price = v0;
        let v1 = DelistEvent{
            id              : 0x2::object::uid_to_inner(id(arg2)),
            delisting_price : v0,
        };
        0x2::event::emit<DelistEvent>(v1);
    }

    public(friend) fun delisted(arg0: &Perpetual) : bool {
        arg0.delisted
    }

    public(friend) fun delisting_price(arg0: &Perpetual) : u128 {
        arg0.delisting_price
    }

    public(friend) fun fee_pool(arg0: &Perpetual) : address {
        arg0.fee_pool
    }

    public(friend) fun funding_rate_mut(arg0: &mut Perpetual) : &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::FundingRate {
        &mut arg0.funding
    }

    public(friend) fun gas_pool(arg0: &Perpetual) : address {
        arg0.gas_pool
    }

    public(friend) fun get_fee(arg0: address, arg1: &Perpetual, arg2: bool) : u128 {
        if (0x2::table::contains<address, SpecialFee>(&arg1.special_fee, arg0)) {
            let v0 = 0x2::table::borrow<address, SpecialFee>(&arg1.special_fee, arg0);
            if (v0.status) {
                if (arg2) {
                    return v0.maker_fee
                };
                return v0.taker_fee
            };
        };
        if (arg2) {
            return arg1.maker_fee
        };
        arg1.taker_fee
    }

    public(friend) fun global_index(arg0: &Perpetual) : 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::FundingIndex {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::funding_rate::index(arg0.funding)
    }

    public(friend) fun has_position(arg0: &Perpetual, arg1: address) : bool {
        0x2::table::contains<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position>(&arg0.positions, arg1)
    }

    public(friend) fun id(arg0: &Perpetual) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun imr(arg0: &Perpetual) : u128 {
        arg0.imr
    }

    public(friend) fun insurance_active_pool(arg0: &Perpetual) : address {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::insurance_fund::active_account(&arg0.insurance_fund)
    }

    public(friend) fun insurance_fund_mut(arg0: &mut Perpetual) : &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::insurance_fund::InsuranceFund {
        &mut arg0.insurance_fund
    }

    public(friend) fun insurance_security_pool(arg0: &Perpetual) : address {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::insurance_fund::security_account(&arg0.insurance_fund)
    }

    public(friend) fun is_trading_permitted(arg0: &Perpetual) : bool {
        arg0.is_trading_permitted
    }

    public(friend) fun maker_fee(arg0: &Perpetual) : u128 {
        arg0.maker_fee
    }

    public(friend) fun mmr(arg0: &Perpetual) : u128 {
        arg0.mmr
    }

    public(friend) fun name(arg0: &Perpetual) : &0x1::string::String {
        &arg0.name
    }

    public(friend) fun positions(arg0: &mut Perpetual) : &mut 0x2::table::Table<address, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position> {
        &mut arg0.positions
    }

    public(friend) fun price_identifier(arg0: &Perpetual) : vector<u8> {
        arg0.price_identifier_id
    }

    public(friend) fun price_oracle(arg0: &Perpetual) : u128 {
        arg0.price_oracle
    }

    public fun remove_empty_positions(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &0x2::clock::Clock, arg3: &mut Perpetual, arg4: vector<address>) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::remove_empty_positions(positions(arg3), arg4, 0x2::clock::timestamp_ms(arg2));
    }

    public fun set_fee_pool_address<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg3: &mut Perpetual, arg4: address) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        assert!(arg4 != @0x0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::address_cannot_be_zero());
        arg3.fee_pool = arg4;
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::create_account_if_not_exist<T0>(arg2, arg3.fee_pool);
        let v0 = FeePoolAccountUpdateEvent{
            id      : 0x2::object::uid_to_inner(id(arg3)),
            account : arg4,
        };
        0x2::event::emit<FeePoolAccountUpdateEvent>(v0);
    }

    public fun set_gas_pool_address<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg3: &mut Perpetual, arg4: address) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        assert!(arg4 != @0x0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::address_cannot_be_zero());
        arg3.gas_pool = arg4;
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::create_account_if_not_exist<T0>(arg2, arg3.gas_pool);
        let v0 = GasPoolAccountUpdateEvent{
            id      : 0x2::object::uid_to_inner(id(arg3)),
            account : arg4,
        };
        0x2::event::emit<GasPoolAccountUpdateEvent>(v0);
    }

    public fun set_initial_margin_required(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut Perpetual, arg3: u128) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        let v0 = arg3 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint();
        assert!(v0 >= arg2.mmr, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::initial_margin_must_be_greater_than_or_equal_to_mmr());
        arg2.imr = v0;
        let v1 = IMRUpdateEvent{
            id  : 0x2::object::uid_to_inner(id(arg2)),
            imr : v0,
        };
        0x2::event::emit<IMRUpdateEvent>(v1);
    }

    public fun set_insurance_active_pool_address<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg3: &mut Perpetual, arg4: address) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::insurance_fund::set_active_account(&mut arg3.insurance_fund, arg4);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::create_account_if_not_exist<T0>(arg2, arg4);
    }

    public fun set_insurance_fund_transfer_amount_limit(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut Perpetual, arg3: u128) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::insurance_fund::set_amount_limit(insurance_fund_mut(arg2), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg3));
    }

    public fun set_insurance_fund_transfer_interval(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut Perpetual, arg3: u64) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::insurance_fund::set_transfer_interval(insurance_fund_mut(arg2), arg3);
    }

    public fun set_insurance_security_pool_address<T0>(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg3: &mut Perpetual, arg4: address) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::insurance_fund::set_security_account(&mut arg3.insurance_fund, arg4);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::create_account_if_not_exist<T0>(arg2, arg4);
    }

    public fun set_maintenance_margin_required(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut Perpetual, arg3: u128) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        let v0 = arg3 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint();
        assert!(v0 > 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::maintenance_margin_must_be_greater_than_zero());
        assert!(v0 <= arg2.imr, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::maintenance_margin_must_be_less_than_or_equal_to_imr());
        arg2.mmr = v0;
        let v1 = MMRUpdateEvent{
            id  : 0x2::object::uid_to_inner(id(arg2)),
            mmr : v0,
        };
        0x2::event::emit<MMRUpdateEvent>(v1);
    }

    public fun set_maker_fee(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut Perpetual, arg3: u128) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        arg2.maker_fee = arg3 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint();
        let v0 = MakerFeeUpdateEvent{
            perp      : 0x2::object::uid_to_inner(id(arg2)),
            maker_fee : arg2.maker_fee,
        };
        0x2::event::emit<MakerFeeUpdateEvent>(v0);
    }

    public fun set_price_oracle_identifier(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut Perpetual, arg3: vector<u8>) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        arg2.price_identifier_id = arg3;
        let v0 = PriceOracleIdentifierUpdateEvent{
            perp       : 0x2::object::uid_to_inner(id(arg2)),
            identifier : arg3,
        };
        0x2::event::emit<PriceOracleIdentifierUpdateEvent>(v0);
    }

    public fun set_special_fee(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut Perpetual, arg3: address, arg4: bool, arg5: u128, arg6: u128) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        assert!(arg3 != @0x0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::address_cannot_be_zero());
        let v0 = SpecialFee{
            status    : arg4,
            maker_fee : arg5 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(),
            taker_fee : arg6 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(),
        };
        if (0x2::table::contains<address, SpecialFee>(&arg2.special_fee, arg3)) {
            *0x2::table::borrow_mut<address, SpecialFee>(&mut arg2.special_fee, arg3) = v0;
        } else {
            0x2::table::add<address, SpecialFee>(&mut arg2.special_fee, arg3, v0);
        };
        let v1 = SpecialFeeEvent{
            perp      : 0x2::object::uid_to_inner(id(arg2)),
            account   : arg3,
            status    : arg4,
            maker_fee : v0.maker_fee,
            taker_fee : v0.taker_fee,
        };
        0x2::event::emit<SpecialFeeEvent>(v1);
    }

    public fun set_taker_fee(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut Perpetual, arg3: u128) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        arg2.taker_fee = arg3 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint();
        let v0 = TakerFeeUpdateEvent{
            perp      : 0x2::object::uid_to_inner(id(arg2)),
            taker_fee : arg2.taker_fee,
        };
        0x2::event::emit<TakerFeeUpdateEvent>(v0);
    }

    public fun set_trading_permit(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg2: &mut Perpetual, arg3: bool) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg0);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::check_manager_validity(arg0, arg1);
        arg2.is_trading_permitted = arg3;
        let v0 = TradingPermissionStatusUpdateEvent{status: arg3};
        0x2::event::emit<TradingPermissionStatusUpdateEvent>(v0);
    }

    public(friend) fun start_time(arg0: &Perpetual) : u64 {
        arg0.start_time
    }

    public(friend) fun taker_fee(arg0: &Perpetual) : u128 {
        arg0.taker_fee
    }

    public fun transfer_insurance_fund_from_active_to_security<T0>(arg0: &0x2::clock::Clock, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg4: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg5: &Perpetual, arg6: u128) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg1);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::insurance_fund::transfer_from_active_to_security<T0>(insurance_fund(arg5), arg0, arg4, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg6), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::increment_tx_index(arg3));
    }

    public fun transfer_insurance_fund_from_security_to_active<T0>(arg0: &0x2::clock::Clock, arg1: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::ProtocolConfig, arg2: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::roles::ExchangeManagerCap, arg3: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::TxIndexer, arg4: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg5: &mut Perpetual, arg6: u128) {
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::protocol::check_basic(arg1);
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::insurance_fund::transfer_from_security_to_active<T0>(insurance_fund_mut(arg5), arg0, arg4, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::decimal_1e18_to_base(arg6), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::sub_accounts::increment_tx_index(arg3));
    }

    public(friend) fun update_oracle_price(arg0: &mut Perpetual, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) {
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::get_price_identifier(arg1) == arg0.price_identifier_id, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::wrong_price_identifier());
        arg0.price_oracle = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_div(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::get_oracle_price(arg1, arg2), (0x1::u64::pow(10, (0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::get_oracle_base(arg1, arg2) as u8)) as u128));
    }

    // decompiled from Move bytecode v6
}

