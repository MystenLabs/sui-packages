module 0xdcedfbd5aa43274ada0a8416766cc18718b5ee8be151ad5ed43ff941343395d9::compose_transfer {
    struct ComposeTransfer<phantom T0> has store, key {
        id: 0x2::object::UID,
        from: address,
        guid: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32,
        coin: 0x2::coin::Coin<T0>,
    }

    public fun coin<T0>(arg0: &ComposeTransfer<T0>) : &0x2::coin::Coin<T0> {
        &arg0.coin
    }

    public(friend) fun create<T0>(arg0: address, arg1: 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : ComposeTransfer<T0> {
        ComposeTransfer<T0>{
            id   : 0x2::object::new(arg3),
            from : arg0,
            guid : arg1,
            coin : arg2,
        }
    }

    public fun destroy<T0>(arg0: ComposeTransfer<T0>) : (address, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32, 0x2::coin::Coin<T0>) {
        let ComposeTransfer {
            id   : v0,
            from : v1,
            guid : v2,
            coin : v3,
        } = arg0;
        0x2::object::delete(v0);
        (v1, v2, v3)
    }

    public fun from<T0>(arg0: &ComposeTransfer<T0>) : address {
        arg0.from
    }

    public fun guid<T0>(arg0: &ComposeTransfer<T0>) : 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::bytes32::Bytes32 {
        arg0.guid
    }

    // decompiled from Move bytecode v6
}

