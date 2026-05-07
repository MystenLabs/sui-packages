module 0x15f27ec5e794de13e04f9855da007d79dbde91afb121048af1f091b88f2f823d::hot_potato_vector {
    struct HotPotatoVector<T0: copy + drop> {
        contents: vector<T0>,
    }

    public fun length<T0: copy + drop>(arg0: &HotPotatoVector<T0>) : u64 {
        0x1::vector::length<T0>(&arg0.contents)
    }

    public(friend) fun borrow<T0: copy + drop>(arg0: &HotPotatoVector<T0>, arg1: u64) : &T0 {
        0x1::vector::borrow<T0>(&arg0.contents, arg1)
    }

    public(friend) fun pop_back<T0: copy + drop>(arg0: HotPotatoVector<T0>) : (T0, HotPotatoVector<T0>) {
        (0x1::vector::pop_back<T0>(&mut arg0.contents), arg0)
    }

    public fun is_empty<T0: copy + drop>(arg0: &HotPotatoVector<T0>) : bool {
        0x1::vector::is_empty<T0>(&arg0.contents)
    }

    public fun destroy<T0: copy + drop>(arg0: HotPotatoVector<T0>) {
        let HotPotatoVector {  } = arg0;
    }

    public(friend) fun new<T0: copy + drop>(arg0: vector<T0>) : HotPotatoVector<T0> {
        HotPotatoVector<T0>{contents: arg0}
    }

    // decompiled from Move bytecode v7
}

