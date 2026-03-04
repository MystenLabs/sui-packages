module 0x1906a868f05cec861532d92aa49059580caf72d900ba2c387d5135b6a9727f52::share {
    struct SharedObjectRef has drop, store {
        objectId: 0x1::string::String,
        initialSharedVersion: 0x1::string::String,
        mutable: bool,
    }

    public fun new_shared_object_ref(arg0: &0x1906a868f05cec861532d92aa49059580caf72d900ba2c387d5135b6a9727f52::admin::AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: bool) : SharedObjectRef {
        SharedObjectRef{
            objectId             : arg1,
            initialSharedVersion : arg2,
            mutable              : arg3,
        }
    }

    // decompiled from Move bytecode v6
}

