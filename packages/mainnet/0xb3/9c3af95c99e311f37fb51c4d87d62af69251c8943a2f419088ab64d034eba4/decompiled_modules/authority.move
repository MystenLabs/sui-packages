module 0xb39c3af95c99e311f37fb51c4d87d62af69251c8943a2f419088ab64d034eba4::authority {
    struct Authority has key {
        id: 0x2::object::UID,
        network: 0x1::string::String,
        environment: 0x1::string::String,
        service: 0x1::string::String,
        version: 0x1::string::String,
    }

    struct AuthorityCap has store, key {
        id: 0x2::object::UID,
        authority_id: 0x2::object::ID,
    }

    public fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : AuthorityCap {
        let v0 = Authority{
            id          : 0x2::object::new(arg4),
            network     : arg0,
            environment : arg1,
            service     : arg2,
            version     : arg3,
        };
        let v1 = AuthorityCap{
            id           : 0x2::object::new(arg4),
            authority_id : id(&v0),
        };
        0x2::transfer::share_object<Authority>(v0);
        v1
    }

    public fun destroy(arg0: AuthorityCap, arg1: Authority) {
        let Authority {
            id          : v0,
            network     : _,
            environment : _,
            service     : _,
            version     : _,
        } = arg1;
        0x2::object::delete(v0);
        let AuthorityCap {
            id           : v5,
            authority_id : _,
        } = arg0;
        0x2::object::delete(v5);
    }

    public fun environment(arg0: &Authority) : 0x1::string::String {
        arg0.environment
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

