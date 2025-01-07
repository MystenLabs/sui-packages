module 0xc741e7b4ecd3ea87d3b033c9887960b6c68135edbea9f52cc84345e0466e0419::plain_storage {
    struct PlainStorage has store {
        nfts: 0x2::object_bag::ObjectBag,
    }

    public(friend) fun contains(arg0: &PlainStorage, arg1: 0x2::object::ID) : bool {
        0x2::object_bag::contains<0x2::object::ID>(&arg0.nfts, arg1)
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : PlainStorage {
        PlainStorage{nfts: 0x2::object_bag::new(arg0)}
    }

    public(friend) fun amount(arg0: &PlainStorage) : u64 {
        0x2::object_bag::length(&arg0.nfts)
    }

    public(friend) fun deposit<T0: store + key>(arg0: &mut PlainStorage, arg1: T0) {
        0x2::object_bag::add<0x2::object::ID, T0>(&mut arg0.nfts, 0x2::object::id<T0>(&arg1), arg1);
    }

    public(friend) fun withdraw<T0: store + key>(arg0: &mut PlainStorage, arg1: 0x2::object::ID) : T0 {
        0x2::object_bag::remove<0x2::object::ID, T0>(&mut arg0.nfts, arg1)
    }

    // decompiled from Move bytecode v6
}

