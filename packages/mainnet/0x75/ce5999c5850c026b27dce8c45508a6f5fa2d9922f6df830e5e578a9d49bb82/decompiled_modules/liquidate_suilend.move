module 0x75ce5999c5850c026b27dce8c45508a6f5fa2d9922f6df830e5e578a9d49bb82::liquidate_suilend {
    public fun assert_unhealthy<T0>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Obligation<T0>) {
        assert!(!0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::is_healthy<T0>(arg0), 120);
    }

    // decompiled from Move bytecode v7
}

