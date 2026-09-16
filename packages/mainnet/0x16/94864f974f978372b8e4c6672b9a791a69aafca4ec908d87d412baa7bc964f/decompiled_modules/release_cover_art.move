module 0x1694864f974f978372b8e4c6672b9a791a69aafca4ec908d87d412baa7bc964f::release_cover_art {
    struct ExtensionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ReleaseCoverArt has store {
        cover: 0x1::option::Option<0x76e1460bcd2bc95cc0a8a40914511c27e5a2425e6d8055caf08161eb59514c67::cover_art::CoverArt>,
        track_covers: 0x1c10bf9ff71a64c2850ce64055124942d65bd0be48ec4758d90073287f389b6::per_track::PerTrack<0x1::option::Option<0x76e1460bcd2bc95cc0a8a40914511c27e5a2425e6d8055caf08161eb59514c67::cover_art::CoverArt>>,
    }

    struct CoverSnapshot has copy, drop {
        present: bool,
        still_blob_id: u256,
        still_is_encrypted: bool,
        still_sealed_dek_length: u64,
        still_sealed_dek_digest: vector<u8>,
        has_animated: bool,
        animated_blob_id: u256,
        animated_is_encrypted: bool,
        animated_sealed_dek_length: u64,
        animated_sealed_dek_digest: vector<u8>,
    }

    struct ReleaseCoverArtSetEvent has copy, drop {
        release_id: address,
        admin_cap_id: address,
        track_count: u64,
        field_existed_before: bool,
        field_exists_after: bool,
        previous_present: bool,
        previous_still_blob_id: u256,
        previous_still_is_encrypted: bool,
        previous_still_sealed_dek_length: u64,
        previous_still_sealed_dek_digest: vector<u8>,
        previous_has_animated: bool,
        previous_animated_blob_id: u256,
        previous_animated_is_encrypted: bool,
        previous_animated_sealed_dek_length: u64,
        previous_animated_sealed_dek_digest: vector<u8>,
        current_present: bool,
        current_still_blob_id: u256,
        current_still_is_encrypted: bool,
        current_still_sealed_dek_length: u64,
        current_still_sealed_dek_digest: vector<u8>,
        current_has_animated: bool,
        current_animated_blob_id: u256,
        current_animated_is_encrypted: bool,
        current_animated_sealed_dek_length: u64,
        current_animated_sealed_dek_digest: vector<u8>,
    }

    struct ReleaseCoverArtUnsetEvent has copy, drop {
        release_id: address,
        admin_cap_id: address,
        track_count: u64,
        field_existed_before: bool,
        field_exists_after: bool,
        previous_present: bool,
        previous_still_blob_id: u256,
        previous_still_is_encrypted: bool,
        previous_still_sealed_dek_length: u64,
        previous_still_sealed_dek_digest: vector<u8>,
        previous_has_animated: bool,
        previous_animated_blob_id: u256,
        previous_animated_is_encrypted: bool,
        previous_animated_sealed_dek_length: u64,
        previous_animated_sealed_dek_digest: vector<u8>,
        current_present: bool,
        current_still_blob_id: u256,
        current_still_is_encrypted: bool,
        current_still_sealed_dek_length: u64,
        current_still_sealed_dek_digest: vector<u8>,
        current_has_animated: bool,
        current_animated_blob_id: u256,
        current_animated_is_encrypted: bool,
        current_animated_sealed_dek_length: u64,
        current_animated_sealed_dek_digest: vector<u8>,
    }

    struct ReleaseTrackCoverArtSetEvent has copy, drop {
        release_id: address,
        admin_cap_id: address,
        track_count: u64,
        field_existed_before: bool,
        field_exists_after: bool,
        track_index: u64,
        recording_id: address,
        composition_id: address,
        previous_present: bool,
        previous_still_blob_id: u256,
        previous_still_is_encrypted: bool,
        previous_still_sealed_dek_length: u64,
        previous_still_sealed_dek_digest: vector<u8>,
        previous_has_animated: bool,
        previous_animated_blob_id: u256,
        previous_animated_is_encrypted: bool,
        previous_animated_sealed_dek_length: u64,
        previous_animated_sealed_dek_digest: vector<u8>,
        current_present: bool,
        current_still_blob_id: u256,
        current_still_is_encrypted: bool,
        current_still_sealed_dek_length: u64,
        current_still_sealed_dek_digest: vector<u8>,
        current_has_animated: bool,
        current_animated_blob_id: u256,
        current_animated_is_encrypted: bool,
        current_animated_sealed_dek_length: u64,
        current_animated_sealed_dek_digest: vector<u8>,
        album: CoverSnapshot,
    }

    struct ReleaseTrackCoverArtUnsetEvent has copy, drop {
        release_id: address,
        admin_cap_id: address,
        track_count: u64,
        field_existed_before: bool,
        field_exists_after: bool,
        track_index: u64,
        recording_id: address,
        composition_id: address,
        previous_present: bool,
        previous_still_blob_id: u256,
        previous_still_is_encrypted: bool,
        previous_still_sealed_dek_length: u64,
        previous_still_sealed_dek_digest: vector<u8>,
        previous_has_animated: bool,
        previous_animated_blob_id: u256,
        previous_animated_is_encrypted: bool,
        previous_animated_sealed_dek_length: u64,
        previous_animated_sealed_dek_digest: vector<u8>,
        current_present: bool,
        current_still_blob_id: u256,
        current_still_is_encrypted: bool,
        current_still_sealed_dek_length: u64,
        current_still_sealed_dek_digest: vector<u8>,
        current_has_animated: bool,
        current_animated_blob_id: u256,
        current_animated_is_encrypted: bool,
        current_animated_sealed_dek_length: u64,
        current_animated_sealed_dek_digest: vector<u8>,
        album: CoverSnapshot,
    }

    fun borrow(arg0: &0x2::object::UID) : &ReleaseCoverArt {
        let v0 = ExtensionKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ExtensionKey>(arg0, v0), 1);
        let v1 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::borrow<ExtensionKey, ReleaseCoverArt>(arg0, v1)
    }

    fun borrow_mut_or_init(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap) : &mut ReleaseCoverArt {
        let v0 = ExtensionKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<ExtensionKey>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::uid(arg0), v0)) {
            let v1 = ExtensionKey{dummy_field: false};
            let v2 = ReleaseCoverArt{
                cover        : 0x1::option::none<0x76e1460bcd2bc95cc0a8a40914511c27e5a2425e6d8055caf08161eb59514c67::cover_art::CoverArt>(),
                track_covers : 0x1c10bf9ff71a64c2850ce64055124942d65bd0be48ec4758d90073287f389b6::per_track::filled<0x1::option::Option<0x76e1460bcd2bc95cc0a8a40914511c27e5a2425e6d8055caf08161eb59514c67::cover_art::CoverArt>>(arg0, 0x1::option::none<0x76e1460bcd2bc95cc0a8a40914511c27e5a2425e6d8055caf08161eb59514c67::cover_art::CoverArt>()),
            };
            0x2::dynamic_field::add<ExtensionKey, ReleaseCoverArt>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::uid_mut(arg0, arg1), v1, v2);
        };
        let v3 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<ExtensionKey, ReleaseCoverArt>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::uid_mut(arg0, arg1), v3)
    }

    public fun cover(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release) : &0x1::option::Option<0x76e1460bcd2bc95cc0a8a40914511c27e5a2425e6d8055caf08161eb59514c67::cover_art::CoverArt> {
        &borrow(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::uid(arg0)).cover
    }

    fun cover_snapshot(arg0: &0x1::option::Option<0x76e1460bcd2bc95cc0a8a40914511c27e5a2425e6d8055caf08161eb59514c67::cover_art::CoverArt>) : (bool, u256, bool, u64, vector<u8>, bool, u256, bool, u64, vector<u8>) {
        if (0x1::option::is_none<0x76e1460bcd2bc95cc0a8a40914511c27e5a2425e6d8055caf08161eb59514c67::cover_art::CoverArt>(arg0)) {
            (false, 0, false, 0, b"", false, 0, false, 0, b"")
        } else {
            let v10 = 0x1::option::borrow<0x76e1460bcd2bc95cc0a8a40914511c27e5a2425e6d8055caf08161eb59514c67::cover_art::CoverArt>(arg0);
            let v11 = 0x76e1460bcd2bc95cc0a8a40914511c27e5a2425e6d8055caf08161eb59514c67::cover_art::still(v10);
            let v12 = 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::blob_confidentiality(v11);
            let (v13, v14, v15) = if (0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::confidentiality::is_encrypted(v12)) {
                let v16 = 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::confidentiality::sealed_dek(v12);
                (true, 0x1::vector::length<u8>(v16), 0x2::hash::blake2b256(v16))
            } else {
                (false, 0, b"")
            };
            let (v17, v18, v19, v20, v21) = if (0x1::option::is_some<0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::WalrusBlob>(0x76e1460bcd2bc95cc0a8a40914511c27e5a2425e6d8055caf08161eb59514c67::cover_art::animated(v10))) {
                let v22 = 0x1::option::borrow<0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::WalrusBlob>(0x76e1460bcd2bc95cc0a8a40914511c27e5a2425e6d8055caf08161eb59514c67::cover_art::animated(v10));
                let v23 = 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::blob_confidentiality(v22);
                let (v24, v25, v26) = if (0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::confidentiality::is_encrypted(v23)) {
                    let v27 = 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::confidentiality::sealed_dek(v23);
                    (true, 0x1::vector::length<u8>(v27), 0x2::hash::blake2b256(v27))
                } else {
                    (false, 0, b"")
                };
                (v25, v26, true, 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::blob_id(v22), v24)
            } else {
                (0, b"", false, 0, false)
            };
            (true, 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::blob_id(v11), v13, v14, v15, v19, v20, v21, v17, v18)
        }
    }

    public fun has_cover_art(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release) : bool {
        let v0 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::exists<ExtensionKey>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::uid(arg0), v0)
    }

    public fun set_cover(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap, arg2: 0x76e1460bcd2bc95cc0a8a40914511c27e5a2425e6d8055caf08161eb59514c67::cover_art::CoverArt) {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release>(arg0);
        let v1 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap>(arg1);
        let v2 = 0x1::vector::length<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::track::Track>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::tracks(arg0));
        let v3 = ExtensionKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::exists<ExtensionKey>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::uid(arg0), v3);
        let v5 = borrow_mut_or_init(arg0, arg1);
        let v6 = v5.cover;
        0x1::option::swap_or_fill<0x76e1460bcd2bc95cc0a8a40914511c27e5a2425e6d8055caf08161eb59514c67::cover_art::CoverArt>(&mut v5.cover, arg2);
        let v7 = v5.cover;
        let (v8, v9, v10, v11, v12, v13, v14, v15, v16, v17) = cover_snapshot(&v6);
        let (v18, v19, v20, v21, v22, v23, v24, v25, v26, v27) = cover_snapshot(&v7);
        if (v6 != 0x1::option::some<0x76e1460bcd2bc95cc0a8a40914511c27e5a2425e6d8055caf08161eb59514c67::cover_art::CoverArt>(arg2)) {
            let v28 = ReleaseCoverArtSetEvent{
                release_id                          : 0x2::object::id_to_address(&v0),
                admin_cap_id                        : 0x2::object::id_to_address(&v1),
                track_count                         : v2,
                field_existed_before                : v4,
                field_exists_after                  : true,
                previous_present                    : v8,
                previous_still_blob_id              : v9,
                previous_still_is_encrypted         : v10,
                previous_still_sealed_dek_length    : v11,
                previous_still_sealed_dek_digest    : v12,
                previous_has_animated               : v13,
                previous_animated_blob_id           : v14,
                previous_animated_is_encrypted      : v15,
                previous_animated_sealed_dek_length : v16,
                previous_animated_sealed_dek_digest : v17,
                current_present                     : v18,
                current_still_blob_id               : v19,
                current_still_is_encrypted          : v20,
                current_still_sealed_dek_length     : v21,
                current_still_sealed_dek_digest     : v22,
                current_has_animated                : v23,
                current_animated_blob_id            : v24,
                current_animated_is_encrypted       : v25,
                current_animated_sealed_dek_length  : v26,
                current_animated_sealed_dek_digest  : v27,
            };
            0x2::event::emit<ReleaseCoverArtSetEvent>(v28);
        };
    }

    public fun set_track_cover(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap, arg2: u64, arg3: 0x76e1460bcd2bc95cc0a8a40914511c27e5a2425e6d8055caf08161eb59514c67::cover_art::CoverArt) {
        assert!(arg2 < 0x1::vector::length<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::track::Track>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::tracks(arg0)), 2);
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release>(arg0);
        let v1 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap>(arg1);
        let v2 = 0x1::vector::length<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::track::Track>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::tracks(arg0));
        let v3 = ExtensionKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::exists<ExtensionKey>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::uid(arg0), v3);
        let v5 = 0x1::vector::borrow<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::track::Track>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::tracks(arg0), arg2);
        let v6 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::track::recording_id(v5);
        let v7 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::track::composition_id(v5);
        let v8 = borrow_mut_or_init(arg0, arg1);
        let v9 = 0x1c10bf9ff71a64c2850ce64055124942d65bd0be48ec4758d90073287f389b6::per_track::borrow_mut<0x1::option::Option<0x76e1460bcd2bc95cc0a8a40914511c27e5a2425e6d8055caf08161eb59514c67::cover_art::CoverArt>>(&mut v8.track_covers, arg2);
        let v10 = *v9;
        0x1::option::swap_or_fill<0x76e1460bcd2bc95cc0a8a40914511c27e5a2425e6d8055caf08161eb59514c67::cover_art::CoverArt>(v9, arg3);
        let v11 = *v9;
        let v12 = v8.cover;
        let v11 = v11;
        let (v13, v14, v15, v16, v17, v18, v19, v20, v21, v22) = cover_snapshot(&v10);
        let (v23, v24, v25, v26, v27, v28, v29, v30, v31, v32) = cover_snapshot(&v11);
        let (v33, v34, v35, v36, v37, v38, v39, v40, v41, v42) = cover_snapshot(&v12);
        if (v10 != 0x1::option::some<0x76e1460bcd2bc95cc0a8a40914511c27e5a2425e6d8055caf08161eb59514c67::cover_art::CoverArt>(arg3)) {
            let v43 = CoverSnapshot{
                present                    : v33,
                still_blob_id              : v34,
                still_is_encrypted         : v35,
                still_sealed_dek_length    : v36,
                still_sealed_dek_digest    : v37,
                has_animated               : v38,
                animated_blob_id           : v39,
                animated_is_encrypted      : v40,
                animated_sealed_dek_length : v41,
                animated_sealed_dek_digest : v42,
            };
            let v44 = ReleaseTrackCoverArtSetEvent{
                release_id                          : 0x2::object::id_to_address(&v0),
                admin_cap_id                        : 0x2::object::id_to_address(&v1),
                track_count                         : v2,
                field_existed_before                : v4,
                field_exists_after                  : true,
                track_index                         : arg2,
                recording_id                        : 0x2::object::id_to_address(&v6),
                composition_id                      : 0x2::object::id_to_address(&v7),
                previous_present                    : v13,
                previous_still_blob_id              : v14,
                previous_still_is_encrypted         : v15,
                previous_still_sealed_dek_length    : v16,
                previous_still_sealed_dek_digest    : v17,
                previous_has_animated               : v18,
                previous_animated_blob_id           : v19,
                previous_animated_is_encrypted      : v20,
                previous_animated_sealed_dek_length : v21,
                previous_animated_sealed_dek_digest : v22,
                current_present                     : v23,
                current_still_blob_id               : v24,
                current_still_is_encrypted          : v25,
                current_still_sealed_dek_length     : v26,
                current_still_sealed_dek_digest     : v27,
                current_has_animated                : v28,
                current_animated_blob_id            : v29,
                current_animated_is_encrypted       : v30,
                current_animated_sealed_dek_length  : v31,
                current_animated_sealed_dek_digest  : v32,
                album                               : v43,
            };
            0x2::event::emit<ReleaseTrackCoverArtSetEvent>(v44);
        };
    }

    public fun track_cover(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release, arg1: u64) : 0x1::option::Option<0x76e1460bcd2bc95cc0a8a40914511c27e5a2425e6d8055caf08161eb59514c67::cover_art::CoverArt> {
        assert!(arg1 < 0x1::vector::length<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::track::Track>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::tracks(arg0)), 2);
        let v0 = borrow(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::uid(arg0));
        let v1 = 0x1c10bf9ff71a64c2850ce64055124942d65bd0be48ec4758d90073287f389b6::per_track::borrow<0x1::option::Option<0x76e1460bcd2bc95cc0a8a40914511c27e5a2425e6d8055caf08161eb59514c67::cover_art::CoverArt>>(&v0.track_covers, arg1);
        if (0x1::option::is_some<0x76e1460bcd2bc95cc0a8a40914511c27e5a2425e6d8055caf08161eb59514c67::cover_art::CoverArt>(v1)) {
            *v1
        } else {
            v0.cover
        }
    }

    public fun unset_cover(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap) {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release>(arg0);
        let v1 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap>(arg1);
        let v2 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::uid_mut(arg0, arg1);
        let v3 = ExtensionKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ExtensionKey>(v2, v3), 1);
        let v4 = ExtensionKey{dummy_field: false};
        let v5 = 0x2::dynamic_field::borrow_mut<ExtensionKey, ReleaseCoverArt>(v2, v4);
        let v6 = v5.cover;
        v5.cover = 0x1::option::none<0x76e1460bcd2bc95cc0a8a40914511c27e5a2425e6d8055caf08161eb59514c67::cover_art::CoverArt>();
        let v7 = v5.cover;
        let (v8, v9, v10, v11, v12, v13, v14, v15, v16, v17) = cover_snapshot(&v6);
        let (v18, v19, v20, v21, v22, v23, v24, v25, v26, v27) = cover_snapshot(&v7);
        if (v6 != v7) {
            let v28 = ReleaseCoverArtUnsetEvent{
                release_id                          : 0x2::object::id_to_address(&v0),
                admin_cap_id                        : 0x2::object::id_to_address(&v1),
                track_count                         : 0x1::vector::length<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::track::Track>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::tracks(arg0)),
                field_existed_before                : true,
                field_exists_after                  : true,
                previous_present                    : v8,
                previous_still_blob_id              : v9,
                previous_still_is_encrypted         : v10,
                previous_still_sealed_dek_length    : v11,
                previous_still_sealed_dek_digest    : v12,
                previous_has_animated               : v13,
                previous_animated_blob_id           : v14,
                previous_animated_is_encrypted      : v15,
                previous_animated_sealed_dek_length : v16,
                previous_animated_sealed_dek_digest : v17,
                current_present                     : v18,
                current_still_blob_id               : v19,
                current_still_is_encrypted          : v20,
                current_still_sealed_dek_length     : v21,
                current_still_sealed_dek_digest     : v22,
                current_has_animated                : v23,
                current_animated_blob_id            : v24,
                current_animated_is_encrypted       : v25,
                current_animated_sealed_dek_length  : v26,
                current_animated_sealed_dek_digest  : v27,
            };
            0x2::event::emit<ReleaseCoverArtUnsetEvent>(v28);
        };
    }

    public fun unset_track_cover(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap, arg2: u64) {
        let v0 = 0x1::vector::length<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::track::Track>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::tracks(arg0));
        let v1 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::Release>(arg0);
        let v2 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::ReleaseAdminCap>(arg1);
        0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::uid_mut(arg0, arg1);
        let v3 = ExtensionKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ExtensionKey>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::uid(arg0), v3), 1);
        assert!(arg2 < v0, 2);
        let v4 = 0x1::vector::borrow<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::track::Track>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::tracks(arg0), arg2);
        let v5 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::track::recording_id(v4);
        let v6 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::track::composition_id(v4);
        let v7 = ExtensionKey{dummy_field: false};
        let v8 = 0x2::dynamic_field::borrow_mut<ExtensionKey, ReleaseCoverArt>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::release::uid_mut(arg0, arg1), v7);
        let v9 = 0x1c10bf9ff71a64c2850ce64055124942d65bd0be48ec4758d90073287f389b6::per_track::borrow_mut<0x1::option::Option<0x76e1460bcd2bc95cc0a8a40914511c27e5a2425e6d8055caf08161eb59514c67::cover_art::CoverArt>>(&mut v8.track_covers, arg2);
        let v10 = *v9;
        *v9 = 0x1::option::none<0x76e1460bcd2bc95cc0a8a40914511c27e5a2425e6d8055caf08161eb59514c67::cover_art::CoverArt>();
        let v11 = *v9;
        let v12 = v8.cover;
        let (v13, v14, v15, v16, v17, v18, v19, v20, v21, v22) = cover_snapshot(&v10);
        let (v23, v24, v25, v26, v27, v28, v29, v30, v31, v32) = cover_snapshot(&v11);
        let (v33, v34, v35, v36, v37, v38, v39, v40, v41, v42) = cover_snapshot(&v12);
        if (v10 != v11) {
            let v43 = CoverSnapshot{
                present                    : v33,
                still_blob_id              : v34,
                still_is_encrypted         : v35,
                still_sealed_dek_length    : v36,
                still_sealed_dek_digest    : v37,
                has_animated               : v38,
                animated_blob_id           : v39,
                animated_is_encrypted      : v40,
                animated_sealed_dek_length : v41,
                animated_sealed_dek_digest : v42,
            };
            let v44 = ReleaseTrackCoverArtUnsetEvent{
                release_id                          : 0x2::object::id_to_address(&v1),
                admin_cap_id                        : 0x2::object::id_to_address(&v2),
                track_count                         : v0,
                field_existed_before                : true,
                field_exists_after                  : true,
                track_index                         : arg2,
                recording_id                        : 0x2::object::id_to_address(&v5),
                composition_id                      : 0x2::object::id_to_address(&v6),
                previous_present                    : v13,
                previous_still_blob_id              : v14,
                previous_still_is_encrypted         : v15,
                previous_still_sealed_dek_length    : v16,
                previous_still_sealed_dek_digest    : v17,
                previous_has_animated               : v18,
                previous_animated_blob_id           : v19,
                previous_animated_is_encrypted      : v20,
                previous_animated_sealed_dek_length : v21,
                previous_animated_sealed_dek_digest : v22,
                current_present                     : v23,
                current_still_blob_id               : v24,
                current_still_is_encrypted          : v25,
                current_still_sealed_dek_length     : v26,
                current_still_sealed_dek_digest     : v27,
                current_has_animated                : v28,
                current_animated_blob_id            : v29,
                current_animated_is_encrypted       : v30,
                current_animated_sealed_dek_length  : v31,
                current_animated_sealed_dek_digest  : v32,
                album                               : v43,
            };
            0x2::event::emit<ReleaseTrackCoverArtUnsetEvent>(v44);
        };
    }

    // decompiled from Move bytecode v7
}

