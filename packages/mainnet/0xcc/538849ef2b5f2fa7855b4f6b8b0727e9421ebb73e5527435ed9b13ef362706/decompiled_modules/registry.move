module 0xcc538849ef2b5f2fa7855b4f6b8b0727e9421ebb73e5527435ed9b13ef362706::registry {
    struct Entry has drop, store {
        blob_id: 0x1::string::String,
        image_hash: 0x1::string::String,
        prompt: 0x1::string::String,
        timestamp: u64,
        creator: address,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        entries: 0x2::table::Table<0x1::string::String, Entry>,
        total: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id      : 0x2::object::new(arg0),
            entries : 0x2::table::new<0x1::string::String, Entry>(arg0),
            total   : 0,
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun is_registered(arg0: &Registry, arg1: &0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, Entry>(&arg0.entries, *arg1)
    }

    public entry fun register(arg0: &mut Registry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Entry{
            blob_id    : arg1,
            image_hash : arg2,
            prompt     : arg3,
            timestamp  : arg4,
            creator    : 0x2::tx_context::sender(arg5),
        };
        0x2::table::add<0x1::string::String, Entry>(&mut arg0.entries, arg1, v0);
        arg0.total = arg0.total + 1;
    }

    public fun total(arg0: &Registry) : u64 {
        arg0.total
    }

    // decompiled from Move bytecode v7
}

