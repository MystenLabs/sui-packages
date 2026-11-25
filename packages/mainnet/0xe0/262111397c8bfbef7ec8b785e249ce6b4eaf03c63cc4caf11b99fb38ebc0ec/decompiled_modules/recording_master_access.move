module 0xe0262111397c8bfbef7ec8b785e249ce6b4eaf03c63cc4caf11b99fb38ebc0ec::recording_master_access {
    struct RecordingMasterGrant has copy, drop, store {
        terms: vector<u8>,
        policy_version: u64,
    }

    struct RecordingMasterGrantKey<phantom T0> has copy, drop, store {
        pos0: u256,
    }

    struct RecordingMasterGrantedEvent<phantom T0> has copy, drop {
        recording_id: 0x2::object::ID,
        master_blob_id: u256,
        policy_id: 0x2::object::ID,
        policy_version: u64,
        terms: vector<u8>,
    }

    struct RecordingMasterGrantRevokedEvent<phantom T0> has copy, drop {
        recording_id: 0x2::object::ID,
        master_blob_id: u256,
    }

    struct RecordingMasterGrantConsumedEvent<phantom T0> has copy, drop {
        recording_id: 0x2::object::ID,
        master_blob_id: u256,
    }

    public fun consume<T0, T1>(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::RecordingAdminCap<T0>, arg2: u256) : RecordingMasterGrant {
        let v0 = RecordingMasterGrantKey<T1>{pos0: arg2};
        let v1 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid_mut<T0>(arg0, arg1);
        assert!(0x2::dynamic_field::exists<RecordingMasterGrantKey<T1>>(v1, v0), 4);
        let v2 = 0x2::dynamic_field::remove<RecordingMasterGrantKey<T1>, RecordingMasterGrant>(v1, v0);
        let v3 = RecordingMasterGrantConsumedEvent<T1>{
            recording_id   : 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>>(arg0),
            master_blob_id : arg2,
        };
        0x2::event::emit<RecordingMasterGrantConsumedEvent<T1>>(v3);
        v2
    }

    fun ed25519_address(arg0: vector<u8>) : address {
        0x1::vector::insert<u8>(&mut arg0, 0, 0);
        0x2::address::from_bytes(0x2::hash::blake2b256(&arg0))
    }

    public fun grant<T0, T1: drop>(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::RecordingAdminCap<T0>, arg2: &0x7914545ac251592310fd47fb3a70cdc2b30c233ca0e38b15b5494f30bb0df0ce::enclave::EnclavePolicy<T1>, arg3: u256, arg4: vector<u8>) {
        assert!(0x139e6ee3f98645506a5e8a5f6258922b46eb97d645ecb371bce1b3082707145e::recording_master::has_master<T0>(arg0, arg3), 2);
        assert!(0x1::vector::length<u8>(&arg4) <= 64, 3);
        let v0 = 0x7914545ac251592310fd47fb3a70cdc2b30c233ca0e38b15b5494f30bb0df0ce::enclave::version<T1>(arg2);
        let v1 = RecordingMasterGrant{
            terms          : arg4,
            policy_version : v0,
        };
        let v2 = RecordingMasterGrantKey<T1>{pos0: arg3};
        let v3 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid_mut<T0>(arg0, arg1);
        if (0x2::dynamic_field::exists<RecordingMasterGrantKey<T1>>(v3, v2)) {
            let v4 = 0x2::dynamic_field::borrow_mut<RecordingMasterGrantKey<T1>, RecordingMasterGrant>(v3, v2);
            if (*v4 == v1) {
                return
            };
            *v4 = v1;
        } else {
            0x2::dynamic_field::add<RecordingMasterGrantKey<T1>, RecordingMasterGrant>(v3, v2, v1);
        };
        let v5 = RecordingMasterGrantedEvent<T1>{
            recording_id   : 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>>(arg0),
            master_blob_id : arg3,
            policy_id      : 0x2::object::id<0x7914545ac251592310fd47fb3a70cdc2b30c233ca0e38b15b5494f30bb0df0ce::enclave::EnclavePolicy<T1>>(arg2),
            policy_version : v0,
            terms          : arg4,
        };
        0x2::event::emit<RecordingMasterGrantedEvent<T1>>(v5);
    }

    fun grant_of<T0, T1>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg1: u256) : &RecordingMasterGrant {
        assert!(has_grant<T0, T1>(arg0, arg1), 4);
        let v0 = RecordingMasterGrantKey<T1>{pos0: arg1};
        0x2::dynamic_field::borrow<RecordingMasterGrantKey<T1>, RecordingMasterGrant>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid<T0>(arg0), v0)
    }

    public fun grant_policy_version<T0, T1>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg1: u256) : u64 {
        grant_of<T0, T1>(arg0, arg1).policy_version
    }

    public fun grant_terms<T0, T1>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg1: u256) : &vector<u8> {
        &grant_of<T0, T1>(arg0, arg1).terms
    }

    public fun has_grant<T0, T1>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg1: u256) : bool {
        let v0 = RecordingMasterGrantKey<T1>{pos0: arg1};
        0x2::dynamic_field::exists<RecordingMasterGrantKey<T1>>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid<T0>(arg0), v0)
    }

    fun master_of<T0>(arg0: vector<u8>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>) : u256 {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>>(arg1);
        assert!(0x2::bcs::peel_address(&mut v0) == 0x2::object::id_to_address(&v1), 0);
        let v2 = 0x2::bcs::peel_u256(&mut v0);
        let v3 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v3), 1);
        assert!(0x139e6ee3f98645506a5e8a5f6258922b46eb97d645ecb371bce1b3082707145e::recording_master::has_master<T0>(arg1, v2), 2);
        v2
    }

    public fun max_terms_length() : u64 {
        64
    }

    public fun policy_version(arg0: &RecordingMasterGrant) : u64 {
        arg0.policy_version
    }

    public fun revoke<T0, T1>(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::RecordingAdminCap<T0>, arg2: u256) {
        let v0 = RecordingMasterGrantKey<T1>{pos0: arg2};
        let v1 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid_mut<T0>(arg0, arg1);
        if (!0x2::dynamic_field::exists<RecordingMasterGrantKey<T1>>(v1, v0)) {
            return
        };
        0x2::dynamic_field::remove<RecordingMasterGrantKey<T1>, RecordingMasterGrant>(v1, v0);
        let v2 = RecordingMasterGrantRevokedEvent<T1>{
            recording_id   : 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>>(arg0),
            master_blob_id : arg2,
        };
        0x2::event::emit<RecordingMasterGrantRevokedEvent<T1>>(v2);
    }

    entry fun seal_approve<T0>(arg0: vector<u8>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg2: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::RecordingAdminCap<T0>) {
        master_of<T0>(arg0, arg1);
    }

    entry fun seal_approve_enclave<T0, T1: drop>(arg0: vector<u8>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg2: &0x7914545ac251592310fd47fb3a70cdc2b30c233ca0e38b15b5494f30bb0df0ce::enclave::EnclavePolicy<T1>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::tx_context::TxContext) {
        let v0 = grant_of<T0, T1>(arg1, master_of<T0>(arg0, arg1));
        assert!(v0.terms == arg4, 5);
        assert!(0x7914545ac251592310fd47fb3a70cdc2b30c233ca0e38b15b5494f30bb0df0ce::enclave::version<T1>(arg2) == v0.policy_version, 6);
        assert!(0x7914545ac251592310fd47fb3a70cdc2b30c233ca0e38b15b5494f30bb0df0ce::enclave::is_registered<T1>(arg2, arg3), 7);
        assert!(0x7914545ac251592310fd47fb3a70cdc2b30c233ca0e38b15b5494f30bb0df0ce::enclave::registered_version<T1>(arg2, arg3) == v0.policy_version, 7);
        assert!(0x2::tx_context::sender(arg5) == ed25519_address(arg3), 8);
    }

    public fun terms(arg0: &RecordingMasterGrant) : &vector<u8> {
        &arg0.terms
    }

    // decompiled from Move bytecode v7
}

