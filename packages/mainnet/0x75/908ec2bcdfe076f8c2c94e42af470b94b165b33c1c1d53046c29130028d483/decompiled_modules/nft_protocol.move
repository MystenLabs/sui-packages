module 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::nft_protocol {
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
        let (v0, v1) = 0x9346bb5562cd221640e4ad431797149c7cab60bb5b90f8bf19e7079c51cc557b::allowlist::new(arg0);
        let v2 = v1;
        let v3 = v0;
        0x9346bb5562cd221640e4ad431797149c7cab60bb5b90f8bf19e7079c51cc557b::allowlist::insert_authority<0x3af385a04e03432e91e6e7bee4132269887f1a9826a0c96cfbabbf4747ebcbe2::orderbook::Witness>(&v2, &mut v3);
        0x9346bb5562cd221640e4ad431797149c7cab60bb5b90f8bf19e7079c51cc557b::allowlist::insert_authority<0x3af385a04e03432e91e6e7bee4132269887f1a9826a0c96cfbabbf4747ebcbe2::bidding::Witness>(&v2, &mut v3);
        0x2::transfer::public_transfer<0x9346bb5562cd221640e4ad431797149c7cab60bb5b90f8bf19e7079c51cc557b::allowlist::AllowlistOwnerCap>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_share_object<0x9346bb5562cd221640e4ad431797149c7cab60bb5b90f8bf19e7079c51cc557b::allowlist::Allowlist>(v3);
        (0x2::object::id<0x9346bb5562cd221640e4ad431797149c7cab60bb5b90f8bf19e7079c51cc557b::allowlist::Allowlist>(&v3), 0x2::object::id<0x9346bb5562cd221640e4ad431797149c7cab60bb5b90f8bf19e7079c51cc557b::allowlist::AllowlistOwnerCap>(&v2))
    }

    public fun init_authlist(arg0: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID) {
        let (v0, v1) = 0x46d3c9bac58fe067efd1e1358bb1c545994aae7697db89791f1f8934623f3331::authlist::new(arg0);
        let v2 = v1;
        let v3 = v0;
        0x46d3c9bac58fe067efd1e1358bb1c545994aae7697db89791f1f8934623f3331::authlist::insert_authority(&v2, &mut v3, 0x46d3c9bac58fe067efd1e1358bb1c545994aae7697db89791f1f8934623f3331::authlist::address_to_bytes(@0x8a1a8348dde5d979c85553c03e204c73efc3b91a2c9ce96b1004c9ec26eaacc8));
        0x2::transfer::public_transfer<0x46d3c9bac58fe067efd1e1358bb1c545994aae7697db89791f1f8934623f3331::authlist::AuthlistOwnerCap>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_share_object<0x46d3c9bac58fe067efd1e1358bb1c545994aae7697db89791f1f8934623f3331::authlist::Authlist>(v3);
        (0x2::object::id<0x46d3c9bac58fe067efd1e1358bb1c545994aae7697db89791f1f8934623f3331::authlist::Authlist>(&v3), 0x2::object::id<0x46d3c9bac58fe067efd1e1358bb1c545994aae7697db89791f1f8934623f3331::authlist::AuthlistOwnerCap>(&v2))
    }

    public fun permissionless_private_key() : address {
        @0xac5dbb29bea100f5f6382ebcb116afc66fc7b05ff64d2d1e3fc60849504a29f0
    }

    public fun permissionless_public_key() : address {
        @0x8a1a8348dde5d979c85553c03e204c73efc3b91a2c9ce96b1004c9ec26eaacc8
    }

    // decompiled from Move bytecode v6
}

