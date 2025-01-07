module 0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::data {
    struct Data has store {
        coupons: 0x2::bag::Bag,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Data {
        Data{coupons: 0x2::bag::new(arg0)}
    }

    public(friend) fun coupons(arg0: &Data) : &0x2::bag::Bag {
        &arg0.coupons
    }

    public(friend) fun coupons_mut(arg0: &mut Data) : &mut 0x2::bag::Bag {
        &mut arg0.coupons
    }

    public(friend) fun remove_coupon(arg0: &mut Data, arg1: 0x1::string::String) {
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.coupons, arg1), 2);
        0x2::bag::remove<0x1::string::String, 0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::coupon::Coupon>(&mut arg0.coupons, arg1);
    }

    public(friend) fun save_coupon(arg0: &mut Data, arg1: 0x1::string::String, arg2: 0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::coupon::Coupon) {
        assert!(!0x2::bag::contains<0x1::string::String>(&arg0.coupons, arg1), 1);
        0x2::bag::add<0x1::string::String, 0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::coupon::Coupon>(&mut arg0.coupons, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

