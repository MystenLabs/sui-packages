module 0x8c3f9a72091b58ef2a9271a35abdb738ff510a4010658dc66650c7ab4060f75c::relay2 {
    struct Relay2<phantom T0> has key {
        id: 0x2::object::UID,
        enclave: 0x2::object::ID,
        scan_key: vector<u8>,
        spend_key: vector<u8>,
        nullifier_key: vector<u8>,
        published_ms: u64,
        min_delay_ms: u64,
        max_delay_ms: u64,
        min_batch: u64,
    }

    struct MetaPayload2 has copy, drop {
        scan_key: vector<u8>,
        spend_key: vector<u8>,
        nullifier_key: vector<u8>,
        min_delay_ms: u64,
        max_delay_ms: u64,
        min_batch: u64,
    }

    struct MetaPublished2<phantom T0> has copy, drop {
        relay: 0x2::object::ID,
        enclave: 0x2::object::ID,
        scan_key: vector<u8>,
        spend_key: vector<u8>,
        nullifier_key: vector<u8>,
    }

    fun check<T0>(arg0: &0x8c3f9a72091b58ef2a9271a35abdb738ff510a4010658dc66650c7ab4060f75c::enclave::Enclave<T0>, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: &vector<u8>, arg9: u64) : MetaPayload2 {
        let v0 = if (0x1::vector::length<u8>(&arg2) == 33) {
            if (0x1::vector::length<u8>(&arg3) == 33) {
                0x1::vector::length<u8>(&arg4) == 32
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        assert!(arg5 <= arg6, 1);
        assert!(arg9 <= arg1 + 600000, 2);
        assert!(arg1 <= arg9 + 600000, 2);
        let v1 = MetaPayload2{
            scan_key      : arg2,
            spend_key     : arg3,
            nullifier_key : arg4,
            min_delay_ms  : arg5,
            max_delay_ms  : arg6,
            min_batch     : arg7,
        };
        assert!(0x8c3f9a72091b58ef2a9271a35abdb738ff510a4010658dc66650c7ab4060f75c::enclave::verify_signature<T0, MetaPayload2>(arg0, 8, arg1, v1, arg8), 0);
        v1
    }

    public fun enclave_id<T0>(arg0: &Relay2<T0>) : 0x2::object::ID {
        arg0.enclave
    }

    public fun new_relay<T0>(arg0: &0x8c3f9a72091b58ef2a9271a35abdb738ff510a4010658dc66650c7ab4060f75c::enclave::Enclave<T0>, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = check<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, &arg8, 0x2::clock::timestamp_ms(arg9));
        let v1 = Relay2<T0>{
            id            : 0x2::object::new(arg10),
            enclave       : 0x2::object::id<0x8c3f9a72091b58ef2a9271a35abdb738ff510a4010658dc66650c7ab4060f75c::enclave::Enclave<T0>>(arg0),
            scan_key      : v0.scan_key,
            spend_key     : v0.spend_key,
            nullifier_key : v0.nullifier_key,
            published_ms  : arg1,
            min_delay_ms  : arg5,
            max_delay_ms  : arg6,
            min_batch     : arg7,
        };
        let v2 = MetaPublished2<T0>{
            relay         : 0x2::object::id<Relay2<T0>>(&v1),
            enclave       : 0x2::object::id<0x8c3f9a72091b58ef2a9271a35abdb738ff510a4010658dc66650c7ab4060f75c::enclave::Enclave<T0>>(arg0),
            scan_key      : v1.scan_key,
            spend_key     : v1.spend_key,
            nullifier_key : v1.nullifier_key,
        };
        0x2::event::emit<MetaPublished2<T0>>(v2);
        0x2::transfer::share_object<Relay2<T0>>(v1);
    }

    public fun nullifier_key<T0>(arg0: &Relay2<T0>) : &vector<u8> {
        &arg0.nullifier_key
    }

    public fun policy<T0>(arg0: &Relay2<T0>) : (u64, u64, u64) {
        (arg0.min_delay_ms, arg0.max_delay_ms, arg0.min_batch)
    }

    public fun publish_meta<T0>(arg0: &mut Relay2<T0>, arg1: &0x8c3f9a72091b58ef2a9271a35abdb738ff510a4010658dc66650c7ab4060f75c::enclave::Enclave<T0>, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock) {
        assert!(0x2::object::id<0x8c3f9a72091b58ef2a9271a35abdb738ff510a4010658dc66650c7ab4060f75c::enclave::Enclave<T0>>(arg1) == arg0.enclave, 0);
        assert!(arg2 > arg0.published_ms, 2);
        let v0 = check<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, &arg9, 0x2::clock::timestamp_ms(arg10));
        arg0.scan_key = v0.scan_key;
        arg0.spend_key = v0.spend_key;
        arg0.nullifier_key = v0.nullifier_key;
        arg0.published_ms = arg2;
        arg0.min_delay_ms = arg6;
        arg0.max_delay_ms = arg7;
        arg0.min_batch = arg8;
        let v1 = MetaPublished2<T0>{
            relay         : 0x2::object::id<Relay2<T0>>(arg0),
            enclave       : 0x2::object::id<0x8c3f9a72091b58ef2a9271a35abdb738ff510a4010658dc66650c7ab4060f75c::enclave::Enclave<T0>>(arg1),
            scan_key      : arg0.scan_key,
            spend_key     : arg0.spend_key,
            nullifier_key : arg0.nullifier_key,
        };
        0x2::event::emit<MetaPublished2<T0>>(v1);
    }

    public fun published_ms<T0>(arg0: &Relay2<T0>) : u64 {
        arg0.published_ms
    }

    public fun scan_key<T0>(arg0: &Relay2<T0>) : &vector<u8> {
        &arg0.scan_key
    }

    public fun spend_key<T0>(arg0: &Relay2<T0>) : &vector<u8> {
        &arg0.spend_key
    }

    // decompiled from Move bytecode v7
}

