module 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::governance_witness {
    struct GovernanceWitness has drop {
        dummy_field: bool,
    }

    public(friend) fun new_governance_witness() : GovernanceWitness {
        GovernanceWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

