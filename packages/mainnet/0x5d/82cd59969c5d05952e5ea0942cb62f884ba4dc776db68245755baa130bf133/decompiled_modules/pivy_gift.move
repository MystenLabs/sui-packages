module 0x5d82cd59969c5d05952e5ea0942cb62f884ba4dc776db68245755baa130bf133::pivy_gift {
    struct GiftStore has key {
        id: 0x2::object::UID,
        bags: 0x2::table::Table<address, GiftBag>,
        total_created: u64,
        total_claimed: u64,
    }

    struct GiftBag has store {
        id: 0x2::object::UID,
        owner: address,
        encrypted_metadata: vector<u8>,
        item_ids: 0x2::vec_set::VecSet<address>,
        gift_ephemeral_pubkey: vector<u8>,
    }

    struct GiftClaim has drop {
        bag_id: 0x2::object::ID,
    }

    struct GiftStoreCreatedEvent has copy, drop {
        store_id: 0x2::object::ID,
        creator: address,
    }

    struct GiftCreatedEvent has copy, drop {
        claim_address: address,
        owner: address,
        bag_address: address,
        encrypted_metadata: vector<u8>,
        gift_ephemeral_pubkey: vector<u8>,
        funding_ephemeral_pubkey: vector<u8>,
    }

    struct GiftFundedEvent<phantom T0> has copy, drop {
        claim_address: address,
        amount: u64,
    }

    struct GiftClaimedEvent has copy, drop {
        claim_address: address,
        claimer: address,
        destination: address,
    }

    struct GiftCancelledEvent has copy, drop {
        claim_address: address,
        owner: address,
    }

    public entry fun add_coin<T0>(arg0: &mut GiftStore, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, GiftBag>(&arg0.bags, arg1), 2);
        let v0 = 0x2::table::borrow_mut<address, GiftBag>(&mut arg0.bags, arg1);
        assert!(v0.owner == 0x2::tx_context::sender(arg3), 3);
        assert!(0x2::vec_set::size<address>(&v0.item_ids) < 50, 7);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 > 0, 9);
        0x2::vec_set::insert<address>(&mut v0.item_ids, 0x2::object::id_address<0x2::coin::Coin<T0>>(&arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::object::uid_to_address(&v0.id));
        let v2 = GiftFundedEvent<T0>{
            claim_address : arg1,
            amount        : v1,
        };
        0x2::event::emit<GiftFundedEvent<T0>>(v2);
    }

    public fun bag_exists(arg0: &GiftStore, arg1: address) : bool {
        0x2::table::contains<address, GiftBag>(&arg0.bags, arg1)
    }

    public fun bag_item_count(arg0: &GiftBag) : u64 {
        0x2::vec_set::size<address>(&arg0.item_ids)
    }

    public fun claim_coin<T0>(arg0: &mut GiftBag, arg1: &GiftClaim, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) : 0x2::coin::Coin<T0> {
        assert!(arg1.bag_id == 0x2::object::uid_to_inner(&arg0.id), 4);
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg2);
        let v1 = 0x2::object::id_address<0x2::coin::Coin<T0>>(&v0);
        if (0x2::vec_set::contains<address>(&arg0.item_ids, &v1)) {
            0x2::vec_set::remove<address>(&mut arg0.item_ids, &v1);
        };
        v0
    }

    public entry fun create_bag(arg0: &mut GiftStore, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, GiftBag>(&arg0.bags, arg1), 1);
        assert!(0x1::vector::length<u8>(&arg2) <= 512, 6);
        assert!(0x1::vector::length<u8>(&arg3) == 33, 8);
        let v0 = *0x1::vector::borrow<u8>(&arg3, 0);
        assert!(v0 == 2 || v0 == 3, 8);
        assert!(0x1::vector::length<u8>(&arg4) == 33, 8);
        let v1 = *0x1::vector::borrow<u8>(&arg4, 0);
        assert!(v1 == 2 || v1 == 3, 8);
        let v2 = GiftBag{
            id                    : 0x2::object::new(arg5),
            owner                 : 0x2::tx_context::sender(arg5),
            encrypted_metadata    : arg2,
            item_ids              : 0x2::vec_set::empty<address>(),
            gift_ephemeral_pubkey : arg3,
        };
        let v3 = GiftCreatedEvent{
            claim_address            : arg1,
            owner                    : 0x2::tx_context::sender(arg5),
            bag_address              : 0x2::object::uid_to_address(&v2.id),
            encrypted_metadata       : arg2,
            gift_ephemeral_pubkey    : arg3,
            funding_ephemeral_pubkey : arg4,
        };
        0x2::event::emit<GiftCreatedEvent>(v3);
        0x2::table::add<address, GiftBag>(&mut arg0.bags, arg1, v2);
        arg0.total_created = arg0.total_created + 1;
    }

    public fun finalize_claim(arg0: &mut GiftStore, arg1: GiftBag, arg2: GiftClaim, arg3: address, arg4: &0x2::tx_context::TxContext) {
        assert!(arg2.bag_id == 0x2::object::uid_to_inner(&arg1.id), 4);
        assert!(0x2::vec_set::is_empty<address>(&arg1.item_ids), 5);
        let v0 = GiftClaimedEvent{
            claim_address : 0x2::tx_context::sender(arg4),
            claimer       : 0x2::tx_context::sender(arg4),
            destination   : arg3,
        };
        0x2::event::emit<GiftClaimedEvent>(v0);
        arg0.total_claimed = arg0.total_claimed + 1;
        let GiftBag {
            id                    : v1,
            owner                 : _,
            encrypted_metadata    : _,
            item_ids              : _,
            gift_ephemeral_pubkey : _,
        } = arg1;
        0x2::object::delete(v1);
    }

    public fun finalize_reclaim(arg0: GiftBag, arg1: GiftClaim) {
        assert!(arg1.bag_id == 0x2::object::uid_to_inner(&arg0.id), 4);
        assert!(0x2::vec_set::is_empty<address>(&arg0.item_ids), 5);
        let GiftBag {
            id                    : v0,
            owner                 : _,
            encrypted_metadata    : _,
            item_ids              : _,
            gift_ephemeral_pubkey : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_bag_address(arg0: &GiftStore, arg1: address) : address {
        assert!(0x2::table::contains<address, GiftBag>(&arg0.bags, arg1), 2);
        0x2::object::uid_to_address(&0x2::table::borrow<address, GiftBag>(&arg0.bags, arg1).id)
    }

    public fun get_ephemeral_pubkey(arg0: &GiftStore, arg1: address) : vector<u8> {
        assert!(0x2::table::contains<address, GiftBag>(&arg0.bags, arg1), 2);
        0x2::table::borrow<address, GiftBag>(&arg0.bags, arg1).gift_ephemeral_pubkey
    }

    public fun get_item_count(arg0: &GiftStore, arg1: address) : u64 {
        assert!(0x2::table::contains<address, GiftBag>(&arg0.bags, arg1), 2);
        0x2::vec_set::size<address>(&0x2::table::borrow<address, GiftBag>(&arg0.bags, arg1).item_ids)
    }

    public fun get_metadata(arg0: &GiftStore, arg1: address) : vector<u8> {
        assert!(0x2::table::contains<address, GiftBag>(&arg0.bags, arg1), 2);
        0x2::table::borrow<address, GiftBag>(&arg0.bags, arg1).encrypted_metadata
    }

    public fun get_owner(arg0: &GiftStore, arg1: address) : address {
        assert!(0x2::table::contains<address, GiftBag>(&arg0.bags, arg1), 2);
        0x2::table::borrow<address, GiftBag>(&arg0.bags, arg1).owner
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GiftStore{
            id            : 0x2::object::new(arg0),
            bags          : 0x2::table::new<address, GiftBag>(arg0),
            total_created : 0,
            total_claimed : 0,
        };
        let v1 = GiftStoreCreatedEvent{
            store_id : 0x2::object::id<GiftStore>(&v0),
            creator  : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<GiftStoreCreatedEvent>(v1);
        0x2::transfer::share_object<GiftStore>(v0);
    }

    public fun init_claim(arg0: &mut GiftStore, arg1: &mut 0x2::tx_context::TxContext) : (GiftBag, GiftClaim) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, GiftBag>(&arg0.bags, v0), 2);
        let v1 = 0x2::table::remove<address, GiftBag>(&mut arg0.bags, v0);
        let v2 = GiftClaim{bag_id: 0x2::object::uid_to_inner(&v1.id)};
        (v1, v2)
    }

    public fun reclaim(arg0: &mut GiftStore, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : (GiftBag, GiftClaim) {
        assert!(0x2::table::contains<address, GiftBag>(&arg0.bags, arg1), 2);
        assert!(0x2::table::borrow<address, GiftBag>(&arg0.bags, arg1).owner == 0x2::tx_context::sender(arg2), 3);
        let v0 = 0x2::table::remove<address, GiftBag>(&mut arg0.bags, arg1);
        let v1 = GiftClaim{bag_id: 0x2::object::uid_to_inner(&v0.id)};
        let v2 = GiftCancelledEvent{
            claim_address : arg1,
            owner         : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<GiftCancelledEvent>(v2);
        (v0, v1)
    }

    public fun reclaim_coin<T0>(arg0: &mut GiftBag, arg1: &GiftClaim, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) : 0x2::coin::Coin<T0> {
        assert!(arg1.bag_id == 0x2::object::uid_to_inner(&arg0.id), 4);
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg2);
        let v1 = 0x2::object::id_address<0x2::coin::Coin<T0>>(&v0);
        if (0x2::vec_set::contains<address>(&arg0.item_ids, &v1)) {
            0x2::vec_set::remove<address>(&mut arg0.item_ids, &v1);
        };
        v0
    }

    public fun total_claimed(arg0: &GiftStore) : u64 {
        arg0.total_claimed
    }

    public fun total_created(arg0: &GiftStore) : u64 {
        arg0.total_created
    }

    // decompiled from Move bytecode v6
}

