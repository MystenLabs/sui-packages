module 0x541697a7d01707e61210afd1deb1c269ebe0dd65ae3e318fea4c9b1ad7dcc2a2::discount_coupon {
    struct DiscountCoupon has key {
        id: 0x2::object::UID,
        issuer: address,
        discount: u8,
        expiration: u64,
    }

    public entry fun transfer(arg0: DiscountCoupon, arg1: address) {
        assert!(&arg0.issuer == &arg1, 0);
        0x2::transfer::transfer<DiscountCoupon>(arg0, arg1);
    }

    public entry fun burn(arg0: DiscountCoupon) {
        let DiscountCoupon {
            id         : v0,
            issuer     : _,
            discount   : _,
            expiration : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun issuer(arg0: &DiscountCoupon) : address {
        arg0.issuer
    }

    public entry fun mint_and_topup(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0 && arg1 <= 100, 1);
        let v0 = DiscountCoupon{
            id         : 0x2::object::new(arg4),
            issuer     : 0x2::tx_context::sender(arg4),
            discount   : arg1,
            expiration : arg2,
        };
        0x2::transfer::transfer<DiscountCoupon>(v0, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg3);
    }

    // decompiled from Move bytecode v6
}

