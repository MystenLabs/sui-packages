module 0x3366ebcba1b91c328bdffcbcdd6b30b61ca7e5ae74459141230c00f4b6ed2cab::payment_auth {
    struct AuthorizationProof has drop {
        dummy_field: bool,
    }

    public fun get_proof(arg0: &0x2::package::Publisher) : AuthorizationProof {
        assert!(0x2::package::from_package<AuthorizationProof>(arg0), 9223372109869219841);
        AuthorizationProof{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

