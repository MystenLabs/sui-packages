module 0xe3e9192999b22c045007637d73b670781ceba682092e2388f8fd753b51b9e333::recording_streaming_transcode {
    struct ExtensionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct StreamingTranscode has copy, drop, store {
        quilt: 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::WalrusQuilt,
    }

    struct RecordingStreamingTranscodeSetEvent<phantom T0, phantom T1> has copy, drop {
        recording_id: address,
        composition_id: address,
        admin_cap_id: address,
        had_transcode: bool,
        previous_quilt_id: u256,
        quilt_id: u256,
    }

    struct RecordingStreamingTranscodeClearedEvent<phantom T0, phantom T1> has copy, drop {
        recording_id: address,
        composition_id: address,
        admin_cap_id: address,
        quilt_id: u256,
    }

    public fun has_streaming_transcode<T0, T1>(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>) : bool {
        let v0 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::exists<ExtensionKey>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid<T0, T1>(arg0), v0)
    }

    public fun new(arg0: 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::WalrusQuilt) : StreamingTranscode {
        StreamingTranscode{quilt: arg0}
    }

    public fun quilt(arg0: &StreamingTranscode) : &0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::WalrusQuilt {
        &arg0.quilt
    }

    public fun set_streaming_transcode<T0, T1>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>, arg2: StreamingTranscode) {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>>(arg0);
        let v1 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::composition_id<T0, T1>(arg0);
        let v2 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>>(arg1);
        let v3 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid_mut<T0, T1>(arg0, arg1);
        let v4 = ExtensionKey{dummy_field: false};
        let v5 = 0x2::dynamic_field::exists<ExtensionKey>(v3, v4);
        let v6 = 0;
        let v7 = true;
        if (v5) {
            let v8 = ExtensionKey{dummy_field: false};
            let v9 = 0x2::dynamic_field::borrow<ExtensionKey, StreamingTranscode>(v3, v8);
            v6 = 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::quilt_id(quilt(v9));
            v7 = *v9 != arg2;
            let v10 = ExtensionKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<ExtensionKey, StreamingTranscode>(v3, v10) = arg2;
        } else {
            let v11 = ExtensionKey{dummy_field: false};
            0x2::dynamic_field::add<ExtensionKey, StreamingTranscode>(v3, v11, arg2);
        };
        if (v7) {
            let v12 = RecordingStreamingTranscodeSetEvent<T0, T1>{
                recording_id      : 0x2::object::id_to_address(&v0),
                composition_id    : 0x2::object::id_to_address(&v1),
                admin_cap_id      : 0x2::object::id_to_address(&v2),
                had_transcode     : v5,
                previous_quilt_id : v6,
                quilt_id          : 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::quilt_id(quilt(&arg2)),
            };
            0x2::event::emit<RecordingStreamingTranscodeSetEvent<T0, T1>>(v12);
        };
    }

    public fun streaming_transcode<T0, T1>(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>) : &StreamingTranscode {
        assert!(has_streaming_transcode<T0, T1>(arg0), 13906834797113638913);
        let v0 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::borrow<ExtensionKey, StreamingTranscode>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid<T0, T1>(arg0), v0)
    }

    public fun unset_streaming_transcode<T0, T1>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>) {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::Recording<T0, T1>>(arg0);
        let v1 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::composition_id<T0, T1>(arg0);
        let v2 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::RecordingAdminCap<T0>>(arg1);
        let v3 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::recording::uid_mut<T0, T1>(arg0, arg1);
        let v4 = ExtensionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ExtensionKey>(v3, v4)) {
            let v5 = ExtensionKey{dummy_field: false};
            let v6 = 0x2::dynamic_field::remove<ExtensionKey, StreamingTranscode>(v3, v5);
            let v7 = RecordingStreamingTranscodeClearedEvent<T0, T1>{
                recording_id   : 0x2::object::id_to_address(&v0),
                composition_id : 0x2::object::id_to_address(&v1),
                admin_cap_id   : 0x2::object::id_to_address(&v2),
                quilt_id       : 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::quilt_id(quilt(&v6)),
            };
            0x2::event::emit<RecordingStreamingTranscodeClearedEvent<T0, T1>>(v7);
        };
    }

    // decompiled from Move bytecode v7
}

