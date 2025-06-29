module 0xb48eb04ffd49ab3f435f5442727b4c3ce1fac5bc0fd122f2dc07dd386c050d83::marketplace {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Marketplace has store, key {
        id: 0x2::object::UID,
        fee_bps: u64,
        fee_dest: address,
        total_vol: u64,
        frozen: bool,
        minted: u64,
        listings: vector<Card>,
        listed: u64,
    }

    struct Card has store, key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        cyberpunk_type: 0x1::string::String,
        price: u64,
        for_sale: bool,
        minted_at: u64,
    }

    struct MarketplaceCreated has copy, drop {
        market_id: 0x2::object::ID,
        admin: address,
        fee_bps: u64,
    }

    struct CardCreated has copy, drop {
        card_id: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
        cyberpunk_type: 0x1::string::String,
        minted_at: u64,
    }

    struct CardListed has copy, drop {
        card_id: 0x2::object::ID,
        seller: address,
        price: u64,
        cyberpunk_type: 0x1::string::String,
    }

    struct CardPurchased has copy, drop {
        card_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
        fee: u64,
        cyberpunk_type: 0x1::string::String,
    }

    public entry fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut Marketplace, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.minted < 1025, 4);
        assert!(0x1::string::length(&arg0) <= 64, 5);
        assert!(0x1::string::length(&arg1) <= 32, 5);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::tx_context::epoch(arg3);
        let v2 = Card{
            id             : 0x2::object::new(arg3),
            owner          : v0,
            name           : arg0,
            cyberpunk_type : arg1,
            price          : 0,
            for_sale       : false,
            minted_at      : v1,
        };
        arg2.minted = arg2.minted + 1;
        let v3 = CardCreated{
            card_id        : 0x2::object::id<Card>(&v2),
            owner          : v0,
            name           : v2.name,
            cyberpunk_type : v2.cyberpunk_type,
            minted_at      : v1,
        };
        0x2::event::emit<CardCreated>(v3);
        0x2::transfer::transfer<Card>(v2, v0);
    }

    public entry fun buy_card(arg0: 0x2::object::ID, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut Marketplace, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.frozen, 3);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = remove_listing(arg2, arg0);
        assert!(v1.for_sale, 1);
        let v2 = v1.price;
        let v3 = v1.owner;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v2, 0);
        let v4 = v2 * arg2.fee_bps / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v4, arg3), arg2.fee_dest);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v3);
        arg2.total_vol = arg2.total_vol + v2;
        let v5 = CardPurchased{
            card_id        : arg0,
            seller         : v3,
            buyer          : v0,
            price          : v2,
            fee            : v4,
            cyberpunk_type : v1.cyberpunk_type,
        };
        0x2::event::emit<CardPurchased>(v5);
        v1.owner = v0;
        v1.for_sale = false;
        v1.price = 0;
        0x2::transfer::public_transfer<Card>(v1, v0);
    }

    public entry fun delist_card(arg0: 0x2::object::ID, arg1: &mut Marketplace, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.frozen, 3);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = remove_listing(arg1, arg0);
        assert!(v1.owner == v0, 2);
        v1.for_sale = false;
        v1.price = 0;
        0x2::transfer::public_transfer<Card>(v1, v0);
    }

    public fun get_listings(arg0: &Marketplace) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Card>(&arg0.listings)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::id<Card>(0x1::vector::borrow<Card>(&arg0.listings, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Marketplace{
            id        : 0x2::object::new(arg0),
            fee_bps   : 250,
            fee_dest  : 0x2::tx_context::sender(arg0),
            total_vol : 0,
            frozen    : false,
            minted    : 0,
            listings  : 0x1::vector::empty<Card>(),
            listed    : 0,
        };
        let v2 = MarketplaceCreated{
            market_id : 0x2::object::id<Marketplace>(&v1),
            admin     : 0x2::tx_context::sender(arg0),
            fee_bps   : 250,
        };
        0x2::event::emit<MarketplaceCreated>(v2);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_share_object<Marketplace>(v1);
    }

    public entry fun list_card(arg0: Card, arg1: u64, arg2: &mut Marketplace, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.frozen, 3);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.owner == v0, 2);
        arg0.price = arg1;
        arg0.for_sale = true;
        0x1::vector::push_back<Card>(&mut arg2.listings, arg0);
        arg2.listed = arg2.listed + 1;
        let v1 = CardListed{
            card_id        : 0x2::object::id<Card>(&arg0),
            seller         : v0,
            price          : arg1,
            cyberpunk_type : arg0.cyberpunk_type,
        };
        0x2::event::emit<CardListed>(v1);
    }

    fun remove_listing(arg0: &mut Marketplace, arg1: 0x2::object::ID) : Card {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Card>(&arg0.listings)) {
            if (0x2::object::id<Card>(0x1::vector::borrow<Card>(&arg0.listings, v0)) == arg1) {
                arg0.listed = arg0.listed - 1;
                return 0x1::vector::swap_remove<Card>(&mut arg0.listings, v0)
            };
            v0 = v0 + 1;
        };
        abort 1
    }

    public entry fun toggle_freeze(arg0: &AdminCap, arg1: &mut Marketplace) {
        arg1.frozen = !arg1.frozen;
    }

    public entry fun update_fee(arg0: &AdminCap, arg1: &mut Marketplace, arg2: u64, arg3: address) {
        assert!(arg2 <= 1000, 5);
        arg1.fee_bps = arg2;
        arg1.fee_dest = arg3;
    }

    // decompiled from Move bytecode v6
}

