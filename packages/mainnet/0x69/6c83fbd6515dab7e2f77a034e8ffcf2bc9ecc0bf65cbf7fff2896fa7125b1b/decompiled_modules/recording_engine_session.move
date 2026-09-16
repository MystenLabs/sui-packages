module 0x696c83fbd6515dab7e2f77a034e8ffcf2bc9ecc0bf65cbf7fff2896fa7125b1b::recording_engine_session {
    struct ExtensionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Stem has copy, drop, store {
        digest: vector<u8>,
        blob_id: u256,
    }

    struct EngineSession has copy, drop, store {
        blob_id: u256,
        stems: vector<Stem>,
    }

    struct EngineSessionSetEvent<phantom T0, phantom T1> has copy, drop {
        recording_id: address,
        composition_id: address,
        admin_cap_id: address,
        had_previous: bool,
        value_changed: bool,
        previous_session_blob_id: u256,
        previous_stem_count: u64,
        session_blob_id: u256,
        stem_count: u64,
    }

    struct EngineSessionUnsetEvent<phantom T0, phantom T1> has copy, drop {
        recording_id: address,
        composition_id: address,
        admin_cap_id: address,
        removed_session_blob_id: u256,
        removed_stem_count: u64,
    }

    public fun blob_id(arg0: &EngineSession) : u256 {
        arg0.blob_id
    }

    fun digest_lt(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 32) {
            if (*0x1::vector::borrow<u8>(arg0, v0) != *0x1::vector::borrow<u8>(arg1, v0)) {
                return *0x1::vector::borrow<u8>(arg0, v0) < *0x1::vector::borrow<u8>(arg1, v0)
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun engine_session<T0, T1>(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>) : &EngineSession {
        assert!(has_engine_session<T0, T1>(arg0), 13906835153596252166);
        let v0 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::borrow<ExtensionKey, EngineSession>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid<T0, T1>(arg0), v0)
    }

    fun event_snapshot(arg0: &EngineSession) : (u256, u64) {
        (arg0.blob_id, 0x1::vector::length<Stem>(&arg0.stems))
    }

    public fun has_engine_session<T0, T1>(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>) : bool {
        let v0 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::exists<ExtensionKey>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid<T0, T1>(arg0), v0)
    }

    public fun new(arg0: u256, arg1: vector<Stem>) : EngineSession {
        let v0 = 1;
        while (v0 < 0x1::vector::length<Stem>(&arg1)) {
            assert!(digest_lt(&0x1::vector::borrow<Stem>(&arg1, v0 - 1).digest, &0x1::vector::borrow<Stem>(&arg1, v0).digest), 13906834698329587716);
            v0 = v0 + 1;
        };
        EngineSession{
            blob_id : arg0,
            stems   : arg1,
        }
    }

    public fun new_stem(arg0: vector<u8>, arg1: u256) : Stem {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 13906834646789849090);
        Stem{
            digest  : arg0,
            blob_id : arg1,
        }
    }

    public fun set_engine_session<T0, T1>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>, arg2: EngineSession) {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>>(arg0);
        let v1 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::composition_id<T0, T1>(arg0);
        let v2 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>>(arg1);
        let v3 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid_mut<T0, T1>(arg0, arg1);
        let v4 = ExtensionKey{dummy_field: false};
        let v5 = 0x2::dynamic_field::exists<ExtensionKey>(v3, v4);
        let (v6, v7, v8) = if (v5) {
            let v9 = ExtensionKey{dummy_field: false};
            let v10 = 0x2::dynamic_field::borrow<ExtensionKey, EngineSession>(v3, v9);
            (v10.blob_id, 0x1::vector::length<Stem>(&v10.stems), *v10 != arg2)
        } else {
            (0, 0, true)
        };
        let (v11, v12) = event_snapshot(&arg2);
        if (v5) {
            let v13 = ExtensionKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<ExtensionKey, EngineSession>(v3, v13) = arg2;
        } else {
            let v14 = ExtensionKey{dummy_field: false};
            0x2::dynamic_field::add<ExtensionKey, EngineSession>(v3, v14, arg2);
        };
        if (v8) {
            let v15 = EngineSessionSetEvent<T0, T1>{
                recording_id             : 0x2::object::id_to_address(&v0),
                composition_id           : 0x2::object::id_to_address(&v1),
                admin_cap_id             : 0x2::object::id_to_address(&v2),
                had_previous             : v5,
                value_changed            : v8,
                previous_session_blob_id : v6,
                previous_stem_count      : v7,
                session_blob_id          : v11,
                stem_count               : v12,
            };
            0x2::event::emit<EngineSessionSetEvent<T0, T1>>(v15);
        };
    }

    public fun stem_blob_id(arg0: &Stem) : u256 {
        arg0.blob_id
    }

    public fun stem_digest(arg0: &Stem) : &vector<u8> {
        &arg0.digest
    }

    public fun stems(arg0: &EngineSession) : &vector<Stem> {
        &arg0.stems
    }

    public fun unset_engine_session<T0, T1>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>) {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>>(arg0);
        let v1 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::composition_id<T0, T1>(arg0);
        let v2 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>>(arg1);
        let v3 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid_mut<T0, T1>(arg0, arg1);
        let v4 = ExtensionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ExtensionKey>(v3, v4)) {
            let v5 = ExtensionKey{dummy_field: false};
            let (v6, v7) = event_snapshot(0x2::dynamic_field::borrow<ExtensionKey, EngineSession>(v3, v5));
            let v8 = ExtensionKey{dummy_field: false};
            0x2::dynamic_field::remove<ExtensionKey, EngineSession>(v3, v8);
            let v9 = EngineSessionUnsetEvent<T0, T1>{
                recording_id            : 0x2::object::id_to_address(&v0),
                composition_id          : 0x2::object::id_to_address(&v1),
                admin_cap_id            : 0x2::object::id_to_address(&v2),
                removed_session_blob_id : v6,
                removed_stem_count      : v7,
            };
            0x2::event::emit<EngineSessionUnsetEvent<T0, T1>>(v9);
        };
    }

    // decompiled from Move bytecode v7
}

