module 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::hot_potato_vector {
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

    // decompiled from Move bytecode v6
}

