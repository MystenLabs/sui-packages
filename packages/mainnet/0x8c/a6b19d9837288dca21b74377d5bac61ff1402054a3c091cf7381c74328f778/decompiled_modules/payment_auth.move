module 0x8ca6b19d9837288dca21b74377d5bac61ff1402054a3c091cf7381c74328f778::payment_auth {
    struct AuthorizationProof has drop {
        dummy_field: bool,
    }

    public fun get_proof(arg0: &0x2::package::Publisher) : AuthorizationProof {
        assert!(0x2::package::from_package<AuthorizationProof>(arg0), 9223372109869219841);
        AuthorizationProof{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

