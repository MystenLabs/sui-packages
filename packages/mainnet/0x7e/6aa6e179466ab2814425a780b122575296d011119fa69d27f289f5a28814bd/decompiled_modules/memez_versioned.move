module 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_versioned {
    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct VersionChangeCap {
        versioned_id: 0x2::object::ID,
        old_version: u64,
    }

    public(friend) fun create<T0: store + key>(arg0: u64, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) : Versioned {
        let v0 = Versioned{
            id      : 0x2::object::new(arg2),
            version : arg0,
        };
        0x2::dynamic_object_field::add<u64, T0>(&mut v0.id, arg0, arg1);
        v0
    }

    public(friend) fun destroy<T0: store + key>(arg0: Versioned) : T0 {
        let Versioned {
            id      : v0,
            version : v1,
        } = arg0;
        let v2 = v0;
        0x2::object::delete(v2);
        0x2::dynamic_object_field::remove<u64, T0>(&mut v2, v1)
    }

    public(friend) fun load_value<T0: store + key>(arg0: &Versioned) : &T0 {
        0x2::dynamic_object_field::borrow<u64, T0>(&arg0.id, arg0.version)
    }

    public(friend) fun load_value_mut<T0: store + key>(arg0: &mut Versioned) : &mut T0 {
        0x2::dynamic_object_field::borrow_mut<u64, T0>(&mut arg0.id, arg0.version)
    }

    public(friend) fun remove_value_for_upgrade<T0: store + key>(arg0: &mut Versioned) : (T0, VersionChangeCap) {
        let v0 = VersionChangeCap{
            versioned_id : 0x2::object::id<Versioned>(arg0),
            old_version  : arg0.version,
        };
        (0x2::dynamic_object_field::remove<u64, T0>(&mut arg0.id, arg0.version), v0)
    }

    public(friend) fun upgrade<T0: store + key>(arg0: &mut Versioned, arg1: u64, arg2: T0, arg3: VersionChangeCap) {
        let VersionChangeCap {
            versioned_id : v0,
            old_version  : v1,
        } = arg3;
        assert!(v0 == 0x2::object::id<Versioned>(arg0), 20);
        assert!(v1 < arg1, 20);
        0x2::dynamic_object_field::add<u64, T0>(&mut arg0.id, arg1, arg2);
        arg0.version = arg1;
    }

    public(friend) fun version(arg0: &Versioned) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

