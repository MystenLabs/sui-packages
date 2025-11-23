module 0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::tee_verifier {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TeeVerifier has key {
        id: 0x2::object::UID,
        service_name: vector<u8>,
        measurement: vector<u8>,
        version: vector<u8>,
        attestation_pubkey: vector<u8>,
        last_rotation: u64,
        configured: bool,
        admin: address,
        records: 0x2::table::Table<u64, AttestationRecord>,
    }

    struct AttestationRecord has drop, store {
        batch_id: u64,
        input_hash: vector<u8>,
        output_hash: vector<u8>,
        timestamp: u64,
        measurement: vector<u8>,
    }

    struct TrustedMeasurementInitialized has copy, drop {
        service_name: vector<u8>,
        version: vector<u8>,
        measurement: vector<u8>,
    }

    struct TrustedMeasurementRotated has copy, drop {
        new_measurement: vector<u8>,
        timestamp: u64,
    }

    struct AttestationVerified has copy, drop {
        batch_id: u64,
        timestamp: u64,
        measurement: vector<u8>,
    }

    fun bytes_equal(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        if (0x1::vector::length<u8>(arg0) != 0x1::vector::length<u8>(arg1)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) != *0x1::vector::borrow<u8>(arg1, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun check_timestamp_freshness(arg0: u64, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (arg0 > v0) {
            return false
        };
        v0 - arg0 <= 300000
    }

    public fun get_attestation_record(arg0: &TeeVerifier, arg1: u64) : bool {
        0x2::table::contains<u64, AttestationRecord>(&arg0.records, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = TeeVerifier{
            id                 : 0x2::object::new(arg0),
            service_name       : 0x1::vector::empty<u8>(),
            measurement        : 0x1::vector::empty<u8>(),
            version            : 0x1::vector::empty<u8>(),
            attestation_pubkey : 0x1::vector::empty<u8>(),
            last_rotation      : 0,
            configured         : false,
            admin              : 0x2::tx_context::sender(arg0),
            records            : 0x2::table::new<u64, AttestationRecord>(arg0),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<TeeVerifier>(v1);
    }

    entry fun initialize_trusted_measurement(arg0: &AdminCap, arg1: &mut TeeVerifier, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::clock::Clock) {
        assert!(!arg1.configured, 4005);
        arg1.service_name = arg2;
        arg1.measurement = arg3;
        arg1.version = arg4;
        arg1.attestation_pubkey = arg5;
        arg1.last_rotation = 0x2::clock::timestamp_ms(arg6);
        arg1.configured = true;
        let v0 = TrustedMeasurementInitialized{
            service_name : arg1.service_name,
            version      : arg1.version,
            measurement  : arg1.measurement,
        };
        0x2::event::emit<TrustedMeasurementInitialized>(v0);
    }

    public entry fun rotate_attestation_key(arg0: &AdminCap, arg1: &mut TeeVerifier, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        assert!(arg1.configured, 4001);
        arg1.measurement = arg2;
        arg1.version = arg3;
        arg1.attestation_pubkey = arg4;
        arg1.last_rotation = 0x2::clock::timestamp_ms(arg5);
        let v0 = TrustedMeasurementRotated{
            new_measurement : arg1.measurement,
            timestamp       : arg1.last_rotation,
        };
        0x2::event::emit<TrustedMeasurementRotated>(v0);
    }

    entry fun submit_attestation_record(arg0: &mut TeeVerifier, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock) {
        assert!(arg0.configured, 4001);
        assert!(arg6, 4002);
        assert!(verify_measurement_match(arg0, &arg4), 4003);
        assert!(check_timestamp_freshness(arg5, arg7), 4004);
        assert!(!0x2::table::contains<u64, AttestationRecord>(&arg0.records, arg1), 4005);
        let v0 = AttestationRecord{
            batch_id    : arg1,
            input_hash  : arg2,
            output_hash : arg3,
            timestamp   : arg5,
            measurement : arg4,
        };
        0x2::table::add<u64, AttestationRecord>(&mut arg0.records, arg1, v0);
        let v1 = AttestationVerified{
            batch_id    : arg1,
            timestamp   : arg5,
            measurement : arg4,
        };
        0x2::event::emit<AttestationVerified>(v1);
    }

    public fun verify_measurement_match(arg0: &TeeVerifier, arg1: &vector<u8>) : bool {
        bytes_equal(&arg0.measurement, arg1)
    }

    // decompiled from Move bytecode v6
}

