module 0x3c85625e6b0d571e694a76b6be5f61c0634bd7007862ad0f0cca28f08b4e5f55::recording_master {
    struct ExtensionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct MasterSetEvent<phantom T0, phantom T1> has copy, drop {
        recording_id: 0x2::object::ID,
        master: 0x73a989640258bd5d82e0ae23bcb6f874fae65c78aecc1781b9a702801a043d7e::audio::Audio,
    }

    struct MasterUnsetEvent<phantom T0, phantom T1> has copy, drop {
        recording_id: 0x2::object::ID,
    }

    public fun has_master<T0, T1>(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>) : bool {
        let v0 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::exists<ExtensionKey>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid<T0, T1>(arg0), v0)
    }

    public fun master<T0, T1>(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>) : &0x73a989640258bd5d82e0ae23bcb6f874fae65c78aecc1781b9a702801a043d7e::audio::Audio {
        assert!(has_master<T0, T1>(arg0), 1);
        let v0 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::borrow<ExtensionKey, 0x73a989640258bd5d82e0ae23bcb6f874fae65c78aecc1781b9a702801a043d7e::audio::Audio>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid<T0, T1>(arg0), v0)
    }

    public fun set_master<T0, T1>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>, arg2: 0x73a989640258bd5d82e0ae23bcb6f874fae65c78aecc1781b9a702801a043d7e::audio::Audio) {
        let v0 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid_mut<T0, T1>(arg0, arg1);
        let v1 = true;
        let v2 = ExtensionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ExtensionKey>(v0, v2)) {
            let v3 = ExtensionKey{dummy_field: false};
            v1 = *0x2::dynamic_field::borrow<ExtensionKey, 0x73a989640258bd5d82e0ae23bcb6f874fae65c78aecc1781b9a702801a043d7e::audio::Audio>(v0, v3) != arg2;
            let v4 = ExtensionKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<ExtensionKey, 0x73a989640258bd5d82e0ae23bcb6f874fae65c78aecc1781b9a702801a043d7e::audio::Audio>(v0, v4) = arg2;
        } else {
            let v5 = ExtensionKey{dummy_field: false};
            0x2::dynamic_field::add<ExtensionKey, 0x73a989640258bd5d82e0ae23bcb6f874fae65c78aecc1781b9a702801a043d7e::audio::Audio>(v0, v5, arg2);
        };
        if (v1) {
            let v6 = MasterSetEvent<T0, T1>{
                recording_id : 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>>(arg0),
                master       : arg2,
            };
            0x2::event::emit<MasterSetEvent<T0, T1>>(v6);
        };
    }

    public fun unset_master<T0, T1>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>) {
        let v0 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid_mut<T0, T1>(arg0, arg1);
        let v1 = ExtensionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ExtensionKey>(v0, v1)) {
            let v2 = ExtensionKey{dummy_field: false};
            0x2::dynamic_field::remove<ExtensionKey, 0x73a989640258bd5d82e0ae23bcb6f874fae65c78aecc1781b9a702801a043d7e::audio::Audio>(v0, v2);
            let v3 = MasterUnsetEvent<T0, T1>{recording_id: 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>>(arg0)};
            0x2::event::emit<MasterUnsetEvent<T0, T1>>(v3);
        };
    }

    // decompiled from Move bytecode v7
}

