module 0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::price_oracle {
    struct OraclePriceUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        price: u128,
        updatedAt: u64,
    }

    struct MaxAllowedPriceDiffUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        maxAllowedPriceDifference: u128,
    }

    struct PriceOracle has copy, drop, store {
        price: u128,
        updatedAt: u64,
        maxAllowedPriceDifference: u128,
    }

    public(friend) fun initialize(arg0: 0x2::object::ID, arg1: u128) : PriceOracle {
        let v0 = PriceOracle{
            price                     : 0,
            updatedAt                 : 0,
            maxAllowedPriceDifference : arg1,
        };
        let v1 = OraclePriceUpdateEvent{
            id        : arg0,
            price     : 0,
            updatedAt : 0,
        };
        0x2::event::emit<OraclePriceUpdateEvent>(v1);
        let v2 = MaxAllowedPriceDiffUpdateEvent{
            id                        : arg0,
            maxAllowedPriceDifference : arg1,
        };
        0x2::event::emit<MaxAllowedPriceDiffUpdateEvent>(v2);
        v0
    }

    public fun price(arg0: PriceOracle) : u128 {
        arg0.price
    }

    public(friend) fun set_oracle_price(arg0: &0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::roles::CapabilitiesSafe, arg1: &0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::roles::PriceOracleOperatorCap, arg2: &mut PriceOracle, arg3: 0x2::object::ID, arg4: u128, arg5: u64) {
        0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::roles::check_price_oracle_operator_validity(arg0, arg1);
        assert!(verify_oracle_price_update_diff(arg2.maxAllowedPriceDifference, arg4, arg2.price), 0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::error::out_of_max_allowed_price_diff_bounds());
        arg2.price = arg4;
        arg2.updatedAt = arg5;
        let v0 = OraclePriceUpdateEvent{
            id        : arg3,
            price     : arg4,
            updatedAt : arg5,
        };
        0x2::event::emit<OraclePriceUpdateEvent>(v0);
    }

    public(friend) fun set_oracle_price_max_allowed_diff(arg0: 0x2::object::ID, arg1: &mut PriceOracle, arg2: u128) {
        assert!(arg2 != 0, 0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::error::max_allowed_price_diff_cannot_be_zero());
        arg1.maxAllowedPriceDifference = arg2;
        let v0 = MaxAllowedPriceDiffUpdateEvent{
            id                        : arg0,
            maxAllowedPriceDifference : arg2,
        };
        0x2::event::emit<MaxAllowedPriceDiffUpdateEvent>(v0);
    }

    fun verify_oracle_price_update_diff(arg0: u128, arg1: u128, arg2: u128) : bool {
        if (arg2 == 0) {
            return true
        };
        let v0 = if (arg1 > arg2) {
            arg1 - arg2
        } else {
            arg2 - arg1
        };
        if (v0 * 0x6daf6e084de79fde6ff50856b0470c2003552570a92b35cffed3dbe82744ffe4::library::base_uint() / arg2 > arg0) {
            return false
        };
        true
    }

    // decompiled from Move bytecode v6
}

