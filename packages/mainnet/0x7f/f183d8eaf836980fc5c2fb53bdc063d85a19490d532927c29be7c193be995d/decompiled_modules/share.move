module 0x7ff183d8eaf836980fc5c2fb53bdc063d85a19490d532927c29be7c193be995d::share {
    struct SharedObjectRef has drop, store {
        objectId: 0x1::string::String,
        initialSharedVersion: 0x1::string::String,
        mutable: bool,
    }

    public fun new_shared_object_ref(arg0: &0x7ff183d8eaf836980fc5c2fb53bdc063d85a19490d532927c29be7c193be995d::admin::AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: bool) : SharedObjectRef {
        SharedObjectRef{
            objectId             : arg1,
            initialSharedVersion : arg2,
            mutable              : arg3,
        }
    }

    // decompiled from Move bytecode v6
}

