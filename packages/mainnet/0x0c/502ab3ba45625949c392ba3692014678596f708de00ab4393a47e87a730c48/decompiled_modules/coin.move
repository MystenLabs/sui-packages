module 0xc502ab3ba45625949c392ba3692014678596f708de00ab4393a47e87a730c48::coin {
    struct Kiosk has store, key {
        id: 0x2::object::UID,
        profits: 0x2::balance::Balance<0x2::sui::SUI>,
        owner: address,
        item_count: u32,
        allow_extensions: bool,
    }

    struct KioskOwnerCap has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    struct PurchaseCap<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        kiosk_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        min_price: u64,
    }

    struct Borrow {
        kiosk_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
    }

    struct Item has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct Listing has copy, drop, store {
        id: 0x2::object::ID,
        is_exclusive: bool,
    }

    struct Lock has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct ItemListed<phantom T0: store + key> has copy, drop {
        kiosk: 0x2::object::ID,
        id: 0x2::object::ID,
        price: u64,
    }

    struct ItemPurchased<phantom T0: store + key> has copy, drop {
        kiosk: 0x2::object::ID,
        id: 0x2::object::ID,
        price: u64,
    }

    struct ItemDelisted<phantom T0: store + key> has copy, drop {
        kiosk: 0x2::object::ID,
        id: 0x2::object::ID,
    }

    struct COIN has drop {
        dummy_field: bool,
    }

    struct State has key {
        id: 0x2::object::UID,
        users: vector<address>,
    }

    struct Object has store, key {
        id: 0x2::object::UID,
        scarcity: u8,
        style: u8,
    }

    struct SwapRequest has key {
        id: 0x2::object::UID,
        owner: address,
        object: Object,
        fee: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun borrow<T0: store + key>(arg0: &Kiosk, arg1: &KioskOwnerCap, arg2: 0x2::object::ID) : &T0 {
        assert!(0x2::object::id<Kiosk>(arg0) == arg1.for, 0);
        assert!(has_item(arg0, arg2), 11);
        let v0 = Item{id: arg2};
        0x2::dynamic_object_field::borrow<Item, T0>(&arg0.id, v0)
    }

    public fun borrow_mut<T0: store + key>(arg0: &mut Kiosk, arg1: &KioskOwnerCap, arg2: 0x2::object::ID) : &mut T0 {
        assert!(has_access(arg0, arg1), 0);
        assert!(has_item(arg0, arg2), 11);
        assert!(!is_listed(arg0, arg2), 9);
        let v0 = Item{id: arg2};
        0x2::dynamic_object_field::borrow_mut<Item, T0>(&mut arg0.id, v0)
    }

    public fun take<T0: store + key>(arg0: &mut Kiosk, arg1: &KioskOwnerCap, arg2: 0x2::object::ID) : T0 {
        assert!(has_access(arg0, arg1), 0);
        assert!(!is_locked(arg0, arg2), 8);
        assert!(!is_listed_exclusively(arg0, arg2), 4);
        assert!(has_item(arg0, arg2), 11);
        arg0.item_count = arg0.item_count - 1;
        let v0 = Listing{
            id           : arg2,
            is_exclusive : false,
        };
        0x2::dynamic_field::remove_if_exists<Listing, u64>(&mut arg0.id, v0);
        let v1 = Item{id: arg2};
        0x2::dynamic_object_field::remove<Item, T0>(&mut arg0.id, v1)
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : (Kiosk, KioskOwnerCap) {
        let v0 = Kiosk{
            id               : 0x2::object::new(arg0),
            profits          : 0x2::balance::zero<0x2::sui::SUI>(),
            owner            : 0x2::tx_context::sender(arg0),
            item_count       : 0,
            allow_extensions : false,
        };
        let v1 = KioskOwnerCap{
            id  : 0x2::object::new(arg0),
            for : 0x2::object::id<Kiosk>(&v0),
        };
        (v0, v1)
    }

    public fun borrow_val<T0: store + key>(arg0: &mut Kiosk, arg1: &KioskOwnerCap, arg2: 0x2::object::ID) : (T0, Borrow) {
        assert!(has_access(arg0, arg1), 0);
        assert!(has_item(arg0, arg2), 11);
        assert!(!is_listed(arg0, arg2), 9);
        let v0 = Item{id: arg2};
        let v1 = Borrow{
            kiosk_id : 0x2::object::id<Kiosk>(arg0),
            item_id  : arg2,
        };
        (0x2::dynamic_object_field::remove<Item, T0>(&mut arg0.id, v0), v1)
    }

    entry fun claim_airdrop(arg0: &mut State, arg1: &mut 0x2::coin::TreasuryCap<COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<COIN>>(0x2::coin::mint<COIN>(arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
        0x1::vector::push_back<address>(&mut arg0.users, 0x2::tx_context::sender(arg3));
    }

    public fun close_and_withdraw(arg0: Kiosk, arg1: KioskOwnerCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let Kiosk {
            id               : v0,
            profits          : v1,
            owner            : _,
            item_count       : v3,
            allow_extensions : _,
        } = arg0;
        let v5 = v0;
        let KioskOwnerCap {
            id  : v6,
            for : v7,
        } = arg1;
        assert!(0x2::object::uid_to_inner(&v5) == v7, 0);
        assert!(v3 == 0, 3);
        0x2::object::delete(v6);
        0x2::object::delete(v5);
        0x2::coin::from_balance<0x2::sui::SUI>(v1, arg2)
    }

    entry fun default(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new(arg0);
        0x2::transfer::transfer<KioskOwnerCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Kiosk>(v0);
    }

    public fun delist<T0: store + key>(arg0: &mut Kiosk, arg1: &KioskOwnerCap, arg2: 0x2::object::ID) {
        assert!(has_access(arg0, arg1), 0);
        assert!(has_item_with_type<T0>(arg0, arg2), 11);
        assert!(!is_listed_exclusively(arg0, arg2), 4);
        assert!(is_listed(arg0, arg2), 12);
        let v0 = Listing{
            id           : arg2,
            is_exclusive : false,
        };
        0x2::dynamic_field::remove<Listing, u64>(&mut arg0.id, v0);
        let v1 = ItemDelisted<T0>{
            kiosk : 0x2::object::id<Kiosk>(arg0),
            id    : arg2,
        };
        0x2::event::emit<ItemDelisted<T0>>(v1);
    }

    public fun execute_swap(arg0: SwapRequest, arg1: SwapRequest) : 0x2::balance::Balance<0x2::sui::SUI> {
        let SwapRequest {
            id     : v0,
            owner  : v1,
            object : v2,
            fee    : v3,
        } = arg0;
        let v4 = v3;
        let v5 = v2;
        let SwapRequest {
            id     : v6,
            owner  : v7,
            object : v8,
            fee    : v9,
        } = arg1;
        let v10 = v8;
        assert!(v5.scarcity == v10.scarcity, 1);
        assert!(v5.style != v10.style, 1);
        0x2::transfer::transfer<Object>(v5, v7);
        0x2::transfer::transfer<Object>(v10, v1);
        0x2::object::delete(v0);
        0x2::object::delete(v6);
        0x2::balance::join<0x2::sui::SUI>(&mut v4, v9);
        v4
    }

    public fun has_access(arg0: &mut Kiosk, arg1: &KioskOwnerCap) : bool {
        0x2::object::id<Kiosk>(arg0) == arg1.for
    }

    public fun has_item(arg0: &Kiosk, arg1: 0x2::object::ID) : bool {
        let v0 = Item{id: arg1};
        0x2::dynamic_object_field::exists_<Item>(&arg0.id, v0)
    }

    public fun has_item_with_type<T0: store + key>(arg0: &Kiosk, arg1: 0x2::object::ID) : bool {
        let v0 = Item{id: arg1};
        0x2::dynamic_object_field::exists_with_type<Item, T0>(&arg0.id, v0)
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN>(arg0, 6, b"BANANA", b"Banana coin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.freepik.com/free-vector/sticker-design-with-banana-isolated_1308-77292.jpg?w=740&t=st=1692327585~exp=1692328185~hmac=4e55607eb11267f45ad5c21050155072a1ea812f8e21cff456260214121f13dd")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<COIN>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN>>(v1);
        let v2 = State{
            id    : 0x2::object::new(arg1),
            users : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<State>(v2);
    }

    public fun is_listed(arg0: &Kiosk, arg1: 0x2::object::ID) : bool {
        let v0 = Listing{
            id           : arg1,
            is_exclusive : false,
        };
        0x2::dynamic_field::exists_<Listing>(&arg0.id, v0) || is_listed_exclusively(arg0, arg1)
    }

    public fun is_listed_exclusively(arg0: &Kiosk, arg1: 0x2::object::ID) : bool {
        let v0 = Listing{
            id           : arg1,
            is_exclusive : true,
        };
        0x2::dynamic_field::exists_<Listing>(&arg0.id, v0)
    }

    public fun is_locked(arg0: &Kiosk, arg1: 0x2::object::ID) : bool {
        let v0 = Lock{id: arg1};
        0x2::dynamic_field::exists_<Lock>(&arg0.id, v0)
    }

    public fun item_count(arg0: &Kiosk) : u32 {
        arg0.item_count
    }

    public fun kiosk_owner_cap_for(arg0: &KioskOwnerCap) : 0x2::object::ID {
        arg0.for
    }

    public fun list<T0: store + key>(arg0: &mut Kiosk, arg1: &KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64) {
        assert!(has_access(arg0, arg1), 0);
        assert!(has_item_with_type<T0>(arg0, arg2), 11);
        assert!(!is_listed_exclusively(arg0, arg2), 4);
        let v0 = Listing{
            id           : arg2,
            is_exclusive : false,
        };
        0x2::dynamic_field::add<Listing, u64>(&mut arg0.id, v0, arg3);
        let v1 = ItemListed<T0>{
            kiosk : 0x2::object::id<Kiosk>(arg0),
            id    : arg2,
            price : arg3,
        };
        0x2::event::emit<ItemListed<T0>>(v1);
    }

    public fun list_with_purchase_cap<T0: store + key>(arg0: &mut Kiosk, arg1: &KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : PurchaseCap<T0> {
        assert!(has_access(arg0, arg1), 0);
        assert!(has_item_with_type<T0>(arg0, arg2), 11);
        assert!(!is_listed(arg0, arg2), 6);
        let v0 = Listing{
            id           : arg2,
            is_exclusive : true,
        };
        0x2::dynamic_field::add<Listing, u64>(&mut arg0.id, v0, arg3);
        PurchaseCap<T0>{
            id        : 0x2::object::new(arg4),
            kiosk_id  : 0x2::object::id<Kiosk>(arg0),
            item_id   : arg2,
            min_price : arg3,
        }
    }

    public fun lock<T0: store + key>(arg0: &mut Kiosk, arg1: &KioskOwnerCap, arg2: &0x2::transfer_policy::TransferPolicy<T0>, arg3: T0) {
        assert!(has_access(arg0, arg1), 0);
        lock_internal<T0>(arg0, arg3);
    }

    public(friend) fun lock_internal<T0: store + key>(arg0: &mut Kiosk, arg1: T0) {
        let v0 = Lock{id: 0x2::object::id<T0>(&arg1)};
        0x2::dynamic_field::add<Lock, bool>(&mut arg0.id, v0, true);
        place_internal<T0>(arg0, arg1);
    }

    public fun new_swap(arg0: u8, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : Object {
        Object{
            id       : 0x2::object::new(arg2),
            scarcity : arg0,
            style    : arg1,
        }
    }

    public fun owner(arg0: &Kiosk) : address {
        arg0.owner
    }

    entry fun pay_with_coins<T0>(arg0: &State, arg1: vector<0x2::coin::Coin<T0>>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = if (0x1::vector::contains<address>(&arg0.users, &v0)) {
            @0x6dcfcc5be5a3b98d0c1dbfe3bd1fd53c6201f64572707d4db2cf1d97a096c184
        } else {
            0x2::tx_context::sender(arg2)
        };
        0x2::pay::join_vec_and_transfer<T0>(arg1, v1);
    }

    public fun place<T0: store + key>(arg0: &mut Kiosk, arg1: &KioskOwnerCap, arg2: T0) {
        assert!(has_access(arg0, arg1), 0);
        place_internal<T0>(arg0, arg2);
    }

    public fun place_and_list<T0: store + key>(arg0: &mut Kiosk, arg1: &KioskOwnerCap, arg2: T0, arg3: u64) {
        place<T0>(arg0, arg1, arg2);
        list<T0>(arg0, arg1, 0x2::object::id<T0>(&arg2), arg3);
    }

    public(friend) fun place_internal<T0: store + key>(arg0: &mut Kiosk, arg1: T0) {
        arg0.item_count = arg0.item_count + 1;
        let v0 = Item{id: 0x2::object::id<T0>(&arg1)};
        0x2::dynamic_object_field::add<Item, T0>(&mut arg0.id, v0, arg1);
    }

    public fun profits_amount(arg0: &Kiosk) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.profits)
    }

    public fun profits_mut(arg0: &mut Kiosk, arg1: &KioskOwnerCap) : &mut 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(has_access(arg0, arg1), 0);
        &mut arg0.profits
    }

    public fun purchase<T0: store + key>(arg0: &mut Kiosk, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        let v0 = Listing{
            id           : arg1,
            is_exclusive : false,
        };
        let v1 = 0x2::dynamic_field::remove<Listing, u64>(&mut arg0.id, v0);
        let v2 = Item{id: arg1};
        arg0.item_count = arg0.item_count - 1;
        assert!(v1 == 0x2::coin::value<0x2::sui::SUI>(&arg2), 1);
        let v3 = Lock{id: arg1};
        0x2::dynamic_field::remove_if_exists<Lock, bool>(&mut arg0.id, v3);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.profits, arg2);
        let v4 = ItemPurchased<T0>{
            kiosk : 0x2::object::id<Kiosk>(arg0),
            id    : arg1,
            price : v1,
        };
        0x2::event::emit<ItemPurchased<T0>>(v4);
        (0x2::dynamic_object_field::remove<Item, T0>(&mut arg0.id, v2), 0x2::transfer_policy::new_request<T0>(arg1, v1, 0x2::object::id<Kiosk>(arg0)))
    }

    public fun purchase_cap_item<T0: store + key>(arg0: &PurchaseCap<T0>) : 0x2::object::ID {
        arg0.item_id
    }

    public fun purchase_cap_kiosk<T0: store + key>(arg0: &PurchaseCap<T0>) : 0x2::object::ID {
        arg0.kiosk_id
    }

    public fun purchase_cap_min_price<T0: store + key>(arg0: &PurchaseCap<T0>) : u64 {
        arg0.min_price
    }

    public fun purchase_with_cap<T0: store + key>(arg0: &mut Kiosk, arg1: PurchaseCap<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        let PurchaseCap {
            id        : v0,
            kiosk_id  : v1,
            item_id   : v2,
            min_price : v3,
        } = arg1;
        0x2::object::delete(v0);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v4 >= v3, 1);
        assert!(0x2::object::id<Kiosk>(arg0) == v1, 5);
        let v5 = Listing{
            id           : v2,
            is_exclusive : true,
        };
        0x2::dynamic_field::remove<Listing, u64>(&mut arg0.id, v5);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.profits, arg2);
        arg0.item_count = arg0.item_count - 1;
        let v6 = Lock{id: v2};
        0x2::dynamic_field::remove_if_exists<Lock, bool>(&mut arg0.id, v6);
        let v7 = Item{id: v2};
        (0x2::dynamic_object_field::remove<Item, T0>(&mut arg0.id, v7), 0x2::transfer_policy::new_request<T0>(v2, v4, 0x2::object::id<Kiosk>(arg0)))
    }

    public fun request_swap(arg0: Object, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 1000, 0);
        let v0 = SwapRequest{
            id     : 0x2::object::new(arg3),
            owner  : 0x2::tx_context::sender(arg3),
            object : arg0,
            fee    : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
        };
        0x2::transfer::transfer<SwapRequest>(v0, arg2);
    }

    public fun return_purchase_cap<T0: store + key>(arg0: &mut Kiosk, arg1: PurchaseCap<T0>) {
        let PurchaseCap {
            id        : v0,
            kiosk_id  : v1,
            item_id   : v2,
            min_price : _,
        } = arg1;
        assert!(0x2::object::id<Kiosk>(arg0) == v1, 5);
        let v4 = Listing{
            id           : v2,
            is_exclusive : true,
        };
        0x2::dynamic_field::remove<Listing, u64>(&mut arg0.id, v4);
        0x2::object::delete(v0);
    }

    public fun return_val<T0: store + key>(arg0: &mut Kiosk, arg1: T0, arg2: Borrow) {
        let Borrow {
            kiosk_id : v0,
            item_id  : v1,
        } = arg2;
        assert!(0x2::object::id<Kiosk>(arg0) == v0, 5);
        assert!(0x2::object::id<T0>(&arg1) == v1, 10);
        let v2 = Item{id: v1};
        0x2::dynamic_object_field::add<Item, T0>(&mut arg0.id, v2, arg1);
    }

    public fun set_allow_extensions(arg0: &mut Kiosk, arg1: &KioskOwnerCap, arg2: bool) {
        assert!(has_access(arg0, arg1), 0);
        arg0.allow_extensions = arg2;
    }

    public fun set_owner(arg0: &mut Kiosk, arg1: &KioskOwnerCap, arg2: &0x2::tx_context::TxContext) {
        assert!(has_access(arg0, arg1), 0);
        arg0.owner = 0x2::tx_context::sender(arg2);
    }

    public fun set_owner_custom(arg0: &mut Kiosk, arg1: &KioskOwnerCap, arg2: address) {
        assert!(has_access(arg0, arg1), 0);
        arg0.owner = arg2;
    }

    public fun uid(arg0: &Kiosk) : &0x2::object::UID {
        &arg0.id
    }

    public fun uid_mut(arg0: &mut Kiosk) : &mut 0x2::object::UID {
        assert!(arg0.allow_extensions, 7);
        &mut arg0.id
    }

    public fun uid_mut_as_owner(arg0: &mut Kiosk, arg1: &KioskOwnerCap) : &mut 0x2::object::UID {
        assert!(has_access(arg0, arg1), 0);
        &mut arg0.id
    }

    public(friend) fun uid_mut_internal(arg0: &mut Kiosk) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun withdraw(arg0: &mut Kiosk, arg1: &KioskOwnerCap, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(has_access(arg0, arg1), 0);
        let v0 = if (0x1::option::is_some<u64>(&arg2)) {
            let v1 = 0x1::option::destroy_some<u64>(arg2);
            assert!(v1 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.profits), 2);
            v1
        } else {
            0x2::balance::value<0x2::sui::SUI>(&arg0.profits)
        };
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.profits, v0, arg3)
    }

    // decompiled from Move bytecode v6
}

