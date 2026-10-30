module 0x6231076997dcc53b533ce7cc368562f1758d357a5424b3b895d5944cac9a7e86::bundle {
    struct Bundle<phantom T0: store + key> has key {
        id: 0x2::object::UID,
        kiosk_id: 0x2::object::ID,
        seller: address,
        caps: vector<0x2::kiosk::PurchaseCap<T0>>,
        total_price: u64,
        expires_at_ms: u64,
    }

    struct BundlePurchase<phantom T0: store + key> {
        bundle_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        seller: address,
        caps: vector<0x2::kiosk::PurchaseCap<T0>>,
        item_ids: vector<0x2::object::ID>,
        prices: vector<u64>,
        payment: 0x2::balance::Balance<0x2::sui::SUI>,
        total_price: u64,
    }

    struct BundleListed<phantom T0> has copy, drop {
        bundle_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        seller: address,
        item_ids: vector<0x2::object::ID>,
        prices: vector<u64>,
        total_price: u64,
        expires_at_ms: u64,
    }

    struct BundleSold<phantom T0> has copy, drop {
        bundle_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        buyer_kiosk_id: 0x2::object::ID,
        item_ids: vector<0x2::object::ID>,
        prices: vector<u64>,
        total_price: u64,
    }

    struct BundleCancelled<phantom T0> has copy, drop {
        bundle_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        by: address,
        expired: bool,
    }

    public fun begin_purchase<T0: store + key>(arg0: Bundle<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock) : BundlePurchase<T0> {
        let Bundle {
            id            : v0,
            kiosk_id      : v1,
            seller        : v2,
            caps          : v3,
            total_price   : v4,
            expires_at_ms : v5,
        } = arg0;
        let v6 = v3;
        let v7 = v0;
        assert!(0x2::clock::timestamp_ms(arg2) < v5, 8);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == v4, 3);
        let (v8, v9) = manifest<T0>(&v6);
        0x2::object::delete(v7);
        BundlePurchase<T0>{
            bundle_id   : 0x2::object::uid_to_inner(&v7),
            kiosk_id    : v1,
            seller      : v2,
            caps        : v6,
            item_ids    : v8,
            prices      : v9,
            payment     : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            total_price : v4,
        }
    }

    public fun cancel<T0: store + key>(arg0: Bundle<T0>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg1, arg2), 4);
        release<T0>(arg0, arg1, 0x2::tx_context::sender(arg3), false);
    }

    public fun create<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: vector<0x2::object::ID>, arg3: vector<u64>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::kiosk::has_access(arg0, arg1), 4);
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg2);
        assert!(0x1::vector::length<u64>(&arg3) == v0, 2);
        assert!(v0 >= 2, 0);
        assert!(v0 <= 9, 1);
        assert!(arg4 > 0x2::clock::timestamp_ms(arg5), 8);
        let v1 = 0x1::vector::empty<0x2::kiosk::PurchaseCap<T0>>();
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            assert!(*0x1::vector::borrow<u64>(&arg3, v3) > 0, 10);
            0x1::vector::push_back<0x2::kiosk::PurchaseCap<T0>>(&mut v1, 0x2::kiosk::list_with_purchase_cap<T0>(arg0, arg1, *0x1::vector::borrow<0x2::object::ID>(&arg2, v3), *0x1::vector::borrow<u64>(&arg3, v3), arg6));
            v2 = v2 + *0x1::vector::borrow<u64>(&arg3, v3);
            v3 = v3 + 1;
        };
        let v4 = 0x2::object::id<0x2::kiosk::Kiosk>(arg0);
        let v5 = Bundle<T0>{
            id            : 0x2::object::new(arg6),
            kiosk_id      : v4,
            seller        : 0x2::tx_context::sender(arg6),
            caps          : v1,
            total_price   : v2,
            expires_at_ms : arg4,
        };
        let v6 = 0x2::object::id<Bundle<T0>>(&v5);
        let v7 = BundleListed<T0>{
            bundle_id     : v6,
            kiosk_id      : v4,
            seller        : 0x2::tx_context::sender(arg6),
            item_ids      : arg2,
            prices        : arg3,
            total_price   : v2,
            expires_at_ms : arg4,
        };
        0x2::event::emit<BundleListed<T0>>(v7);
        0x2::transfer::share_object<Bundle<T0>>(v5);
        v6
    }

    public fun expire<T0: store + key>(arg0: Bundle<T0>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.expires_at_ms, 9);
        release<T0>(arg0, arg1, 0x2::tx_context::sender(arg3), true);
    }

    public fun expires_at_ms<T0: store + key>(arg0: &Bundle<T0>) : u64 {
        arg0.expires_at_ms
    }

    public fun finish<T0: store + key>(arg0: BundlePurchase<T0>, arg1: &0x2::kiosk::Kiosk, arg2: &mut 0x2::tx_context::TxContext) {
        let BundlePurchase {
            bundle_id   : v0,
            kiosk_id    : v1,
            seller      : v2,
            caps        : v3,
            item_ids    : v4,
            prices      : v5,
            payment     : v6,
            total_price : v7,
        } = arg0;
        let v8 = v4;
        let v9 = v3;
        assert!(0x1::vector::is_empty<0x2::kiosk::PurchaseCap<T0>>(&v9), 6);
        0x1::vector::destroy_empty<0x2::kiosk::PurchaseCap<T0>>(v9);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v6);
        let v10 = &v8;
        let v11 = 0;
        while (v11 < 0x1::vector::length<0x2::object::ID>(v10)) {
            let v12 = 0x1::vector::borrow<0x2::object::ID>(v10, v11);
            assert!(0x2::kiosk::has_item_with_type<T0>(arg1, *v12) && 0x2::kiosk::is_locked(arg1, *v12), 7);
            v11 = v11 + 1;
        };
        let v13 = BundleSold<T0>{
            bundle_id      : v0,
            kiosk_id       : v1,
            seller         : v2,
            buyer          : 0x2::tx_context::sender(arg2),
            buyer_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            item_ids       : v8,
            prices         : v5,
            total_price    : v7,
        };
        0x2::event::emit<BundleSold<T0>>(v13);
    }

    public fun item_ids<T0: store + key>(arg0: &Bundle<T0>) : vector<0x2::object::ID> {
        let (v0, _) = manifest<T0>(&arg0.caps);
        v0
    }

    public fun kiosk_id<T0: store + key>(arg0: &Bundle<T0>) : 0x2::object::ID {
        arg0.kiosk_id
    }

    fun manifest<T0: store + key>(arg0: &vector<0x2::kiosk::PurchaseCap<T0>>) : (vector<0x2::object::ID>, vector<u64>) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::kiosk::PurchaseCap<T0>>(arg0)) {
            let v3 = 0x1::vector::borrow<0x2::kiosk::PurchaseCap<T0>>(arg0, v2);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::kiosk::purchase_cap_item<T0>(v3));
            0x1::vector::push_back<u64>(&mut v1, 0x2::kiosk::purchase_cap_min_price<T0>(v3));
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun prices<T0: store + key>(arg0: &Bundle<T0>) : vector<u64> {
        let (_, v1) = manifest<T0>(&arg0.caps);
        v1
    }

    public fun purchase_next<T0: store + key>(arg0: &mut BundlePurchase<T0>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == arg0.kiosk_id, 5);
        let v0 = 0x1::vector::pop_back<0x2::kiosk::PurchaseCap<T0>>(&mut arg0.caps);
        0x2::kiosk::purchase_with_cap<T0>(arg1, v0, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.payment, 0x2::kiosk::purchase_cap_min_price<T0>(&v0)), arg2))
    }

    fun release<T0: store + key>(arg0: Bundle<T0>, arg1: &mut 0x2::kiosk::Kiosk, arg2: address, arg3: bool) {
        let Bundle {
            id            : v0,
            kiosk_id      : v1,
            seller        : _,
            caps          : v3,
            total_price   : _,
            expires_at_ms : _,
        } = arg0;
        let v6 = v3;
        let v7 = v0;
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == v1, 5);
        while (!0x1::vector::is_empty<0x2::kiosk::PurchaseCap<T0>>(&v6)) {
            0x2::kiosk::return_purchase_cap<T0>(arg1, 0x1::vector::pop_back<0x2::kiosk::PurchaseCap<T0>>(&mut v6));
        };
        0x1::vector::destroy_empty<0x2::kiosk::PurchaseCap<T0>>(v6);
        let v8 = BundleCancelled<T0>{
            bundle_id : 0x2::object::uid_to_inner(&v7),
            kiosk_id  : v1,
            by        : arg2,
            expired   : arg3,
        };
        0x2::event::emit<BundleCancelled<T0>>(v8);
        0x2::object::delete(v7);
    }

    public fun seller<T0: store + key>(arg0: &Bundle<T0>) : address {
        arg0.seller
    }

    public fun total_price<T0: store + key>(arg0: &Bundle<T0>) : u64 {
        arg0.total_price
    }

    // decompiled from Move bytecode v7
}

