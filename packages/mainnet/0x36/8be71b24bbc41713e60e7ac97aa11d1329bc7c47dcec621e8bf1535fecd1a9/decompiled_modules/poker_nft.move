module 0x368be71b24bbc41713e60e7ac97aa11d1329bc7c47dcec621e8bf1535fecd1a9::poker_nft {
    struct Store has store, key {
        id: 0x2::object::UID,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
        store: Store,
        nft_ids: vector<0x2::object::ID>,
        fee_rate: u64,
        beneficiary: address,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        ask: u64,
        fee: u64,
        total: u64,
        owner: address,
    }

    struct ListEvent has copy, drop {
        seller: address,
        nft_id: 0x2::object::ID,
        ask: u64,
        fee: u64,
        total: u64,
    }

    struct DelistEvent has copy, drop {
        seller: address,
        nft_id: 0x2::object::ID,
    }

    struct BuyEvent has copy, drop {
        buyer: address,
        seller: address,
        nft_id: 0x2::object::ID,
        price: u64,
        fee: u64,
    }

    struct FeeChangedEvent has copy, drop {
        new_rate: u64,
    }

    struct BeneficiaryChangedEvent has copy, drop {
        new_addr: address,
    }

    struct PriceChangedEvent has copy, drop {
        seller: address,
        nft_id: 0x2::object::ID,
        old_price: u64,
        new_price: u64,
    }

    public fun buy_and_take<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let Listing {
            id     : v0,
            nft_id : _,
            ask    : v2,
            fee    : v3,
            total  : v4,
            owner  : v5,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing>(&mut arg0.store.id, arg1);
        let v6 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v6 >= v4, 0);
        if (v6 > v4) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v6 - v4, arg3), 0x2::tx_context::sender(arg3));
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v3, arg3), arg0.beneficiary);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v5);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg1), 0x2::tx_context::sender(arg3));
        let v7 = 0;
        while (v7 < 0x1::vector::length<0x2::object::ID>(&arg0.nft_ids)) {
            if (*0x1::vector::borrow<0x2::object::ID>(&arg0.nft_ids, v7) == arg1) {
                0x1::vector::swap_remove<0x2::object::ID>(&mut arg0.nft_ids, v7);
                break
            };
            v7 = v7 + 1;
        };
        0x2::object::delete(v0);
        let v8 = BuyEvent{
            buyer  : 0x2::tx_context::sender(arg3),
            seller : v5,
            nft_id : arg1,
            price  : v2,
            fee    : v3,
        };
        0x2::event::emit<BuyEvent>(v8);
    }

    fun contains_id(arg0: &vector<0x2::object::ID>, arg1: 0x2::object::ID) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun delist_and_take<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let Listing {
            id     : v0,
            nft_id : _,
            ask    : _,
            fee    : _,
            total  : _,
            owner  : v5,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing>(&mut arg0.store.id, arg1);
        assert!(0x2::tx_context::sender(arg2) == v5, 1);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg1), 0x2::tx_context::sender(arg2));
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x2::object::ID>(&arg0.nft_ids)) {
            if (*0x1::vector::borrow<0x2::object::ID>(&arg0.nft_ids, v6) == arg1) {
                0x1::vector::swap_remove<0x2::object::ID>(&mut arg0.nft_ids, v6);
                break
            };
            v6 = v6 + 1;
        };
        0x2::object::delete(v0);
        let v7 = DelistEvent{
            seller : 0x2::tx_context::sender(arg2),
            nft_id : arg1,
        };
        0x2::event::emit<DelistEvent>(v7);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Store{id: 0x2::object::new(arg0)};
        let v1 = Marketplace{
            id          : 0x2::object::new(arg0),
            store       : v0,
            nft_ids     : 0x1::vector::empty<0x2::object::ID>(),
            fee_rate    : 25,
            beneficiary : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Marketplace>(v1);
    }

    public fun list<T0: store + key>(arg0: &mut Marketplace, arg1: T0, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<T0>(&arg1);
        assert!(!contains_id(&arg0.nft_ids, v0), 2);
        let v1 = arg2 * arg0.fee_rate / 1000;
        let v2 = arg2 + v1;
        let v3 = Listing{
            id     : 0x2::object::new(arg3),
            nft_id : v0,
            ask    : arg2,
            fee    : v1,
            total  : v2,
            owner  : 0x2::tx_context::sender(arg3),
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Listing>(&mut arg0.store.id, v0, v3);
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, v0, arg1);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.nft_ids, v0);
        let v4 = ListEvent{
            seller : 0x2::tx_context::sender(arg3),
            nft_id : v0,
            ask    : arg2,
            fee    : v1,
            total  : v2,
        };
        0x2::event::emit<ListEvent>(v4);
    }

    public fun set_beneficiary(arg0: &mut Marketplace, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.beneficiary, 1);
        arg0.beneficiary = arg1;
        let v0 = BeneficiaryChangedEvent{new_addr: arg1};
        0x2::event::emit<BeneficiaryChangedEvent>(v0);
    }

    public fun set_fee_rate(arg0: &mut Marketplace, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.beneficiary, 1);
        arg0.fee_rate = arg1;
        let v0 = FeeChangedEvent{new_rate: arg1};
        0x2::event::emit<FeeChangedEvent>(v0);
    }

    public fun update_listing_price(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Listing>(&mut arg0.store.id, arg1);
        assert!(0x2::tx_context::sender(arg3) == v0.owner, 1);
        v0.ask = arg2;
        v0.fee = arg2 * arg0.fee_rate / 1000;
        v0.total = arg2 + v0.fee;
        let v1 = PriceChangedEvent{
            seller    : 0x2::tx_context::sender(arg3),
            nft_id    : arg1,
            old_price : v0.ask,
            new_price : arg2,
        };
        0x2::event::emit<PriceChangedEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

