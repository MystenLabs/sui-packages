module 0xa6c46e36729e1bf1e567230726b10357f0c5587e48de14b71278134f0f60e479::payment_auth {
    struct AuthorizationProof has drop {
        dummy_field: bool,
    }

    public fun get_proof(arg0: &0x2::package::Publisher) : AuthorizationProof {
        assert!(0x2::package::from_package<AuthorizationProof>(arg0), 9223372109869219841);
        AuthorizationProof{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

