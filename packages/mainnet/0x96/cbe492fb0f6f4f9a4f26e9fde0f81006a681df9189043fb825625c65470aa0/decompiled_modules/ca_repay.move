module 0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::ca_repay {
    public fun repay<T0: store>(arg0: &mut 0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::market::Market, arg1: &mut 0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::credit_account::CreditAccount, arg2: &0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::credit_account::OwnerKey, arg3: &0x2::clock::Clock, arg4: u64) {
        0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::credit_account::assert_owner(arg1, arg2);
        assert!(0x1::type_name::get<T0>() == 0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::credit_account::denom(arg1), 0);
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::market::accrue_interest<T0>(arg0, v0);
        0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::credit_account::accrue_interest(arg1, 0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::market::get_coin_interest_config<T0>(arg0));
        let v1 = 0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::credit_account::pop_asset<0x2::balance::Balance<T0>>(arg1);
        0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::credit_account::add_asset<0x2::balance::Balance<T0>>(v1, arg1);
        0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::market::handle_repay<T0>(arg0, 0x2::balance::split<T0>(&mut v1, arg4), v0);
        0x96cbe492fb0f6f4f9a4f26e9fde0f81006a681df9189043fb825625c65470aa0::credit_account::decrease_debt(arg1, arg4);
    }

    // decompiled from Move bytecode v6
}

