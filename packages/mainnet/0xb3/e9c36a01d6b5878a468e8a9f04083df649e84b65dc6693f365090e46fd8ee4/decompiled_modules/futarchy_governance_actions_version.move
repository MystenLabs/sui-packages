module 0xb3e9c36a01d6b5878a468e8a9f04083df649e84b65dc6693f365090e46fd8ee4::futarchy_governance_actions_version {
    struct V1 has drop {
        dummy_field: bool,
    }

    public(friend) fun current() : 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::version_witness::VersionWitness {
        let v0 = V1{dummy_field: false};
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::version_witness::new<V1>(v0)
    }

    public fun get() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

