module 0x5bb7d0bb3240011336ca9015f553b2646302a4f05f821160344e9ec5a988f740::zk_bag {
    struct BagStore has key {
        id: 0x2::object::UID,
        items: 0x2::table::Table<address, ZkBag>,
    }

    struct BagClaim {
        bag_id: 0x2::object::ID,
    }

    struct ZkBag has store, key {
        id: 0x2::object::UID,
        owner: address,
        item_ids: 0x2::vec_set::VecSet<address>,
    }

    public fun new(arg0: &mut BagStore, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, ZkBag>(&arg0.items, arg1), 5);
        let v0 = ZkBag{
            id       : 0x2::object::new(arg2),
            owner    : 0x2::tx_context::sender(arg2),
            item_ids : 0x2::vec_set::empty<address>(),
        };
        0x2::table::add<address, ZkBag>(&mut arg0.items, arg1, v0);
    }

    public fun add<T0: store + key>(arg0: &mut BagStore, arg1: address, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, ZkBag>(&arg0.items, arg1), 6);
        let v0 = 0x2::table::borrow_mut<address, ZkBag>(&mut arg0.items, arg1);
        assert!(v0.owner == 0x2::tx_context::sender(arg3), 1);
        assert!(0x2::vec_set::size<address>(&v0.item_ids) < 50, 0);
        0x2::vec_set::insert<address>(&mut v0.item_ids, 0x2::object::id_address<T0>(&arg2));
        0x2::transfer::public_transfer<T0>(arg2, 0x2::object::id_address<ZkBag>(v0));
    }

    public fun claim<T0: store + key>(arg0: &mut ZkBag, arg1: &BagClaim, arg2: 0x2::transfer::Receiving<T0>) : T0 {
        assert!(is_valid_claim_object(arg0, arg1), 2);
        let v0 = 0x2::transfer::public_receive<T0>(&mut arg0.id, arg2);
        let v1 = 0x2::object::id_address<T0>(&v0);
        assert!(0x2::vec_set::contains<address>(&arg0.item_ids, &v1), 7);
        let v2 = 0x2::object::id_address<T0>(&v0);
        0x2::vec_set::remove<address>(&mut arg0.item_ids, &v2);
        v0
    }

    public fun finalize(arg0: ZkBag, arg1: BagClaim) {
        assert!(is_valid_claim_object(&arg0, &arg1), 2);
        assert!(0x2::vec_set::is_empty<address>(&arg0.item_ids), 3);
        let BagClaim {  } = arg1;
        let ZkBag {
            id       : v0,
            owner    : _,
            item_ids : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BagStore{
            id    : 0x2::object::new(arg0),
            items : 0x2::table::new<address, ZkBag>(arg0),
        };
        0x2::transfer::share_object<BagStore>(v0);
    }

    public fun init_claim(arg0: &mut BagStore, arg1: &mut 0x2::tx_context::TxContext) : (ZkBag, BagClaim) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, ZkBag>(&arg0.items, v0), 6);
        let v1 = 0x2::table::remove<address, ZkBag>(&mut arg0.items, v0);
        let v2 = BagClaim{bag_id: 0x2::object::id<ZkBag>(&v1)};
        (v1, v2)
    }

    fun is_valid_claim_object(arg0: &ZkBag, arg1: &BagClaim) : bool {
        arg1.bag_id == 0x2::object::id<ZkBag>(arg0)
    }

    public fun reclaim(arg0: &mut BagStore, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : (ZkBag, BagClaim) {
        assert!(0x2::table::contains<address, ZkBag>(&arg0.items, arg1), 6);
        let v0 = 0x2::table::remove<address, ZkBag>(&mut arg0.items, arg1);
        assert!(v0.owner == 0x2::tx_context::sender(arg2), 1);
        let v1 = BagClaim{bag_id: 0x2::object::id<ZkBag>(&v0)};
        (v0, v1)
    }

    public fun update_receiver(arg0: &mut BagStore, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, ZkBag>(&arg0.items, arg1), 6);
        assert!(!0x2::table::contains<address, ZkBag>(&arg0.items, arg2), 5);
        let v0 = 0x2::table::remove<address, ZkBag>(&mut arg0.items, arg1);
        assert!(v0.owner == 0x2::tx_context::sender(arg3), 1);
        0x2::table::add<address, ZkBag>(&mut arg0.items, arg2, v0);
    }

    // decompiled from Move bytecode v6
}

