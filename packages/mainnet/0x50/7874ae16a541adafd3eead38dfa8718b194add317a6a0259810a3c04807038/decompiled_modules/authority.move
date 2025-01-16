module 0x507874ae16a541adafd3eead38dfa8718b194add317a6a0259810a3c04807038::authority {
    struct Authority has key {
        id: 0x2::object::UID,
        network: 0x1::string::String,
        service: 0x1::string::String,
        version: 0x1::string::String,
    }

    struct AuthorityCap has key {
        id: 0x2::object::UID,
        authority_id: 0x2::object::ID,
    }

    public fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Authority{
            id      : 0x2::object::new(arg3),
            network : arg0,
            service : arg1,
            version : arg2,
        };
        0x2::transfer::share_object<Authority>(v0);
    }

    public fun destroy(arg0: AuthorityCap, arg1: Authority) {
        let Authority {
            id      : v0,
            network : _,
            service : _,
            version : _,
        } = arg1;
        0x2::object::delete(v0);
        let AuthorityCap {
            id           : v4,
            authority_id : _,
        } = arg0;
        0x2::object::delete(v4);
    }

    public fun id(arg0: &Authority) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun network(arg0: &Authority) : 0x1::string::String {
        arg0.network
    }

    public fun service(arg0: &Authority) : 0x1::string::String {
        arg0.service
    }

    public fun update_version(arg0: &mut Authority, arg1: &AuthorityCap, arg2: 0x1::string::String) {
        assert!(arg1.authority_id == id(arg0), 0);
        arg0.version = arg2;
    }

    public fun version(arg0: &Authority) : 0x1::string::String {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

