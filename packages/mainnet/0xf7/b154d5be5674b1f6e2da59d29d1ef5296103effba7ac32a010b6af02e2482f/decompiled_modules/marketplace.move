module 0xf7b154d5be5674b1f6e2da59d29d1ef5296103effba7ac32a010b6af02e2482f::marketplace {
    struct MARKETPLACE has drop {
        dummy_field: bool,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
        fee: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        admin: address,
    }

    struct RoyaltyFee has store, key {
        id: 0x2::object::UID,
        creator: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        fee: u64,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        ask: u64,
        owner: address,
    }

    struct ListEvent has copy, drop {
        item_id: 0x2::object::ID,
        ask: u64,
        seller: address,
    }

    struct DeListEvent has copy, drop {
        item_id: 0x2::object::ID,
        ask: u64,
        seller: address,
    }

    struct BuyEvent has copy, drop {
        item_id: 0x2::object::ID,
        ask: u64,
        seller: address,
        buyer: address,
    }

    struct EditEvent has copy, drop {
        item_id: 0x2::object::ID,
        old_ask: u64,
        ask: u64,
        seller: address,
    }

    public entry fun add_royalty_fee<T0>(arg0: &mut Marketplace, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 1);
        let v0 = RoyaltyFee{
            id      : 0x2::object::new(arg3),
            creator : arg1,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            fee     : arg2,
        };
        0x2::dynamic_object_field::add<0x1::string::String, RoyaltyFee>(&mut arg0.id, get_type_string<T0>(), v0);
    }

    public fun buy<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : T0 {
        let Listing {
            id    : v0,
            ask   : v1,
            owner : v2,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        let v3 = v0;
        assert!(v1 == 0x2::coin::value<0x2::sui::SUI>(&arg2), 0);
        pay<T0>(arg0, arg2, v2, arg3);
        0x2::object::delete(v3);
        let v4 = BuyEvent{
            item_id : arg1,
            ask     : v1,
            seller  : v2,
            buyer   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<BuyEvent>(v4);
        0x2::dynamic_object_field::remove<bool, T0>(&mut v3, true)
    }

    public entry fun buy_and_take<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = buy<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun delist<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : T0 {
        let Listing {
            id    : v0,
            ask   : v1,
            owner : v2,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        let v3 = v0;
        assert!(0x2::tx_context::sender(arg2) == v2, 1);
        0x2::object::delete(v3);
        let v4 = DeListEvent{
            item_id : arg1,
            ask     : v1,
            seller  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<DeListEvent>(v4);
        0x2::dynamic_object_field::remove<bool, T0>(&mut v3, true)
    }

    public entry fun delist_and_take<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(delist<T0>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun edit<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        assert!(v1.owner == v0, 1);
        let v2 = EditEvent{
            item_id : arg1,
            old_ask : v1.ask,
            ask     : arg2,
            seller  : v0,
        };
        0x2::event::emit<EditEvent>(v2);
        v1.ask = arg2;
    }

    public fun get_type_string<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    fun init(arg0: MARKETPLACE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<MARKETPLACE>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = Marketplace{
            id      : 0x2::object::new(arg1),
            fee     : 200,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            admin   : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<Marketplace>(v0);
    }

    public entry fun list<T0: store + key>(arg0: &mut Marketplace, arg1: T0, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<T0>(&arg1);
        let v1 = Listing{
            id    : 0x2::object::new(arg3),
            ask   : arg2,
            owner : 0x2::tx_context::sender(arg3),
        };
        0x2::dynamic_object_field::add<bool, T0>(&mut v1.id, true, arg1);
        0x2::dynamic_object_field::add<0x2::object::ID, Listing>(&mut arg0.id, v0, v1);
        let v2 = ListEvent{
            item_id : v0,
            ask     : arg2,
            seller  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ListEvent>(v2);
    }

    public entry fun pay<T0>(arg0: &mut Marketplace, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v0 * arg0.fee / 10000, arg3)));
        let v1 = get_type_string<T0>();
        if (0x2::dynamic_object_field::exists_with_type<0x1::string::String, RoyaltyFee>(&mut arg0.id, v1)) {
            let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, RoyaltyFee>(&mut arg0.id, v1);
            0x2::balance::join<0x2::sui::SUI>(&mut v2.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v0 * v2.fee / 10000, arg3)));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg2);
    }

    public entry fun take_profits(arg0: &mut Marketplace, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.admin == v0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance)), arg1), v0);
    }

    public entry fun take_royalty_fee<T0>(arg0: &mut Marketplace, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, RoyaltyFee>(&mut arg0.id, get_type_string<T0>());
        assert!(v0 == v1.creator || v0 == arg0.admin, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1.balance, 0x2::balance::value<0x2::sui::SUI>(&v1.balance)), arg1), v0);
    }

    public entry fun update_fee(arg0: &mut Marketplace, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        arg0.fee = arg1;
    }

    // decompiled from Move bytecode v6
}

