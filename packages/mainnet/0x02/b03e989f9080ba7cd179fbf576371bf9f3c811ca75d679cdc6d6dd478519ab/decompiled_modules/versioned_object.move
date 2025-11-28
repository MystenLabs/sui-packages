module 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::versioned_object {
    struct VersionedObject has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct VersionChangeCap {
        versioned_id: 0x2::object::ID,
        old_version: u64,
    }

    public fun create<T0: store + key>(arg0: u64, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) : VersionedObject {
        let v0 = VersionedObject{
            id      : 0x2::object::new(arg2),
            version : arg0,
        };
        0x2::dynamic_object_field::add<u64, T0>(&mut v0.id, arg0, arg1);
        v0
    }

    public fun destroy<T0: store + key>(arg0: VersionedObject) : T0 {
        let VersionedObject {
            id      : v0,
            version : v1,
        } = arg0;
        let v2 = v0;
        0x2::object::delete(v2);
        0x2::dynamic_object_field::remove<u64, T0>(&mut v2, v1)
    }

    public fun load_value<T0: store + key>(arg0: &VersionedObject) : &T0 {
        0x2::dynamic_object_field::borrow<u64, T0>(&arg0.id, arg0.version)
    }

    public fun load_value_mut<T0: store + key>(arg0: &mut VersionedObject) : &mut T0 {
        0x2::dynamic_object_field::borrow_mut<u64, T0>(&mut arg0.id, arg0.version)
    }

    public fun remove_value_for_upgrade<T0: store + key>(arg0: &mut VersionedObject) : (T0, VersionChangeCap) {
        let v0 = VersionChangeCap{
            versioned_id : 0x2::object::id<VersionedObject>(arg0),
            old_version  : arg0.version,
        };
        (0x2::dynamic_object_field::remove<u64, T0>(&mut arg0.id, arg0.version), v0)
    }

    public fun upgrade<T0: store + key>(arg0: &mut VersionedObject, arg1: u64, arg2: T0, arg3: VersionChangeCap) {
        let VersionChangeCap {
            versioned_id : v0,
            old_version  : v1,
        } = arg3;
        assert!(v0 == 0x2::object::id<VersionedObject>(arg0), 0);
        assert!(v1 < arg1, 0);
        0x2::dynamic_object_field::add<u64, T0>(&mut arg0.id, arg1, arg2);
        arg0.version = arg1;
    }

    public fun version(arg0: &VersionedObject) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

