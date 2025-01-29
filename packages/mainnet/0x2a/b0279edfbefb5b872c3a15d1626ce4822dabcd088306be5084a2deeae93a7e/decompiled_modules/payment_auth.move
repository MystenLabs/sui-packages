module 0x2ab0279edfbefb5b872c3a15d1626ce4822dabcd088306be5084a2deeae93a7e::payment_auth {
    struct AuthorizationProof has drop {
        dummy_field: bool,
    }

    public fun get_proof(arg0: &0x2::package::Publisher) : AuthorizationProof {
        assert!(0x2::package::from_package<AuthorizationProof>(arg0), 9223372109869219841);
        AuthorizationProof{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

