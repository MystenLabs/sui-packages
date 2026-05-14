module 0x53648b2a17bc489ada0154fdff370766fbbf1ebf5c5e3531b93a2dc7fe29d091::container {
    struct Container has store, key {
        id: 0x2::object::UID,
        count: u64,
    }

    public entry fun create_container(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Container{
            id    : 0x2::object::new(arg0),
            count : 0,
        };
        0x2::transfer::public_transfer<Container>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun extract_coin(arg0: &mut Container, arg1: u64, arg2: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::dynamic_object_field::remove<u64, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, arg1), arg2);
    }

    public entry fun store_coin(arg0: &mut Container, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = arg0.count;
        arg0.count = v0 + 1;
        0x2::dynamic_object_field::add<u64, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, v0, arg1);
    }

    // decompiled from Move bytecode v7
}

