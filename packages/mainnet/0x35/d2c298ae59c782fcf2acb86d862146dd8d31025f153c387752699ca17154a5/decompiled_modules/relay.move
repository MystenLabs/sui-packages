module 0x35d2c298ae59c782fcf2acb86d862146dd8d31025f153c387752699ca17154a5::relay {
    struct Relay<phantom T0> has key {
        id: 0x2::object::UID,
        enclave: 0x2::object::ID,
        scan_key: vector<u8>,
        spend_key: vector<u8>,
        published_ms: u64,
        min_delay_ms: u64,
        max_delay_ms: u64,
        min_batch: u64,
    }

    struct MetaPayload has copy, drop {
        scan_key: vector<u8>,
        spend_key: vector<u8>,
        min_delay_ms: u64,
        max_delay_ms: u64,
        min_batch: u64,
    }

    struct MetaPublished<phantom T0> has copy, drop {
        relay: 0x2::object::ID,
        enclave: 0x2::object::ID,
        scan_key: vector<u8>,
        spend_key: vector<u8>,
    }

    fun check<T0>(arg0: &0x35d2c298ae59c782fcf2acb86d862146dd8d31025f153c387752699ca17154a5::enclave::Enclave<T0>, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: &vector<u8>, arg8: u64) : MetaPayload {
        assert!(0x1::vector::length<u8>(&arg2) == 33 && 0x1::vector::length<u8>(&arg3) == 33, 1);
        assert!(arg4 <= arg5, 1);
        assert!(arg8 <= arg1 + 600000, 2);
        let v0 = MetaPayload{
            scan_key     : arg2,
            spend_key    : arg3,
            min_delay_ms : arg4,
            max_delay_ms : arg5,
            min_batch    : arg6,
        };
        assert!(0x35d2c298ae59c782fcf2acb86d862146dd8d31025f153c387752699ca17154a5::enclave::verify_signature<T0, MetaPayload>(arg0, 7, arg1, v0, arg7), 0);
        v0
    }

    public fun enclave_id<T0>(arg0: &Relay<T0>) : 0x2::object::ID {
        arg0.enclave
    }

    public fun new_relay<T0>(arg0: &0x35d2c298ae59c782fcf2acb86d862146dd8d31025f153c387752699ca17154a5::enclave::Enclave<T0>, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = check<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, &arg7, arg8);
        let v1 = Relay<T0>{
            id           : 0x2::object::new(arg9),
            enclave      : 0x2::object::id<0x35d2c298ae59c782fcf2acb86d862146dd8d31025f153c387752699ca17154a5::enclave::Enclave<T0>>(arg0),
            scan_key     : v0.scan_key,
            spend_key    : v0.spend_key,
            published_ms : arg1,
            min_delay_ms : arg4,
            max_delay_ms : arg5,
            min_batch    : arg6,
        };
        let v2 = MetaPublished<T0>{
            relay     : 0x2::object::id<Relay<T0>>(&v1),
            enclave   : 0x2::object::id<0x35d2c298ae59c782fcf2acb86d862146dd8d31025f153c387752699ca17154a5::enclave::Enclave<T0>>(arg0),
            scan_key  : v1.scan_key,
            spend_key : v1.spend_key,
        };
        0x2::event::emit<MetaPublished<T0>>(v2);
        0x2::transfer::share_object<Relay<T0>>(v1);
    }

    public fun policy<T0>(arg0: &Relay<T0>) : (u64, u64, u64) {
        (arg0.min_delay_ms, arg0.max_delay_ms, arg0.min_batch)
    }

    public fun publish_meta<T0>(arg0: &mut Relay<T0>, arg1: &0x35d2c298ae59c782fcf2acb86d862146dd8d31025f153c387752699ca17154a5::enclave::Enclave<T0>, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: u64) {
        assert!(0x2::object::id<0x35d2c298ae59c782fcf2acb86d862146dd8d31025f153c387752699ca17154a5::enclave::Enclave<T0>>(arg1) == arg0.enclave, 0);
        assert!(arg2 > arg0.published_ms, 2);
        let v0 = check<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, &arg8, arg9);
        arg0.scan_key = v0.scan_key;
        arg0.spend_key = v0.spend_key;
        arg0.published_ms = arg2;
        arg0.min_delay_ms = arg5;
        arg0.max_delay_ms = arg6;
        arg0.min_batch = arg7;
        let v1 = MetaPublished<T0>{
            relay     : 0x2::object::id<Relay<T0>>(arg0),
            enclave   : 0x2::object::id<0x35d2c298ae59c782fcf2acb86d862146dd8d31025f153c387752699ca17154a5::enclave::Enclave<T0>>(arg1),
            scan_key  : arg0.scan_key,
            spend_key : arg0.spend_key,
        };
        0x2::event::emit<MetaPublished<T0>>(v1);
    }

    public fun published_ms<T0>(arg0: &Relay<T0>) : u64 {
        arg0.published_ms
    }

    public fun scan_key<T0>(arg0: &Relay<T0>) : &vector<u8> {
        &arg0.scan_key
    }

    public fun spend_key<T0>(arg0: &Relay<T0>) : &vector<u8> {
        &arg0.spend_key
    }

    // decompiled from Move bytecode v7
}

