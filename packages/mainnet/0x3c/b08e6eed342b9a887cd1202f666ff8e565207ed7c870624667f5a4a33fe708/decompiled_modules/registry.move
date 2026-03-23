module 0x3cb08e6eed342b9a887cd1202f666ff8e565207ed7c870624667f5a4a33fe708::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        records: 0x2::table::Table<address, 0x2::object::ID>,
        count: u64,
    }

    struct MultisigRecord has store, key {
        id: 0x2::object::UID,
        multisig_address: address,
        name: 0x1::string::String,
        threshold: u16,
        network: 0x1::string::String,
        creator: address,
        created_at: u64,
        signers: vector<SignerEntry>,
    }

    struct SignerEntry has copy, drop, store {
        public_key: vector<u8>,
        key_scheme: u8,
        weight: u8,
        name: 0x1::string::String,
        sui_address: address,
    }

    struct MultisigRegistered has copy, drop {
        record_id: 0x2::object::ID,
        multisig_address: address,
        threshold: u16,
        signer_count: u64,
        creator: address,
    }

    public fun created_at(arg0: &MultisigRecord) : u64 {
        arg0.created_at
    }

    public fun creator(arg0: &MultisigRecord) : address {
        arg0.creator
    }

    public fun get_count(arg0: &Registry) : u64 {
        arg0.count
    }

    public fun get_record_id(arg0: &Registry, arg1: address) : 0x2::object::ID {
        *0x2::table::borrow<address, 0x2::object::ID>(&arg0.records, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id      : 0x2::object::new(arg0),
            records : 0x2::table::new<address, 0x2::object::ID>(arg0),
            count   : 0,
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun is_registered(arg0: &Registry, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.records, arg1)
    }

    public fun multisig_address(arg0: &MultisigRecord) : address {
        arg0.multisig_address
    }

    public fun name(arg0: &MultisigRecord) : 0x1::string::String {
        arg0.name
    }

    public fun network(arg0: &MultisigRecord) : 0x1::string::String {
        arg0.network
    }

    public fun register(arg0: &mut Registry, arg1: address, arg2: 0x1::string::String, arg3: u16, arg4: 0x1::string::String, arg5: vector<vector<u8>>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<0x1::string::String>, arg9: vector<address>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<vector<u8>>(&arg5);
        assert!(v0 == 0x1::vector::length<u8>(&arg6), 0);
        assert!(v0 == 0x1::vector::length<u8>(&arg7), 0);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg8), 0);
        assert!(v0 == 0x1::vector::length<address>(&arg9), 0);
        assert!(v0 >= 2 && v0 <= 10, 1);
        assert!(arg3 > 0, 2);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.records, arg1), 3);
        let v1 = 0;
        let v2 = false;
        let v3 = 0x2::tx_context::sender(arg10);
        let v4 = 0;
        while (v4 < v0) {
            assert!(*0x1::vector::borrow<u8>(&arg6, v4) <= 2, 5);
            let v5 = *0x1::vector::borrow<u8>(&arg7, v4);
            assert!(v5 >= 1, 6);
            v1 = v1 + (v5 as u64);
            if (*0x1::vector::borrow<address>(&arg9, v4) == v3) {
                v2 = true;
            };
            v4 = v4 + 1;
        };
        assert!(v1 >= (arg3 as u64), 4);
        assert!(v2, 7);
        let v6 = 0x1::vector::empty<SignerEntry>();
        v4 = 0;
        while (v4 < v0) {
            let v7 = SignerEntry{
                public_key  : *0x1::vector::borrow<vector<u8>>(&arg5, v4),
                key_scheme  : *0x1::vector::borrow<u8>(&arg6, v4),
                weight      : *0x1::vector::borrow<u8>(&arg7, v4),
                name        : *0x1::vector::borrow<0x1::string::String>(&arg8, v4),
                sui_address : *0x1::vector::borrow<address>(&arg9, v4),
            };
            0x1::vector::push_back<SignerEntry>(&mut v6, v7);
            v4 = v4 + 1;
        };
        let v8 = MultisigRecord{
            id               : 0x2::object::new(arg10),
            multisig_address : arg1,
            name             : arg2,
            threshold        : arg3,
            network          : arg4,
            creator          : v3,
            created_at       : 0x2::tx_context::epoch(arg10),
            signers          : v6,
        };
        let v9 = 0x2::object::id<MultisigRecord>(&v8);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.records, arg1, v9);
        arg0.count = arg0.count + 1;
        let v10 = MultisigRegistered{
            record_id        : v9,
            multisig_address : arg1,
            threshold        : arg3,
            signer_count     : v0,
            creator          : v3,
        };
        0x2::event::emit<MultisigRegistered>(v10);
        0x2::transfer::share_object<MultisigRecord>(v8);
    }

    public fun signer_count(arg0: &MultisigRecord) : u64 {
        0x1::vector::length<SignerEntry>(&arg0.signers)
    }

    public fun signer_key_scheme(arg0: &SignerEntry) : u8 {
        arg0.key_scheme
    }

    public fun signer_name(arg0: &SignerEntry) : 0x1::string::String {
        arg0.name
    }

    public fun signer_public_key(arg0: &SignerEntry) : &vector<u8> {
        &arg0.public_key
    }

    public fun signer_sui_address(arg0: &SignerEntry) : address {
        arg0.sui_address
    }

    public fun signer_weight(arg0: &SignerEntry) : u8 {
        arg0.weight
    }

    public fun signers(arg0: &MultisigRecord) : &vector<SignerEntry> {
        &arg0.signers
    }

    public fun threshold(arg0: &MultisigRecord) : u16 {
        arg0.threshold
    }

    // decompiled from Move bytecode v6
}

