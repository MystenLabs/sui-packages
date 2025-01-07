module 0x631889e37e45cda904a7c34dd3b81df6dd4f33ae125bcd231a28c106e1d298ff::router {
    public entry fun add_media_to_pool(arg0: &0x631889e37e45cda904a7c34dd3b81df6dd4f33ae125bcd231a28c106e1d298ff::config::AdminCap, arg1: &mut 0x631889e37e45cda904a7c34dd3b81df6dd4f33ae125bcd231a28c106e1d298ff::config::Config, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        0x631889e37e45cda904a7c34dd3b81df6dd4f33ae125bcd231a28c106e1d298ff::config::add_media_to_pool(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun add_pool_conf(arg0: &0x631889e37e45cda904a7c34dd3b81df6dd4f33ae125bcd231a28c106e1d298ff::config::AdminCap, arg1: &mut 0x631889e37e45cda904a7c34dd3b81df6dd4f33ae125bcd231a28c106e1d298ff::config::Config, arg2: address, arg3: bool, arg4: vector<0x1::string::String>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String) {
        0x631889e37e45cda904a7c34dd3b81df6dd4f33ae125bcd231a28c106e1d298ff::config::add_pool_conf(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun remove_media_from_pool(arg0: &0x631889e37e45cda904a7c34dd3b81df6dd4f33ae125bcd231a28c106e1d298ff::config::AdminCap, arg1: &mut 0x631889e37e45cda904a7c34dd3b81df6dd4f33ae125bcd231a28c106e1d298ff::config::Config, arg2: address, arg3: 0x1::string::String) {
        0x631889e37e45cda904a7c34dd3b81df6dd4f33ae125bcd231a28c106e1d298ff::config::remove_media_from_pool(arg0, arg1, arg2, arg3);
    }

    public entry fun remove_pool_conf(arg0: &0x631889e37e45cda904a7c34dd3b81df6dd4f33ae125bcd231a28c106e1d298ff::config::AdminCap, arg1: &mut 0x631889e37e45cda904a7c34dd3b81df6dd4f33ae125bcd231a28c106e1d298ff::config::Config, arg2: address) {
        0x631889e37e45cda904a7c34dd3b81df6dd4f33ae125bcd231a28c106e1d298ff::config::remove_pool_conf(arg0, arg1, arg2);
    }

    public entry fun update_pool_conf(arg0: &0x631889e37e45cda904a7c34dd3b81df6dd4f33ae125bcd231a28c106e1d298ff::config::AdminCap, arg1: &mut 0x631889e37e45cda904a7c34dd3b81df6dd4f33ae125bcd231a28c106e1d298ff::config::Config, arg2: address, arg3: bool, arg4: vector<0x1::string::String>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String) {
        0x631889e37e45cda904a7c34dd3b81df6dd4f33ae125bcd231a28c106e1d298ff::config::update_pool_conf(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    // decompiled from Move bytecode v6
}

