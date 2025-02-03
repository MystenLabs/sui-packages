module 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::promise {
    struct Promise<T0> {
        value: T0,
    }

    public(friend) fun await<T0: drop>(arg0: T0) : Promise<T0> {
        Promise<T0>{value: arg0}
    }

    public(friend) fun resolve<T0: drop>(arg0: Promise<T0>, arg1: T0) {
        let Promise { value: v0 } = arg0;
        assert!(v0 == arg1, 1);
    }

    public fun value<T0: drop>(arg0: &Promise<T0>) : &T0 {
        &arg0.value
    }

    // decompiled from Move bytecode v6
}

