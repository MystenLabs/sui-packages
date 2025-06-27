module 0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_fee {
    public fun get_composition_fee(arg0: u64, arg1: u64) : u64 {
        verify_fee(arg1);
        0xf2565732e0fe45f224e3f0d17914960ac0e36d2470dceb5d09e77d72473ebbdc::uint_safe::safe64((arg0 as u256) * (arg1 as u256) * ((arg1 as u256) + (0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_constants::precision() as u256)) / (0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_constants::squared_precision() as u256))
    }

    public fun get_fee_amount(arg0: u64, arg1: u64) : u64 {
        verify_fee(arg1);
        let v0 = (((0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_constants::precision() as u64) - arg1) as u256);
        0xf2565732e0fe45f224e3f0d17914960ac0e36d2470dceb5d09e77d72473ebbdc::uint_safe::safe64(((arg0 as u256) * (arg1 as u256) + v0 - 1) / v0)
    }

    public fun get_fee_amount_from(arg0: u64, arg1: u64) : u64 {
        verify_fee(arg1);
        0xf2565732e0fe45f224e3f0d17914960ac0e36d2470dceb5d09e77d72473ebbdc::uint_safe::safe64(((arg0 as u256) * (arg1 as u256) + (0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_constants::precision() as u256) - 1) / (0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_constants::precision() as u256))
    }

    public fun get_protocol_fee_amount(arg0: u64, arg1: u16) : u64 {
        verify_protocol_share(arg1);
        0xf2565732e0fe45f224e3f0d17914960ac0e36d2470dceb5d09e77d72473ebbdc::uint_safe::safe64((arg0 as u256) * (arg1 as u256) / (0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_constants::basis_point_max() as u256))
    }

    public fun verify_fee(arg0: u64) {
        assert!(arg0 <= 0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_constants::max_fee(), 13906834225882988545);
    }

    public fun verify_protocol_share(arg0: u16) {
        assert!(arg0 <= 0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_constants::max_protocol_share(), 13906834243062988803);
    }

    // decompiled from Move bytecode v6
}

