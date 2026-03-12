module 0x3081bcb24f60c1005c65af522afdb57514668d31fb42d410d5a63ede3542a76e::credentials {
    struct IssuerCap has store, key {
        id: 0x2::object::UID,
        issuer: address,
    }

    struct Credential has store, key {
        id: 0x2::object::UID,
        wallet: address,
        credential_type: u8,
        status: u8,
        threshold: u64,
        value: u64,
        verified_at: u64,
        expires_at: u64,
        issuer: address,
        metadata: vector<u8>,
    }

    struct CredentialCreated has copy, drop {
        credential_id: address,
        wallet: address,
        credential_type: u8,
        issuer: address,
    }

    struct CredentialRevoked has copy, drop {
        credential_id: address,
        wallet: address,
        credential_type: u8,
    }

    entry fun create_issuer(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = IssuerCap{
            id     : 0x2::object::new(arg0),
            issuer : v0,
        };
        0x2::transfer::transfer<IssuerCap>(v1, v0);
    }

    public fun get_credential_type(arg0: &Credential) : u8 {
        arg0.credential_type
    }

    public fun get_issuer_address(arg0: &IssuerCap) : address {
        arg0.issuer
    }

    public fun get_status(arg0: &Credential) : u8 {
        arg0.status
    }

    public fun get_threshold(arg0: &Credential) : u64 {
        arg0.threshold
    }

    public fun get_value(arg0: &Credential) : u64 {
        arg0.value
    }

    public fun get_wallet(arg0: &Credential) : address {
        arg0.wallet
    }

    public fun is_verified(arg0: &Credential) : bool {
        arg0.status == 0
    }

    entry fun issue_credential(arg0: &IssuerCap, arg1: address, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 7, 2);
        let v0 = arg0.issuer;
        let v1 = Credential{
            id              : 0x2::object::new(arg7),
            wallet          : arg1,
            credential_type : arg2,
            status          : 0,
            threshold       : arg3,
            value           : arg4,
            verified_at     : 0x2::tx_context::epoch(arg7),
            expires_at      : arg5,
            issuer          : v0,
            metadata        : arg6,
        };
        let v2 = CredentialCreated{
            credential_id   : 0x2::object::uid_to_address(&v1.id),
            wallet          : arg1,
            credential_type : arg2,
            issuer          : v0,
        };
        0x2::event::emit<CredentialCreated>(v2);
        0x2::transfer::transfer<Credential>(v1, arg1);
    }

    entry fun revoke_credential(arg0: &IssuerCap, arg1: &mut Credential) {
        assert!(arg0.issuer == arg1.issuer, 0);
        assert!(arg1.status != 1, 1);
        arg1.status = 1;
        let v0 = CredentialRevoked{
            credential_id   : 0x2::object::uid_to_address(&arg1.id),
            wallet          : arg1.wallet,
            credential_type : arg1.credential_type,
        };
        0x2::event::emit<CredentialRevoked>(v0);
    }

    entry fun verify_wallet_ownership(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Credential{
            id              : 0x2::object::new(arg0),
            wallet          : v0,
            credential_type : 0,
            status          : 0,
            threshold       : 0,
            value           : 1,
            verified_at     : 0x2::tx_context::epoch(arg0),
            expires_at      : 0,
            issuer          : v0,
            metadata        : b"wallet_ownership",
        };
        let v2 = CredentialCreated{
            credential_id   : 0x2::object::uid_to_address(&v1.id),
            wallet          : v0,
            credential_type : 0,
            issuer          : v0,
        };
        0x2::event::emit<CredentialCreated>(v2);
        0x2::transfer::transfer<Credential>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

