module 0x77bf6a36c2236579f084d7c66ad16b3da3277982d958e43f3d716c81ebe43f61::access {
    struct ACCESS has drop {
        dummy_field: bool,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        policy: 0x2::object::ID,
    }

    struct AccessPolicy has key {
        id: 0x2::object::UID,
        owner: address,
        grants: 0x2::table::Table<0x1::string::String, bool>,
        receipt_count: u64,
        chain_head: vector<u8>,
    }

    struct Receipt has store, key {
        id: 0x2::object::UID,
        policy: 0x2::object::ID,
        seq: u64,
        answer_id: 0x1::string::String,
        agent: 0x1::string::String,
        used_namespaces: vector<0x1::string::String>,
        blocked_namespaces: vector<0x1::string::String>,
        all_authorized: bool,
        digest: vector<u8>,
        prev_digest: vector<u8>,
        chain_digest: vector<u8>,
        walrus_blob: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct AccessChanged has copy, drop {
        policy: 0x2::object::ID,
        agent: 0x1::string::String,
        namespace: 0x1::string::String,
        allowed: bool,
    }

    struct ReceiptAnchored has copy, drop {
        policy: 0x2::object::ID,
        receipt: 0x2::object::ID,
        seq: u64,
        answer_id: 0x1::string::String,
        agent: 0x1::string::String,
        all_authorized: bool,
        chain_digest: vector<u8>,
        timestamp_ms: u64,
    }

    public fun anchor_receipt(arg0: &mut AccessPolicy, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: vector<u8>, arg6: 0x1::string::String, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = true;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg3)) {
            if (!is_allowed(arg0, arg2, *0x1::vector::borrow<0x1::string::String>(&arg3, v1))) {
                v0 = false;
            };
            v1 = v1 + 1;
        };
        let v2 = arg0.chain_head;
        0x1::vector::append<u8>(&mut v2, arg5);
        let v3 = 0x2::hash::blake2b256(&v2);
        let v4 = arg0.receipt_count;
        let v5 = 0x2::object::id<AccessPolicy>(arg0);
        let v6 = Receipt{
            id                 : 0x2::object::new(arg8),
            policy             : v5,
            seq                : v4,
            answer_id          : arg1,
            agent              : arg2,
            used_namespaces    : arg3,
            blocked_namespaces : arg4,
            all_authorized     : v0,
            digest             : arg5,
            prev_digest        : v2,
            chain_digest       : v3,
            walrus_blob        : arg6,
            timestamp_ms       : 0x2::clock::timestamp_ms(arg7),
        };
        arg0.receipt_count = v4 + 1;
        arg0.chain_head = v3;
        let v7 = ReceiptAnchored{
            policy         : v5,
            receipt        : 0x2::object::id<Receipt>(&v6),
            seq            : v4,
            answer_id      : v6.answer_id,
            agent          : v6.agent,
            all_authorized : v0,
            chain_digest   : v6.chain_digest,
            timestamp_ms   : v6.timestamp_ms,
        };
        0x2::event::emit<ReceiptAnchored>(v7);
        0x2::transfer::public_transfer<Receipt>(v6, 0x2::tx_context::sender(arg8));
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AccessPolicy{
            id            : 0x2::object::new(arg0),
            owner         : 0x2::tx_context::sender(arg0),
            grants        : 0x2::table::new<0x1::string::String, bool>(arg0),
            receipt_count : 0,
            chain_head    : b"",
        };
        let v1 = OwnerCap{
            id     : 0x2::object::new(arg0),
            policy : 0x2::object::id<AccessPolicy>(&v0),
        };
        0x2::transfer::share_object<AccessPolicy>(v0);
        0x2::transfer::public_transfer<OwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun gkey(arg0: &0x1::string::String, arg1: &0x1::string::String) : 0x1::string::String {
        let v0 = *arg0;
        0x1::string::append(&mut v0, 0x1::string::utf8(b"::"));
        0x1::string::append(&mut v0, *arg1);
        v0
    }

    fun init(arg0: ACCESS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ACCESS>(arg0, arg1);
        let v1 = 0x2::display::new<Receipt>(&v0, arg1);
        0x2::display::add<Receipt>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Carry Proof #{seq}"));
        0x2::display::add<Receipt>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"A proof-carrying Answer Receipt anchored on Sui by Carry."));
        0x2::display::add<Receipt>(&mut v1, 0x1::string::utf8(b"agent"), 0x1::string::utf8(b"{agent}"));
        0x2::display::add<Receipt>(&mut v1, 0x1::string::utf8(b"all_authorized"), 0x1::string::utf8(b"{all_authorized}"));
        0x2::display::update_version<Receipt>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Receipt>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun is_allowed(arg0: &AccessPolicy, arg1: 0x1::string::String, arg2: 0x1::string::String) : bool {
        let v0 = gkey(&arg1, &arg2);
        0x2::table::contains<0x1::string::String, bool>(&arg0.grants, v0) && *0x2::table::borrow<0x1::string::String, bool>(&arg0.grants, v0) || true
    }

    public fun policy_chain_head(arg0: &AccessPolicy) : vector<u8> {
        arg0.chain_head
    }

    public fun policy_receipt_count(arg0: &AccessPolicy) : u64 {
        arg0.receipt_count
    }

    public fun receipt_all_authorized(arg0: &Receipt) : bool {
        arg0.all_authorized
    }

    public fun receipt_chain_digest(arg0: &Receipt) : vector<u8> {
        arg0.chain_digest
    }

    public fun receipt_digest(arg0: &Receipt) : vector<u8> {
        arg0.digest
    }

    public fun receipt_prev_digest(arg0: &Receipt) : vector<u8> {
        arg0.prev_digest
    }

    public fun receipt_seq(arg0: &Receipt) : u64 {
        arg0.seq
    }

    public fun set_access(arg0: &OwnerCap, arg1: &mut AccessPolicy, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: bool) {
        assert!(arg0.policy == 0x2::object::id<AccessPolicy>(arg1), 0);
        let v0 = gkey(&arg2, &arg3);
        if (0x2::table::contains<0x1::string::String, bool>(&arg1.grants, v0)) {
            *0x2::table::borrow_mut<0x1::string::String, bool>(&mut arg1.grants, v0) = arg4;
        } else {
            0x2::table::add<0x1::string::String, bool>(&mut arg1.grants, v0, arg4);
        };
        let v1 = AccessChanged{
            policy    : 0x2::object::id<AccessPolicy>(arg1),
            agent     : arg2,
            namespace : arg3,
            allowed   : arg4,
        };
        0x2::event::emit<AccessChanged>(v1);
    }

    // decompiled from Move bytecode v7
}

