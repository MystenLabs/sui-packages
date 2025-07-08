module 0x45b2fe39773aa5fb4aacff2419725b8a773f659985890be868c5d2addcb17f03::malicious {
    struct MaliciousWitness has drop {
        dummy_field: bool,
    }

    public fun create_witness() : MaliciousWitness {
        MaliciousWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

