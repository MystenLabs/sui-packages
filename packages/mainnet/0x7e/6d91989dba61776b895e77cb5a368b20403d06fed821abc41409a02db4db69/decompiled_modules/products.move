module 0x7e6d91989dba61776b895e77cb5a368b20403d06fed821abc41409a02db4db69::products {
    struct Product has store, key {
        id: 0x2::object::UID,
        sku: 0x1::string::String,
        description: 0x1::string::String,
        price: u64,
    }

    struct ProductCreated has copy, drop {
        product_id: 0x2::object::ID,
        sku: 0x1::string::String,
    }

    struct ProductUpdated has copy, drop {
        product_id: 0x2::object::ID,
        field: 0x1::string::String,
    }

    struct ProductDeleted has copy, drop {
        product_id: 0x2::object::ID,
    }

    public entry fun create_product(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        let v0 = Product{
            id          : 0x2::object::new(arg3),
            sku         : arg0,
            description : arg1,
            price       : arg2,
        };
        let v1 = ProductCreated{
            product_id : 0x2::object::uid_to_inner(&v0.id),
            sku        : v0.sku,
        };
        0x2::event::emit<ProductCreated>(v1);
        0x2::transfer::public_transfer<Product>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun delete_product(arg0: Product) {
        let Product {
            id          : v0,
            sku         : _,
            description : _,
            price       : _,
        } = arg0;
        let v4 = v0;
        let v5 = ProductDeleted{product_id: 0x2::object::uid_to_inner(&v4)};
        0x2::event::emit<ProductDeleted>(v5);
        0x2::object::delete(v4);
    }

    public fun get_description(arg0: &Product) : &0x1::string::String {
        &arg0.description
    }

    public fun get_price(arg0: &Product) : u64 {
        arg0.price
    }

    public fun get_sku(arg0: &Product) : &0x1::string::String {
        &arg0.sku
    }

    public entry fun update_description(arg0: &mut Product, arg1: 0x1::string::String) {
        arg0.description = arg1;
        let v0 = ProductUpdated{
            product_id : 0x2::object::uid_to_inner(&arg0.id),
            field      : 0x1::string::utf8(b"description"),
        };
        0x2::event::emit<ProductUpdated>(v0);
    }

    public entry fun update_price(arg0: &mut Product, arg1: u64) {
        assert!(arg1 > 0, 1);
        arg0.price = arg1;
        let v0 = ProductUpdated{
            product_id : 0x2::object::uid_to_inner(&arg0.id),
            field      : 0x1::string::utf8(b"price"),
        };
        0x2::event::emit<ProductUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

