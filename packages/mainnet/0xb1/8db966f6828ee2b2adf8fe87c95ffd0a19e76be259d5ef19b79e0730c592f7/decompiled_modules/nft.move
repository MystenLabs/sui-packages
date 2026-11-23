module 0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::nft {
    struct NftPolicy has drop, store {
        collections: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        max_price: u64,
    }

    struct PolicyKey has copy, drop, store {
        agent: address,
    }

    struct FeeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AdapterKey has copy, drop, store {
        witness: 0x1::type_name::TypeName,
    }

    struct Purchase<phantom T0> {
        pool_id: 0x2::object::ID,
        owner: address,
        agent: address,
        item_id: 0x2::object::ID,
        collection: 0x1::type_name::TypeName,
        adapter: 0x1::type_name::TypeName,
        kiosk_id: 0x2::object::ID,
        quoted: u64,
        fee: 0x2::balance::Balance<T0>,
    }

    struct PurchaseFeeSet has copy, drop {
        bps: u64,
    }

    struct PurchaseFeePaid has copy, drop {
        pool_id: 0x2::object::ID,
        agent: address,
        item_id: 0x2::object::ID,
        amount: u64,
        treasury: address,
    }

    struct NftPolicySet has copy, drop {
        pool_id: 0x2::object::ID,
        agent: address,
        max_price: u64,
        collections: u64,
    }

    struct NftBought has copy, drop {
        pool_id: 0x2::object::ID,
        owner: address,
        kiosk_id: 0x2::object::ID,
        agent: address,
        item_id: 0x2::object::ID,
        collection: 0x1::type_name::TypeName,
        market: 0x1::type_name::TypeName,
        paid: u64,
    }

    public fun allow_collection<T0, T1: store + key>(arg0: &0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::OwnerCap, arg1: &mut 0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::Pool<T0>, arg2: address) {
        0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::assert_owner_cap<T0>(arg0, arg1);
        let v0 = policy_mut<T0>(arg1, arg2);
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&v0.collections, &v1)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0.collections, v1);
        };
        emit_policy<T0>(arg1, arg2);
    }

    public fun begin_purchase<T0, T1: store + key, T2: drop>(arg0: T2, arg1: &0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::Platform, arg2: &mut 0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::Pool<T0>, arg3: address, arg4: 0x2::object::ID, arg5: u64, arg6: 0x1::string::String, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Purchase<T0>, 0x2::kiosk::Kiosk, 0x2::kiosk::KioskOwnerCap) {
        assert!(is_adapter<T2>(arg1), 305);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = PolicyKey{agent: v0};
        assert!(0x2::dynamic_field::exists<PolicyKey>(0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::uid<T0>(arg2), v1), 302);
        let v2 = 0x2::dynamic_field::borrow<PolicyKey, NftPolicy>(0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::uid<T0>(arg2), v1);
        assert!(v2.max_price > 0, 302);
        let v3 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&v2.collections, &v3), 303);
        let v4 = purchase_fee(arg1, arg5);
        assert!(arg5 + v4 <= v2.max_price, 304);
        let v5 = 0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::take_for_purchase<T0>(arg1, arg2, v0, arg3, arg5 + v4, arg6, arg7, arg8);
        let (v6, v7) = 0x2::kiosk::new(arg8);
        let v8 = v6;
        let v9 = Purchase<T0>{
            pool_id    : 0x2::object::id<0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::Pool<T0>>(arg2),
            owner      : 0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::owner<T0>(arg2),
            agent      : v0,
            item_id    : arg4,
            collection : v3,
            adapter    : 0x1::type_name::with_defining_ids<T2>(),
            kiosk_id   : 0x2::object::id<0x2::kiosk::Kiosk>(&v8),
            quoted     : arg5,
            fee        : 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v5, v4, arg8)),
        };
        (v5, v9, v8, v7)
    }

    public fun can_buy<T0, T1: store + key>(arg0: &0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::Pool<T0>, arg1: address) : bool {
        let v0 = PolicyKey{agent: arg1};
        if (!0x2::dynamic_field::exists<PolicyKey>(0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::uid<T0>(arg0), v0)) {
            return false
        };
        let v1 = 0x2::dynamic_field::borrow<PolicyKey, NftPolicy>(0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::uid<T0>(arg0), v0);
        if (v1.max_price > 0) {
            let v3 = 0x1::type_name::with_defining_ids<T1>();
            0x2::vec_set::contains<0x1::type_name::TypeName>(&v1.collections, &v3)
        } else {
            false
        }
    }

    public fun clear_nft_policy<T0>(arg0: &0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::OwnerCap, arg1: &mut 0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::Pool<T0>, arg2: address) {
        0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::assert_owner_cap<T0>(arg0, arg1);
        let v0 = PolicyKey{agent: arg2};
        if (0x2::dynamic_field::exists<PolicyKey>(0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::uid<T0>(arg1), v0)) {
            0x2::dynamic_field::remove<PolicyKey, NftPolicy>(0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::uid_mut<T0>(arg1), v0);
        };
        emit_policy<T0>(arg1, arg2);
    }

    public fun disallow_collection<T0, T1: store + key>(arg0: &0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::OwnerCap, arg1: &mut 0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::Pool<T0>, arg2: address) {
        0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::assert_owner_cap<T0>(arg0, arg1);
        let v0 = policy_mut<T0>(arg1, arg2);
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&v0.collections, &v1)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut v0.collections, &v1);
        };
        emit_policy<T0>(arg1, arg2);
    }

    fun emit_policy<T0>(arg0: &0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::Pool<T0>, arg1: address) {
        let v0 = PolicyKey{agent: arg1};
        let (v1, v2) = if (0x2::dynamic_field::exists<PolicyKey>(0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::uid<T0>(arg0), v0)) {
            let v3 = 0x2::dynamic_field::borrow<PolicyKey, NftPolicy>(0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::uid<T0>(arg0), v0);
            (v3.max_price, 0x2::vec_set::length<0x1::type_name::TypeName>(&v3.collections))
        } else {
            (0, 0)
        };
        let v4 = NftPolicySet{
            pool_id     : 0x2::object::id<0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::Pool<T0>>(arg0),
            agent       : arg1,
            max_price   : v1,
            collections : v2,
        };
        0x2::event::emit<NftPolicySet>(v4);
    }

    public fun finish_purchase<T0, T1: store + key>(arg0: Purchase<T0>, arg1: &0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::Platform, arg2: &mut 0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::Pool<T0>, arg3: 0x2::kiosk::Kiosk, arg4: 0x2::kiosk::KioskOwnerCap, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        let Purchase {
            pool_id    : v0,
            owner      : v1,
            agent      : v2,
            item_id    : v3,
            collection : v4,
            adapter    : v5,
            kiosk_id   : v6,
            quoted     : v7,
            fee        : v8,
        } = arg0;
        assert!(v0 == 0x2::object::id<0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::Pool<T0>>(arg2), 308);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(&arg3) == v6 && 0x2::kiosk::kiosk_owner_cap_for(&arg4) == v6, 306);
        assert!(v4 == 0x1::type_name::with_defining_ids<T1>(), 308);
        assert!(0x2::kiosk::has_item_with_type<T1>(&arg3, v3), 307);
        assert!(0x2::kiosk::item_count(&arg3) == 1, 306);
        assert!(!0x2::kiosk::is_listed(&arg3, v3) && !0x2::kiosk::is_listed_exclusively(&arg3, v3), 311);
        let v9 = 0x2::coin::value<T0>(&arg5);
        assert!(v9 <= v7, 308);
        let v10 = v7 - v9;
        let v11 = purchase_fee(arg1, v10);
        let v12 = v8;
        0x2::coin::join<T0>(&mut arg5, 0x2::coin::from_balance<T0>(v12, arg6));
        if (v11 > 0) {
            let v13 = 0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::treasury(arg1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v12, v11), arg6), v13);
            let v14 = PurchaseFeePaid{
                pool_id  : v0,
                agent    : v2,
                item_id  : v3,
                amount   : v11,
                treasury : v13,
            };
            0x2::event::emit<PurchaseFeePaid>(v14);
        } else {
            0x2::balance::destroy_zero<T0>(0x2::balance::split<T0>(&mut v12, v11));
        };
        if (0x2::coin::value<T0>(&arg5) > 0) {
            0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::refund_purchase<T0>(arg2, v2, arg5);
        } else {
            0x2::coin::destroy_zero<T0>(arg5);
        };
        0x2::kiosk::set_owner_custom(&mut arg3, &arg4, v1);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(arg3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(arg4, v1);
        let v15 = NftBought{
            pool_id    : v0,
            owner      : v1,
            kiosk_id   : v6,
            agent      : v2,
            item_id    : v3,
            collection : v4,
            market     : v5,
            paid       : v10 + v11,
        };
        0x2::event::emit<NftBought>(v15);
    }

    public fun is_adapter<T0: drop>(arg0: &0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::Platform) : bool {
        let v0 = AdapterKey{witness: 0x1::type_name::with_defining_ids<T0>()};
        0x2::dynamic_field::exists<AdapterKey>(0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::uid(arg0), v0)
    }

    public fun nft_max<T0>(arg0: &0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::Pool<T0>, arg1: address) : u64 {
        let v0 = PolicyKey{agent: arg1};
        if (!0x2::dynamic_field::exists<PolicyKey>(0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::uid<T0>(arg0), v0)) {
            return 0
        };
        0x2::dynamic_field::borrow<PolicyKey, NftPolicy>(0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::uid<T0>(arg0), v0).max_price
    }

    fun policy_mut<T0>(arg0: &mut 0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::Pool<T0>, arg1: address) : &mut NftPolicy {
        let v0 = PolicyKey{agent: arg1};
        if (!0x2::dynamic_field::exists<PolicyKey>(0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::uid<T0>(arg0), v0)) {
            let v1 = NftPolicy{
                collections : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
                max_price   : 0,
            };
            0x2::dynamic_field::add<PolicyKey, NftPolicy>(0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::uid_mut<T0>(arg0), v0, v1);
        };
        0x2::dynamic_field::borrow_mut<PolicyKey, NftPolicy>(0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::uid_mut<T0>(arg0), v0)
    }

    public fun purchase_fee(arg0: &0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::Platform, arg1: u64) : u64 {
        (((arg1 as u128) * (purchase_fee_bps(arg0) as u128) / 10000) as u64)
    }

    public fun purchase_fee_bps(arg0: &0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::Platform) : u64 {
        let v0 = FeeKey{dummy_field: false};
        if (0x2::dynamic_field::exists<FeeKey>(0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::uid(arg0), v0)) {
            let v2 = FeeKey{dummy_field: false};
            *0x2::dynamic_field::borrow<FeeKey, u64>(0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::uid(arg0), v2)
        } else {
            0
        }
    }

    public fun purchase_owner<T0>(arg0: &Purchase<T0>) : address {
        arg0.owner
    }

    public fun register_adapter<T0: drop>(arg0: &0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::AdminCap, arg1: &mut 0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::Platform) {
        let v0 = AdapterKey{witness: 0x1::type_name::with_defining_ids<T0>()};
        if (!0x2::dynamic_field::exists<AdapterKey>(0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::uid(arg1), v0)) {
            0x2::dynamic_field::add<AdapterKey, bool>(0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::uid_mut(arg1), v0, true);
        };
    }

    public fun set_nft_max<T0>(arg0: &0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::OwnerCap, arg1: &mut 0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::Pool<T0>, arg2: address, arg3: u64) {
        0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::pool::assert_owner_cap<T0>(arg0, arg1);
        let v0 = policy_mut<T0>(arg1, arg2);
        v0.max_price = arg3;
        emit_policy<T0>(arg1, arg2);
    }

    public fun set_purchase_fee(arg0: &0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::AdminCap, arg1: &mut 0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::Platform, arg2: u64) {
        assert!(arg2 <= 100, 310);
        let v0 = FeeKey{dummy_field: false};
        if (0x2::dynamic_field::exists<FeeKey>(0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::uid(arg1), v0)) {
            let v1 = FeeKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<FeeKey, u64>(0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::uid_mut(arg1), v1) = arg2;
        } else {
            let v2 = FeeKey{dummy_field: false};
            0x2::dynamic_field::add<FeeKey, u64>(0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::uid_mut(arg1), v2, arg2);
        };
        let v3 = PurchaseFeeSet{bps: arg2};
        0x2::event::emit<PurchaseFeeSet>(v3);
    }

    public fun unregister_adapter<T0: drop>(arg0: &0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::AdminCap, arg1: &mut 0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::Platform) {
        let v0 = AdapterKey{witness: 0x1::type_name::with_defining_ids<T0>()};
        if (0x2::dynamic_field::exists<AdapterKey>(0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::uid(arg1), v0)) {
            0x2::dynamic_field::remove<AdapterKey, bool>(0x97dde98c62fe7d073925b6154d352152996748f27046fca1e790c612fc7827e2::platform::uid_mut(arg1), v0);
        };
    }

    // decompiled from Move bytecode v7
}

