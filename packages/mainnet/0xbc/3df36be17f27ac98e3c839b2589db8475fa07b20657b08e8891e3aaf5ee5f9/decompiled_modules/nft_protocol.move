module 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::nft_protocol {
    struct NFT_PROTOCOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFT_PROTOCOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT_PROTOCOL>(arg0, arg1);
        let (_, _) = init_allowlist(arg1);
        let (_, _) = init_authlist(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun init_allowlist(arg0: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID) {
        let (v0, v1) = 0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::new(arg0);
        let v2 = v1;
        let v3 = v0;
        0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::insert_authority<0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::orderbook::Witness>(&v2, &mut v3);
        0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::insert_authority<0xae5e376b646e4d095b99e2eeaa222e40d5a6c26250419f00c4fc613a9cfb2e18::bidding::Witness>(&v2, &mut v3);
        0x2::transfer::public_transfer<0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::AllowlistOwnerCap>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_share_object<0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::Allowlist>(v3);
        (0x2::object::id<0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::Allowlist>(&v3), 0x2::object::id<0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::AllowlistOwnerCap>(&v2))
    }

    public fun init_authlist(arg0: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID) {
        let (v0, v1) = 0x228b48911fdc05f8d80ac4334cd734d38dd7db74a0f4e423cb91f736f429ebe4::authlist::new(arg0);
        let v2 = v1;
        let v3 = v0;
        0x228b48911fdc05f8d80ac4334cd734d38dd7db74a0f4e423cb91f736f429ebe4::authlist::insert_authority(&v2, &mut v3, 0x228b48911fdc05f8d80ac4334cd734d38dd7db74a0f4e423cb91f736f429ebe4::authlist::address_to_bytes(@0x8a1a8348dde5d979c85553c03e204c73efc3b91a2c9ce96b1004c9ec26eaacc8));
        0x2::transfer::public_transfer<0x228b48911fdc05f8d80ac4334cd734d38dd7db74a0f4e423cb91f736f429ebe4::authlist::AuthlistOwnerCap>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_share_object<0x228b48911fdc05f8d80ac4334cd734d38dd7db74a0f4e423cb91f736f429ebe4::authlist::Authlist>(v3);
        (0x2::object::id<0x228b48911fdc05f8d80ac4334cd734d38dd7db74a0f4e423cb91f736f429ebe4::authlist::Authlist>(&v3), 0x2::object::id<0x228b48911fdc05f8d80ac4334cd734d38dd7db74a0f4e423cb91f736f429ebe4::authlist::AuthlistOwnerCap>(&v2))
    }

    public fun permissionless_private_key() : address {
        @0xac5dbb29bea100f5f6382ebcb116afc66fc7b05ff64d2d1e3fc60849504a29f0
    }

    public fun permissionless_public_key() : address {
        @0x8a1a8348dde5d979c85553c03e204c73efc3b91a2c9ce96b1004c9ec26eaacc8
    }

    // decompiled from Move bytecode v6
}

