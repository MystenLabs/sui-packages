module 0x141d8a2333f9369452fe075331924bb98d2abf0ee98de941db85aaf809c4ef54::distribution {
    struct DISTRIBUTION has drop {
        dummy_field: bool,
    }

    struct Distribution has key {
        id: 0x2::object::UID,
    }

    struct ObjectKey<phantom T0> has copy, drop, store {
        domain: 0x1::string::String,
    }

    struct ObjectValue<T0: store> has store {
        object: T0,
        lock_in_kiosk: bool,
    }

    struct LockPromise {
        object_id: 0x2::object::ID,
    }

    public(friend) fun add_nft<T0: store + key>(arg0: &mut Distribution, arg1: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain, arg2: T0, arg3: bool) {
        let v0 = ObjectKey<T0>{domain: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::to_string(&arg1)};
        let v1 = ObjectValue<T0>{
            object        : arg2,
            lock_in_kiosk : arg3,
        };
        0x2::dynamic_field::add<ObjectKey<T0>, ObjectValue<T0>>(&mut arg0.id, v0, v1);
    }

    public fun claim<T0: store + key>(arg0: &mut Distribution, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg2: &0x2::clock::Clock) : T0 {
        let ObjectValue {
            object        : v0,
            lock_in_kiosk : v1,
        } = internal_claim<T0>(arg0, arg1, arg2);
        assert!(!v1, 3);
        v0
    }

    public fun claim_in_kiosk<T0: store + key>(arg0: &mut Distribution, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg2: &0x2::clock::Clock) : (T0, LockPromise) {
        let ObjectValue {
            object        : v0,
            lock_in_kiosk : v1,
        } = internal_claim<T0>(arg0, arg1, arg2);
        let v2 = v0;
        assert!(v1, 4);
        let v3 = LockPromise{object_id: 0x2::object::id<T0>(&v2)};
        (v2, v3)
    }

    fun init(arg0: DISTRIBUTION, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<DISTRIBUTION>(arg0, arg1);
        let v0 = Distribution{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<Distribution>(v0);
    }

    fun internal_claim<T0: store>(arg0: &mut Distribution, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg2: &0x2::clock::Clock) : ObjectValue<T0> {
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg1);
        let v1 = ObjectKey<T0>{domain: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::to_string(&v0)};
        assert!(0x2::dynamic_field::exists_with_type<ObjectKey<T0>, ObjectValue<T0>>(&arg0.id, v1), 1);
        assert!(!0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::has_expired(arg1, arg2), 2);
        0x2::dynamic_field::remove<ObjectKey<T0>, ObjectValue<T0>>(&mut arg0.id, v1)
    }

    public fun prove_locked(arg0: LockPromise, arg1: &0x2::kiosk::Kiosk) {
        let LockPromise { object_id: v0 } = arg0;
        assert!(0x2::kiosk::is_locked(arg1, v0), 5);
    }

    // decompiled from Move bytecode v6
}

