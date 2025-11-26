module 0x66e681a9e83d9a3b57ecddd0b7f37594e85a888bba01cfa60de14f46be6a8abb::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x66e681a9e83d9a3b57ecddd0b7f37594e85a888bba01cfa60de14f46be6a8abb::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

