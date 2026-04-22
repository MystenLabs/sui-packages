module 0x6420b80c495da6f72a3e5c744a6d919a76e48deae0bae6d50bd686c0148de032::bundle_v2 {
    struct BundleCreated2 has copy, drop {
        bundle_id: 0x2::object::ID,
        seller: address,
        price: u64,
        types: vector<0x1::string::String>,
        counts: vector<u64>,
        total_count: u64,
    }

    struct BundlePurchased2 has copy, drop {
        bundle_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
    }

    struct BundleCancelled2 has copy, drop {
        bundle_id: 0x2::object::ID,
        seller: address,
    }

    struct Bundle2 has key {
        id: 0x2::object::UID,
        seller: address,
        price: u64,
        is_active: bool,
        is_paid: bool,
        type_names: vector<0x1::type_name::TypeName>,
        type_counts: vector<u64>,
        total_remaining: u64,
        caps: 0x2::bag::Bag,
    }

    public fun new(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : Bundle2 {
        Bundle2{
            id              : 0x2::object::new(arg1),
            seller          : 0x2::tx_context::sender(arg1),
            price           : arg0,
            is_active       : false,
            is_paid         : false,
            type_names      : 0x1::vector::empty<0x1::type_name::TypeName>(),
            type_counts     : vector[],
            total_remaining : 0,
            caps            : 0x2::bag::new(arg1),
        }
    }

    public fun activate(arg0: &mut Bundle2, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.seller, 0);
        assert!(!arg0.is_active, 3);
        assert!(arg0.total_remaining > 0, 2);
        arg0.is_active = true;
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.type_names)) {
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::from_ascii(0x1::type_name::into_string(*0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.type_names, v1))));
            v1 = v1 + 1;
        };
        let v2 = BundleCreated2{
            bundle_id   : 0x2::object::id<Bundle2>(arg0),
            seller      : arg0.seller,
            price       : arg0.price,
            types       : v0,
            counts      : arg0.type_counts,
            total_count : arg0.total_remaining,
        };
        0x2::event::emit<BundleCreated2>(v2);
    }

    public fun add_caps<T0: store + key>(arg0: &mut Bundle2, arg1: vector<0x2::kiosk::PurchaseCap<T0>>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.seller, 0);
        assert!(!arg0.is_active, 3);
        let v0 = 0x1::vector::length<0x2::kiosk::PurchaseCap<T0>>(&arg1);
        if (v0 == 0) {
            0x1::vector::destroy_empty<0x2::kiosk::PurchaseCap<T0>>(arg1);
            return
        };
        let v1 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.caps, v1)) {
            let v2 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, vector<0x2::kiosk::PurchaseCap<T0>>>(&mut arg0.caps, v1);
            while (0x1::vector::length<0x2::kiosk::PurchaseCap<T0>>(&arg1) > 0) {
                0x1::vector::push_back<0x2::kiosk::PurchaseCap<T0>>(v2, 0x1::vector::pop_back<0x2::kiosk::PurchaseCap<T0>>(&mut arg1));
            };
            0x1::vector::destroy_empty<0x2::kiosk::PurchaseCap<T0>>(arg1);
            let v3 = 0x1::vector::borrow_mut<u64>(&mut arg0.type_counts, find_type_index(&arg0.type_names, &v1));
            *v3 = *v3 + v0;
        } else {
            0x2::bag::add<0x1::type_name::TypeName, vector<0x2::kiosk::PurchaseCap<T0>>>(&mut arg0.caps, v1, arg1);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.type_names, v1);
            0x1::vector::push_back<u64>(&mut arg0.type_counts, v0);
        };
        arg0.total_remaining = arg0.total_remaining + v0;
    }

    public fun cancel_take<T0: store + key>(arg0: &mut Bundle2, arg1: &0x2::tx_context::TxContext) : vector<0x2::kiosk::PurchaseCap<T0>> {
        assert!(0x2::tx_context::sender(arg1) == arg0.seller, 0);
        assert!(!arg0.is_paid, 6);
        arg0.is_active = false;
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.caps, v0), 8);
        let v1 = 0x2::bag::remove<0x1::type_name::TypeName, vector<0x2::kiosk::PurchaseCap<T0>>>(&mut arg0.caps, v0);
        let v2 = find_type_index(&arg0.type_names, &v0);
        0x1::vector::remove<0x1::type_name::TypeName>(&mut arg0.type_names, v2);
        0x1::vector::remove<u64>(&mut arg0.type_counts, v2);
        arg0.total_remaining = arg0.total_remaining - 0x1::vector::length<0x2::kiosk::PurchaseCap<T0>>(&v1);
        v1
    }

    public fun finalize_cancel(arg0: Bundle2, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.seller, 0);
        assert!(arg0.total_remaining == 0, 5);
        let Bundle2 {
            id              : v0,
            seller          : v1,
            price           : _,
            is_active       : _,
            is_paid         : _,
            type_names      : _,
            type_counts     : _,
            total_remaining : _,
            caps            : v8,
        } = arg0;
        let v9 = v0;
        0x2::bag::destroy_empty(v8);
        let v10 = BundleCancelled2{
            bundle_id : 0x2::object::uid_to_inner(&v9),
            seller    : v1,
        };
        0x2::event::emit<BundleCancelled2>(v10);
        0x2::object::delete(v9);
    }

    public fun finalize_purchase(arg0: Bundle2, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.is_paid, 7);
        assert!(arg0.total_remaining == 0, 5);
        let Bundle2 {
            id              : v0,
            seller          : _,
            price           : _,
            is_active       : _,
            is_paid         : _,
            type_names      : _,
            type_counts     : _,
            total_remaining : _,
            caps            : v8,
        } = arg0;
        0x2::bag::destroy_empty(v8);
        0x2::object::delete(v0);
    }

    fun find_type_index(arg0: &vector<0x1::type_name::TypeName>, arg1: &0x1::type_name::TypeName) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(arg0)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(arg0, v0) == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        abort 8
    }

    public fun is_active(arg0: &Bundle2) : bool {
        arg0.is_active
    }

    public fun is_paid(arg0: &Bundle2) : bool {
        arg0.is_paid
    }

    public fun new_shared(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = new(arg0, arg1);
        0x2::transfer::share_object<Bundle2>(v0);
        0x2::object::id<Bundle2>(&v0)
    }

    public fun pay(arg0: &mut Bundle2, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 4);
        assert!(!arg0.is_paid, 6);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= arg0.price, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, arg0.price, arg2), arg0.seller);
        arg0.is_paid = true;
        arg0.is_active = false;
        let v0 = BundlePurchased2{
            bundle_id : 0x2::object::id<Bundle2>(arg0),
            seller    : arg0.seller,
            buyer     : 0x2::tx_context::sender(arg2),
            price     : arg0.price,
        };
        0x2::event::emit<BundlePurchased2>(v0);
    }

    public fun price(arg0: &Bundle2) : u64 {
        arg0.price
    }

    public fun seller(arg0: &Bundle2) : address {
        arg0.seller
    }

    public fun take_cap<T0: store + key>(arg0: &mut Bundle2) : 0x2::kiosk::PurchaseCap<T0> {
        assert!(arg0.is_paid, 7);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.caps, v0), 8);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, vector<0x2::kiosk::PurchaseCap<T0>>>(&mut arg0.caps, v0);
        let v2 = 0x1::vector::pop_back<0x2::kiosk::PurchaseCap<T0>>(v1);
        let v3 = find_type_index(&arg0.type_names, &v0);
        let v4 = 0x1::vector::borrow_mut<u64>(&mut arg0.type_counts, v3);
        *v4 = *v4 - 1;
        arg0.total_remaining = arg0.total_remaining - 1;
        if (0x1::vector::length<0x2::kiosk::PurchaseCap<T0>>(v1) == 0) {
            0x1::vector::destroy_empty<0x2::kiosk::PurchaseCap<T0>>(0x2::bag::remove<0x1::type_name::TypeName, vector<0x2::kiosk::PurchaseCap<T0>>>(&mut arg0.caps, v0));
            0x1::vector::remove<0x1::type_name::TypeName>(&mut arg0.type_names, v3);
            0x1::vector::remove<u64>(&mut arg0.type_counts, v3);
        };
        v2
    }

    public fun total_remaining(arg0: &Bundle2) : u64 {
        arg0.total_remaining
    }

    public fun type_counts(arg0: &Bundle2) : &vector<u64> {
        &arg0.type_counts
    }

    public fun type_names(arg0: &Bundle2) : &vector<0x1::type_name::TypeName> {
        &arg0.type_names
    }

    // decompiled from Move bytecode v7
}

