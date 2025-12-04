module 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_fee {
    fun cap_fee_rate(arg0: u64) : u64 {
        if (arg0 >= 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_constants::max_fee()) {
            return 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_constants::max_fee()
        };
        arg0
    }

    public fun get_composition_fee(arg0: u64, arg1: u64) : u64 {
        let v0 = cap_fee_rate(arg1);
        0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64((arg0 as u256) * (v0 as u256) * ((v0 as u256) + (100000000 as u256)) / 100000000 * 100000000)
    }

    public fun get_fee_amount_by_net_input(arg0: u64, arg1: u64) : u64 {
        let v0 = cap_fee_rate(arg1);
        let v1 = (((100000000 as u64) - v0) as u256);
        0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64(((arg0 as u256) * (v0 as u256) + v1 - 1) / v1)
    }

    public fun get_fee_amount_from(arg0: u64, arg1: u64) : u64 {
        0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64(((arg0 as u256) * (cap_fee_rate(arg1) as u256) + 100000000 - 1) / 100000000)
    }

    public fun get_protocol_fee_amount(arg0: u64, arg1: u16) : u64 {
        verify_protocol_share(arg1);
        0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64((arg0 as u256) * (arg1 as u256) / (0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_constants::basis_point_max() as u256))
    }

    public fun verify_fee(arg0: u64) {
        assert!(arg0 <= 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_constants::max_fee(), 13906834234472923137);
    }

    public fun verify_protocol_share(arg0: u16) {
        assert!(arg0 <= 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_constants::max_protocol_share(), 13906834251652923395);
    }

    // decompiled from Move bytecode v6
}

