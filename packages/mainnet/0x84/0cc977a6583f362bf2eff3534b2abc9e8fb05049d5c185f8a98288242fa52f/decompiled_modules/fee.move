module 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::fee {
    struct FeeConfig has store, key {
        id: 0x2::object::UID,
        fee_rate: 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::rate::Rate,
        fee_collector: address,
    }

    struct FeeCollected has copy, drop {
        collector: address,
        amount: u64,
        fee_rate: 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::rate::Rate,
    }

    struct FeeCollectedV2 has copy, drop {
        collector: address,
        fee_amount: u64,
        coin_amount: u64,
        fee_rate: 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::rate::Rate,
    }

    public(friend) fun delete_fee_config(arg0: FeeConfig) {
        let FeeConfig {
            id            : v0,
            fee_rate      : _,
            fee_collector : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun estimate_fee(arg0: &FeeConfig, arg1: u64) : u64 {
        0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::ceil_u64(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::mul_with_rate(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::from_raw((arg1 as u256)), get_fee_rate(arg0)))
    }

    public fun get_fee_collector(arg0: &FeeConfig) : address {
        arg0.fee_collector
    }

    public fun get_fee_rate(arg0: &FeeConfig) : 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::rate::Rate {
        arg0.fee_rate
    }

    public(friend) fun new_fee_config(arg0: 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::rate::Rate, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : FeeConfig {
        let v0 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::rate::one();
        let v1 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::rate::zero();
        assert!(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::rate::lt(&arg0, &v0), 1001);
        assert!(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::rate::gt(&arg0, &v1), 1001);
        assert!(arg1 != @0x0, 1002);
        FeeConfig{
            id            : 0x2::object::new(arg2),
            fee_rate      : arg0,
            fee_collector : arg1,
        }
    }

    public(friend) fun pay_fee<T0>(arg0: &FeeConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = get_fee_collector(arg0);
        assert!(v0 != @0x0, 1002);
        let v1 = 0x2::coin::value<T0>(arg1);
        let v2 = estimate_fee(arg0, v1);
        if (v2 > 0) {
            let v3 = 0x2::coin::split<T0>(arg1, v2, arg2);
            if (0x2::coin::value<T0>(&v3) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, v0);
            } else {
                0x2::coin::destroy_zero<T0>(v3);
            };
        };
        let v4 = FeeCollectedV2{
            collector   : v0,
            fee_amount  : v2,
            coin_amount : v1,
            fee_rate    : get_fee_rate(arg0),
        };
        0x2::event::emit<FeeCollectedV2>(v4);
    }

    // decompiled from Move bytecode v6
}

