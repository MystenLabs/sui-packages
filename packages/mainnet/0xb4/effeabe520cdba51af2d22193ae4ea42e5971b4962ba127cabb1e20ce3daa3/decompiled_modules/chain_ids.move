module 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::chain_ids {
    struct BridgeRoute has drop {
        source: u8,
        destination: u8,
    }

    public fun eth_local_test() : u8 {
        12
    }

    public fun eth_mainnet() : u8 {
        10
    }

    public fun eth_sepolia() : u8 {
        11
    }

    public fun is_valid_route(arg0: u8, arg1: u8) : bool {
        let v0 = BridgeRoute{
            source      : arg0,
            destination : arg1,
        };
        let v1 = valid_routes();
        0x1::vector::contains<BridgeRoute>(&v1, &v0)
    }

    public fun sui_devnet() : u8 {
        2
    }

    public fun sui_local_test() : u8 {
        3
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
            source      : 2,
            destination : 11,
        };
        let v2 = BridgeRoute{
            source      : 1,
            destination : 11,
        };
        let v3 = BridgeRoute{
            source      : 3,
            destination : 12,
        };
        let v4 = BridgeRoute{
            source      : 10,
            destination : 0,
        };
        let v5 = BridgeRoute{
            source      : 11,
            destination : 2,
        };
        let v6 = BridgeRoute{
            source      : 11,
            destination : 1,
        };
        let v7 = BridgeRoute{
            source      : 12,
            destination : 3,
        };
        let v8 = 0x1::vector::empty<BridgeRoute>();
        let v9 = &mut v8;
        0x1::vector::push_back<BridgeRoute>(v9, v0);
        0x1::vector::push_back<BridgeRoute>(v9, v1);
        0x1::vector::push_back<BridgeRoute>(v9, v2);
        0x1::vector::push_back<BridgeRoute>(v9, v3);
        0x1::vector::push_back<BridgeRoute>(v9, v4);
        0x1::vector::push_back<BridgeRoute>(v9, v5);
        0x1::vector::push_back<BridgeRoute>(v9, v6);
        0x1::vector::push_back<BridgeRoute>(v9, v7);
        v8
    }

    // decompiled from Move bytecode v7
}

