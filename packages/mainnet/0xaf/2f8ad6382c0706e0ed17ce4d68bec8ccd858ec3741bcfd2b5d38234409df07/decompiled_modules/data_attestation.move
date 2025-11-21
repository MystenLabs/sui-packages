module 0xaf2f8ad6382c0706e0ed17ce4d68bec8ccd858ec3741bcfd2b5d38234409df07::data_attestation {
    struct DataAttestation has store, key {
        id: 0x2::object::UID,
        attestation_hash: vector<u8>,
        data_type: 0x1::string::String,
        borrower_id: 0x1::string::String,
        timestamp: u64,
        attester: address,
        is_valid: bool,
    }

    struct AttestationCreated has copy, drop {
        attestation_id: address,
        attestation_hash: vector<u8>,
        data_type: 0x1::string::String,
        borrower_id: 0x1::string::String,
        timestamp: u64,
        attester: address,
    }

    struct AttestationRevoked has copy, drop {
        attestation_id: address,
        reason: 0x1::string::String,
        timestamp: u64,
    }

    public entry fun create_attestation(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = DataAttestation{
            id               : 0x2::object::new(arg3),
            attestation_hash : arg0,
            data_type        : 0x1::string::utf8(arg1),
            borrower_id      : 0x1::string::utf8(arg2),
            timestamp        : 0x2::tx_context::epoch_timestamp_ms(arg3),
            attester         : 0x2::tx_context::sender(arg3),
            is_valid         : true,
        };
        let v1 = AttestationCreated{
            attestation_id   : 0x2::object::uid_to_address(&v0.id),
            attestation_hash : arg0,
            data_type        : 0x1::string::utf8(arg1),
            borrower_id      : 0x1::string::utf8(arg2),
            timestamp        : 0x2::tx_context::epoch_timestamp_ms(arg3),
            attester         : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<AttestationCreated>(v1);
        0x2::transfer::public_share_object<DataAttestation>(v0);
    }

    public fun get_attestation_hash(arg0: &DataAttestation) : vector<u8> {
        arg0.attestation_hash
    }

    public fun get_attester(arg0: &DataAttestation) : address {
        arg0.attester
    }

    public fun get_borrower_id(arg0: &DataAttestation) : 0x1::string::String {
        arg0.borrower_id
    }

    public fun get_data_type(arg0: &DataAttestation) : 0x1::string::String {
        arg0.data_type
    }

    public fun get_timestamp(arg0: &DataAttestation) : u64 {
        arg0.timestamp
    }

    public fun is_valid(arg0: &DataAttestation) : bool {
        arg0.is_valid
    }

    public entry fun revoke_attestation(arg0: &mut DataAttestation, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.attester == 0x2::tx_context::sender(arg2), 0);
        arg0.is_valid = false;
        let v0 = AttestationRevoked{
            attestation_id : 0x2::object::uid_to_address(&arg0.id),
            reason         : 0x1::string::utf8(arg1),
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<AttestationRevoked>(v0);
    }

    // decompiled from Move bytecode v6
}

