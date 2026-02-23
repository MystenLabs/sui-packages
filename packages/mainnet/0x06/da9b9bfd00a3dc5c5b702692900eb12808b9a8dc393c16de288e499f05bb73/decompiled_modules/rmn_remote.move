module 0x6da9b9bfd00a3dc5c5b702692900eb12808b9a8dc393c16de288e499f05bb73::rmn_remote {
    struct RMNRemoteState has store, key {
        id: 0x2::object::UID,
        local_chain_selector: u64,
        config: Config,
        config_count: u32,
        signers: 0x2::vec_map::VecMap<vector<u8>, bool>,
        cursed_subjects: 0x2::vec_map::VecMap<vector<u8>, bool>,
    }

    struct Config has copy, drop, store {
        rmn_home_contract_config_digest: vector<u8>,
        signers: vector<Signer>,
        f_sign: u64,
    }

    struct Signer has copy, drop, store {
        onchain_public_key: vector<u8>,
        node_index: u64,
    }

    struct Report has drop {
        dest_chain_selector: u64,
        rmn_remote_contract_address: address,
        off_ramp_address: address,
        rmn_home_contract_config_digest: vector<u8>,
        merkle_roots: vector<MerkleRoot>,
    }

    struct MerkleRoot has drop {
        source_chain_selector: u64,
        on_ramp_address: vector<u8>,
        min_seq_nr: u64,
        max_seq_nr: u64,
        merkle_root: vector<u8>,
    }

    struct ConfigSet has copy, drop {
        version: u32,
        config: Config,
    }

    struct Cursed has copy, drop {
        subjects: vector<vector<u8>>,
    }

    struct Uncursed has copy, drop {
        subjects: vector<vector<u8>>,
    }

    public fun emit_config_set_event(arg0: u32, arg1: Config) {
        let v0 = ConfigSet{
            version : arg0,
            config  : arg1,
        };
        0x2::event::emit<ConfigSet>(v0);
    }

    public fun emit_cursed_event(arg0: vector<u8>) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, arg0);
        let v1 = Cursed{subjects: v0};
        0x2::event::emit<Cursed>(v1);
    }

    public fun emit_cursed_multiple_event(arg0: vector<vector<u8>>) {
        let v0 = Cursed{subjects: arg0};
        0x2::event::emit<Cursed>(v0);
    }

    public fun emit_uncursed_event(arg0: vector<u8>) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, arg0);
        let v1 = Uncursed{subjects: v0};
        0x2::event::emit<Uncursed>(v1);
    }

    public fun emit_uncursed_multiple_event(arg0: vector<vector<u8>>) {
        let v0 = Uncursed{subjects: arg0};
        0x2::event::emit<Uncursed>(v0);
    }

    // decompiled from Move bytecode v6
}

