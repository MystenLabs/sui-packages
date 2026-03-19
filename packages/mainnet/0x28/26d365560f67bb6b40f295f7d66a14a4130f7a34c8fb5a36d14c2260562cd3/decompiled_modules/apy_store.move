module 0x2826d365560f67bb6b40f295f7d66a14a4130f7a34c8fb5a36d14c2260562cd3::apy_store {
    struct ApyStore has key {
        id: 0x2::object::UID,
    }

    struct ApysUpdatedEvent has copy, drop {
        timestamp_ms: u64,
    }

    public fun create_store(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ApyStore{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<ApyStore>(v0);
    }

    public fun get_apy(arg0: &ApyStore, arg1: u8) : u64 {
        let v0 = b"apy_";
        0x1::vector::push_back<u8>(&mut v0, arg1);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, v0)
        } else {
            0
        }
    }

    public fun push_base_apys(arg0: &mut ApyStore, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) {
        set_apy(arg0, 1, arg1);
        set_apy(arg0, 2, arg2);
        set_apy(arg0, 3, arg3);
        set_apy(arg0, 4, arg4);
        set_apy(arg0, 6, arg5);
        set_apy(arg0, 7, arg6);
        set_apy(arg0, 8, arg7);
        let v0 = ApysUpdatedEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg8)};
        0x2::event::emit<ApysUpdatedEvent>(v0);
    }

    fun set_apy(arg0: &mut ApyStore, arg1: u8, arg2: u64) {
        let v0 = if (arg2 > 20000) {
            20000
        } else {
            arg2
        };
        let v1 = b"apy_";
        0x1::vector::push_back<u8>(&mut v1, arg1);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v1)) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg0.id, v1) = v0;
        } else {
            0x2::dynamic_field::add<vector<u8>, u64>(&mut arg0.id, v1, v0);
        };
    }

    // decompiled from Move bytecode v6
}

