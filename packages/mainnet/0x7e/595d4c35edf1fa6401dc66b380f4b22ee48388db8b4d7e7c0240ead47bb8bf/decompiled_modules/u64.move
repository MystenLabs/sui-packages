module 0x7e595d4c35edf1fa6401dc66b380f4b22ee48388db8b4d7e7c0240ead47bb8bf::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x7e595d4c35edf1fa6401dc66b380f4b22ee48388db8b4d7e7c0240ead47bb8bf::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

