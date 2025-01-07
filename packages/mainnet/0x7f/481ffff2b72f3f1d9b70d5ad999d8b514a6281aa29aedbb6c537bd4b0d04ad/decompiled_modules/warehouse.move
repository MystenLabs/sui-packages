module 0x7f481ffff2b72f3f1d9b70d5ad999d8b514a6281aa29aedbb6c537bd4b0d04ad::warehouse {
    struct Warehouse<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        total_deposited: u64,
    }

    public fun new<T0: store + key>(arg0: &mut 0x2::tx_context::TxContext) : Warehouse<T0> {
        Warehouse<T0>{
            id              : 0x2::object::new(arg0),
            total_deposited : 0,
        }
    }

    public fun assert_exists<T0: store + key>(arg0: &Warehouse<T0>, arg1: 0x2::object::ID) {
        assert!(exists_<T0>(arg0, arg1), 1);
    }

    public fun deposit_nft<T0: store + key>(arg0: &mut Warehouse<T0>, arg1: T0) {
        arg0.total_deposited = arg0.total_deposited + 1;
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, 0x2::object::id<T0>(&arg1), arg1);
    }

    public fun exists_<T0: store + key>(arg0: &Warehouse<T0>, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, T0>(&arg0.id, arg1)
    }

    public fun redeem_nft<T0: store + key>(arg0: &mut Warehouse<T0>, arg1: 0x2::object::ID) : T0 {
        assert!(arg0.total_deposited > 0, 0);
        assert_exists<T0>(arg0, arg1);
        arg0.total_deposited = arg0.total_deposited - 1;
        0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg1)
    }

    // decompiled from Move bytecode v6
}

