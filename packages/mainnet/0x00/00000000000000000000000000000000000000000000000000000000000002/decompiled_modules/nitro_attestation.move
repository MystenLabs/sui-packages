module 0x2::nitro_attestation {
    struct PCREntry has drop {
        index: u8,
        value: vector<u8>,
    }

    struct NitroAttestationDocument has drop {
        module_id: vector<u8>,
        timestamp: u64,
        digest: vector<u8>,
        pcrs: vector<PCREntry>,
        public_key: 0x1::option::Option<vector<u8>>,
        user_data: 0x1::option::Option<vector<u8>>,
        nonce: 0x1::option::Option<vector<u8>>,
    }

    public fun digest(arg0: &NitroAttestationDocument) : &vector<u8> {
        &arg0.digest
    }

    public fun index(arg0: &PCREntry) : u8 {
        arg0.index
    }

    entry fun load_nitro_attestation(arg0: vector<u8>, arg1: &0x2::clock::Clock) : NitroAttestationDocument {
        load_nitro_attestation_internal(&arg0, 0x2::clock::timestamp_ms(arg1))
    }

    native fun load_nitro_attestation_internal(arg0: &vector<u8>, arg1: u64) : NitroAttestationDocument;
    public fun module_id(arg0: &NitroAttestationDocument) : &vector<u8> {
        &arg0.module_id
    }

    public fun nonce(arg0: &NitroAttestationDocument) : &0x1::option::Option<vector<u8>> {
        &arg0.nonce
    }

    public fun pcrs(arg0: &NitroAttestationDocument) : &vector<PCREntry> {
        &arg0.pcrs
    }

    public fun public_key(arg0: &NitroAttestationDocument) : &0x1::option::Option<vector<u8>> {
        &arg0.public_key
    }

    public fun timestamp(arg0: &NitroAttestationDocument) : &u64 {
        &arg0.timestamp
    }

    public fun user_data(arg0: &NitroAttestationDocument) : &0x1::option::Option<vector<u8>> {
        &arg0.user_data
    }

    public fun value(arg0: &PCREntry) : &vector<u8> {
        &arg0.value
    }

    // decompiled from Move bytecode v6
}

