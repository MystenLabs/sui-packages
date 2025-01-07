module 0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::range {
    struct Range has copy, drop, store {
        vec: vector<u8>,
    }

    public fun from(arg0: &Range) : u8 {
        *0x1::vector::borrow<u8>(&arg0.vec, 0)
    }

    public fun is_in_range(arg0: &Range, arg1: u8) : bool {
        arg1 >= from(arg0) && arg1 <= to(arg0)
    }

    public fun new(arg0: u8, arg1: u8) : Range {
        assert!(arg1 >= arg0, 0);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, arg0);
        0x1::vector::push_back<u8>(v1, arg1);
        Range{vec: v0}
    }

    public fun to(arg0: &Range) : u8 {
        *0x1::vector::borrow<u8>(&arg0.vec, 1)
    }

    // decompiled from Move bytecode v6
}

