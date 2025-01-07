module 0x904b221c8e883c3c3046c865d045027cc9defea75073930dae8c58cee7ada965::ido {
    struct IdoDetails has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        start_date: 0x1::string::String,
        end_date: 0x1::string::String,
        whitelist: 0x2::vec_map::VecMap<address, u64>,
        admin: address,
    }

    public entry fun create(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = IdoDetails{
            id         : 0x2::object::new(arg3),
            title      : arg0,
            start_date : arg1,
            end_date   : arg2,
            whitelist  : 0x2::vec_map::empty<address, u64>(),
            admin      : 0x2::tx_context::sender(arg3),
        };
        0x2::transfer::share_object<IdoDetails>(v0);
    }

    // decompiled from Move bytecode v6
}

