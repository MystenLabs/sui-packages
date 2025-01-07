module 0x60590241a2a2c8099fa314eb53b4bf3dc8d1d0c1181d5e5211a720f3f402dfdb::promises {
    struct Promise has key {
        id: 0x2::object::UID,
        text: 0x1::string::String,
        userAddy: address,
        timestamp: u32,
    }

    struct PromiseStorage has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PromiseStorage{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<PromiseStorage>(v0);
    }

    public fun promise_create(arg0: vector<u8>, arg1: u32, arg2: &mut PromiseStorage, arg3: &mut 0x2::tx_context::TxContext) : address {
        let v0 = Promise{
            id        : 0x2::object::new(arg3),
            text      : 0x1::string::utf8(arg0),
            userAddy  : 0x2::tx_context::sender(arg3),
            timestamp : arg1,
        };
        let v1 = 0x2::object::id<PromiseStorage>(arg2);
        let v2 = 0x2::object::id<Promise>(&v0);
        0x2::transfer::transfer<Promise>(v0, 0x2::object::id_to_address(&v1));
        0x2::object::id_to_address(&v2)
    }

    public fun promise_text(arg0: &Promise) : 0x1::string::String {
        arg0.text
    }

    public fun receive_promise(arg0: &mut PromiseStorage, arg1: 0x2::transfer::Receiving<Promise>) : Promise {
        0x2::transfer::receive<Promise>(&mut arg0.id, arg1)
    }

    public fun timestamp(arg0: &Promise) : u32 {
        arg0.timestamp
    }

    public fun userAddy(arg0: &Promise) : address {
        arg0.userAddy
    }

    // decompiled from Move bytecode v6
}

