module 0x3a75968d0951fc99e7b336b26088d0f6888efd691b9cf2ac61c3958cfaa6d41b::validator_v2 {
    struct DkgState has store, key {
        id: 0x2::object::UID,
        version: u64,
        com_to_pub_key: 0x2::vec_map::VecMap<u64, vector<u8>>,
    }

    struct StorePublicKeyEvent has copy, drop {
        committee_id: u64,
        public_key: vector<u8>,
        timestamp: u64,
    }

    struct RemovePublicKeyEvent has copy, drop {
        committee_id: u64,
        public_key: vector<u8>,
        timestamp: u64,
    }

    public entry fun add_committee_public_key(arg0: &mut 0x3a75968d0951fc99e7b336b26088d0f6888efd691b9cf2ac61c3958cfaa6d41b::validator::OwnerCap, arg1: &mut DkgState, arg2: &0x2::clock::Clock, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        dkg_state_version_check(arg1);
        assert!(0x1::vector::length<u8>(&arg4) == 96, 3);
        if (0x2::vec_map::contains<u64, vector<u8>>(&arg1.com_to_pub_key, &arg3)) {
            let v0 = 0x2::vec_map::get_mut<u64, vector<u8>>(&mut arg1.com_to_pub_key, &arg3);
            assert!(arg4 != *v0, 2);
            *v0 = arg4;
        } else {
            0x2::vec_map::insert<u64, vector<u8>>(&mut arg1.com_to_pub_key, arg3, arg4);
        };
        let v1 = StorePublicKeyEvent{
            committee_id : arg3,
            public_key   : arg4,
            timestamp    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<StorePublicKeyEvent>(v1);
    }

    public fun committee_sign_verification(arg0: &DkgState, arg1: u64, arg2: vector<u8>, arg3: vector<u8>) : bool {
        let v0 = get_committee_public_key(arg0, arg1);
        0x2::bls12381::bls12381_min_sig_verify(&arg3, &v0, &arg2)
    }

    fun create_dkg_state(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DkgState{
            id             : 0x2::object::new(arg0),
            version        : 1,
            com_to_pub_key : 0x2::vec_map::empty<u64, vector<u8>>(),
        };
        0x2::transfer::share_object<DkgState>(v0);
    }

    public fun dkg_state_version_check(arg0: &DkgState) {
        assert!(arg0.version == 1, 4);
    }

    fun ensure_committee_public_key_exist(arg0: &DkgState, arg1: u64) {
        assert!(0x2::vec_map::contains<u64, vector<u8>>(&arg0.com_to_pub_key, &arg1), 1);
    }

    public fun get_committee_public_key(arg0: &DkgState, arg1: u64) : vector<u8> {
        dkg_state_version_check(arg0);
        ensure_committee_public_key_exist(arg0, arg1);
        *0x2::vec_map::get<u64, vector<u8>>(&arg0.com_to_pub_key, &arg1)
    }

    public fun get_committee_public_key_length(arg0: &DkgState) : u64 {
        0x2::vec_map::size<u64, vector<u8>>(&arg0.com_to_pub_key)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        create_dkg_state(arg0);
    }

    entry fun migrate(arg0: &mut 0x3a75968d0951fc99e7b336b26088d0f6888efd691b9cf2ac61c3958cfaa6d41b::validator::OwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        create_dkg_state(arg1);
    }

    public entry fun remove_committee_public_key(arg0: &mut 0x3a75968d0951fc99e7b336b26088d0f6888efd691b9cf2ac61c3958cfaa6d41b::validator::OwnerCap, arg1: &mut DkgState, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        dkg_state_version_check(arg1);
        ensure_committee_public_key_exist(arg1, arg3);
        let (_, v1) = 0x2::vec_map::remove<u64, vector<u8>>(&mut arg1.com_to_pub_key, &arg3);
        let v2 = RemovePublicKeyEvent{
            committee_id : arg3,
            public_key   : v1,
            timestamp    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<RemovePublicKeyEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

