module 0xe4e30b29e4aca4566e496bf3e221b32e33de92318a8d8992fe36df47f1530693::attestation {
    struct Attestation has store, key {
        id: 0x2::object::UID,
        subject: 0x2::object::ID,
        attester: address,
        kind: vector<u8>,
        score: u8,
        uri: vector<u8>,
        timestamp_ms: u64,
    }

    struct Attested has copy, drop {
        attestation_id: 0x2::object::ID,
        subject: 0x2::object::ID,
        attester: address,
        kind: vector<u8>,
        score: u8,
    }

    public fun timestamp_ms(arg0: &Attestation) : u64 {
        arg0.timestamp_ms
    }

    public fun attest(arg0: &mut 0xe4e30b29e4aca4566e496bf3e221b32e33de92318a8d8992fe36df47f1530693::agent_passport::AgentPassport, arg1: &0xe4e30b29e4aca4566e496bf3e221b32e33de92318a8d8992fe36df47f1530693::agent_passport::AgentPassport, arg2: vector<u8>, arg3: u8, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Attestation {
        assert!(arg3 <= 100, 1);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(v0 == 0xe4e30b29e4aca4566e496bf3e221b32e33de92318a8d8992fe36df47f1530693::agent_passport::owner(arg1) || v0 == 0xe4e30b29e4aca4566e496bf3e221b32e33de92318a8d8992fe36df47f1530693::agent_passport::runtime_wallet(arg1), 2);
        assert!(0xe4e30b29e4aca4566e496bf3e221b32e33de92318a8d8992fe36df47f1530693::agent_passport::is_active(arg1), 3);
        assert!(0x2::object::id<0xe4e30b29e4aca4566e496bf3e221b32e33de92318a8d8992fe36df47f1530693::agent_passport::AgentPassport>(arg1) != 0x2::object::id<0xe4e30b29e4aca4566e496bf3e221b32e33de92318a8d8992fe36df47f1530693::agent_passport::AgentPassport>(arg0), 4);
        let v1 = Attestation{
            id           : 0x2::object::new(arg6),
            subject      : 0x2::object::id<0xe4e30b29e4aca4566e496bf3e221b32e33de92318a8d8992fe36df47f1530693::agent_passport::AgentPassport>(arg0),
            attester     : v0,
            kind         : arg2,
            score        : arg3,
            uri          : arg4,
            timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0xe4e30b29e4aca4566e496bf3e221b32e33de92318a8d8992fe36df47f1530693::agent_passport::record_attestation_internal(arg0, arg3);
        let v2 = Attested{
            attestation_id : 0x2::object::id<Attestation>(&v1),
            subject        : 0x2::object::id<0xe4e30b29e4aca4566e496bf3e221b32e33de92318a8d8992fe36df47f1530693::agent_passport::AgentPassport>(arg0),
            attester       : v0,
            kind           : arg2,
            score          : arg3,
        };
        0x2::event::emit<Attested>(v2);
        v1
    }

    public fun attester(arg0: &Attestation) : address {
        arg0.attester
    }

    public fun kind(arg0: &Attestation) : vector<u8> {
        arg0.kind
    }

    public fun score(arg0: &Attestation) : u8 {
        arg0.score
    }

    public fun subject(arg0: &Attestation) : 0x2::object::ID {
        arg0.subject
    }

    public fun uri(arg0: &Attestation) : vector<u8> {
        arg0.uri
    }

    // decompiled from Move bytecode v7
}

