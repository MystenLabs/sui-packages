module 0xfa91e9dcff56cc0f47cd3b844543b111f5625b605d5db5042b37572112f506d6::object_lock {
    struct ObjectLockVault has store, key {
        id: 0x2::object::UID,
        locked_object_count: u64,
    }

    struct LockedObjectWrapper<T0: store + key> has store, key {
        id: 0x2::object::UID,
        owner: address,
        obj: T0,
        invoice: vector<u8>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ObjectLockVault{
            id                  : 0x2::object::new(arg0),
            locked_object_count : 0,
        };
        0x2::transfer::share_object<ObjectLockVault>(v0);
    }

    public entry fun lock_with_hash<T0: store + key>(arg0: &mut ObjectLockVault, arg1: vector<u8>, arg2: T0, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = LockedObjectWrapper<T0>{
            id      : 0x2::object::new(arg4),
            owner   : 0x2::tx_context::sender(arg4),
            obj     : arg2,
            invoice : arg3,
        };
        0x2::dynamic_object_field::add<vector<u8>, LockedObjectWrapper<T0>>(&mut arg0.id, arg1, v0);
        arg0.locked_object_count = arg0.locked_object_count + 1;
    }

    public fun unlock_with_preimage<T0: store + key>(arg0: &mut ObjectLockVault, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : T0 {
        let LockedObjectWrapper {
            id      : v0,
            owner   : _,
            obj     : v2,
            invoice : _,
        } = 0x2::dynamic_object_field::remove<vector<u8>, LockedObjectWrapper<T0>>(&mut arg0.id, arg1);
        0x2::object::delete(v0);
        arg0.locked_object_count = arg0.locked_object_count - 1;
        v2
    }

    // decompiled from Move bytecode v6
}

