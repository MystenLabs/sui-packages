module 0xb83f65f467d5e436fd1142f930d4081d9e1ae71ac588866c20ac830f2843cdd4::oracle {
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

