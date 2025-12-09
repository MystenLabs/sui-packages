module 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::publisher_wrapper {
    struct PublisherWrapper<phantom T0: drop> {
        package_address: address,
    }

    public fun create<T0: drop>(arg0: &0x2::package::Publisher, arg1: T0) : PublisherWrapper<T0> {
        assert!(0x2::package::from_module<T0>(arg0), 1);
        PublisherWrapper<T0>{package_address: 0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(0x2::package::published_package(arg0)))}
    }

    public(friend) fun get_package_address<T0: drop>(arg0: PublisherWrapper<T0>) : address {
        let PublisherWrapper { package_address: v0 } = arg0;
        v0
    }

    // decompiled from Move bytecode v6
}

