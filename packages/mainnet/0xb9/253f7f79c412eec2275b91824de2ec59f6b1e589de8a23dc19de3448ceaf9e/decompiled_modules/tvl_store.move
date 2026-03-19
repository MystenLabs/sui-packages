module 0xb9253f7f79c412eec2275b91824de2ec59f6b1e589de8a23dc19de3448ceaf9e::tvl_store {
    struct TvlStore has key {
        id: 0x2::object::UID,
        last_update_ms: u64,
        num_protocols: u64,
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TvlStore{
            id             : 0x2::object::new(arg0),
            last_update_ms : 0,
            num_protocols  : 0,
        };
        0x2::transfer::share_object<TvlStore>(v0);
    }

    public fun get_tvl(arg0: &TvlStore, arg1: u8) : u64 {
        let v0 = tvl_key(arg1);
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, v0)
        } else {
            0
        }
    }

    public fun last_update_ms(arg0: &TvlStore) : u64 {
        arg0.last_update_ms
    }

    public fun push_tvls(arg0: &mut TvlStore, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) {
        let v0 = &mut arg0.id;
        set_tvl(v0, 1, arg1);
        let v1 = &mut arg0.id;
        set_tvl(v1, 2, arg2);
        let v2 = &mut arg0.id;
        set_tvl(v2, 3, arg3);
        let v3 = &mut arg0.id;
        set_tvl(v3, 4, arg4);
        let v4 = &mut arg0.id;
        set_tvl(v4, 6, arg5);
        let v5 = &mut arg0.id;
        set_tvl(v5, 7, arg6);
        let v6 = &mut arg0.id;
        set_tvl(v6, 8, arg7);
        arg0.last_update_ms = 0x2::clock::timestamp_ms(arg8);
        arg0.num_protocols = 7;
    }

    fun set_tvl(arg0: &mut 0x2::object::UID, arg1: u8, arg2: u64) {
        let v0 = tvl_key(arg1);
        if (0x2::dynamic_field::exists_<0x1::string::String>(arg0, v0)) {
            *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(arg0, v0) = arg2;
        } else {
            0x2::dynamic_field::add<0x1::string::String, u64>(arg0, v0, arg2);
        };
    }

    fun tvl_key(arg0: u8) : 0x1::string::String {
        let v0 = b"tvl_";
        0x1::vector::push_back<u8>(&mut v0, arg0);
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

