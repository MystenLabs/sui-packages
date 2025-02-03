module 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::perpetual {
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
        checks: 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::evaluator::TradeChecks,
        funding: 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::funding_rate::FundingRate,
    }

    struct SpecialFee has copy, drop, store {
        status: bool,
        makerFee: u128,
        takerFee: u128,
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
        checks: 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::evaluator::TradeChecks,
        positions: 0x2::table::Table<address, 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::position::UserPosition>,
        specialFee: 0x2::table::Table<address, SpecialFee>,
        priceOracle: u128,
        funding: 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::funding_rate::FundingRate,
        priceIdentifierId: vector<u8>,
    }

    public(friend) fun initialize(arg0: vector<u8>, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: address, arg7: address, arg8: u128, arg9: u128, arg10: u128, arg11: u128, arg12: u128, arg13: u128, arg14: u128, arg15: u128, arg16: u128, arg17: u128, arg18: u64, arg19: vector<u128>, arg20: 0x2::table::Table<address, 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::position::UserPosition>, arg21: 0x2::table::Table<address, SpecialFee>, arg22: vector<u8>, arg23: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg23);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::evaluator::initialize(arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg19);
        let v3 = 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::funding_rate::initialize(arg18, arg17);
        assert!(arg2 > 0, 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::error::maintenance_margin_must_be_greater_than_zero());
        assert!(arg2 <= arg1, 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::error::maintenance_margin_must_be_less_than_or_equal_to_imr());
        let v4 = Perpetual{
            id                 : v0,
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
            positions          : arg20,
            specialFee         : arg21,
            priceOracle        : 0,
            funding            : v3,
            priceIdentifierId  : arg22,
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
        0x2::transfer::share_object<Perpetual>(v4);
        v1
    }

    public entry fun set_max_oi_open(arg0: &0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: vector<u128>) {
        0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::evaluator::set_max_oi_open(0x2::object::uid_to_inner(&arg1.id), &mut arg1.checks, 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::library::to_1x9_vec(arg2));
    }

    public entry fun set_max_price(arg0: &0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: u128) {
        0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::evaluator::set_max_price(0x2::object::uid_to_inner(&arg1.id), &mut arg1.checks, arg2 / 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::library::base_uint());
    }

    public entry fun set_max_qty_limit(arg0: &0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: u128) {
        0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::evaluator::set_max_qty_limit(0x2::object::uid_to_inner(&arg1.id), &mut arg1.checks, arg2 / 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::library::base_uint());
    }

    public entry fun set_max_qty_market(arg0: &0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: u128) {
        0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::evaluator::set_max_qty_market(0x2::object::uid_to_inner(&arg1.id), &mut arg1.checks, arg2 / 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::library::base_uint());
    }

    public entry fun set_min_price(arg0: &0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: u128) {
        0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::evaluator::set_min_price(0x2::object::uid_to_inner(&arg1.id), &mut arg1.checks, arg2 / 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::library::base_uint());
    }

    public entry fun set_min_qty(arg0: &0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: u128) {
        0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::evaluator::set_min_qty(0x2::object::uid_to_inner(&arg1.id), &mut arg1.checks, arg2 / 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::library::base_uint());
    }

    public entry fun set_mtb_long(arg0: &0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: u128) {
        0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::evaluator::set_mtb_long(0x2::object::uid_to_inner(&arg1.id), &mut arg1.checks, arg2 / 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::library::base_uint());
    }

    public entry fun set_mtb_short(arg0: &0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: u128) {
        0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::evaluator::set_mtb_short(0x2::object::uid_to_inner(&arg1.id), &mut arg1.checks, arg2 / 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::library::base_uint());
    }

    public entry fun set_step_size(arg0: &0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: u128) {
        0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::evaluator::set_step_size(0x2::object::uid_to_inner(&arg1.id), &mut arg1.checks, arg2 / 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::library::base_uint());
    }

    public entry fun set_tick_size(arg0: &0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: u128) {
        0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::evaluator::set_tick_size(0x2::object::uid_to_inner(&arg1.id), &mut arg1.checks, arg2 / 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::library::base_uint());
    }

    public entry fun set_funding_rate(arg0: &0x2::clock::Clock, arg1: &0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::roles::CapabilitiesSafe, arg2: &0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::roles::FundingRateCap, arg3: &mut Perpetual, arg4: u128, arg5: bool, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        update_oracle_price(arg3, arg6);
        update_global_index(arg0, arg3);
        0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::funding_rate::set_funding_rate(arg1, arg2, &mut arg3.funding, arg4 / 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::library::base_uint(), arg5, 0x2::clock::timestamp_ms(arg0), 0x2::object::uid_to_inner(&arg3.id));
    }

    public entry fun set_max_allowed_funding_rate(arg0: &0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: u128) {
        0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::funding_rate::set_max_allowed_funding_rate(&mut arg1.funding, arg2 / 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::library::base_uint(), 0x2::object::uid_to_inner(id(arg1)));
    }

    public fun checks(arg0: &Perpetual) : 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::evaluator::TradeChecks {
        arg0.checks
    }

    public entry fun delist_perpetual(arg0: &0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: u128) {
        let v0 = arg2 / 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::library::base_uint();
        assert!(!arg1.delisted, 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::error::perpetual_has_been_already_de_listed());
        0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::evaluator::verify_price_checks(arg1.checks, v0);
        arg1.delisted = true;
        arg1.delistingPrice = v0;
        let v1 = DelistEvent{
            id             : 0x2::object::uid_to_inner(id(arg1)),
            delistingPrice : v0,
        };
        0x2::event::emit<DelistEvent>(v1);
    }

    public fun delisted(arg0: &Perpetual) : bool {
        arg0.delisted
    }

    public fun delistingPrice(arg0: &Perpetual) : u128 {
        arg0.delistingPrice
    }

    public fun feePool(arg0: &Perpetual) : address {
        arg0.feePool
    }

    public fun fundingRate(arg0: &Perpetual) : 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::funding_rate::FundingRate {
        arg0.funding
    }

    public fun get_fee(arg0: address, arg1: &Perpetual, arg2: bool) : u128 {
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

    public fun globalIndex(arg0: &Perpetual) : 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::funding_rate::FundingIndex {
        0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::funding_rate::index(arg0.funding)
    }

    public fun id(arg0: &Perpetual) : &0x2::object::UID {
        &arg0.id
    }

    public fun imr(arg0: &Perpetual) : u128 {
        arg0.imr
    }

    public fun insurancePool(arg0: &Perpetual) : address {
        arg0.insurancePool
    }

    public fun is_trading_permitted(arg0: &mut Perpetual) : bool {
        arg0.isTradingPermitted
    }

    public fun makerFee(arg0: &Perpetual) : u128 {
        arg0.makerFee
    }

    public fun mmr(arg0: &Perpetual) : u128 {
        arg0.mmr
    }

    public fun name(arg0: &Perpetual) : &0x1::string::String {
        &arg0.name
    }

    public fun poolPercentage(arg0: &Perpetual) : u128 {
        arg0.insurancePoolRatio
    }

    public(friend) fun positions(arg0: &mut Perpetual) : &mut 0x2::table::Table<address, 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::position::UserPosition> {
        &mut arg0.positions
    }

    public fun priceIdenfitier(arg0: &Perpetual) : vector<u8> {
        arg0.priceIdentifierId
    }

    public fun priceOracle(arg0: &Perpetual) : u128 {
        arg0.priceOracle
    }

    public entry fun set_fee_pool_address(arg0: &0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: address) {
        assert!(arg2 != @0x0, 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::error::address_cannot_be_zero());
        arg1.feePool = arg2;
        let v0 = FeePoolAccountUpdateEvent{
            id      : 0x2::object::uid_to_inner(id(arg1)),
            account : arg2,
        };
        0x2::event::emit<FeePoolAccountUpdateEvent>(v0);
    }

    public entry fun set_initial_margin_required(arg0: &0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: u128) {
        let v0 = arg2 / 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::library::base_uint();
        assert!(v0 >= arg1.mmr, 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::error::initial_margin_must_be_greater_than_or_equal_to_mmr());
        arg1.imr = v0;
        let v1 = IMRUpdateEvent{
            id  : 0x2::object::uid_to_inner(id(arg1)),
            imr : v0,
        };
        0x2::event::emit<IMRUpdateEvent>(v1);
    }

    public entry fun set_insurance_pool_address(arg0: &0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: address) {
        assert!(arg2 != @0x0, 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::error::address_cannot_be_zero());
        arg1.insurancePool = arg2;
        let v0 = InsurancePoolAccountUpdateEvent{
            id      : 0x2::object::uid_to_inner(id(arg1)),
            account : arg2,
        };
        0x2::event::emit<InsurancePoolAccountUpdateEvent>(v0);
    }

    public entry fun set_insurance_pool_percentage(arg0: &0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: u128) {
        let v0 = arg2 / 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::library::base_uint();
        assert!(v0 <= 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::library::base_uint(), 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::error::can_not_be_greater_than_hundred_percent());
        arg1.insurancePoolRatio = v0;
        let v1 = InsurancePoolRatioUpdateEvent{
            id    : 0x2::object::uid_to_inner(id(arg1)),
            ratio : v0,
        };
        0x2::event::emit<InsurancePoolRatioUpdateEvent>(v1);
    }

    public entry fun set_maintenance_margin_required(arg0: &0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: u128) {
        let v0 = arg2 / 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::library::base_uint();
        assert!(v0 > 0, 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::error::maintenance_margin_must_be_greater_than_zero());
        assert!(v0 <= arg1.imr, 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::error::maintenance_margin_must_be_less_than_or_equal_to_imr());
        arg1.mmr = v0;
        let v1 = MMRUpdateEvent{
            id  : 0x2::object::uid_to_inner(id(arg1)),
            mmr : v0,
        };
        0x2::event::emit<MMRUpdateEvent>(v1);
    }

    public entry fun set_special_fee(arg0: &0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::roles::ExchangeAdminCap, arg1: &mut Perpetual, arg2: address, arg3: bool, arg4: u128, arg5: u128) {
        let v0 = SpecialFee{
            status   : arg3,
            makerFee : arg4,
            takerFee : arg5,
        };
        if (0x2::table::contains<address, SpecialFee>(&arg1.specialFee, arg2)) {
            *0x2::table::borrow_mut<address, SpecialFee>(&mut arg1.specialFee, arg2) = v0;
        } else {
            0x2::table::add<address, SpecialFee>(&mut arg1.specialFee, arg2, v0);
        };
        let v1 = SpecialFeeEvent{
            perp     : 0x2::object::uid_to_inner(id(arg1)),
            account  : arg2,
            status   : arg3,
            makerFee : arg4,
            takerFee : arg5,
        };
        0x2::event::emit<SpecialFeeEvent>(v1);
    }

    public entry fun set_trading_permit(arg0: &0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::roles::CapabilitiesSafe, arg1: &0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::roles::ExchangeGuardianCap, arg2: &mut Perpetual, arg3: bool) {
        0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::roles::check_guardian_validity(arg0, arg1);
        arg2.isTradingPermitted = arg3;
        let v0 = TradingPermissionStatusUpdate{status: arg3};
        0x2::event::emit<TradingPermissionStatusUpdate>(v0);
    }

    public fun startTime(arg0: &Perpetual) : u64 {
        arg0.startTime
    }

    public fun takerFee(arg0: &Perpetual) : u128 {
        arg0.takerFee
    }

    fun update_global_index(arg0: &0x2::clock::Clock, arg1: &mut Perpetual) {
        0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::funding_rate::set_global_index(&mut arg1.funding, 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::funding_rate::compute_new_global_index(arg0, arg1.funding, priceOracle(arg1)), 0x2::object::uid_to_inner(&arg1.id));
    }

    public(friend) fun update_oracle_price(arg0: &mut Perpetual, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        assert!(0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::library::get_price_identifier(arg1) == priceIdenfitier(arg0), 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::error::wrong_price_identifier());
        arg0.priceOracle = 0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::library::base_div(0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::library::get_oracle_price(arg1), (0x2::math::pow(10, (0xd73f8b766f9d0766f34782156e1c96ae4ed5953bf7905e0a16992c147379a443::library::get_oracle_base(arg1) as u8)) as u128));
    }

    // decompiled from Move bytecode v6
}

