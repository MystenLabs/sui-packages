module 0x2f7ac6243d91340358f43ca17a38516caac6fb52effa7a8fe5c5f5e64a024ed3::presign_cap {
    struct PresignCap has store, key {
        id: 0x2::object::UID,
        app_type_name: 0x1::type_name::TypeName,
        wallet_key: u64,
        cap: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap,
    }

    public(friend) fun new(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap, arg3: &mut 0x2::tx_context::TxContext) : PresignCap {
        PresignCap{
            id            : 0x2::object::new(arg3),
            app_type_name : arg0,
            wallet_key    : arg1,
            cap           : arg2,
        }
    }

    public(friend) fun destroy(arg0: PresignCap) : (0x1::type_name::TypeName, u64, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap) {
        let PresignCap {
            id            : v0,
            app_type_name : v1,
            wallet_key    : v2,
            cap           : v3,
        } = arg0;
        0x2::object::delete(v0);
        (v1, v2, v3)
    }

    public fun wallet_key(arg0: &PresignCap) : u64 {
        arg0.wallet_key
    }

    // decompiled from Move bytecode v6
}

