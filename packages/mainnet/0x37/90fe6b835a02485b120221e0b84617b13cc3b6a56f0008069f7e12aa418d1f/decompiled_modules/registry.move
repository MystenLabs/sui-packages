module 0x3790fe6b835a02485b120221e0b84617b13cc3b6a56f0008069f7e12aa418d1f::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        entries: 0x2::table::Table<0x1::string::String, Listing>,
    }

    struct Listing has store {
        author: address,
        ir_uri: 0x1::string::String,
        ir_hash: vector<u8>,
        alpha_uri: 0x1::string::String,
        alpha_hash: vector<u8>,
        fee_model: u8,
        version: u64,
        updated_at_ms: u64,
    }

    struct AuthorCap has store, key {
        id: 0x2::object::UID,
        strategy_id: 0x1::string::String,
    }

    struct Registered has copy, drop {
        strategy_id: 0x1::string::String,
        author: address,
        ir_uri: 0x1::string::String,
        ir_hash: vector<u8>,
        alpha_uri: 0x1::string::String,
        alpha_hash: vector<u8>,
        fee_model: u8,
        version: u64,
        timestamp_ms: u64,
    }

    struct Updated has copy, drop {
        strategy_id: 0x1::string::String,
        author: address,
        ir_uri: 0x1::string::String,
        alpha_uri: 0x1::string::String,
        fee_model: u8,
        version: u64,
        timestamp_ms: u64,
    }

    struct Unlisted has copy, drop {
        strategy_id: 0x1::string::String,
        author: address,
        timestamp_ms: u64,
    }

    public fun cap_strategy_id(arg0: &AuthorCap) : 0x1::string::String {
        arg0.strategy_id
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

    public fun listing(arg0: &Registry, arg1: 0x1::string::String) : (address, 0x1::string::String, vector<u8>, 0x1::string::String, vector<u8>, u8, u64, u64) {
        let v0 = 0x2::table::borrow<0x1::string::String, Listing>(&arg0.entries, arg1);
        (v0.author, v0.ir_uri, v0.ir_hash, v0.alpha_uri, v0.alpha_hash, v0.fee_model, v0.version, v0.updated_at_ms)
    }

    public fun register(arg0: &mut Registry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<u8>, arg4: 0x1::string::String, arg5: vector<u8>, arg6: u8, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : AuthorCap {
        assert!(!0x2::table::contains<0x1::string::String, Listing>(&arg0.entries, arg1), 0);
        assert!(arg6 <= 3, 2);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        let v2 = Listing{
            author        : v0,
            ir_uri        : arg2,
            ir_hash       : arg3,
            alpha_uri     : arg4,
            alpha_hash    : arg5,
            fee_model     : arg6,
            version       : 1,
            updated_at_ms : v1,
        };
        0x2::table::add<0x1::string::String, Listing>(&mut arg0.entries, arg1, v2);
        let v3 = Registered{
            strategy_id  : arg1,
            author       : v0,
            ir_uri       : arg2,
            ir_hash      : arg3,
            alpha_uri    : arg4,
            alpha_hash   : arg5,
            fee_model    : arg6,
            version      : 1,
            timestamp_ms : v1,
        };
        0x2::event::emit<Registered>(v3);
        AuthorCap{
            id          : 0x2::object::new(arg8),
            strategy_id : arg1,
        }
    }

    public fun unlist(arg0: &mut Registry, arg1: &AuthorCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::string::String, Listing>(&arg0.entries, arg1.strategy_id), 1);
        let Listing {
            author        : v0,
            ir_uri        : _,
            ir_hash       : _,
            alpha_uri     : _,
            alpha_hash    : _,
            fee_model     : _,
            version       : _,
            updated_at_ms : _,
        } = 0x2::table::remove<0x1::string::String, Listing>(&mut arg0.entries, arg1.strategy_id);
        let v8 = Unlisted{
            strategy_id  : arg1.strategy_id,
            author       : v0,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<Unlisted>(v8);
    }

    public fun update(arg0: &mut Registry, arg1: &AuthorCap, arg2: 0x1::string::String, arg3: vector<u8>, arg4: 0x1::string::String, arg5: vector<u8>, arg6: u8, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::string::String, Listing>(&arg0.entries, arg1.strategy_id), 1);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, Listing>(&mut arg0.entries, arg1.strategy_id);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        v0.ir_uri = arg2;
        v0.ir_hash = arg3;
        v0.alpha_uri = arg4;
        v0.alpha_hash = arg5;
        v0.fee_model = arg6;
        v0.version = v0.version + 1;
        v0.updated_at_ms = v1;
        let v2 = Updated{
            strategy_id  : arg1.strategy_id,
            author       : v0.author,
            ir_uri       : arg2,
            alpha_uri    : arg4,
            fee_model    : arg6,
            version      : v0.version,
            timestamp_ms : v1,
        };
        0x2::event::emit<Updated>(v2);
    }

    // decompiled from Move bytecode v7
}

