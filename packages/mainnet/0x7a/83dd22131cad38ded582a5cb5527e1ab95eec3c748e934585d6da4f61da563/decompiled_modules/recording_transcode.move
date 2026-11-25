module 0x7a83dd22131cad38ded582a5cb5527e1ab95eec3c748e934585d6da4f61da563::recording_transcode {
    struct RecordingTranscode<phantom T0> has drop, store {
        data: 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::WalrusBlob,
        preview: RecordingPreview,
    }

    struct RecordingPreview has copy, drop, store {
        start_sample: u64,
        end_sample: u64,
        data: 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::WalrusBlob,
    }

    struct RecordingTranscodeKey has copy, drop, store {
        pos0: u256,
    }

    struct RecordingTranscodeSetEvent<phantom T0> has copy, drop {
        recording_id: 0x2::object::ID,
        master_blob_id: u256,
        data: 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::WalrusBlob,
        preview: RecordingPreview,
    }

    struct RecordingTranscodeRemovedEvent<phantom T0> has copy, drop {
        recording_id: 0x2::object::ID,
        master_blob_id: u256,
    }

    public fun add_transcode<T0, T1>(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::RecordingAdminCap<T0>, arg2: u256, arg3: RecordingTranscode<T1>) {
        assert!(0x139e6ee3f98645506a5e8a5f6258922b46eb97d645ecb371bce1b3082707145e::recording_master::has_master<T0>(arg0, arg2), 1);
        let v0 = RecordingTranscodeKey{pos0: arg2};
        let v1 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid_mut<T0>(arg0, arg1);
        if (0x2::dynamic_field::exists_with_type<RecordingTranscodeKey, RecordingTranscode<T1>>(v1, v0)) {
            let v2 = 0x2::dynamic_field::borrow_mut<RecordingTranscodeKey, RecordingTranscode<T1>>(v1, v0);
            if (v2 == &arg3) {
                return
            };
            *v2 = arg3;
        } else {
            assert!(!0x2::dynamic_field::exists<RecordingTranscodeKey>(v1, v0), 5);
            0x2::dynamic_field::add<RecordingTranscodeKey, RecordingTranscode<T1>>(v1, v0, arg3);
        };
        let v3 = RecordingTranscodeSetEvent<T1>{
            recording_id   : 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>>(arg0),
            master_blob_id : arg2,
            data           : arg3.data,
            preview        : arg3.preview,
        };
        0x2::event::emit<RecordingTranscodeSetEvent<T1>>(v3);
    }

    public fun data<T0>(arg0: &RecordingTranscode<T0>) : &0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::WalrusBlob {
        &arg0.data
    }

    public fun end_sample(arg0: &RecordingPreview) : u64 {
        arg0.end_sample
    }

    public fun has_transcode<T0>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg1: u256) : bool {
        let v0 = RecordingTranscodeKey{pos0: arg1};
        0x2::dynamic_field::exists<RecordingTranscodeKey>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid<T0>(arg0), v0)
    }

    public fun new<T0: drop>(arg0: T0, arg1: 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::WalrusBlob, arg2: RecordingPreview) : RecordingTranscode<T0> {
        assert!(0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::confidentiality::is_encrypted(0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::blob_confidentiality(&arg1)), 2);
        RecordingTranscode<T0>{
            data    : arg1,
            preview : arg2,
        }
    }

    public fun new_preview(arg0: u64, arg1: u64, arg2: 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::WalrusBlob) : RecordingPreview {
        assert!(arg0 < arg1, 4);
        assert!(!0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::confidentiality::is_encrypted(0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::blob_confidentiality(&arg2)), 3);
        RecordingPreview{
            start_sample : arg0,
            end_sample   : arg1,
            data         : arg2,
        }
    }

    public fun preview<T0>(arg0: &RecordingTranscode<T0>) : &RecordingPreview {
        &arg0.preview
    }

    public fun preview_data(arg0: &RecordingPreview) : &0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::WalrusBlob {
        &arg0.data
    }

    public fun remove_transcode<T0, T1>(arg0: &mut 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::RecordingAdminCap<T0>, arg2: u256) : RecordingTranscode<T1> {
        let v0 = RecordingTranscodeKey{pos0: arg2};
        let v1 = 0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid_mut<T0>(arg0, arg1);
        assert!(0x2::dynamic_field::exists<RecordingTranscodeKey>(v1, v0), 0);
        let v2 = 0x2::dynamic_field::remove<RecordingTranscodeKey, RecordingTranscode<T1>>(v1, v0);
        let v3 = RecordingTranscodeRemovedEvent<T1>{
            recording_id   : 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>>(arg0),
            master_blob_id : arg2,
        };
        0x2::event::emit<RecordingTranscodeRemovedEvent<T1>>(v3);
        v2
    }

    public fun start_sample(arg0: &RecordingPreview) : u64 {
        arg0.start_sample
    }

    public fun transcode<T0, T1>(arg0: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg1: u256) : &RecordingTranscode<T1> {
        assert!(has_transcode<T0>(arg0, arg1), 0);
        let v0 = RecordingTranscodeKey{pos0: arg1};
        0x2::dynamic_field::borrow<RecordingTranscodeKey, RecordingTranscode<T1>>(0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::uid<T0>(arg0), v0)
    }

    // decompiled from Move bytecode v7
}

