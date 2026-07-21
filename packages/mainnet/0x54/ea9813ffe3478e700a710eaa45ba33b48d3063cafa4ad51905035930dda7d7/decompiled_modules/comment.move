module 0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::comment {
    struct CommentPostedEvent<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        comment_id: address,
        author: address,
        reply_to: 0x1::option::Option<address>,
        body: 0x1::string::String,
    }

    public fun max_comment_len() : u64 {
        15000
    }

    public fun post<T0, T1>(arg0: &0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::LaunchpadConfig, arg1: &0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::Pool<T0, T1>, arg2: 0x1::string::String, arg3: 0x1::option::Option<address>, arg4: &mut 0x2::tx_context::TxContext) {
        0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::assert_version(arg0);
        0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::config::assert_not_paused(arg0);
        assert!(!0x1::string::is_empty(&arg2), 1);
        assert!(0x1::string::length(&arg2) <= 15000, 2);
        let v0 = CommentPostedEvent<T0, T1>{
            pool_id    : 0x2::object::id<0x54ea9813ffe3478e700a710eaa45ba33b48d3063cafa4ad51905035930dda7d7::pool::Pool<T0, T1>>(arg1),
            comment_id : 0x2::tx_context::fresh_object_address(arg4),
            author     : 0x2::tx_context::sender(arg4),
            reply_to   : arg3,
            body       : arg2,
        };
        0x2::event::emit<CommentPostedEvent<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v7
}

