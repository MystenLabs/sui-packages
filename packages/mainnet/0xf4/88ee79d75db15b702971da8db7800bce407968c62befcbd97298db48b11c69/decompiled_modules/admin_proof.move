module 0xf488ee79d75db15b702971da8db7800bce407968c62befcbd97298db48b11c69::admin_proof {
    struct AuthorizationProof has drop {
        dummy_field: bool,
    }

    public fun get_proof(arg0: &0x2::package::Publisher) : AuthorizationProof {
        assert!(0x2::package::from_package<AuthorizationProof>(arg0), 13906834251652792321);
        AuthorizationProof{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

