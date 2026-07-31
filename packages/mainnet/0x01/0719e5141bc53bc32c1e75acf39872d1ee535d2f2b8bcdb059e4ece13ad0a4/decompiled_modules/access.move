module 0x10719e5141bc53bc32c1e75acf39872d1ee535d2f2b8bcdb059e4ece13ad0a4::access {
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
        policy_version: u64,
        used_nonces: 0x2::table::Table<0x1::string::String, bool>,
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
        policy_version: u64,
        nonce: 0x1::string::String,
        expires_at_ms: u64,
        timestamp_ms: u64,
    }

    struct CarryVault has store, key {
        id: 0x2::object::UID,
        owner: address,
        policy: 0x2::object::ID,
        manifest_blob: 0x1::string::String,
        manifest_digest: vector<u8>,
        manifest_version: u64,
        updated_at_ms: u64,
    }

    struct AccessChanged has copy, drop {
        policy: 0x2::object::ID,
        agent: 0x1::string::String,
        namespace: 0x1::string::String,
        allowed: bool,
        policy_version: u64,
    }

    struct ReceiptAnchored has copy, drop {
        policy: 0x2::object::ID,
        receipt: 0x2::object::ID,
        seq: u64,
        answer_id: 0x1::string::String,
        agent: 0x1::string::String,
        all_authorized: bool,
        chain_digest: vector<u8>,
        policy_version: u64,
        timestamp_ms: u64,
    }

    struct VaultUpdated has copy, drop {
        vault: 0x2::object::ID,
        owner: address,
        manifest_blob: 0x1::string::String,
        manifest_version: u64,
        updated_at_ms: u64,
    }

    public fun anchor_receipt(arg0: &mut AccessPolicy, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: vector<u8>, arg6: 0x1::string::String, arg7: u64, arg8: 0x1::string::String, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 == arg0.policy_version, 1);
        let v0 = 0x2::clock::timestamp_ms(arg10);
        assert!(arg9 == 0 || v0 <= arg9, 3);
        assert!(!0x2::table::contains<0x1::string::String, bool>(&arg0.used_nonces, arg8), 2);
        0x2::table::add<0x1::string::String, bool>(&mut arg0.used_nonces, arg8, true);
        let v1 = true;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&arg3)) {
            if (!is_allowed(arg0, arg2, *0x1::vector::borrow<0x1::string::String>(&arg3, v2))) {
                v1 = false;
            };
            v2 = v2 + 1;
        };
        let v3 = arg0.chain_head;
        0x1::vector::append<u8>(&mut v3, arg5);
        let v4 = 0x2::hash::blake2b256(&v3);
        let v5 = arg0.receipt_count;
        let v6 = 0x2::object::id<AccessPolicy>(arg0);
        let v7 = Receipt{
            id                 : 0x2::object::new(arg11),
            policy             : v6,
            seq                : v5,
            answer_id          : arg1,
            agent              : arg2,
            used_namespaces    : arg3,
            blocked_namespaces : arg4,
            all_authorized     : v1,
            digest             : arg5,
            prev_digest        : v3,
            chain_digest       : v4,
            walrus_blob        : arg6,
            policy_version     : arg7,
            nonce              : arg8,
            expires_at_ms      : arg9,
            timestamp_ms       : v0,
        };
        arg0.receipt_count = v5 + 1;
        arg0.chain_head = v4;
        let v8 = ReceiptAnchored{
            policy         : v6,
            receipt        : 0x2::object::id<Receipt>(&v7),
            seq            : v5,
            answer_id      : v7.answer_id,
            agent          : v7.agent,
            all_authorized : v1,
            chain_digest   : v7.chain_digest,
            policy_version : arg7,
            timestamp_ms   : v7.timestamp_ms,
        };
        0x2::event::emit<ReceiptAnchored>(v8);
        0x2::transfer::public_transfer<Receipt>(v7, 0x2::tx_context::sender(arg11));
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AccessPolicy{
            id             : 0x2::object::new(arg0),
            owner          : 0x2::tx_context::sender(arg0),
            grants         : 0x2::table::new<0x1::string::String, bool>(arg0),
            receipt_count  : 0,
            chain_head     : b"",
            policy_version : 1,
            used_nonces    : 0x2::table::new<0x1::string::String, bool>(arg0),
        };
        let v1 = OwnerCap{
            id     : 0x2::object::new(arg0),
            policy : 0x2::object::id<AccessPolicy>(&v0),
        };
        0x2::transfer::share_object<AccessPolicy>(v0);
        0x2::transfer::public_transfer<OwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun create_vault(arg0: &AccessPolicy, arg1: 0x1::string::String, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = CarryVault{
            id               : 0x2::object::new(arg4),
            owner            : 0x2::tx_context::sender(arg4),
            policy           : 0x2::object::id<AccessPolicy>(arg0),
            manifest_blob    : arg1,
            manifest_digest  : arg2,
            manifest_version : 1,
            updated_at_ms    : 0x2::clock::timestamp_ms(arg3),
        };
        let v1 = VaultUpdated{
            vault            : 0x2::object::id<CarryVault>(&v0),
            owner            : v0.owner,
            manifest_blob    : v0.manifest_blob,
            manifest_version : v0.manifest_version,
            updated_at_ms    : v0.updated_at_ms,
        };
        0x2::event::emit<VaultUpdated>(v1);
        0x2::transfer::public_transfer<CarryVault>(v0, 0x2::tx_context::sender(arg4));
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
        0x2::display::add<Receipt>(&mut v1, 0x1::string::utf8(b"policy_version"), 0x1::string::utf8(b"{policy_version}"));
        0x2::display::update_version<Receipt>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Receipt>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun is_allowed(arg0: &AccessPolicy, arg1: 0x1::string::String, arg2: 0x1::string::String) : bool {
        let v0 = gkey(&arg1, &arg2);
        0x2::table::contains<0x1::string::String, bool>(&arg0.grants, v0) && *0x2::table::borrow<0x1::string::String, bool>(&arg0.grants, v0) || true
    }

    public fun nonce_used(arg0: &AccessPolicy, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, bool>(&arg0.used_nonces, arg1)
    }

    public fun policy_chain_head(arg0: &AccessPolicy) : vector<u8> {
        arg0.chain_head
    }

    public fun policy_receipt_count(arg0: &AccessPolicy) : u64 {
        arg0.receipt_count
    }

    public fun policy_version(arg0: &AccessPolicy) : u64 {
        arg0.policy_version
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

    public fun receipt_expires_at_ms(arg0: &Receipt) : u64 {
        arg0.expires_at_ms
    }

    public fun receipt_nonce(arg0: &Receipt) : 0x1::string::String {
        arg0.nonce
    }

    public fun receipt_policy_version(arg0: &Receipt) : u64 {
        arg0.policy_version
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
        let v1 = if (0x2::table::contains<0x1::string::String, bool>(&arg1.grants, v0)) {
            let v2 = 0x2::table::borrow_mut<0x1::string::String, bool>(&mut arg1.grants, v0);
            *v2 = arg4;
            *v2 != arg4
        } else {
            0x2::table::add<0x1::string::String, bool>(&mut arg1.grants, v0, arg4);
            arg4 == false
        };
        if (v1) {
            arg1.policy_version = arg1.policy_version + 1;
        };
        let v3 = AccessChanged{
            policy         : 0x2::object::id<AccessPolicy>(arg1),
            agent          : arg2,
            namespace      : arg3,
            allowed        : arg4,
            policy_version : arg1.policy_version,
        };
        0x2::event::emit<AccessChanged>(v3);
    }

    public fun update_manifest(arg0: &mut CarryVault, arg1: 0x1::string::String, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg5), 4);
        assert!(arg3 == arg0.manifest_version, 5);
        arg0.manifest_blob = arg1;
        arg0.manifest_digest = arg2;
        arg0.manifest_version = arg0.manifest_version + 1;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg4);
        let v0 = VaultUpdated{
            vault            : 0x2::object::id<CarryVault>(arg0),
            owner            : arg0.owner,
            manifest_blob    : arg0.manifest_blob,
            manifest_version : arg0.manifest_version,
            updated_at_ms    : arg0.updated_at_ms,
        };
        0x2::event::emit<VaultUpdated>(v0);
    }

    public fun vault_manifest_blob(arg0: &CarryVault) : 0x1::string::String {
        arg0.manifest_blob
    }

    public fun vault_manifest_digest(arg0: &CarryVault) : vector<u8> {
        arg0.manifest_digest
    }

    public fun vault_manifest_version(arg0: &CarryVault) : u64 {
        arg0.manifest_version
    }

    public fun vault_owner(arg0: &CarryVault) : address {
        arg0.owner
    }

    // decompiled from Move bytecode v7
}

