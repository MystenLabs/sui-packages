module 0x3790fe6b835a02485b120221e0b84617b13cc3b6a56f0008069f7e12aa418d1f::access {
    struct StrategyLicense has store, key {
        id: 0x2::object::UID,
        namespace: vector<u8>,
    }

    struct Subscription has store, key {
        id: 0x2::object::UID,
        namespace: vector<u8>,
        expiry_ms: u64,
    }

    public fun extend_subscription(arg0: &0x3790fe6b835a02485b120221e0b84617b13cc3b6a56f0008069f7e12aa418d1f::registry::AuthorCap, arg1: &mut Subscription, arg2: u64) {
        if (arg2 > arg1.expiry_ms) {
            arg1.expiry_ms = arg2;
        };
    }

    fun is_prefix(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 > 0x1::vector::length<u8>(arg1)) {
            return false
        };
        let v1 = 0;
        while (v1 < v0) {
            if (*0x1::vector::borrow<u8>(arg0, v1) != *0x1::vector::borrow<u8>(arg1, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun license_namespace(arg0: &StrategyLicense) : vector<u8> {
        arg0.namespace
    }

    public fun mint_license(arg0: &0x3790fe6b835a02485b120221e0b84617b13cc3b6a56f0008069f7e12aa418d1f::registry::AuthorCap, arg1: vector<u8>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = StrategyLicense{
            id        : 0x2::object::new(arg3),
            namespace : arg1,
        };
        0x2::transfer::public_transfer<StrategyLicense>(v0, arg2);
    }

    public fun mint_subscription(arg0: &0x3790fe6b835a02485b120221e0b84617b13cc3b6a56f0008069f7e12aa418d1f::registry::AuthorCap, arg1: vector<u8>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Subscription{
            id        : 0x2::object::new(arg4),
            namespace : arg1,
            expiry_ms : arg2,
        };
        0x2::transfer::public_transfer<Subscription>(v0, arg3);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &StrategyLicense) {
        assert!(is_prefix(&arg1.namespace, &arg0), 0);
    }

    entry fun seal_approve_subscription(arg0: vector<u8>, arg1: &Subscription, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) <= arg1.expiry_ms, 0);
        assert!(is_prefix(&arg1.namespace, &arg0), 0);
    }

    public fun subscription_expiry(arg0: &Subscription) : u64 {
        arg0.expiry_ms
    }

    // decompiled from Move bytecode v7
}

