module 0x205976d41ed12d0156ad3e331f4b5d7321c755df2f2a805930e61e9aa1e77c7f::utils {
    struct WhitelistUserTier has drop {
        user: address,
        tier: u8,
    }

    public fun calculate_fair_launch_fee(arg0: u64, arg1: u64, arg2: u8, arg3: u8) : (u64, u64) {
        (arg0 * (arg2 as u64) / 100, arg1 * (arg3 as u64) / 100)
    }

    public fun calculate_fair_launch_finalized_figures(arg0: u64, arg1: u64, arg2: u64, arg3: u8, arg4: u8, arg5: u8, arg6: u8) : (u64, u64, u64, u64) {
        let (v0, v1) = calculate_fair_launch_fee(arg0, arg1, arg4, arg5);
        let v2 = 0x205976d41ed12d0156ad3e331f4b5d7321c755df2f2a805930e61e9aa1e77c7f::math_safe_precise::mul_div(arg0 - v0, (arg3 as u64), 100);
        (v0, v1, v2, 0x205976d41ed12d0156ad3e331f4b5d7321c755df2f2a805930e61e9aa1e77c7f::math_safe_precise::mul_div(v2, arg2, 0x1::u64::pow(10, arg6)))
    }

    public fun calculate_fee(arg0: u8, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64) {
        (arg1 * arg3 / 100, 0x205976d41ed12d0156ad3e331f4b5d7321c755df2f2a805930e61e9aa1e77c7f::math_safe_precise::mul_div(arg1, arg2, 0x1::u64::pow(10, arg0)) * arg4 / 100)
    }

    public fun calculate_listing_fair_launch_total_tokens(arg0: u64, arg1: u8, arg2: u8, arg3: u8) : u64 {
        0x205976d41ed12d0156ad3e331f4b5d7321c755df2f2a805930e61e9aa1e77c7f::math_safe_precise::mul_div(arg0, (arg3 as u64), 100) + 0x205976d41ed12d0156ad3e331f4b5d7321c755df2f2a805930e61e9aa1e77c7f::math_safe_precise::mul_div(arg0 - 0x205976d41ed12d0156ad3e331f4b5d7321c755df2f2a805930e61e9aa1e77c7f::math_safe_precise::mul_div(arg0, (arg2 as u64), 100), (arg1 as u64), 100) + arg0
    }

    public fun calculate_listing_presale_total_tokens(arg0: u64, arg1: u64, arg2: u64, arg3: u8, arg4: u8, arg5: u8, arg6: u8) : u64 {
        let (v0, v1) = calculate_fee(arg6, arg0, arg1, (arg4 as u64), (arg5 as u64));
        let (v2, v3) = calculate_presale_and_listing_tokens(arg0, arg1, arg2, arg3, arg6, v0);
        v2 + v3 + v1
    }

    public fun calculate_manual_list_fair_launch_total_tokens(arg0: u64, arg1: u8) : u64 {
        0x205976d41ed12d0156ad3e331f4b5d7321c755df2f2a805930e61e9aa1e77c7f::math_safe_precise::mul_div(arg0, (arg1 as u64), 100) + arg0
    }

    public fun calculate_manual_list_presale_total_tokens(arg0: u64, arg1: u64, arg2: u8, arg3: u8, arg4: u8) : u64 {
        let (_, v1) = calculate_fee(arg4, arg0, arg1, (arg2 as u64), (arg3 as u64));
        v1 + convert_currency_to_token(arg4, arg0, arg1)
    }

    public fun calculate_presale_and_listing_tokens(arg0: u64, arg1: u64, arg2: u64, arg3: u8, arg4: u8, arg5: u64) : (u64, u64) {
        let v0 = 0x1::u64::pow(10, arg4);
        (0x205976d41ed12d0156ad3e331f4b5d7321c755df2f2a805930e61e9aa1e77c7f::math_safe_precise::mul_div(arg0, arg1, v0), 0x205976d41ed12d0156ad3e331f4b5d7321c755df2f2a805930e61e9aa1e77c7f::math_safe_precise::mul_div(0x205976d41ed12d0156ad3e331f4b5d7321c755df2f2a805930e61e9aa1e77c7f::math_safe_precise::mul_div(arg0 - arg5, arg2, v0), (arg3 as u64), 100))
    }

    public fun calculate_presale_finalized_figures(arg0: u64, arg1: u64, arg2: u64, arg3: u8, arg4: u8, arg5: u8, arg6: u8) : (u64, u64, u64, u64) {
        let (v0, v1) = calculate_fee(arg6, arg0, arg1, (arg4 as u64), (arg5 as u64));
        let v2 = 0x205976d41ed12d0156ad3e331f4b5d7321c755df2f2a805930e61e9aa1e77c7f::math_safe_precise::mul_div(arg0 - v0, (arg3 as u64), 100);
        (v0, v1, v2, 0x205976d41ed12d0156ad3e331f4b5d7321c755df2f2a805930e61e9aa1e77c7f::math_safe_precise::mul_div(v2, arg2, 0x1::u64::pow(10, arg6)))
    }

    public fun convert_currency_to_token(arg0: u8, arg1: u64, arg2: u64) : u64 {
        0x205976d41ed12d0156ad3e331f4b5d7321c755df2f2a805930e61e9aa1e77c7f::math_safe_precise::mul_div(arg1, arg2, 0x1::u64::pow(10, arg0))
    }

    public fun get_epoch_timestamp(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun parse_unit(arg0: u64, arg1: u8) : u64 {
        (((arg0 as u128) * (0x1::u64::pow(10, arg1) as u128)) as u64)
    }

    public fun verify_proof(arg0: vector<u8>, arg1: address, arg2: u8, arg3: &vector<vector<u8>>) : bool {
        let v0 = WhitelistUserTier{
            user : arg1,
            tier : arg2,
        };
        let v1 = 0x2::bcs::to_bytes<WhitelistUserTier>(&v0);
        0x205976d41ed12d0156ad3e331f4b5d7321c755df2f2a805930e61e9aa1e77c7f::merkle_proof::verify(arg3, arg0, 0x2::hash::keccak256(&v1))
    }

    // decompiled from Move bytecode v6
}

