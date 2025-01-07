module 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::crypto {
    public fun test_ecds() : bool {
        let v0 = b"set whitelist";
        let v1 = x"fbbea5cd4a5039652c5e565b22551fc9253f5df9b415ca269689c1c32f4a1cfc";
        let v2 = x"26c49f2f7aececcff917a65ae13c7caee4c3273aa0819d3be328febf0bdb140d3bc2a7b04ef4977868fd96afebe65cc84e4b162db3f56831cf9f9b64cd31eb06";
        0x2::ed25519::ed25519_verify(&v2, &v1, &v0)
    }

    // decompiled from Move bytecode v6
}

