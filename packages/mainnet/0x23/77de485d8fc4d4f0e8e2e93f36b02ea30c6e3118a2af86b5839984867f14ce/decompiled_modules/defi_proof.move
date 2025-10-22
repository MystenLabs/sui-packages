module 0x2377de485d8fc4d4f0e8e2e93f36b02ea30c6e3118a2af86b5839984867f14ce::defi_proof {
    struct NaviProof has drop {
        dummy_field: bool,
    }

    struct ScallopProof has drop {
        dummy_field: bool,
    }

    public fun consume_navi_proof(arg0: NaviProof) : bool {
        let NaviProof {  } = arg0;
        true
    }

    public fun consume_scallop_proof(arg0: ScallopProof) : bool {
        let ScallopProof {  } = arg0;
        true
    }

    public(friend) fun create_navi_proof() : NaviProof {
        NaviProof{dummy_field: false}
    }

    public(friend) fun create_scallop_proof() : ScallopProof {
        ScallopProof{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

