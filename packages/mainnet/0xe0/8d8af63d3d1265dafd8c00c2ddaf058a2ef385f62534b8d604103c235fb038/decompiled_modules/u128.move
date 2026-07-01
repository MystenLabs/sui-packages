module 0xe08d8af63d3d1265dafd8c00c2ddaf058a2ef385f62534b8d604103c235fb038::u128 {
    public fun safe_from_u256(arg0: u256) : u128 {
        assert!(arg0 <= 340282366920938463463374607431768211455, 1);
        (arg0 as u128)
    }

    // decompiled from Move bytecode v7
}

