module 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::runtime_config {
    struct RuntimeConfig has key {
        id: 0x2::object::UID,
        creator_claim_signer_public_key: vector<u8>,
        protocol_fee_share_bps: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps,
        treasury: address,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : RuntimeConfig {
        RuntimeConfig{
            id                              : 0x2::object::new(arg0),
            creator_claim_signer_public_key : b"",
            protocol_fee_share_bps          : 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::new(0),
            treasury                        : 0x2::tx_context::sender(arg0),
        }
    }

    public(friend) fun creator_claim_signer(arg0: &RuntimeConfig) : &vector<u8> {
        &arg0.creator_claim_signer_public_key
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<RuntimeConfig>(new(arg0));
    }

    public(friend) fun protocol_fee_share(arg0: &RuntimeConfig) : 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps {
        arg0.protocol_fee_share_bps
    }

    public fun set_creator_claim_signer(arg0: &mut RuntimeConfig, arg1: &0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::PackageVersion, arg2: &0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::blast_acl::AdminWitness<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun_domain::ClaimSignerAdmin>, arg3: vector<u8>) {
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::assert_current(arg1);
        assert!(0x1::vector::is_empty<u8>(&arg3) || 0x1::vector::length<u8>(&arg3) == 32, 27);
        assert!(arg3 != arg0.creator_claim_signer_public_key, 23);
        arg0.creator_claim_signer_public_key = arg3;
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::events::creator_claim_signer_set(arg3);
    }

    public fun set_protocol_fee_share(arg0: &mut RuntimeConfig, arg1: &0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::PackageVersion, arg2: &0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::blast_acl::AdminWitness<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun_domain::FeeAdmin>, arg3: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps) {
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::assert_current(arg1);
        assert!(arg3 != arg0.protocol_fee_share_bps, 23);
        arg0.protocol_fee_share_bps = arg3;
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::events::protocol_fee_share_changed(0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(arg3));
    }

    public fun set_treasury(arg0: &mut RuntimeConfig, arg1: &0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::PackageVersion, arg2: &0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::blast_acl::AdminWitness<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun_domain::TreasuryAdmin>, arg3: address) {
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::assert_current(arg1);
        assert!(arg3 != @0x0, 6);
        assert!(arg3 != arg0.treasury, 23);
        arg0.treasury = arg3;
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::events::treasury_changed(arg3);
    }

    public(friend) fun treasury(arg0: &RuntimeConfig) : address {
        arg0.treasury
    }

    // decompiled from Move bytecode v7
}

