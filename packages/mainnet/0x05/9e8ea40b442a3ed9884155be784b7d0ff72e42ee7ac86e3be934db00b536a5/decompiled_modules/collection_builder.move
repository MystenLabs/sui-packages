module 0x59e8ea40b442a3ed9884155be784b7d0ff72e42ee7ac86e3be934db00b536a5::collection_builder {
    struct CollectionBuilder {
        name: 0x1::option::Option<0x1::string::String>,
        description: 0x1::option::Option<0x1::string::String>,
        amount: 0x1::option::Option<u64>,
        price: 0x1::option::Option<u64>,
    }

    public fun amount(arg0: CollectionBuilder, arg1: u64) : CollectionBuilder {
        0x1::option::fill<u64>(&mut arg0.amount, arg1);
        arg0
    }

    public fun builder() : CollectionBuilder {
        CollectionBuilder{
            name        : 0x1::option::none<0x1::string::String>(),
            description : 0x1::option::none<0x1::string::String>(),
            amount      : 0x1::option::none<u64>(),
            price       : 0x1::option::none<u64>(),
        }
    }

    public fun description(arg0: CollectionBuilder, arg1: 0x1::string::String) : CollectionBuilder {
        0x1::option::fill<0x1::string::String>(&mut arg0.description, arg1);
        arg0
    }

    public fun name(arg0: CollectionBuilder, arg1: 0x1::string::String) : CollectionBuilder {
        0x1::option::fill<0x1::string::String>(&mut arg0.name, arg1);
        arg0
    }

    public fun price(arg0: CollectionBuilder, arg1: u64) : CollectionBuilder {
        0x1::option::fill<u64>(&mut arg0.price, arg1);
        arg0
    }

    // decompiled from Move bytecode v6
}

