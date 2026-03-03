module 0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::share {
    struct SharedObjectRef has drop, store {
        objectId: 0x1::string::String,
        initialSharedVersion: 0x1::string::String,
        mutable: bool,
    }

    public fun new_shared_object_ref(arg0: &0x164e001fa5d7b7aa147cc501fe38108693aa5f4621d6d9a9d755d9f43c97d976::admin::AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: bool) : SharedObjectRef {
        SharedObjectRef{
            objectId             : arg1,
            initialSharedVersion : arg2,
            mutable              : arg3,
        }
    }

    // decompiled from Move bytecode v6
}

