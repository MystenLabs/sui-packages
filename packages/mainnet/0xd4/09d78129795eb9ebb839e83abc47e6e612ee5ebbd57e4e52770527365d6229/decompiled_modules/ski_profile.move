module 0xd409d78129795eb9ebb839e83abc47e6e612ee5ebbd57e4e52770527365d6229::ski_profile {
    struct ChainKey has copy, drop, store {
        chain: vector<u8>,
    }

    struct ProfileKey has copy, drop, store {
        dummy_field: bool,
    }

    struct BalanceSealKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SuiamiKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PointsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ChainAddress has drop, store {
        address_bytes: vector<u8>,
        address_str: vector<u8>,
        dwallet_id: address,
        updated_ms: u64,
    }

    struct Profile has drop, store {
        rumble_curves: u8,
        thunder_count: u64,
        created_ms: u64,
        updated_ms: u64,
    }

    struct SuiamiProof has drop, store {
        proof_hash: vector<u8>,
        nft_id: address,
        verified_ms: u64,
    }

    struct BalanceSealRef has drop, store {
        policy_id: address,
        name_hash: vector<u8>,
        updated_ms: u64,
    }

    struct ChainAddressSet has copy, drop {
        domain: vector<u8>,
        chain: vector<u8>,
        address_str: vector<u8>,
        dwallet_id: address,
    }

    struct ProfileCreated has copy, drop {
        domain: vector<u8>,
        timestamp_ms: u64,
    }

    struct SuiamiVerified has copy, drop {
        domain: vector<u8>,
        proof_hash: vector<u8>,
        nft_id: address,
    }

    public fun get_chain_address(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg1: vector<u8>) : (vector<u8>, vector<u8>, address) {
        let v0 = ChainKey{chain: arg1};
        assert!(0x2::dynamic_field::exists_<ChainKey>(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid(arg0), v0), 0);
        let v1 = 0x2::dynamic_field::borrow<ChainKey, ChainAddress>(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid(arg0), v0);
        (v1.address_bytes, v1.address_str, v1.dwallet_id)
    }

    public fun get_points(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration) : u64 {
        let v0 = PointsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<PointsKey>(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid(arg0), v0)) {
            return 0
        };
        *0x2::dynamic_field::borrow<PointsKey, u64>(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid(arg0), v0)
    }

    public fun has_chain_address(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg1: vector<u8>) : bool {
        0x2::dynamic_field::exists_<ChainKey>(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid(arg0), key(arg1))
    }

    public fun has_suiami(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration) : bool {
        let v0 = SuiamiKey{dummy_field: false};
        0x2::dynamic_field::exists_<SuiamiKey>(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid(arg0), v0)
    }

    entry fun init_profile(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = ProfileKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<ProfileKey>(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid(arg0), v0)) {
            return
        };
        let v1 = Profile{
            rumble_curves : 0,
            thunder_count : 0,
            created_ms    : 0x2::clock::timestamp_ms(arg1),
            updated_ms    : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::dynamic_field::add<ProfileKey, Profile>(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid_mut(arg0), v0, v1);
        let v2 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg0);
        let v3 = ProfileCreated{
            domain       : 0x1::string::into_bytes(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::to_string(&v2)),
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<ProfileCreated>(v3);
    }

    fun key(arg0: vector<u8>) : ChainKey {
        ChainKey{chain: arg0}
    }

    entry fun remove_chain_address(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        let v0 = ChainKey{chain: arg1};
        if (0x2::dynamic_field::exists_<ChainKey>(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid(arg0), v0)) {
            0x2::dynamic_field::remove<ChainKey, ChainAddress>(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid_mut(arg0), v0);
        };
    }

    entry fun set_balance_seal(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg1: address, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = BalanceSealKey{dummy_field: false};
        let v1 = BalanceSealRef{
            policy_id  : arg1,
            name_hash  : arg2,
            updated_ms : 0x2::clock::timestamp_ms(arg3),
        };
        if (0x2::dynamic_field::exists_<BalanceSealKey>(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid(arg0), v0)) {
            0x2::dynamic_field::remove<BalanceSealKey, BalanceSealRef>(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid_mut(arg0), v0);
        };
        0x2::dynamic_field::add<BalanceSealKey, BalanceSealRef>(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid_mut(arg0), v0, v1);
    }

    entry fun set_chain_address(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        let v0 = ChainKey{chain: arg1};
        let v1 = ChainAddress{
            address_bytes : arg2,
            address_str   : arg3,
            dwallet_id    : arg4,
            updated_ms    : 0x2::clock::timestamp_ms(arg5),
        };
        if (0x2::dynamic_field::exists_<ChainKey>(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid(arg0), v0)) {
            0x2::dynamic_field::remove<ChainKey, ChainAddress>(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid_mut(arg0), v0);
        };
        0x2::dynamic_field::add<ChainKey, ChainAddress>(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid_mut(arg0), v0, v1);
        let v2 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg0);
        let v3 = ChainAddressSet{
            domain      : 0x1::string::into_bytes(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::to_string(&v2)),
            chain       : v0.chain,
            address_str : arg3,
            dwallet_id  : arg4,
        };
        0x2::event::emit<ChainAddressSet>(v3);
    }

    entry fun set_points(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = PointsKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<PointsKey>(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid(arg0), v0)) {
            0x2::dynamic_field::remove<PointsKey, u64>(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid_mut(arg0), v0);
        };
        0x2::dynamic_field::add<PointsKey, u64>(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid_mut(arg0), v0, arg1);
    }

    entry fun set_rumble_curves(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg1: u8, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = ProfileKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<ProfileKey>(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid(arg0), v0)) {
            return
        };
        let v1 = 0x2::dynamic_field::borrow_mut<ProfileKey, Profile>(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid_mut(arg0), v0);
        v1.rumble_curves = arg1;
        v1.updated_ms = 0x2::clock::timestamp_ms(arg2);
    }

    entry fun set_suiami(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg1: vector<u8>, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = SuiamiKey{dummy_field: false};
        let v1 = SuiamiProof{
            proof_hash  : arg1,
            nft_id      : arg2,
            verified_ms : 0x2::clock::timestamp_ms(arg3),
        };
        if (0x2::dynamic_field::exists_<SuiamiKey>(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid(arg0), v0)) {
            0x2::dynamic_field::remove<SuiamiKey, SuiamiProof>(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid_mut(arg0), v0);
        };
        0x2::dynamic_field::add<SuiamiKey, SuiamiProof>(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid_mut(arg0), v0, v1);
        let v2 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg0);
        let v3 = SuiamiVerified{
            domain     : 0x1::string::into_bytes(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::to_string(&v2)),
            proof_hash : arg1,
            nft_id     : arg2,
        };
        0x2::event::emit<SuiamiVerified>(v3);
    }

    entry fun set_thunder_count(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = ProfileKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<ProfileKey>(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid(arg0), v0)) {
            return
        };
        let v1 = 0x2::dynamic_field::borrow_mut<ProfileKey, Profile>(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid_mut(arg0), v0);
        v1.thunder_count = arg1;
        v1.updated_ms = 0x2::clock::timestamp_ms(arg2);
    }

    // decompiled from Move bytecode v6
}

