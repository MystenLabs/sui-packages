module 0x6420b80c495da6f72a3e5c744a6d919a76e48deae0bae6d50bd686c0148de032::bundle {
    struct BundleCreated has copy, drop {
        bundle_id: 0x2::object::ID,
        seller: address,
        price: u64,
        type_a_count: u64,
        type_b_count: u64,
        type_c_count: u64,
    }

    struct BundlePurchased has copy, drop {
        bundle_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
    }

    struct BundleCancelled has copy, drop {
        bundle_id: 0x2::object::ID,
        seller: address,
    }

    struct Bundle<phantom T0: store + key, phantom T1: store + key, phantom T2: store + key> has key {
        id: 0x2::object::UID,
        seller: address,
        price: u64,
        is_active: bool,
        caps_a: vector<0x2::kiosk::PurchaseCap<T0>>,
        caps_b: vector<0x2::kiosk::PurchaseCap<T1>>,
        caps_c: vector<0x2::kiosk::PurchaseCap<T2>>,
    }

    public fun cancel_bundle<T0: store + key, T1: store + key, T2: store + key>(arg0: Bundle<T0, T1, T2>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.seller, 0);
        let Bundle {
            id        : v0,
            seller    : _,
            price     : _,
            is_active : _,
            caps_a    : v4,
            caps_b    : v5,
            caps_c    : v6,
        } = arg0;
        let v7 = v6;
        let v8 = v5;
        let v9 = v4;
        let v10 = v0;
        while (0x1::vector::length<0x2::kiosk::PurchaseCap<T0>>(&v9) > 0) {
            0x2::kiosk::return_purchase_cap<T0>(arg1, 0x1::vector::pop_back<0x2::kiosk::PurchaseCap<T0>>(&mut v9));
        };
        while (0x1::vector::length<0x2::kiosk::PurchaseCap<T1>>(&v8) > 0) {
            0x2::kiosk::return_purchase_cap<T1>(arg1, 0x1::vector::pop_back<0x2::kiosk::PurchaseCap<T1>>(&mut v8));
        };
        while (0x1::vector::length<0x2::kiosk::PurchaseCap<T2>>(&v7) > 0) {
            0x2::kiosk::return_purchase_cap<T2>(arg1, 0x1::vector::pop_back<0x2::kiosk::PurchaseCap<T2>>(&mut v7));
        };
        0x1::vector::destroy_empty<0x2::kiosk::PurchaseCap<T0>>(v9);
        0x1::vector::destroy_empty<0x2::kiosk::PurchaseCap<T1>>(v8);
        0x1::vector::destroy_empty<0x2::kiosk::PurchaseCap<T2>>(v7);
        let v11 = BundleCancelled{
            bundle_id : 0x2::object::uid_to_inner(&v10),
            seller    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<BundleCancelled>(v11);
        0x2::object::delete(v10);
    }

    public fun cancel_bundle_v2<T0: store + key, T1: store + key, T2: store + key>(arg0: Bundle<T0, T1, T2>, arg1: &mut 0x2::tx_context::TxContext) : (vector<0x2::kiosk::PurchaseCap<T0>>, vector<0x2::kiosk::PurchaseCap<T1>>, vector<0x2::kiosk::PurchaseCap<T2>>) {
        assert!(0x2::tx_context::sender(arg1) == arg0.seller, 0);
        let Bundle {
            id        : v0,
            seller    : _,
            price     : _,
            is_active : _,
            caps_a    : v4,
            caps_b    : v5,
            caps_c    : v6,
        } = arg0;
        let v7 = v0;
        let v8 = BundleCancelled{
            bundle_id : 0x2::object::uid_to_inner(&v7),
            seller    : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<BundleCancelled>(v8);
        0x2::object::delete(v7);
        (v4, v5, v6)
    }

    public fun count_a<T0: store + key, T1: store + key, T2: store + key>(arg0: &Bundle<T0, T1, T2>) : u64 {
        0x1::vector::length<0x2::kiosk::PurchaseCap<T0>>(&arg0.caps_a)
    }

    public fun count_b<T0: store + key, T1: store + key, T2: store + key>(arg0: &Bundle<T0, T1, T2>) : u64 {
        0x1::vector::length<0x2::kiosk::PurchaseCap<T1>>(&arg0.caps_b)
    }

    public fun count_c<T0: store + key, T1: store + key, T2: store + key>(arg0: &Bundle<T0, T1, T2>) : u64 {
        0x1::vector::length<0x2::kiosk::PurchaseCap<T2>>(&arg0.caps_c)
    }

    public fun create_bundle<T0: store + key, T1: store + key, T2: store + key>(arg0: vector<0x2::kiosk::PurchaseCap<T0>>, arg1: vector<0x2::kiosk::PurchaseCap<T1>>, arg2: vector<0x2::kiosk::PurchaseCap<T2>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x2::kiosk::PurchaseCap<T0>>(&arg0);
        let v1 = 0x1::vector::length<0x2::kiosk::PurchaseCap<T1>>(&arg1);
        let v2 = 0x1::vector::length<0x2::kiosk::PurchaseCap<T2>>(&arg2);
        assert!(v0 + v1 + v2 > 0, 2);
        let v3 = Bundle<T0, T1, T2>{
            id        : 0x2::object::new(arg4),
            seller    : 0x2::tx_context::sender(arg4),
            price     : arg3,
            is_active : true,
            caps_a    : arg0,
            caps_b    : arg1,
            caps_c    : arg2,
        };
        let v4 = BundleCreated{
            bundle_id    : 0x2::object::id<Bundle<T0, T1, T2>>(&v3),
            seller       : 0x2::tx_context::sender(arg4),
            price        : arg3,
            type_a_count : v0,
            type_b_count : v1,
            type_c_count : v2,
        };
        0x2::event::emit<BundleCreated>(v4);
        0x2::transfer::share_object<Bundle<T0, T1, T2>>(v3);
    }

    public fun is_active<T0: store + key, T1: store + key, T2: store + key>(arg0: &Bundle<T0, T1, T2>) : bool {
        arg0.is_active
    }

    public fun price<T0: store + key, T1: store + key, T2: store + key>(arg0: &Bundle<T0, T1, T2>) : u64 {
        arg0.price
    }

    public fun seller<T0: store + key, T1: store + key, T2: store + key>(arg0: &Bundle<T0, T1, T2>) : address {
        arg0.seller
    }

    fun settle_payment<T0: store + key, T1: store + key, T2: store + key>(arg0: &mut Bundle<T0, T1, T2>, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        if (!arg0.is_active) {
            return
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= arg0.price, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, arg0.price, arg2), arg0.seller);
        arg0.is_active = false;
        let v0 = BundlePurchased{
            bundle_id : 0x2::object::id<Bundle<T0, T1, T2>>(arg0),
            seller    : arg0.seller,
            buyer     : 0x2::tx_context::sender(arg2),
            price     : arg0.price,
        };
        0x2::event::emit<BundlePurchased>(v0);
    }

    public fun take_cap_a<T0: store + key, T1: store + key, T2: store + key>(arg0: &mut Bundle<T0, T1, T2>, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::kiosk::PurchaseCap<T0> {
        settle_payment<T0, T1, T2>(arg0, arg1, arg2);
        0x1::vector::pop_back<0x2::kiosk::PurchaseCap<T0>>(&mut arg0.caps_a)
    }

    public fun take_cap_b<T0: store + key, T1: store + key, T2: store + key>(arg0: &mut Bundle<T0, T1, T2>, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::kiosk::PurchaseCap<T1> {
        settle_payment<T0, T1, T2>(arg0, arg1, arg2);
        0x1::vector::pop_back<0x2::kiosk::PurchaseCap<T1>>(&mut arg0.caps_b)
    }

    public fun take_cap_c<T0: store + key, T1: store + key, T2: store + key>(arg0: &mut Bundle<T0, T1, T2>, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::kiosk::PurchaseCap<T2> {
        settle_payment<T0, T1, T2>(arg0, arg1, arg2);
        0x1::vector::pop_back<0x2::kiosk::PurchaseCap<T2>>(&mut arg0.caps_c)
    }

    public fun total_count<T0: store + key, T1: store + key, T2: store + key>(arg0: &Bundle<T0, T1, T2>) : u64 {
        0x1::vector::length<0x2::kiosk::PurchaseCap<T0>>(&arg0.caps_a) + 0x1::vector::length<0x2::kiosk::PurchaseCap<T1>>(&arg0.caps_b) + 0x1::vector::length<0x2::kiosk::PurchaseCap<T2>>(&arg0.caps_c)
    }

    // decompiled from Move bytecode v7
}

