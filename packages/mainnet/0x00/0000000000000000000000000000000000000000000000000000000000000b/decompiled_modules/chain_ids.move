module 0xb::chain_ids {
    struct BridgeRoute has copy, drop, store {
        source: u8,
        destination: u8,
    }

    public fun assert_valid_chain_id(arg0: u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 10) {
            true
        } else if (arg0 == 11) {
            true
        } else {
            arg0 == 12
        };
        assert!(v0, 0);
    }

    public fun eth_custom() : u8 {
        12
    }

    public fun eth_mainnet() : u8 {
        10
    }

    public fun eth_sepolia() : u8 {
        11
    }

    public fun get_route(arg0: u8, arg1: u8) : BridgeRoute {
        let v0 = BridgeRoute{
            source      : arg0,
            destination : arg1,
        };
        let v1 = valid_routes();
        assert!(0x1::vector::contains<BridgeRoute>(&v1, &v0), 0);
        v0
    }

    public fun is_valid_route(arg0: u8, arg1: u8) : bool {
        let v0 = BridgeRoute{
            source      : arg0,
            destination : arg1,
        };
        let v1 = valid_routes();
        0x1::vector::contains<BridgeRoute>(&v1, &v0)
    }

    public fun route_destination(arg0: &BridgeRoute) : &u8 {
        &arg0.destination
    }

    public fun route_source(arg0: &BridgeRoute) : &u8 {
        &arg0.source
    }

    public fun sui_custom() : u8 {
        2
    }

    public fun sui_mainnet() : u8 {
        0
    }

    public fun sui_testnet() : u8 {
        1
    }

    public fun valid_routes() : vector<BridgeRoute> {
        let v0 = BridgeRoute{
            source      : 0,
            destination : 10,
        };
        let v1 = BridgeRoute{
            source      : 10,
            destination : 0,
        };
        let v2 = BridgeRoute{
            source      : 1,
            destination : 11,
        };
        let v3 = BridgeRoute{
            source      : 1,
            destination : 12,
        };
        let v4 = BridgeRoute{
            source      : 2,
            destination : 12,
        };
        let v5 = BridgeRoute{
            source      : 2,
            destination : 11,
        };
        let v6 = BridgeRoute{
            source      : 11,
            destination : 1,
        };
        let v7 = BridgeRoute{
            source      : 11,
            destination : 2,
        };
        let v8 = BridgeRoute{
            source      : 12,
            destination : 1,
        };
        let v9 = BridgeRoute{
            source      : 12,
            destination : 2,
        };
        let v10 = 0x1::vector::empty<BridgeRoute>();
        let v11 = &mut v10;
        0x1::vector::push_back<BridgeRoute>(v11, v0);
        0x1::vector::push_back<BridgeRoute>(v11, v1);
        0x1::vector::push_back<BridgeRoute>(v11, v2);
        0x1::vector::push_back<BridgeRoute>(v11, v3);
        0x1::vector::push_back<BridgeRoute>(v11, v4);
        0x1::vector::push_back<BridgeRoute>(v11, v5);
        0x1::vector::push_back<BridgeRoute>(v11, v6);
        0x1::vector::push_back<BridgeRoute>(v11, v7);
        0x1::vector::push_back<BridgeRoute>(v11, v8);
        0x1::vector::push_back<BridgeRoute>(v11, v9);
        v10
    }

    // decompiled from Move bytecode v6
}

