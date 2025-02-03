module 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::whitelist {
    struct Whitelist has store {
        whitelist_type: u8,
        whitelist_on_chain: 0x1::option::Option<WhitelistOnChain>,
        whitelist_off_chain: 0x1::option::Option<WhitelistOffChain>,
    }

    struct WhitelistOnChain has store {
        record: 0x2::table::Table<address, u64>,
    }

    struct WhitelistOffChain has drop, store {
        public_key: vector<u8>,
    }

    public(friend) fun add_pubkey_into_offchain_whitelist(arg0: &mut Whitelist, arg1: vector<u8>) {
        assert!(arg0.whitelist_type == 2, 0);
        let v0 = WhitelistOffChain{public_key: arg1};
        0x1::option::swap_or_fill<WhitelistOffChain>(&mut arg0.whitelist_off_chain, v0);
    }

    public fun add_whitelist_onchain(arg0: &mut WhitelistOnChain, arg1: vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg1);
            if (!0x2::table::contains<address, u64>(&arg0.record, v1)) {
                0x2::table::add<address, u64>(&mut arg0.record, v1, 1);
            };
            v0 = v0 + 1;
        };
    }

    public fun check_offchain(arg0: &Whitelist, arg1: &vector<u8>, arg2: &vector<u8>) {
        if (!0x1::option::is_some<WhitelistOffChain>(&arg0.whitelist_off_chain)) {
            abort 1
        };
        assert!(0x2::ed25519::ed25519_verify(arg2, &0x1::option::borrow<WhitelistOffChain>(&arg0.whitelist_off_chain).public_key, arg1), 2);
    }

    public fun check_onchain(arg0: &Whitelist, arg1: address) {
        if (!0x1::option::is_some<WhitelistOffChain>(&arg0.whitelist_off_chain)) {
            abort 1
        };
        assert!(0x2::table::contains<address, u64>(&0x1::option::borrow<WhitelistOnChain>(&arg0.whitelist_on_chain).record, arg1), 2);
    }

    public fun create_whitelist(arg0: u8) : Whitelist {
        assert!(arg0 < 3, 0);
        Whitelist{
            whitelist_type      : arg0,
            whitelist_on_chain  : 0x1::option::none<WhitelistOnChain>(),
            whitelist_off_chain : 0x1::option::none<WhitelistOffChain>(),
        }
    }

    public fun get_whitelist_type(arg0: &Whitelist) : u8 {
        arg0.whitelist_type
    }

    // decompiled from Move bytecode v6
}

