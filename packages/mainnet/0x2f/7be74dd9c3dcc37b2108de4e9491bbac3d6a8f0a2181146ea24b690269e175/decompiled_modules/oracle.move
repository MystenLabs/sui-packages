module 0x2f7be74dd9c3dcc37b2108de4e9491bbac3d6a8f0a2181146ea24b690269e175::oracle {
    struct PriceReceipt {
        price: u64,
        asset_type: 0x1::type_name::TypeName,
    }

    public fun asset_type(arg0: &PriceReceipt) : 0x1::type_name::TypeName {
        arg0.asset_type
    }

    public fun burn(arg0: PriceReceipt) {
        let PriceReceipt {
            price      : _,
            asset_type : _,
        } = arg0;
    }

    public fun price(arg0: &PriceReceipt) : u64 {
        arg0.price
    }

    // decompiled from Move bytecode v6
}

