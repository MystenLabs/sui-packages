module 0x6c2c547abd69a924fc371c7ab3b4498f09c38e576374d1e653eb3f8879dbb57d::managed {
    struct EnokiObjects has key {
        id: 0x2::object::UID,
        version: u8,
        managed_objects: 0x2::bag::Bag,
        authorized: 0x2::vec_set::VecSet<address>,
    }

    struct EnokiObjectsCap has store, key {
        id: 0x2::object::UID,
    }

    struct EnokiManagedKey has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct EnokiManagedValue has store {
        custom_id: 0x1::string::String,
        owner: address,
        storage: 0x2::object::UID,
    }

    struct ObjectKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ReturnPromise {
        id: 0x2::object::ID,
    }

    public fun borrow<T0: store + key>(arg0: &mut EnokiObjects, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : (T0, ReturnPromise) {
        validate_version(arg0);
        let v0 = ObjectKey{dummy_field: false};
        let v1 = ReturnPromise{id: arg1};
        (0x2::dynamic_object_field::remove<ObjectKey, T0>(&mut internal_get_value(arg0, arg1, arg2).storage, v0), v1)
    }

    public fun attach_object<T0: store + key>(arg0: &mut EnokiObjects, arg1: T0, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        validate_version(arg0);
        let v0 = EnokiManagedKey{id: 0x2::object::id<T0>(&arg1)};
        let v1 = EnokiManagedValue{
            custom_id : arg2,
            owner     : 0x2::tx_context::sender(arg3),
            storage   : 0x2::object::new(arg3),
        };
        let v2 = ObjectKey{dummy_field: false};
        0x2::dynamic_object_field::add<ObjectKey, T0>(&mut v1.storage, v2, arg1);
        0x2::bag::add<EnokiManagedKey, EnokiManagedValue>(&mut arg0.managed_objects, v0, v1);
    }

    public fun authorize(arg0: &mut EnokiObjects, arg1: &EnokiObjectsCap, arg2: address) {
        validate_version(arg0);
        assert!(!0x2::vec_set::contains<address>(&arg0.authorized, &arg2), 0);
        0x2::vec_set::insert<address>(&mut arg0.authorized, arg2);
    }

    public fun borrow_with_custom_id<T0: store + key>(arg0: &mut EnokiObjects, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) : (T0, ReturnPromise) {
        validate_version(arg0);
        let v0 = internal_get_value(arg0, arg1, arg3);
        assert!(v0.custom_id == arg2, 6);
        let v1 = ObjectKey{dummy_field: false};
        let v2 = ReturnPromise{id: arg1};
        (0x2::dynamic_object_field::remove<ObjectKey, T0>(&mut v0.storage, v1), v2)
    }

    public fun deauthorize(arg0: &mut EnokiObjects, arg1: &EnokiObjectsCap, arg2: address) {
        validate_version(arg0);
        assert!(0x2::vec_set::contains<address>(&arg0.authorized, &arg2), 1);
        0x2::vec_set::remove<address>(&mut arg0.authorized, &arg2);
    }

    public fun deauthorize_self(arg0: &mut EnokiObjects, arg1: &0x2::tx_context::TxContext) {
        validate_version(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.authorized, &v0), 1);
        let v1 = 0x2::tx_context::sender(arg1);
        0x2::vec_set::remove<address>(&mut arg0.authorized, &v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = EnokiObjects{
            id              : 0x2::object::new(arg0),
            version         : 1,
            managed_objects : 0x2::bag::new(arg0),
            authorized      : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<EnokiObjects>(v0);
        let v1 = EnokiObjectsCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<EnokiObjectsCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun internal_get_value(arg0: &mut EnokiObjects, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : &mut EnokiManagedValue {
        let v0 = EnokiManagedKey{id: arg1};
        assert!(0x2::bag::contains<EnokiManagedKey>(&arg0.managed_objects, v0), 3);
        let v1 = EnokiManagedKey{id: arg1};
        let v2 = 0x2::bag::borrow_mut<EnokiManagedKey, EnokiManagedValue>(&mut arg0.managed_objects, v1);
        let v3 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.authorized, &v3) || v2.owner == 0x2::tx_context::sender(arg2), 4);
        v2
    }

    public fun put_back<T0: store + key>(arg0: &mut EnokiObjects, arg1: T0, arg2: ReturnPromise, arg3: &0x2::tx_context::TxContext) {
        validate_version(arg0);
        let ReturnPromise { id: v0 } = arg2;
        assert!(0x2::object::id<T0>(&arg1) == v0, 5);
        let v1 = EnokiManagedKey{id: v0};
        let v2 = ObjectKey{dummy_field: false};
        0x2::dynamic_object_field::add<ObjectKey, T0>(&mut 0x2::bag::borrow_mut<EnokiManagedKey, EnokiManagedValue>(&mut arg0.managed_objects, v1).storage, v2, arg1);
    }

    public fun reclaim_object<T0: store + key>(arg0: &mut EnokiObjects, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : T0 {
        validate_version(arg0);
        let v0 = EnokiManagedKey{id: arg1};
        assert!(0x2::bag::contains<EnokiManagedKey>(&arg0.managed_objects, v0), 3);
        let v1 = EnokiManagedKey{id: arg1};
        let EnokiManagedValue {
            custom_id : _,
            owner     : v3,
            storage   : v4,
        } = 0x2::bag::remove<EnokiManagedKey, EnokiManagedValue>(&mut arg0.managed_objects, v1);
        let v5 = v4;
        assert!(v3 == 0x2::tx_context::sender(arg2), 4);
        let v6 = ObjectKey{dummy_field: false};
        0x2::object::delete(v5);
        0x2::dynamic_object_field::remove<ObjectKey, T0>(&mut v5, v6)
    }

    public fun update_version(arg0: &mut EnokiObjects, arg1: &EnokiObjectsCap, arg2: u8) {
        validate_version(arg0);
        arg0.version = arg2;
    }

    fun validate_version(arg0: &EnokiObjects) {
        assert!(arg0.version == 1, 2);
    }

    // decompiled from Move bytecode v6
}

