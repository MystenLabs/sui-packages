module 0x9c2437a98b78d3ecbc1afca8abbd40ce5f74522545be998cb2fcf657adf0b510::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        entries: 0x2::table::Table<0x1::string::String, Listing>,
    }

    struct Listing has store {
        publisher: address,
        package_id: address,
        manifest_uri: 0x1::string::String,
        manifest_hash: vector<u8>,
        version: u64,
        updated_at_ms: u64,
    }

    struct Registered has copy, drop {
        service_type: 0x1::string::String,
        package_id: address,
        publisher: address,
        manifest_uri: 0x1::string::String,
        manifest_hash: vector<u8>,
        version: u64,
        timestamp_ms: u64,
    }

    struct Updated has copy, drop {
        service_type: 0x1::string::String,
        package_id: address,
        publisher: address,
        manifest_uri: 0x1::string::String,
        manifest_hash: vector<u8>,
        version: u64,
        timestamp_ms: u64,
    }

    struct Unlisted has copy, drop {
        service_type: 0x1::string::String,
        publisher: address,
        timestamp_ms: u64,
    }

    struct Attested has copy, drop {
        service_type: 0x1::string::String,
        attester: address,
        score: u8,
        comment_uri: 0x1::string::String,
        timestamp_ms: u64,
    }

    public fun attest(arg0: &Registry, arg1: 0x1::string::String, arg2: u8, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::string::String, Listing>(&arg0.entries, arg1), 1);
        assert!(arg2 >= 1 && arg2 <= 5, 3);
        let v0 = Attested{
            service_type : arg1,
            attester     : 0x2::tx_context::sender(arg5),
            score        : arg2,
            comment_uri  : arg3,
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<Attested>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id      : 0x2::object::new(arg0),
            entries : 0x2::table::new<0x1::string::String, Listing>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun is_listed(arg0: &Registry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, Listing>(&arg0.entries, arg1)
    }

    public fun listing(arg0: &Registry, arg1: 0x1::string::String) : (address, address, 0x1::string::String, vector<u8>, u64, u64) {
        let v0 = 0x2::table::borrow<0x1::string::String, Listing>(&arg0.entries, arg1);
        (v0.publisher, v0.package_id, v0.manifest_uri, v0.manifest_hash, v0.version, v0.updated_at_ms)
    }

    public fun register(arg0: &mut Registry, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<0x1::string::String, Listing>(&arg0.entries, arg2), 0);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = Listing{
            publisher     : v0,
            package_id    : arg1,
            manifest_uri  : arg3,
            manifest_hash : arg4,
            version       : 1,
            updated_at_ms : v1,
        };
        0x2::table::add<0x1::string::String, Listing>(&mut arg0.entries, arg2, v2);
        let v3 = Registered{
            service_type  : arg2,
            package_id    : arg1,
            publisher     : v0,
            manifest_uri  : arg3,
            manifest_hash : arg4,
            version       : 1,
            timestamp_ms  : v1,
        };
        0x2::event::emit<Registered>(v3);
    }

    public fun unlist(arg0: &mut Registry, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::string::String, Listing>(&arg0.entries, arg1), 1);
        let v0 = 0x2::table::borrow<0x1::string::String, Listing>(&arg0.entries, arg1).publisher;
        assert!(v0 == 0x2::tx_context::sender(arg3), 2);
        let Listing {
            publisher     : _,
            package_id    : _,
            manifest_uri  : _,
            manifest_hash : _,
            version       : _,
            updated_at_ms : _,
        } = 0x2::table::remove<0x1::string::String, Listing>(&mut arg0.entries, arg1);
        let v7 = Unlisted{
            service_type : arg1,
            publisher    : v0,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<Unlisted>(v7);
    }

    public fun update(arg0: &mut Registry, arg1: 0x1::string::String, arg2: address, arg3: 0x1::string::String, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::string::String, Listing>(&arg0.entries, arg1), 1);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, Listing>(&mut arg0.entries, arg1);
        assert!(v0.publisher == 0x2::tx_context::sender(arg6), 2);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        v0.package_id = arg2;
        v0.manifest_uri = arg3;
        v0.manifest_hash = arg4;
        v0.version = v0.version + 1;
        v0.updated_at_ms = v1;
        let v2 = Updated{
            service_type  : arg1,
            package_id    : arg2,
            publisher     : v0.publisher,
            manifest_uri  : arg3,
            manifest_hash : arg4,
            version       : v0.version,
            timestamp_ms  : v1,
        };
        0x2::event::emit<Updated>(v2);
    }

    // decompiled from Move bytecode v7
}

