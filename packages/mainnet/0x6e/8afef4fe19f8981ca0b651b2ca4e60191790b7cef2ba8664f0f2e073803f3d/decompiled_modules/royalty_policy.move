module 0x6e8afef4fe19f8981ca0b651b2ca4e60191790b7cef2ba8664f0f2e073803f3d::royalty_policy {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        amount_bp: u16,
        beneficiary: address,
    }

    public fun calculate(arg0: u16, arg1: u64) : u64 {
        (((arg1 as u128) * (arg0 as u128) / 10000) as u64)
    }

    public fun get_rules<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>) : (u16, address) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0);
        (v1.amount_bp, v1.beneficiary)
    }

    public fun new_royalty_policy<T0>(arg0: &0x2::package::Publisher, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<T0>(arg0, arg2);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        set<T0>(v4, &v2, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<T0>>(v3);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<T0>>(v2, 0x2::tx_context::sender(arg2));
    }

    public fun pay<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0);
        let v2 = calculate(v1.amount_bp, 0x2::transfer_policy::paid<T0>(arg1));
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v2, 1);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v2, arg3), v1.beneficiary);
        };
        let v3 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v3, arg1);
    }

    public fun set<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: u16) {
        assert!(arg2 < 10000, 0);
        let v0 = Rule{dummy_field: false};
        let v1 = Config{
            amount_bp   : arg2,
            beneficiary : @0x2c5476da42075b81416c8587d872e5952df2c784a0b1d9fd879abdb3881cac78,
        };
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    public entry fun update_royalty_bp<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: u16) {
        0x2::transfer_policy::remove_rule<T0, Rule, Config>(arg0, arg1);
        set<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

