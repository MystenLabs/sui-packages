module 0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::swap_math {
    public fun get_amount_out(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = (arg0 as u128) * ((10000 - arg4) as u128) / 10000;
        (0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::full_math::mul_div((arg1 as u128), v0, (arg2 as u128) + (arg3 as u128) + v0) as u64)
    }

    public fun get_sui_out(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = (arg0 as u128) * ((10000 - arg4) as u128) / 10000;
        (0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::full_math::min(0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::full_math::mul_div((arg2 as u128) + (arg3 as u128), v0, (arg1 as u128) + v0), (arg2 as u128)) as u64)
    }

    public fun implied_mcap_sui(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        (0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::full_math::mul_div((arg0 as u128), (spot_price_mist(arg1, arg2, arg3) as u128), 1000000000) as u64)
    }

    public fun spot_price_mist(arg0: u64, arg1: u64, arg2: u64) : u64 {
        ((((arg1 as u128) + (arg2 as u128)) / (arg0 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

