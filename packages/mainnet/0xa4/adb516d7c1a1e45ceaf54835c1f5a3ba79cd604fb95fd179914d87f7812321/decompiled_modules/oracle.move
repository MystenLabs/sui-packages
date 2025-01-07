module 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::oracle {
    struct Attestation has copy, drop, store {
        guardian_id: 0x2::object::ID,
        secp256k1_key: vector<u8>,
        timestamp_ms: u64,
    }

    struct Oracle has key {
        id: 0x2::object::UID,
        oracle_key: vector<u8>,
        queue: 0x2::object::ID,
        queue_key: vector<u8>,
        expiration_time_ms: u64,
        mr_enclave: vector<u8>,
        secp256k1_key: vector<u8>,
        valid_attestations: vector<Attestation>,
    }

    public(friend) fun new(arg0: vector<u8>, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg3);
        let v1 = Oracle{
            id                 : v0,
            oracle_key         : arg0,
            queue              : arg1,
            queue_key          : arg2,
            expiration_time_ms : 0,
            mr_enclave         : 0x1::vector::empty<u8>(),
            secp256k1_key      : 0x1::vector::empty<u8>(),
            valid_attestations : 0x1::vector::empty<Attestation>(),
        };
        0x2::transfer::share_object<Oracle>(v1);
        *0x2::object::uid_as_inner(&v0)
    }

    public(friend) fun add_attestation(arg0: &mut Oracle, arg1: Attestation, arg2: u64) {
        let v0 = 0x1::vector::empty<Attestation>();
        let v1 = arg0.valid_attestations;
        0x1::vector::reverse<Attestation>(&mut v1);
        while (!0x1::vector::is_empty<Attestation>(&v1)) {
            let v2 = 0x1::vector::pop_back<Attestation>(&mut v1);
            let v3 = &v2;
            if (v3.timestamp_ms + 600000 > arg2 && v3.guardian_id != arg1.guardian_id) {
                0x1::vector::push_back<Attestation>(&mut v0, v2);
            };
        };
        0x1::vector::destroy_empty<Attestation>(v1);
        arg0.valid_attestations = v0;
        0x1::vector::push_back<Attestation>(&mut arg0.valid_attestations, arg1);
    }

    public(friend) fun enable_oracle(arg0: &mut Oracle, arg1: vector<u8>, arg2: vector<u8>, arg3: u64) {
        arg0.secp256k1_key = arg1;
        arg0.mr_enclave = arg2;
        arg0.expiration_time_ms = arg3;
    }

    public fun expiration_time_ms(arg0: &Oracle) : u64 {
        arg0.expiration_time_ms
    }

    public fun guardian_id(arg0: &Attestation) : 0x2::object::ID {
        arg0.guardian_id
    }

    public fun id(arg0: &Oracle) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun new_attestation(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64) : Attestation {
        Attestation{
            guardian_id   : arg0,
            secp256k1_key : arg1,
            timestamp_ms  : arg2,
        }
    }

    public fun oracle_key(arg0: &Oracle) : vector<u8> {
        arg0.oracle_key
    }

    public fun oracle_secp256k1_key(arg0: &Attestation) : vector<u8> {
        arg0.secp256k1_key
    }

    public fun queue(arg0: &Oracle) : 0x2::object::ID {
        arg0.queue
    }

    public fun queue_key(arg0: &Oracle) : vector<u8> {
        arg0.queue_key
    }

    public fun secp256k1_key(arg0: &Oracle) : vector<u8> {
        arg0.secp256k1_key
    }

    public fun timestamp_ms(arg0: &Attestation) : u64 {
        arg0.timestamp_ms
    }

    public(friend) fun valid_attestation_count(arg0: &Oracle, arg1: vector<u8>) : u64 {
        let v0 = &arg0.valid_attestations;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Attestation>(v0)) {
            if (0x1::vector::borrow<Attestation>(v0, v2).secp256k1_key == arg1) {
                v1 = v1 + 1;
            };
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

