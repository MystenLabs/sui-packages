module 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::inventory {
    struct Inventory<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct WarehouseKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun assert_warehouse<T0: store + key>(arg0: &Inventory<T0>) {
        assert!(is_warehouse<T0>(arg0), 1);
    }

    public fun borrow_warehouse<T0: store + key>(arg0: &Inventory<T0>) : &0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::Warehouse<T0> {
        assert_warehouse<T0>(arg0);
        let v0 = WarehouseKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<WarehouseKey, 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::Warehouse<T0>>(&arg0.id, v0)
    }

    fun borrow_warehouse_mut<T0: store + key>(arg0: &mut Inventory<T0>) : &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::Warehouse<T0> {
        assert_warehouse<T0>(arg0);
        let v0 = WarehouseKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<WarehouseKey, 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::Warehouse<T0>>(&mut arg0.id, v0)
    }

    public entry fun deposit_nft<T0: store + key>(arg0: &mut Inventory<T0>, arg1: T0) {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::deposit_nft<T0>(borrow_warehouse_mut<T0>(arg0), arg1);
    }

    public fun from_warehouse<T0: store + key>(arg0: 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::Warehouse<T0>, arg1: &mut 0x2::tx_context::TxContext) : Inventory<T0> {
        let v0 = 0x2::object::new(arg1);
        let v1 = WarehouseKey{dummy_field: false};
        0x2::dynamic_object_field::add<WarehouseKey, 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::Warehouse<T0>>(&mut v0, v1, arg0);
        Inventory<T0>{id: v0}
    }

    public fun is_empty<T0: store + key>(arg0: &Inventory<T0>) : bool {
        let v0 = supply<T0>(arg0);
        if (0x1::option::is_some<u64>(&v0)) {
            0x1::option::destroy_some<u64>(v0) == 0
        } else {
            0x1::option::destroy_none<u64>(v0);
            false
        }
    }

    public fun is_warehouse<T0: store + key>(arg0: &Inventory<T0>) : bool {
        let v0 = WarehouseKey{dummy_field: false};
        0x2::dynamic_object_field::exists_with_type<WarehouseKey, 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::Warehouse<T0>>(&arg0.id, v0)
    }

    public fun redeem_nft<T0: store + key>(arg0: &mut Inventory<T0>) : T0 {
        assert_warehouse<T0>(arg0);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::redeem_nft<T0>(borrow_warehouse_mut<T0>(arg0))
    }

    public entry fun redeem_nft_and_transfer<T0: store + key>(arg0: &mut Inventory<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(redeem_nft<T0>(arg0), 0x2::tx_context::sender(arg1));
    }

    public fun redeem_nft_at_index<T0: store + key>(arg0: &mut Inventory<T0>, arg1: u64) : T0 {
        assert_warehouse<T0>(arg0);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::redeem_nft_at_index<T0>(borrow_warehouse_mut<T0>(arg0), arg1)
    }

    public entry fun redeem_nft_at_index_and_transfer<T0: store + key>(arg0: &mut Inventory<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(redeem_nft_at_index<T0>(arg0, arg1), 0x2::tx_context::sender(arg2));
    }

    public fun redeem_nft_with_id<T0: store + key>(arg0: &mut Inventory<T0>, arg1: 0x2::object::ID) : T0 {
        assert_warehouse<T0>(arg0);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::redeem_nft_with_id<T0>(borrow_warehouse_mut<T0>(arg0), arg1)
    }

    public entry fun redeem_nft_with_id_and_transfer<T0: store + key>(arg0: &mut Inventory<T0>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(redeem_nft_with_id<T0>(arg0, arg1), 0x2::tx_context::sender(arg2));
    }

    public fun redeem_pseudorandom_nft<T0: store + key>(arg0: &mut Inventory<T0>, arg1: &mut 0x2::tx_context::TxContext) : T0 {
        assert_warehouse<T0>(arg0);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::redeem_pseudorandom_nft<T0>(borrow_warehouse_mut<T0>(arg0), arg1)
    }

    public entry fun redeem_pseudorandom_nft_and_transfer<T0: store + key>(arg0: &mut Inventory<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = redeem_pseudorandom_nft<T0>(arg0, arg1);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun redeem_random_nft<T0: store + key>(arg0: &mut Inventory<T0>, arg1: 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::RedeemCommitment, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : T0 {
        assert_warehouse<T0>(arg0);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::redeem_random_nft<T0>(borrow_warehouse_mut<T0>(arg0), arg1, arg2, arg3)
    }

    public entry fun redeem_random_nft_and_transfer<T0: store + key>(arg0: &mut Inventory<T0>, arg1: 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::RedeemCommitment, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = redeem_random_nft<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun supply<T0: store + key>(arg0: &Inventory<T0>) : 0x1::option::Option<u64> {
        assert!(is_warehouse<T0>(arg0), 1);
        0x1::option::some<u64>(0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::warehouse::supply<T0>(borrow_warehouse<T0>(arg0)))
    }

    // decompiled from Move bytecode v6
}

