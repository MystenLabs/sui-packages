module 0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::inventory {
    struct Inventory<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct WarehouseKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun assert_warehouse<T0: store + key>(arg0: &Inventory<T0>) {
        assert!(is_warehouse<T0>(arg0), 1);
    }

    public fun borrow_warehouse<T0: store + key>(arg0: &Inventory<T0>) : &0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::warehouse::Warehouse<T0> {
        assert_warehouse<T0>(arg0);
        let v0 = WarehouseKey{dummy_field: false};
        0x2::dynamic_field::borrow<WarehouseKey, 0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::warehouse::Warehouse<T0>>(&arg0.id, v0)
    }

    fun borrow_warehouse_mut<T0: store + key>(arg0: &mut Inventory<T0>) : &mut 0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::warehouse::Warehouse<T0> {
        assert_warehouse<T0>(arg0);
        let v0 = WarehouseKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<WarehouseKey, 0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::warehouse::Warehouse<T0>>(&mut arg0.id, v0)
    }

    public entry fun deposit_nft<T0: store + key>(arg0: &mut Inventory<T0>, arg1: T0) {
        0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::warehouse::deposit_nft<T0>(borrow_warehouse_mut<T0>(arg0), arg1);
    }

    public fun from_warehouse<T0: store + key>(arg0: 0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::warehouse::Warehouse<T0>, arg1: &mut 0x2::tx_context::TxContext) : Inventory<T0> {
        let v0 = 0x2::object::new(arg1);
        let v1 = WarehouseKey{dummy_field: false};
        0x2::dynamic_field::add<WarehouseKey, 0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::warehouse::Warehouse<T0>>(&mut v0, v1, arg0);
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
        0x2::dynamic_field::exists_with_type<WarehouseKey, 0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::warehouse::Warehouse<T0>>(&arg0.id, v0)
    }

    public(friend) fun redeem_nft<T0: store + key>(arg0: &mut Inventory<T0>) : T0 {
        assert!(is_warehouse<T0>(arg0), 0);
        0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::warehouse::redeem_nft<T0>(borrow_warehouse_mut<T0>(arg0))
    }

    public(friend) fun redeem_nft_and_transfer<T0: store + key>(arg0: &mut Inventory<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(redeem_nft<T0>(arg0), 0x2::tx_context::sender(arg1));
    }

    public(friend) fun redeem_nft_at_index<T0: store + key>(arg0: &mut Inventory<T0>, arg1: u64) : T0 {
        assert!(is_warehouse<T0>(arg0), 0);
        0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::warehouse::redeem_nft_at_index<T0>(borrow_warehouse_mut<T0>(arg0), arg1)
    }

    public(friend) fun redeem_nft_at_index_and_transfer<T0: store + key>(arg0: &mut Inventory<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(redeem_nft_at_index<T0>(arg0, arg1), 0x2::tx_context::sender(arg2));
    }

    public(friend) fun redeem_nft_with_id<T0: store + key>(arg0: &mut Inventory<T0>, arg1: 0x2::object::ID) : T0 {
        assert!(is_warehouse<T0>(arg0), 0);
        0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::warehouse::redeem_nft_with_id<T0>(borrow_warehouse_mut<T0>(arg0), arg1)
    }

    public(friend) fun redeem_nft_with_id_and_transfer<T0: store + key>(arg0: &mut Inventory<T0>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(redeem_nft_with_id<T0>(arg0, arg1), 0x2::tx_context::sender(arg2));
    }

    public(friend) fun redeem_pseudorandom_nft<T0: store + key>(arg0: &mut Inventory<T0>, arg1: &mut 0x2::tx_context::TxContext) : T0 {
        assert!(is_warehouse<T0>(arg0), 0);
        0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::warehouse::redeem_pseudorandom_nft<T0>(borrow_warehouse_mut<T0>(arg0), arg1)
    }

    public(friend) fun redeem_pseudorandom_nft_and_transfer<T0: store + key>(arg0: &mut Inventory<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = redeem_pseudorandom_nft<T0>(arg0, arg1);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun redeem_random_nft<T0: store + key>(arg0: &mut Inventory<T0>, arg1: 0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::warehouse::RedeemCommitment, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : T0 {
        assert!(is_warehouse<T0>(arg0), 0);
        0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::warehouse::redeem_random_nft<T0>(borrow_warehouse_mut<T0>(arg0), arg1, arg2, arg3)
    }

    public(friend) fun redeem_random_nft_and_transfer<T0: store + key>(arg0: &mut Inventory<T0>, arg1: 0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::warehouse::RedeemCommitment, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = redeem_random_nft<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun supply<T0: store + key>(arg0: &Inventory<T0>) : 0x1::option::Option<u64> {
        assert!(is_warehouse<T0>(arg0), 0);
        0x1::option::some<u64>(0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::warehouse::supply<T0>(borrow_warehouse<T0>(arg0)))
    }

    // decompiled from Move bytecode v6
}

