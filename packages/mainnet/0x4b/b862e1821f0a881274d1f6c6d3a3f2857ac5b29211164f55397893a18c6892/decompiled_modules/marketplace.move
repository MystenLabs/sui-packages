module 0x4bb862e1821f0a881274d1f6c6d3a3f2857ac5b29211164f55397893a18c6892::marketplace {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
        next_id: u64,
        fee_bps: u64,
        fee_recipient: address,
        paused: bool,
    }

    struct ModelKey has copy, drop, store {
        id: u64,
    }

    struct Model has drop, store {
        owner: address,
        creator: address,
        name: 0x1::string::String,
        uri: 0x1::string::String,
        price: u64,
        royalty_bps: u64,
        listed: bool,
    }

    struct MarketCreated has copy, drop, store {
        fee_bps: u64,
        fee_recipient: address,
    }

    struct ModelListed has copy, drop, store {
        id: u64,
        owner: address,
        price: u64,
    }

    struct ModelUpdated has copy, drop, store {
        id: u64,
        owner: address,
        price: u64,
        listed: bool,
    }

    struct ModelUnlisted has copy, drop, store {
        id: u64,
        owner: address,
    }

    struct ModelSold has copy, drop, store {
        id: u64,
        price: u64,
        buyer: address,
        seller: address,
        fee_paid: u64,
        royalty_paid: u64,
    }

    struct MarketPaused has copy, drop, store {
        paused: bool,
    }

    struct MarketFeesSet has copy, drop, store {
        fee_bps: u64,
        fee_recipient: address,
    }

    fun borrow_model_mut(arg0: &mut Marketplace, arg1: u64) : &mut Model {
        let v0 = ModelKey{id: arg1};
        0x2::dynamic_field::borrow_mut<ModelKey, Model>(&mut arg0.id, v0)
    }

    public fun buy(arg0: &mut Marketplace, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        ensure_not_paused(arg0);
        let v0 = arg0.fee_bps;
        let v1 = arg0.fee_recipient;
        let v2 = borrow_model_mut(arg0, arg1);
        assert!(v2.listed, 110);
        ensure_fee_plus_royalty_ok(v0, v2.royalty_bps);
        let v3 = v2.price;
        let v4 = 0x2::tx_context::sender(arg3);
        let v5 = v2.owner;
        assert!(v4 != v5, 103);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == v3, 111);
        let v6 = v3 * v0 / 10000;
        let v7 = v3 * v2.royalty_bps / 10000;
        let v8 = &mut arg2;
        split_and_transfer_or_destroy(v8, v6, v1, arg3);
        let v9 = &mut arg2;
        split_and_transfer_or_destroy(v9, v7, v2.creator, arg3);
        let v10 = &mut arg2;
        split_and_transfer_or_destroy(v10, v3 - v6 - v7, v5, arg3);
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        v2.owner = v4;
        v2.listed = false;
        let v11 = ModelSold{
            id           : arg1,
            price        : v3,
            buyer        : v4,
            seller       : v5,
            fee_paid     : v6,
            royalty_paid : v7,
        };
        0x2::event::emit<ModelSold>(v11);
    }

    public fun create(arg0: u64, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        ensure_valid_bps(arg0);
        ensure_fee_under_cap(arg0);
        ensure_addr_nonzero(arg1);
        let v0 = Marketplace{
            id            : 0x2::object::new(arg2),
            next_id       : 0,
            fee_bps       : arg0,
            fee_recipient : arg1,
            paused        : false,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg2)};
        let v2 = MarketCreated{
            fee_bps       : arg0,
            fee_recipient : arg1,
        };
        0x2::event::emit<MarketCreated>(v2);
        0x2::transfer::share_object<Marketplace>(v0);
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg2));
    }

    fun ensure_addr_nonzero(arg0: address) {
        assert!(arg0 != @0x0, 116);
    }

    fun ensure_fee_plus_royalty_ok(arg0: u64, arg1: u64) {
        assert!(arg0 + arg1 <= 10000, 112);
    }

    fun ensure_fee_under_cap(arg0: u64) {
        assert!(arg0 <= 2000, 115);
    }

    fun ensure_not_paused(arg0: &Marketplace) {
        assert!(!arg0.paused, 114);
    }

    fun ensure_valid_bps(arg0: u64) {
        assert!(arg0 <= 10000, 101);
    }

    public fun list(arg0: &mut Marketplace, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        ensure_not_paused(arg0);
        assert!(arg3 > 0, 100);
        ensure_valid_bps(arg4);
        ensure_fee_plus_royalty_ok(arg0.fee_bps, arg4);
        let v0 = arg0.next_id;
        arg0.next_id = v0 + 1;
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = Model{
            owner       : v1,
            creator     : v1,
            name        : arg1,
            uri         : arg2,
            price       : arg3,
            royalty_bps : arg4,
            listed      : true,
        };
        let v3 = ModelKey{id: v0};
        0x2::dynamic_field::add<ModelKey, Model>(&mut arg0.id, v3, v2);
        let v4 = ModelListed{
            id    : v0,
            owner : v1,
            price : arg3,
        };
        0x2::event::emit<ModelListed>(v4);
    }

    public fun set_fees(arg0: &mut Marketplace, arg1: &AdminCap, arg2: u64, arg3: address) {
        ensure_not_paused(arg0);
        ensure_valid_bps(arg2);
        ensure_fee_under_cap(arg2);
        ensure_addr_nonzero(arg3);
        arg0.fee_bps = arg2;
        arg0.fee_recipient = arg3;
        let v0 = MarketFeesSet{
            fee_bps       : arg2,
            fee_recipient : arg3,
        };
        0x2::event::emit<MarketFeesSet>(v0);
    }

    public fun set_listed(arg0: &mut Marketplace, arg1: u64, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        ensure_not_paused(arg0);
        let v0 = borrow_model_mut(arg0, arg1);
        assert!(v0.owner == 0x2::tx_context::sender(arg3), 103);
        v0.listed = arg2;
        let v1 = ModelUpdated{
            id     : arg1,
            owner  : v0.owner,
            price  : v0.price,
            listed : arg2,
        };
        0x2::event::emit<ModelUpdated>(v1);
    }

    public fun set_paused(arg0: &mut Marketplace, arg1: &AdminCap, arg2: bool) {
        arg0.paused = arg2;
        let v0 = MarketPaused{paused: arg2};
        0x2::event::emit<MarketPaused>(v0);
    }

    public fun set_price(arg0: &mut Marketplace, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        ensure_not_paused(arg0);
        assert!(arg2 > 0, 102);
        let v0 = borrow_model_mut(arg0, arg1);
        assert!(v0.owner == 0x2::tx_context::sender(arg3), 103);
        v0.price = arg2;
        let v1 = ModelUpdated{
            id     : arg1,
            owner  : v0.owner,
            price  : arg2,
            listed : v0.listed,
        };
        0x2::event::emit<ModelUpdated>(v1);
    }

    fun split_and_transfer_or_destroy(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg0, arg1, arg3), arg2);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(0x2::coin::zero<0x2::sui::SUI>(arg3));
        };
    }

    public fun unlist(arg0: &mut Marketplace, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_model_mut(arg0, arg1);
        assert!(v0.owner == 0x2::tx_context::sender(arg2), 103);
        let v1 = ModelKey{id: arg1};
        let v2 = 0x2::dynamic_field::remove<ModelKey, Model>(&mut arg0.id, v1);
        let v3 = ModelUnlisted{
            id    : arg1,
            owner : v2.owner,
        };
        0x2::event::emit<ModelUnlisted>(v3);
        let Model {
            owner       : _,
            creator     : _,
            name        : _,
            uri         : _,
            price       : _,
            royalty_bps : _,
            listed      : _,
        } = v2;
    }

    // decompiled from Move bytecode v6
}

