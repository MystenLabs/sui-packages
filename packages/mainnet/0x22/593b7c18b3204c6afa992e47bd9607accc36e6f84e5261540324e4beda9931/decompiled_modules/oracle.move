module 0x22593b7c18b3204c6afa992e47bd9607accc36e6f84e5261540324e4beda9931::oracle {
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

