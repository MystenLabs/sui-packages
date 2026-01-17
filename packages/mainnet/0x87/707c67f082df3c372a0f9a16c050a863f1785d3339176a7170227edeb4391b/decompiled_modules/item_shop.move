module 0x87707c67f082df3c372a0f9a16c050a863f1785d3339176a7170227edeb4391b::item_shop {
    struct Shop has key {
        id: 0x2::object::UID,
        owner: address,
        price: u64,
    }

    struct RPGItem has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        power: u64,
    }

    public entry fun add_item(arg0: &mut Shop, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = RPGItem{
            id    : 0x2::object::new(arg3),
            name  : 0x1::string::utf8(arg1),
            power : arg2,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, RPGItem>(&mut arg0.id, 0x2::object::id<RPGItem>(&v0), v0);
    }

    public entry fun buy_item(arg0: &mut Shop, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg0.price, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg0.owner);
        0x2::transfer::public_transfer<RPGItem>(0x2::dynamic_object_field::remove<0x2::object::ID, RPGItem>(&mut arg0.id, arg1), 0x2::tx_context::sender(arg3));
    }

    public entry fun create_shop(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Shop{
            id    : 0x2::object::new(arg1),
            owner : 0x2::tx_context::sender(arg1),
            price : arg0,
        };
        0x2::transfer::share_object<Shop>(v0);
    }

    // decompiled from Move bytecode v6
}

