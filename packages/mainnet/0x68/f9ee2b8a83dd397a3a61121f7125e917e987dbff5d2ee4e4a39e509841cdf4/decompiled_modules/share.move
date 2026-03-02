module 0x68f9ee2b8a83dd397a3a61121f7125e917e987dbff5d2ee4e4a39e509841cdf4::share {
    struct SharedObjectRef has drop, store {
        objectId: 0x1::string::String,
        initialSharedVersion: 0x1::string::String,
        mutable: bool,
    }

    public fun new_shared_object_ref(arg0: &0x68f9ee2b8a83dd397a3a61121f7125e917e987dbff5d2ee4e4a39e509841cdf4::admin::AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: bool) : SharedObjectRef {
        SharedObjectRef{
            objectId             : arg1,
            initialSharedVersion : arg2,
            mutable              : arg3,
        }
    }

    // decompiled from Move bytecode v6
}

