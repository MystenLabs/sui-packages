module 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::cert_submission {
    struct PresigDealerSetMessage has copy, drop, store {
        epoch: u64,
        batch_index: u32,
        dealer_set_digest: vector<u8>,
    }

    fun assert_can_submit(arg0: &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: u64, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        assert!(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::member_authorized(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0), arg2, arg3), 13906835162185859071);
        let v0 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::pending_epoch_change(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0));
        assert!(arg1 == 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::epoch(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0)) || 0x1::option::contains<u64>(&v0, &arg1), 13906835170775793663);
    }

    fun destroy_bucket_if_present(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::TobKey, arg2: u64) {
        let v0 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::tob_mut(arg0);
        if (0x2::bag::contains<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::TobKey>(v0, arg1)) {
            0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::destroy_all(0x2::bag::remove<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::TobKey, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::EpochCertsV1>(v0, arg1), arg2);
        };
    }

    entry fun destroy_key_gen_certs(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: u64) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        let v0 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::epoch(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0));
        assert!(v0 >= arg1 + 8, 13906834711214555141);
        assert!(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::is_before_previous_committee(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0), arg1), 13906834715509653511);
        destroy_bucket_if_present(arg0, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::tob_key(arg1, 0x1::option::none<u32>(), 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::protocol_type_dkg()), v0);
        destroy_bucket_if_present(arg0, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::tob_key(arg1, 0x1::option::none<u32>(), 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::protocol_type_key_rotation()), v0);
    }

    entry fun destroy_nonce_certs(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: u64, arg2: u32) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        let v0 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::epoch(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0));
        assert!(v0 >= arg1 + 2, 13906834822883573763);
        destroy_bucket_if_present(arg0, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::tob_key(arg1, 0x1::option::some<u32>(arg2), 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::protocol_type_nonce_generation()), v0);
    }

    fun submit_cert_internal(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::TobKey, arg2: u64, arg3: address, arg4: vector<u8>, arg5: &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_can_submit(arg0, arg2, arg3, arg7);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::submit_cert_with_signature(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::epoch_certs(arg0, arg1, arg7), arg2, arg3, arg4, arg5, 0x2::clock::timestamp_ms(arg6));
    }

    entry fun submit_dkg_cert(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: u64, arg2: address, arg3: vector<u8>, arg4: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        submit_cert_internal(arg0, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::tob_key(arg1, 0x1::option::none<u32>(), 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::protocol_type_dkg()), arg1, arg2, arg3, &arg4, arg5, arg6);
    }

    entry fun submit_nonce_cert(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: u64, arg2: u32, arg3: address, arg4: vector<u8>, arg5: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        submit_cert_internal(arg0, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::tob_key(arg1, 0x1::option::some<u32>(arg2), 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::protocol_type_nonce_generation()), arg1, arg3, arg4, &arg5, arg6, arg7);
    }

    entry fun submit_presig_dealer_set(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: u32, arg2: vector<u8>, arg3: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg4, arg5);
        submit_presig_dealer_set_internal(arg0, arg1, arg2, arg3, 0x2::random::generate_bytes(&mut v0, 32));
    }

    fun submit_presig_dealer_set_internal(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: u32, arg2: vector<u8>, arg3: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature, arg4: vector<u8>) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        let v0 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::epoch(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0));
        let v1 = PresigDealerSetMessage{
            epoch             : v0,
            batch_index       : arg1,
            dealer_set_digest : arg2,
        };
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::verify<PresigDealerSetMessage>(arg0, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::intent::presig_dealer_set(), v1, arg3);
        let v2 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::tob_key(v0, 0x1::option::some<u32>(arg1), 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::protocol_type_nonce_generation());
        let v3 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::tob_mut(arg0);
        assert!(0x2::bag::contains<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::TobKey>(v3, v2), 13906834968912855049);
        let v4 = 0x2::bag::borrow_mut<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::TobKey, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::EpochCertsV1>(v3, v2);
        if (0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::is_sealed(v4)) {
            return
        };
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::seal(v4, arg4, arg2);
    }

    entry fun submit_rotation_cert(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: u64, arg2: address, arg3: vector<u8>, arg4: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        submit_cert_internal(arg0, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::tob_key(arg1, 0x1::option::none<u32>(), 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::tob::protocol_type_key_rotation()), arg1, arg2, arg3, &arg4, arg5, arg6);
    }

    // decompiled from Move bytecode v7
}

