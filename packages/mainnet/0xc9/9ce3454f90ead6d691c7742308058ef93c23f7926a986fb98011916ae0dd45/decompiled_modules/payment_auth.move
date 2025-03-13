module 0xc99ce3454f90ead6d691c7742308058ef93c23f7926a986fb98011916ae0dd45::payment_auth {
    struct AuthorizationProof has drop {
        dummy_field: bool,
    }

    public fun get_proof(arg0: &0x2::package::Publisher) : AuthorizationProof {
        assert!(0x2::package::from_package<AuthorizationProof>(arg0), 9223372109869219841);
        AuthorizationProof{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

