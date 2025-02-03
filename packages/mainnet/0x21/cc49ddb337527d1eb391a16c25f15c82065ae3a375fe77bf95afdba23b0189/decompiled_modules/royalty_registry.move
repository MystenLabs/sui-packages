module 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::royalty_registry {
    struct RoyaltyStrategy has drop, store {
        fee_bips: u64,
        beneficiary: address,
    }

    struct RoyaltyRegistry has store, key {
        id: 0x2::object::UID,
        strategies: 0x2::table::Table<0x1::ascii::String, RoyaltyStrategy>,
    }

    public fun beneficiary<T0: store + key>(arg0: &RoyaltyRegistry) : address {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (!0x2::table::contains<0x1::ascii::String, RoyaltyStrategy>(&arg0.strategies, v0)) {
            abort 2
        };
        0x2::table::borrow<0x1::ascii::String, RoyaltyStrategy>(&arg0.strategies, v0).beneficiary
    }

    public fun calculate<T0: store + key>(arg0: &RoyaltyRegistry, arg1: u64) : u64 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (!0x2::table::contains<0x1::ascii::String, RoyaltyStrategy>(&arg0.strategies, v0)) {
            0
        } else {
            compute(0x2::table::borrow<0x1::ascii::String, RoyaltyStrategy>(&arg0.strategies, v0).fee_bips, arg1)
        }
    }

    public fun compute(arg0: u64, arg1: u64) : u64 {
        let (_, v1) = 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::math::div_round(arg0, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::constants::bps());
        let (_, v3) = 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::math::mul_round(arg1, v1);
        v3
    }

    public fun fee_bips<T0: store + key>(arg0: &RoyaltyRegistry) : u64 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (!0x2::table::contains<0x1::ascii::String, RoyaltyStrategy>(&arg0.strategies, v0)) {
            abort 2
        };
        0x2::table::borrow<0x1::ascii::String, RoyaltyStrategy>(&arg0.strategies, v0).fee_bips
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RoyaltyRegistry{
            id         : 0x2::object::new(arg0),
            strategies : 0x2::table::new<0x1::ascii::String, RoyaltyStrategy>(arg0),
        };
        0x2::transfer::public_share_object<RoyaltyRegistry>(v0);
    }

    public entry fun register_strategy<T0: store + key>(arg0: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::admin_cap::AdminCap, arg1: &mut RoyaltyRegistry, arg2: u64, arg3: address) {
        if (arg2 >= 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::constants::bps()) {
            abort 0
        };
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (0x2::table::contains<0x1::ascii::String, RoyaltyStrategy>(&arg1.strategies, v0)) {
            abort 1
        };
        let v1 = RoyaltyStrategy{
            fee_bips    : arg2,
            beneficiary : arg3,
        };
        0x2::table::add<0x1::ascii::String, RoyaltyStrategy>(&mut arg1.strategies, v0, v1);
    }

    public entry fun set_royalty_beneficiary<T0: store + key>(arg0: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::admin_cap::AdminCap, arg1: &mut RoyaltyRegistry, arg2: address) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (!0x2::table::contains<0x1::ascii::String, RoyaltyStrategy>(&arg1.strategies, v0)) {
            abort 2
        };
        0x2::table::borrow_mut<0x1::ascii::String, RoyaltyStrategy>(&mut arg1.strategies, v0).beneficiary = arg2;
    }

    public entry fun set_royalty_fee_bips<T0: store + key>(arg0: &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::admin_cap::AdminCap, arg1: &mut RoyaltyRegistry, arg2: u64) {
        if (arg2 >= 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::constants::bps()) {
            abort 0
        };
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (!0x2::table::contains<0x1::ascii::String, RoyaltyStrategy>(&arg1.strategies, v0)) {
            abort 2
        };
        0x2::table::borrow_mut<0x1::ascii::String, RoyaltyStrategy>(&mut arg1.strategies, v0).fee_bips = arg2;
    }

    // decompiled from Move bytecode v6
}

