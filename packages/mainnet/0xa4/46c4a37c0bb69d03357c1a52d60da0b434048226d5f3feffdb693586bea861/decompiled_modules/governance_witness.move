module 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::governance_witness {
    struct GovernanceWitness has drop {
        dummy_field: bool,
    }

    public(friend) fun new_governance_witness() : GovernanceWitness {
        GovernanceWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

