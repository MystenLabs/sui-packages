module 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::flat_fee {
    struct FlatFee has store, key {
        id: 0x2::object::UID,
        rate_bps: u64,
    }

    public fun new(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : FlatFee {
        FlatFee{
            id       : 0x2::object::new(arg1),
            rate_bps : arg0,
        }
    }

    fun calc_fee(arg0: u64, arg1: u64) : u64 {
        let (_, v1) = 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::math::div_round(arg1, (0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::bps() as u64));
        let (_, v3) = 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::math::mul_round(v1, arg0);
        v3
    }

    public entry fun collect_proceeds_and_fees<T0>(arg0: &0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::Marketplace, arg1: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg2: &mut 0x2::tx_context::TxContext) {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::assert_listing_marketplace_match(arg0, arg1);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::assert_correct_admin_or_member(arg0, arg1, arg2);
        let v0 = 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::proceeds::balance<T0>(0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::borrow_proceeds(arg1));
        let v1 = if (0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::contains_custom_fee(arg1)) {
            0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::custom_fee(arg1)
        } else {
            0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::default_fee(arg0)
        };
        assert!(0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::object_box::has_object<FlatFee>(v1), 1);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::proceeds::collect_with_fees<T0>(0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::borrow_proceeds_mut(arg1), calc_fee(0x2::balance::value<T0>(v0), 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::object_box::borrow<FlatFee>(v1).rate_bps), 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::marketplace::receiver(arg0), 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::receiver(arg1), arg2);
    }

    public entry fun init_fee(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = new(arg0, arg1);
        0x2::transfer::public_transfer<FlatFee>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

