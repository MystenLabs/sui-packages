module 0x2b8c5e6172064f331743de25aef77b8026fb6e5d7a4d4e66e3f083463c44c460::marketplace {
    struct Market has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct Locked<T0: store + key> has store, key {
        id: 0x2::object::UID,
        locked_item: T0,
    }

    struct Key<T0: store + key> has store, key {
        id: 0x2::object::UID,
        locked_id: 0x2::object::ID,
    }

    struct ListingKey has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct Listing<phantom T0> has store, key {
        id: 0x2::object::UID,
        seller: address,
        price: u64,
        car_id: 0x2::object::ID,
        locked_car: Locked<0x2b8c5e6172064f331743de25aef77b8026fb6e5d7a4d4e66e3f083463c44c460::cars::Car<T0>>,
        key: Key<0x2b8c5e6172064f331743de25aef77b8026fb6e5d7a4d4e66e3f083463c44c460::cars::Car<T0>>,
    }

    struct ListingCreated<phantom T0> has copy, drop {
        listing_id: 0x2::object::ID,
        car_id: 0x2::object::ID,
        seller: address,
        price: u64,
    }

    struct ListingSold<phantom T0> has copy, drop {
        listing_id: 0x2::object::ID,
        car_id: 0x2::object::ID,
        buyer: address,
        price: u64,
    }

    struct ListingCancelled<phantom T0> has copy, drop {
        listing_id: 0x2::object::ID,
        car_id: 0x2::object::ID,
        seller: address,
    }

    public fun buy<T0>(arg0: &mut Market, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ListingKey{id: arg1};
        let v1 = 0x2::dynamic_object_field::remove<ListingKey, Listing<T0>>(&mut arg0.id, v0);
        let Listing {
            id         : v2,
            seller     : v3,
            price      : v4,
            car_id     : v5,
            locked_car : v6,
            key        : v7,
        } = v1;
        0x2::object::delete(v2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == v4, 13906835020452331527);
        0x2::transfer::public_transfer<0x2b8c5e6172064f331743de25aef77b8026fb6e5d7a4d4e66e3f083463c44c460::cars::Car<T0>>(unlock<0x2b8c5e6172064f331743de25aef77b8026fb6e5d7a4d4e66e3f083463c44c460::cars::Car<T0>>(v6, v7), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v3);
        let v8 = ListingSold<T0>{
            listing_id : 0x2::object::id<Listing<T0>>(&v1),
            car_id     : v5,
            buyer      : 0x2::tx_context::sender(arg3),
            price      : v4,
        };
        0x2::event::emit<ListingSold<T0>>(v8);
    }

    public fun delist<T0>(arg0: &mut Market, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ListingKey{id: arg1};
        let v1 = 0x2::dynamic_object_field::remove<ListingKey, Listing<T0>>(&mut arg0.id, v0);
        let Listing {
            id         : v2,
            seller     : v3,
            price      : _,
            car_id     : v5,
            locked_car : v6,
            key        : v7,
        } = v1;
        0x2::object::delete(v2);
        assert!(v3 == 0x2::tx_context::sender(arg2), 13906834921667952645);
        0x2::transfer::public_transfer<0x2b8c5e6172064f331743de25aef77b8026fb6e5d7a4d4e66e3f083463c44c460::cars::Car<T0>>(unlock<0x2b8c5e6172064f331743de25aef77b8026fb6e5d7a4d4e66e3f083463c44c460::cars::Car<T0>>(v6, v7), v3);
        let v8 = ListingCancelled<T0>{
            listing_id : 0x2::object::id<Listing<T0>>(&v1),
            car_id     : v5,
            seller     : v3,
        };
        0x2::event::emit<ListingCancelled<T0>>(v8);
    }

    public entry fun init_market(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<Market>(new_market(arg0));
    }

    public fun list<T0>(arg0: &mut Market, arg1: 0x2b8c5e6172064f331743de25aef77b8026fb6e5d7a4d4e66e3f083463c44c460::cars::Car<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 13906834754163965953);
        let v0 = 0x2::object::id<0x2b8c5e6172064f331743de25aef77b8026fb6e5d7a4d4e66e3f083463c44c460::cars::Car<T0>>(&arg1);
        let v1 = ListingKey{id: v0};
        assert!(!0x2::dynamic_object_field::exists_with_type<ListingKey, Listing<T0>>(&arg0.id, v1), 13906834771343966211);
        let (v2, v3) = lock<0x2b8c5e6172064f331743de25aef77b8026fb6e5d7a4d4e66e3f083463c44c460::cars::Car<T0>>(arg1, arg3);
        let v4 = 0x2::tx_context::sender(arg3);
        let v5 = Listing<T0>{
            id         : 0x2::object::new(arg3),
            seller     : v4,
            price      : arg2,
            car_id     : v0,
            locked_car : v2,
            key        : v3,
        };
        let v6 = ListingKey{id: v0};
        0x2::dynamic_object_field::add<ListingKey, Listing<T0>>(&mut arg0.id, v6, v5);
        let v7 = ListingCreated<T0>{
            listing_id : 0x2::object::id<Listing<T0>>(&v5),
            car_id     : v0,
            seller     : v4,
            price      : arg2,
        };
        0x2::event::emit<ListingCreated<T0>>(v7);
    }

    public fun listing_exists<T0>(arg0: &Market, arg1: 0x2::object::ID) : bool {
        let v0 = ListingKey{id: arg1};
        0x2::dynamic_object_field::exists_with_type<ListingKey, Listing<T0>>(&arg0.id, v0)
    }

    public fun listing_price<T0>(arg0: &Market, arg1: 0x2::object::ID) : u64 {
        let v0 = ListingKey{id: arg1};
        0x2::dynamic_object_field::borrow<ListingKey, Listing<T0>>(&arg0.id, v0).price
    }

    public fun listing_seller<T0>(arg0: &Market, arg1: 0x2::object::ID) : address {
        let v0 = ListingKey{id: arg1};
        0x2::dynamic_object_field::borrow<ListingKey, Listing<T0>>(&arg0.id, v0).seller
    }

    public fun lock<T0: store + key>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : (Locked<T0>, Key<T0>) {
        let v0 = Locked<T0>{
            id          : 0x2::object::new(arg1),
            locked_item : arg0,
        };
        let v1 = Key<T0>{
            id        : 0x2::object::new(arg1),
            locked_id : 0x2::object::id<Locked<T0>>(&v0),
        };
        (v0, v1)
    }

    public fun new_market(arg0: &mut 0x2::tx_context::TxContext) : Market {
        Market{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
        }
    }

    public fun owner(arg0: &Market) : address {
        arg0.owner
    }

    public fun unlock<T0: store + key>(arg0: Locked<T0>, arg1: Key<T0>) : T0 {
        let Key {
            id        : v0,
            locked_id : v1,
        } = arg1;
        assert!(0x2::object::id<Locked<T0>>(&arg0) == v1, 13906834612430569481);
        0x2::object::delete(v0);
        let Locked {
            id          : v2,
            locked_item : v3,
        } = arg0;
        0x2::object::delete(v2);
        v3
    }

    // decompiled from Move bytecode v6
}

