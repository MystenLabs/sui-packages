module 0xdf6726614a0b41f130ad63456565f26302d369f69051d5d4d019eac3f11bd631::royalty_rule {
    struct RoyaltyRule<phantom T0> has drop {
        dummy_field: bool,
    }

    struct RoyaltyConfig<phantom T0> has drop, store {
        recipient: address,
        basis_points: u16,
    }

    public fun add_to_policy<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: RoyaltyConfig<T0>) {
        let v0 = RoyaltyRule<T0>{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, RoyaltyRule<T0>, RoyaltyConfig<T0>>(v0, arg0, arg1, arg2);
    }

    public entry fun add_to_policy_entry<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: address, arg3: u16) {
        add_to_policy<T0>(arg0, arg1, new_config<T0>(arg2, arg3));
    }

    public fun basis_points<T0>(arg0: &RoyaltyConfig<T0>) : u16 {
        arg0.basis_points
    }

    public fun new_config<T0>(arg0: address, arg1: u16) : RoyaltyConfig<T0> {
        RoyaltyConfig<T0>{
            recipient    : arg0,
            basis_points : arg1,
        }
    }

    public fun recipient<T0>(arg0: &RoyaltyConfig<T0>) : address {
        arg0.recipient
    }

    // decompiled from Move bytecode v6
}

