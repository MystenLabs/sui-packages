module 0xf1f85598c7f7af12ccaff5ad1dafa065867c37f8dba7eadd190e42bf1123bf2f::u128 {
    public fun safe_from_u256(arg0: u256) : u128 {
        assert!(arg0 <= 340282366920938463463374607431768211455, 1);
        (arg0 as u128)
    }

    // decompiled from Move bytecode v7
}

