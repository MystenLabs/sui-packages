module 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::oracle {
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

