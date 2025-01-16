module 0xc2adc4a401903daf00498ca067e072bc3534029e2c4dbe006293ab0fbf4282c0::authority {
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

    struct AuthorityCreatedEvent has copy, drop {
        authority_id: 0x2::object::ID,
        authority_cap_id: 0x2::object::ID,
        network: 0x1::string::String,
        environment: 0x1::string::String,
        service: 0x1::string::String,
        version: 0x1::string::String,
    }

    struct AuthorityDestroyedEvent has copy, drop {
        authority_id: 0x2::object::ID,
    }

    struct AuthorityUpdatedEvent has copy, drop {
        authority_id: 0x2::object::ID,
        from_version: 0x1::string::String,
        to_version: 0x1::string::String,
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
        let v2 = AuthorityCreatedEvent{
            authority_id     : id(&v0),
            authority_cap_id : 0x2::object::uid_to_inner(&v1.id),
            network          : v0.network,
            environment      : v0.environment,
            service          : v0.service,
            version          : v0.version,
        };
        0x2::event::emit<AuthorityCreatedEvent>(v2);
        0x2::transfer::share_object<Authority>(v0);
        v1
    }

    public fun destroy(arg0: AuthorityCap, arg1: Authority) {
        let v0 = AuthorityDestroyedEvent{authority_id: id(&arg1)};
        0x2::event::emit<AuthorityDestroyedEvent>(v0);
        let Authority {
            id          : v1,
            network     : _,
            environment : _,
            service     : _,
            version     : _,
        } = arg1;
        0x2::object::delete(v1);
        let AuthorityCap {
            id           : v6,
            authority_id : _,
        } = arg0;
        0x2::object::delete(v6);
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
        let v0 = AuthorityUpdatedEvent{
            authority_id : id(arg0),
            from_version : arg0.version,
            to_version   : arg0.version,
        };
        0x2::event::emit<AuthorityUpdatedEvent>(v0);
    }

    public fun version(arg0: &Authority) : 0x1::string::String {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

