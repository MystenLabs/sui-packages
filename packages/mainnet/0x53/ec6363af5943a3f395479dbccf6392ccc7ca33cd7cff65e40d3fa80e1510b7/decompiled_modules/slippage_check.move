module 0x53ec6363af5943a3f395479dbccf6392ccc7ca33cd7cff65e40d3fa80e1510b7::slippage_check {
    public fun assert_slippage<T0, T1>(arg0: &mut 0xe49323d005251105ffa695af79c3e840aca49e5453413d123dd196c30963bcca::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        if (arg2) {
            assert!(arg1 < 0xe49323d005251105ffa695af79c3e840aca49e5453413d123dd196c30963bcca::pool::sqrt_price<T0, T1>(arg0), 111);
        } else {
            assert!(arg1 > 0xe49323d005251105ffa695af79c3e840aca49e5453413d123dd196c30963bcca::pool::sqrt_price<T0, T1>(arg0), 111);
        };
    }

    // decompiled from Move bytecode v6
}

