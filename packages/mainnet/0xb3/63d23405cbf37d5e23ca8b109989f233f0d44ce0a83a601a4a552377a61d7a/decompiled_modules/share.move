module 0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::share {
    struct SharedObjectRef has drop, store {
        objectId: 0x1::string::String,
        initialSharedVersion: 0x1::string::String,
        mutable: bool,
    }

    public fun new_shared_object_ref(arg0: &0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::admin::AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: bool) : SharedObjectRef {
        SharedObjectRef{
            objectId             : arg1,
            initialSharedVersion : arg2,
            mutable              : arg3,
        }
    }

    // decompiled from Move bytecode v6
}

