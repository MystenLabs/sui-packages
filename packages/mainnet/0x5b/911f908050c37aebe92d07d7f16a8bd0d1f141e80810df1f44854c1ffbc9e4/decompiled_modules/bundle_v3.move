module 0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3 {
    struct Bundle3 has key {
        id: 0x2::object::UID,
        seller: address,
        price: u64,
        per_item_price: u64,
        fee_amount: u64,
        total_count: u64,
        caps_added: u64,
        caps_taken: u64,
        types: vector<0x1::type_name::TypeName>,
        active: bool,
        fee_paid: bool,
        fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct TypeKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct BundleCreated has copy, drop {
        bundle_id: 0x2::object::ID,
        seller: address,
        price: u64,
        per_item_price: u64,
        total_count: u64,
    }

    struct BundleActivated has copy, drop {
        bundle_id: 0x2::object::ID,
    }

    struct BundleFeePaid has copy, drop {
        bundle_id: 0x2::object::ID,
        buyer: address,
        fee: u64,
    }

    struct BundlePurchased has copy, drop {
        bundle_id: 0x2::object::ID,
        buyer: address,
    }

    struct BundleCancelled has copy, drop {
        bundle_id: 0x2::object::ID,
    }

    public fun new(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Bundle3 {
        assert!(arg1 > 0, 9);
        assert!(arg0 > 0, 9);
        assert!(arg0 % arg1 == 0, 10);
        let v0 = arg0 / arg1;
        let v1 = Bundle3{
            id             : 0x2::object::new(arg2),
            seller         : 0x2::tx_context::sender(arg2),
            price          : arg0,
            per_item_price : v0,
            fee_amount     : ceil_bps(arg0, 200),
            total_count    : arg1,
            caps_added     : 0,
            caps_taken     : 0,
            types          : 0x1::vector::empty<0x1::type_name::TypeName>(),
            active         : false,
            fee_paid       : false,
            fee_balance    : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v2 = BundleCreated{
            bundle_id      : 0x2::object::id<Bundle3>(&v1),
            seller         : v1.seller,
            price          : arg0,
            per_item_price : v0,
            total_count    : arg1,
        };
        0x2::event::emit<BundleCreated>(v2);
        v1
    }

    public fun activate(arg0: &mut Bundle3, arg1: &0x2::tx_context::TxContext) {
        assert!(!arg0.active, 2);
        assert!(0x2::tx_context::sender(arg1) == arg0.seller, 6);
        assert!(arg0.caps_added == arg0.total_count, 7);
        arg0.active = true;
        let v0 = BundleActivated{bundle_id: 0x2::object::id<Bundle3>(arg0)};
        0x2::event::emit<BundleActivated>(v0);
    }

    public fun add_caps<T0: store + key>(arg0: &mut Bundle3, arg1: vector<0x2::kiosk::PurchaseCap<T0>>, arg2: &0x2::tx_context::TxContext) {
        assert!(!arg0.active, 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.seller, 6);
        let v0 = 0x1::vector::length<0x2::kiosk::PurchaseCap<T0>>(&arg1);
        assert!(v0 > 0, 7);
        let v1 = 0;
        while (v1 < v0) {
            assert!(0x2::kiosk::purchase_cap_min_price<T0>(0x1::vector::borrow<0x2::kiosk::PurchaseCap<T0>>(&arg1, v1)) == arg0.per_item_price, 5);
            v1 = v1 + 1;
        };
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x1::vector::contains<0x1::type_name::TypeName>(&arg0.types, &v2)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.types, v2);
        };
        let v3 = TypeKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<TypeKey<T0>>(&arg0.id, v3)) {
            0x1::vector::append<0x2::kiosk::PurchaseCap<T0>>(0x2::dynamic_field::borrow_mut<TypeKey<T0>, vector<0x2::kiosk::PurchaseCap<T0>>>(&mut arg0.id, v3), arg1);
        } else {
            0x2::dynamic_field::add<TypeKey<T0>, vector<0x2::kiosk::PurchaseCap<T0>>>(&mut arg0.id, v3, arg1);
        };
        arg0.caps_added = arg0.caps_added + v0;
    }

    public fun cancel_take<T0: store + key>(arg0: &mut Bundle3, arg1: &0x2::tx_context::TxContext) : vector<0x2::kiosk::PurchaseCap<T0>> {
        assert!(0x2::tx_context::sender(arg1) == arg0.seller, 6);
        assert!(!arg0.fee_paid, 4);
        let v0 = TypeKey<T0>{dummy_field: false};
        0x2::dynamic_field::remove<TypeKey<T0>, vector<0x2::kiosk::PurchaseCap<T0>>>(&mut arg0.id, v0)
    }

    public fun caps_added(arg0: &Bundle3) : u64 {
        arg0.caps_added
    }

    public fun caps_taken(arg0: &Bundle3) : u64 {
        arg0.caps_taken
    }

    fun ceil_bps(arg0: u64, arg1: u64) : u64 {
        let v0 = (10000 as u128);
        ((((arg0 as u128) * (arg1 as u128) + v0 - 1) / v0) as u64)
    }

    public fun fee_amount(arg0: &Bundle3) : u64 {
        arg0.fee_amount
    }

    public fun finalize_cancel(arg0: Bundle3, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.seller, 6);
        assert!(!arg0.fee_paid, 4);
        let Bundle3 {
            id             : v0,
            seller         : v1,
            price          : _,
            per_item_price : _,
            fee_amount     : _,
            total_count    : _,
            caps_added     : _,
            caps_taken     : _,
            types          : _,
            active         : _,
            fee_paid       : _,
            fee_balance    : v11,
        } = arg0;
        let v12 = v11;
        let v13 = v0;
        if (0x2::balance::value<0x2::sui::SUI>(&v12) == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v12);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v12, arg1), v1);
        };
        0x2::object::delete(v13);
        let v14 = BundleCancelled{bundle_id: 0x2::object::uid_to_inner(&v13)};
        0x2::event::emit<BundleCancelled>(v14);
    }

    public fun finalize_purchase(arg0: Bundle3, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 1);
        assert!(arg0.fee_paid, 3);
        assert!(arg0.caps_taken == arg0.total_count, 11);
        let Bundle3 {
            id             : v0,
            seller         : _,
            price          : _,
            per_item_price : _,
            fee_amount     : _,
            total_count    : _,
            caps_added     : _,
            caps_taken     : _,
            types          : _,
            active         : _,
            fee_paid       : _,
            fee_balance    : v11,
        } = arg0;
        let v12 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v11, arg1), @0x1a4c3e81ef4055af3ecf16d2f7c2ee34dd7406555716c9f32f4b75954f581490);
        0x2::object::delete(v12);
        let v13 = BundlePurchased{
            bundle_id : 0x2::object::uid_to_inner(&v12),
            buyer     : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<BundlePurchased>(v13);
    }

    public fun is_active(arg0: &Bundle3) : bool {
        arg0.active
    }

    public fun is_fee_paid(arg0: &Bundle3) : bool {
        arg0.fee_paid
    }

    public fun new_shared(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = new(arg0, arg1, arg2);
        0x2::transfer::share_object<Bundle3>(v0);
        0x2::object::id<Bundle3>(&v0)
    }

    public fun pay_fee(arg0: &mut Bundle3, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 1);
        assert!(!arg0.fee_paid, 4);
        let v0 = arg0.fee_amount;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= v0, 8);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg1, v0, arg2)));
        arg0.fee_paid = true;
        let v1 = BundleFeePaid{
            bundle_id : 0x2::object::id<Bundle3>(arg0),
            buyer     : 0x2::tx_context::sender(arg2),
            fee       : v0,
        };
        0x2::event::emit<BundleFeePaid>(v1);
    }

    public fun per_item_price(arg0: &Bundle3) : u64 {
        arg0.per_item_price
    }

    public fun price(arg0: &Bundle3) : u64 {
        arg0.price
    }

    public fun seller(arg0: &Bundle3) : address {
        arg0.seller
    }

    public fun share(arg0: Bundle3) {
        0x2::transfer::share_object<Bundle3>(arg0);
    }

    public fun take_cap<T0: store + key>(arg0: &mut Bundle3) : 0x2::kiosk::PurchaseCap<T0> {
        assert!(arg0.active, 1);
        assert!(arg0.fee_paid, 3);
        let v0 = TypeKey<T0>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<TypeKey<T0>, vector<0x2::kiosk::PurchaseCap<T0>>>(&mut arg0.id, v0);
        assert!(!0x1::vector::is_empty<0x2::kiosk::PurchaseCap<T0>>(v1), 7);
        arg0.caps_taken = arg0.caps_taken + 1;
        0x1::vector::pop_back<0x2::kiosk::PurchaseCap<T0>>(v1)
    }

    public fun total_count(arg0: &Bundle3) : u64 {
        arg0.total_count
    }

    public fun types(arg0: &Bundle3) : &vector<0x1::type_name::TypeName> {
        &arg0.types
    }

    // decompiled from Move bytecode v7
}

