module 0xd17756c4550941430206cb19d9836bbcce28b331ec581e98c1939641e657c8b7::oracle {
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

