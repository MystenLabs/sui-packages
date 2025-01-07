module 0x66931a1c0dce48df64b278f369a4aa7f138ddb42827b97013686734bf85be1a::login_blockbolt {
    struct LoginDetails has store, key {
        id: 0x2::object::UID,
        merchant_id: u64,
        protocol_name: 0x1::string::String,
        merchant_name: 0x1::string::String,
    }

    struct Whitelist has store, key {
        id: 0x2::object::UID,
        address: 0x1::option::Option<address>,
        status: bool,
    }

    public entry fun create_obj(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg0);
        let v0 = Whitelist{
            id      : 0x2::object::new(arg0),
            address : 0x1::option::none<address>(),
            status  : false,
        };
        0x2::transfer::share_object<Whitelist>(v0);
    }

    public entry fun login(arg0: u64, arg1: 0x1::string::String, arg2: &mut Whitelist, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0x1::option::fill<address>(&mut arg2.address, v0);
        arg2.status = true;
        let v1 = LoginDetails{
            id            : 0x2::object::new(arg3),
            merchant_id   : arg0,
            protocol_name : 0x1::string::utf8(b"Powered by BlockBolt"),
            merchant_name : arg1,
        };
        0x2::transfer::transfer<LoginDetails>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

