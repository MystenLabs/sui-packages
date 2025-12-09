module 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::publisher_wrapper {
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

