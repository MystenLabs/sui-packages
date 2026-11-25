module 0x439af2ba768aad29caf2920e081d20392e2ebd760c6853736bb43964b46001f7::service {
    struct Service<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        seller: address,
        title: 0x1::string::String,
        price: u64,
        terms_hash: vector<u8>,
        terms_url: 0x1::string::String,
        version: u64,
        active: bool,
        orders: u64,
        ratings: u64,
        stars: u64,
    }

    struct OrderKey has copy, drop, store {
        invoice: 0x2::object::ID,
    }

    struct Order has drop, store {
        version: u64,
        rated: bool,
    }

    struct ServiceCreated has copy, drop {
        service: 0x2::object::ID,
        owner: address,
        seller: address,
        title: 0x1::string::String,
        price: u64,
        terms_hash: vector<u8>,
        terms_url: 0x1::string::String,
    }

    struct TermsChanged has copy, drop {
        service: 0x2::object::ID,
        version: u64,
        title: 0x1::string::String,
        price: u64,
        terms_hash: vector<u8>,
        terms_url: 0x1::string::String,
    }

    struct AvailabilityChanged has copy, drop {
        service: 0x2::object::ID,
        active: bool,
    }

    struct Ordered has copy, drop {
        service: 0x2::object::ID,
        invoice: 0x2::object::ID,
        version: u64,
        amount: u64,
    }

    struct Rated has copy, drop {
        service: 0x2::object::ID,
        invoice: 0x2::object::ID,
        rater: address,
        stars: u8,
        comment: 0x1::string::String,
        amount: u64,
        version: u64,
    }

    fun check_terms(arg0: &0x1::string::String, arg1: u64, arg2: &vector<u8>, arg3: &0x1::string::String) {
        assert!(0x1::string::length(arg0) > 0 && 0x1::string::length(arg0) <= 80, 403);
        assert!(0x1::string::length(arg3) <= 200, 403);
        assert!(0x1::vector::length<u8>(arg2) == 32, 410);
        assert!(arg1 > 0, 410);
    }

    public fun create<T0>(arg0: address, arg1: 0x1::string::String, arg2: u64, arg3: vector<u8>, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        check_terms(&arg1, arg2, &arg3, &arg4);
        let v0 = Service<T0>{
            id         : 0x2::object::new(arg5),
            owner      : 0x2::tx_context::sender(arg5),
            seller     : arg0,
            title      : arg1,
            price      : arg2,
            terms_hash : arg3,
            terms_url  : arg4,
            version    : 1,
            active     : true,
            orders     : 0,
            ratings    : 0,
            stars      : 0,
        };
        let v1 = ServiceCreated{
            service    : 0x2::object::id<Service<T0>>(&v0),
            owner      : v0.owner,
            seller     : arg0,
            title      : arg1,
            price      : arg2,
            terms_hash : arg3,
            terms_url  : arg4,
        };
        0x2::event::emit<ServiceCreated>(v1);
        0x2::transfer::share_object<Service<T0>>(v0);
    }

    public fun order<T0>(arg0: &mut Service<T0>, arg1: &mut 0x439af2ba768aad29caf2920e081d20392e2ebd760c6853736bb43964b46001f7::pool::Pool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 409);
        assert!(0x2::tx_context::sender(arg2) == arg0.seller, 404);
        let v0 = 0x1::string::utf8(b"Order: ");
        0x1::string::append(&mut v0, arg0.title);
        0x1::string::append(&mut v0, 0x1::string::utf8(b" (terms v"));
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg0.version));
        0x1::string::append(&mut v0, 0x1::string::utf8(b")"));
        let v1 = 0x439af2ba768aad29caf2920e081d20392e2ebd760c6853736bb43964b46001f7::invoice::new_shared<T0>(arg1, arg0.price, v0, arg2);
        let v2 = OrderKey{invoice: v1};
        let v3 = Order{
            version : arg0.version,
            rated   : false,
        };
        0x2::dynamic_field::add<OrderKey, Order>(&mut arg0.id, v2, v3);
        arg0.orders = arg0.orders + 1;
        let v4 = Ordered{
            service : 0x2::object::id<Service<T0>>(arg0),
            invoice : v1,
            version : arg0.version,
            amount  : arg0.price,
        };
        0x2::event::emit<Ordered>(v4);
    }

    public fun order_version<T0>(arg0: &Service<T0>, arg1: 0x2::object::ID) : u64 {
        let v0 = OrderKey{invoice: arg1};
        0x2::dynamic_field::borrow<OrderKey, Order>(&arg0.id, v0).version
    }

    public fun owner<T0>(arg0: &Service<T0>) : address {
        arg0.owner
    }

    public fun price<T0>(arg0: &Service<T0>) : u64 {
        arg0.price
    }

    public fun rate<T0>(arg0: &mut Service<T0>, arg1: &0x439af2ba768aad29caf2920e081d20392e2ebd760c6853736bb43964b46001f7::invoice::Invoice<T0>, arg2: u8, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        let v0 = OrderKey{invoice: 0x2::object::id<0x439af2ba768aad29caf2920e081d20392e2ebd760c6853736bb43964b46001f7::invoice::Invoice<T0>>(arg1)};
        assert!(0x2::dynamic_field::exists_<OrderKey>(&arg0.id, v0), 405);
        assert!(0x439af2ba768aad29caf2920e081d20392e2ebd760c6853736bb43964b46001f7::invoice::is_paid<T0>(arg1), 406);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(0x439af2ba768aad29caf2920e081d20392e2ebd760c6853736bb43964b46001f7::invoice::payer<T0>(arg1) == 0x1::option::some<address>(v1), 407);
        assert!(v1 != arg0.owner && v1 != arg0.seller, 411);
        assert!(arg2 >= 1 && arg2 <= 5, 402);
        assert!(0x1::string::length(&arg3) <= 280, 403);
        let v2 = 0x2::dynamic_field::borrow_mut<OrderKey, Order>(&mut arg0.id, v0);
        assert!(!v2.rated, 408);
        v2.rated = true;
        arg0.ratings = arg0.ratings + 1;
        arg0.stars = arg0.stars + (arg2 as u64);
        let v3 = Rated{
            service : 0x2::object::id<Service<T0>>(arg0),
            invoice : 0x2::object::id<0x439af2ba768aad29caf2920e081d20392e2ebd760c6853736bb43964b46001f7::invoice::Invoice<T0>>(arg1),
            rater   : v1,
            stars   : arg2,
            comment : arg3,
            amount  : 0x439af2ba768aad29caf2920e081d20392e2ebd760c6853736bb43964b46001f7::invoice::amount<T0>(arg1),
            version : v2.version,
        };
        0x2::event::emit<Rated>(v3);
    }

    public fun ratings<T0>(arg0: &Service<T0>) : (u64, u64) {
        (arg0.ratings, arg0.stars)
    }

    public fun seller<T0>(arg0: &Service<T0>) : address {
        arg0.seller
    }

    public fun set_active<T0>(arg0: &mut Service<T0>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 401);
        arg0.active = arg1;
        let v0 = AvailabilityChanged{
            service : 0x2::object::id<Service<T0>>(arg0),
            active  : arg1,
        };
        0x2::event::emit<AvailabilityChanged>(v0);
    }

    public fun update<T0>(arg0: &mut Service<T0>, arg1: 0x1::string::String, arg2: u64, arg3: vector<u8>, arg4: 0x1::string::String, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 401);
        check_terms(&arg1, arg2, &arg3, &arg4);
        arg0.title = arg1;
        arg0.price = arg2;
        arg0.terms_hash = arg3;
        arg0.terms_url = arg4;
        arg0.version = arg0.version + 1;
        let v0 = TermsChanged{
            service    : 0x2::object::id<Service<T0>>(arg0),
            version    : arg0.version,
            title      : arg1,
            price      : arg2,
            terms_hash : arg3,
            terms_url  : arg4,
        };
        0x2::event::emit<TermsChanged>(v0);
    }

    public fun version<T0>(arg0: &Service<T0>) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

