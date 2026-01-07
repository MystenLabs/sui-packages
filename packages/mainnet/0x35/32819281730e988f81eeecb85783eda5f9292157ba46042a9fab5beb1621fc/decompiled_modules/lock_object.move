module 0x3532819281730e988f81eeecb85783eda5f9292157ba46042a9fab5beb1621fc::lock_object {
    struct LOCK_OBJECT has drop {
        dummy_field: bool,
    }

    struct LockedObject<T0: store + key> has store, key {
        id: 0x2::object::UID,
        recipient: address,
        object: T0,
        unlock_time: u64,
    }

    public fun id<T0: store + key>(arg0: &LockedObject<T0>) : 0x2::object::ID {
        0x2::object::id<LockedObject<T0>>(arg0)
    }

    public fun claim<T0: store + key>(arg0: LockedObject<T0>, arg1: &0x3532819281730e988f81eeecb85783eda5f9292157ba46042a9fab5beb1621fc::version::VersionRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.recipient, 0x3532819281730e988f81eeecb85783eda5f9292157ba46042a9fab5beb1621fc::error::eunauthorized());
        0x3532819281730e988f81eeecb85783eda5f9292157ba46042a9fab5beb1621fc::version::check_version(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.unlock_time, 0x3532819281730e988f81eeecb85783eda5f9292157ba46042a9fab5beb1621fc::error::eobject_still_locked());
        let v1 = arg0.recipient;
        let LockedObject {
            id          : v2,
            recipient   : _,
            object      : v4,
            unlock_time : _,
        } = arg0;
        0x2::object::delete(v2);
        0x2::transfer::public_transfer<T0>(v4, v1);
        0x3532819281730e988f81eeecb85783eda5f9292157ba46042a9fab5beb1621fc::events::emit_object_unlocked(0x2::object::id<LockedObject<T0>>(&arg0), 0x2::object::id<T0>(&arg0.object), v1, v0);
    }

    public fun get_locked_object_id<T0: store + key>(arg0: &LockedObject<T0>) : 0x2::object::ID {
        0x2::object::id<T0>(&arg0.object)
    }

    public fun get_unlock_time<T0: store + key>(arg0: &LockedObject<T0>) : u64 {
        arg0.unlock_time
    }

    fun init(arg0: LOCK_OBJECT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<LOCK_OBJECT>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public(friend) fun new_locked_object<T0: store + key>(arg0: address, arg1: T0, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : LockedObject<T0> {
        assert!(arg2 > arg3, 0x3532819281730e988f81eeecb85783eda5f9292157ba46042a9fab5beb1621fc::error::einvalid_unlock_time());
        LockedObject<T0>{
            id          : 0x2::object::new(arg4),
            recipient   : arg0,
            object      : arg1,
            unlock_time : arg2,
        }
    }

    public fun recipient<T0: store + key>(arg0: &LockedObject<T0>) : address {
        arg0.recipient
    }

    public fun strategy_type() : u8 {
        (4 as u8)
    }

    // decompiled from Move bytecode v6
}

