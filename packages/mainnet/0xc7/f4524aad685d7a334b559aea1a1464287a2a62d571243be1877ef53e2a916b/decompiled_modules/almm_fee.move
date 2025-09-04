module 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_fee {
    public fun get_composition_fee(arg0: u64, arg1: u64) : u64 {
        verify_fee(arg1);
        0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64((arg0 as u256) * (arg1 as u256) * ((arg1 as u256) + (0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::precision() as u256)) / (0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::squared_precision() as u256))
    }

    public fun get_fee_amount_by_net_input(arg0: u64, arg1: u64) : u64 {
        verify_fee(arg1);
        let v0 = (((0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::precision() as u64) - arg1) as u256);
        0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64(((arg0 as u256) * (arg1 as u256) + v0 - 1) / v0)
    }

    public fun get_fee_amount_from(arg0: u64, arg1: u64) : u64 {
        verify_fee(arg1);
        0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64(((arg0 as u256) * (arg1 as u256) + (0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::precision() as u256) - 1) / (0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::precision() as u256))
    }

    public fun get_protocol_fee_amount(arg0: u64, arg1: u16) : u64 {
        verify_protocol_share(arg1);
        0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe64((arg0 as u256) * (arg1 as u256) / (0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::basis_point_max() as u256))
    }

    public fun verify_fee(arg0: u64) {
        assert!(arg0 <= 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::max_fee(), 13906834225882988545);
    }

    public fun verify_protocol_share(arg0: u16) {
        assert!(arg0 <= 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::max_protocol_share(), 13906834243062988803);
    }

    // decompiled from Move bytecode v6
}

