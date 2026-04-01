module 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::collection_offer_registry {
    struct CollectionOfferMade has copy, drop {
        offer_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        offerer: address,
        amount: u64,
        expires_at: u64,
        timestamp: u64,
    }

    struct CollectionOfferAccepted has copy, drop {
        offer_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        amount: u64,
        timestamp: u64,
    }

    struct CollectionOfferCancelled has copy, drop {
        offer_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        offerer: address,
        timestamp: u64,
    }

    struct CollectionOfferExpiredCleanup has copy, drop {
        offer_id: 0x2::object::ID,
        offerer: address,
        amount: u64,
        expires_at: u64,
        timestamp: u64,
    }

    struct CollectionOfferInfo has copy, drop, store {
        offer_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        offerer: address,
        amount: u64,
        expires_at: u64,
        created_at: u64,
        active: bool,
    }

    struct CollectionOfferRegistry has store, key {
        id: 0x2::object::UID,
        offers: 0x2::table::Table<0x2::object::ID, CollectionOfferInfo>,
        offer_payments: 0x2::object_bag::ObjectBag,
        offers_by_collection: 0x2::table::Table<0x2::object::ID, vector<0x2::object::ID>>,
        offers_by_offerer: 0x2::table::Table<address, vector<0x2::object::ID>>,
    }

    struct RegistryAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun accept_collection_offer(arg0: &mut CollectionOfferRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : (0x2::coin::Coin<0x2::sui::SUI>, CollectionOfferInfo) {
        assert!(0x2::table::contains<0x2::object::ID, CollectionOfferInfo>(&arg0.offers, arg1), 200);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, CollectionOfferInfo>(&mut arg0.offers, arg1);
        assert!(v0.active, 200);
        assert!(v0.collection_id == arg2, 204);
        assert!(0x2::clock::timestamp_ms(arg3) < v0.expires_at, 201);
        v0.active = false;
        (0x2::object_bag::remove<0x2::object::ID, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.offer_payments, arg1), *v0)
    }

    public fun amount(arg0: &CollectionOfferInfo) : u64 {
        arg0.amount
    }

    public fun cancel_collection_offer(arg0: &mut CollectionOfferRegistry, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, CollectionOfferInfo>(&arg0.offers, arg1), 200);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, CollectionOfferInfo>(&mut arg0.offers, arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(v0.offerer == v1, 202);
        assert!(v0.active, 200);
        v0.active = false;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::object_bag::remove<0x2::object::ID, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.offer_payments, arg1), v1);
        let v2 = CollectionOfferCancelled{
            offer_id      : arg1,
            collection_id : v0.collection_id,
            offerer       : v1,
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<CollectionOfferCancelled>(v2);
    }

    public fun cleanup_expired_collection_offer(arg0: &mut CollectionOfferRegistry, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        assert!(0x2::table::contains<0x2::object::ID, CollectionOfferInfo>(&arg0.offers, arg1), 200);
        let v0 = 0x2::table::borrow<0x2::object::ID, CollectionOfferInfo>(&arg0.offers, arg1);
        assert!(0x2::clock::timestamp_ms(arg2) >= v0.expires_at, 201);
        assert!(v0.active, 200);
        let v1 = v0.offerer;
        0x2::table::borrow_mut<0x2::object::ID, CollectionOfferInfo>(&mut arg0.offers, arg1).active = false;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::object_bag::remove<0x2::object::ID, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.offer_payments, arg1), v1);
        let v2 = CollectionOfferExpiredCleanup{
            offer_id   : arg1,
            offerer    : v1,
            amount     : v0.amount,
            expires_at : v0.expires_at,
            timestamp  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<CollectionOfferExpiredCleanup>(v2);
    }

    public fun collection_id(arg0: &CollectionOfferInfo) : 0x2::object::ID {
        arg0.collection_id
    }

    public fun create_collection_offer(arg0: &mut CollectionOfferRegistry, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 203);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0x2::object::id_from_address(0x2::tx_context::fresh_object_address(arg5));
        let v3 = 0x2::clock::timestamp_ms(arg4);
        let v4 = v3 + arg3;
        let v5 = CollectionOfferInfo{
            offer_id      : v2,
            collection_id : arg1,
            offerer       : v1,
            amount        : v0,
            expires_at    : v4,
            created_at    : v3,
            active        : true,
        };
        0x2::object_bag::add<0x2::object::ID, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.offer_payments, v2, arg2);
        0x2::table::add<0x2::object::ID, CollectionOfferInfo>(&mut arg0.offers, v2, v5);
        if (!0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(&arg0.offers_by_collection, arg1)) {
            0x2::table::add<0x2::object::ID, vector<0x2::object::ID>>(&mut arg0.offers_by_collection, arg1, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<0x2::object::ID, vector<0x2::object::ID>>(&mut arg0.offers_by_collection, arg1), v2);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.offers_by_offerer, v1)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.offers_by_offerer, v1, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.offers_by_offerer, v1), v2);
        let v6 = CollectionOfferMade{
            offer_id      : v2,
            collection_id : arg1,
            offerer       : v1,
            amount        : v0,
            expires_at    : v4,
            timestamp     : v3,
        };
        0x2::event::emit<CollectionOfferMade>(v6);
    }

    public fun create_registry(arg0: &RegistryAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CollectionOfferRegistry{
            id                   : 0x2::object::new(arg1),
            offers               : 0x2::table::new<0x2::object::ID, CollectionOfferInfo>(arg1),
            offer_payments       : 0x2::object_bag::new(arg1),
            offers_by_collection : 0x2::table::new<0x2::object::ID, vector<0x2::object::ID>>(arg1),
            offers_by_offerer    : 0x2::table::new<address, vector<0x2::object::ID>>(arg1),
        };
        0x2::transfer::share_object<CollectionOfferRegistry>(v0);
    }

    public fun expires_at(arg0: &CollectionOfferInfo) : u64 {
        arg0.expires_at
    }

    public fun get_offer(arg0: &CollectionOfferRegistry, arg1: 0x2::object::ID) : CollectionOfferInfo {
        assert!(0x2::table::contains<0x2::object::ID, CollectionOfferInfo>(&arg0.offers, arg1), 200);
        *0x2::table::borrow<0x2::object::ID, CollectionOfferInfo>(&arg0.offers, arg1)
    }

    public fun get_offers_for_collection(arg0: &CollectionOfferRegistry, arg1: 0x2::object::ID) : vector<0x2::object::ID> {
        if (!0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(&arg0.offers_by_collection, arg1)) {
            return 0x1::vector::empty<0x2::object::ID>()
        };
        *0x2::table::borrow<0x2::object::ID, vector<0x2::object::ID>>(&arg0.offers_by_collection, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RegistryAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<RegistryAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_active(arg0: &CollectionOfferInfo) : bool {
        arg0.active
    }

    public fun is_offer_active(arg0: &CollectionOfferRegistry, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : bool {
        if (!0x2::table::contains<0x2::object::ID, CollectionOfferInfo>(&arg0.offers, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<0x2::object::ID, CollectionOfferInfo>(&arg0.offers, arg1);
        v0.active && 0x2::clock::timestamp_ms(arg2) < v0.expires_at
    }

    public fun offer_id(arg0: &CollectionOfferInfo) : 0x2::object::ID {
        arg0.offer_id
    }

    public fun offerer(arg0: &CollectionOfferInfo) : address {
        arg0.offerer
    }

    // decompiled from Move bytecode v6
}

