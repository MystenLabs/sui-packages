module 0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::admin {
    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::create(0x2::tx_context::sender(arg0), arg0);
    }

    public fun removeAdmin(arg0: &mut 0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::Admin, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::is_admin(arg0, v0), 3);
        assert!(arg1 != v0, 100);
        0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::remove_admin(arg0, arg1);
    }

    public fun setAdmin(arg0: &mut 0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::Admin, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::is_admin(arg0, 0x2::tx_context::sender(arg2)), 3);
        0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::set_admin(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

