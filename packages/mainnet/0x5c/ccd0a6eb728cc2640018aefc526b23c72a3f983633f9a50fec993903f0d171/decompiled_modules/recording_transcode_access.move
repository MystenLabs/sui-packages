module 0x5cccd0a6eb728cc2640018aefc526b23c72a3f983633f9a50fec993903f0d171::recording_transcode_access {
    fun assert_identity<T0, T1>(arg0: vector<u8>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>) {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>>(arg1);
        assert!(0x2::bcs::peel_address(&mut v0) == 0x2::object::id_to_address(&v1), 0);
        let v2 = 0x2::bcs::peel_u256(&mut v0);
        let v3 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v3), 1);
        assert!(0x7a83dd22131cad38ded582a5cb5527e1ab95eec3c748e934585d6da4f61da563::recording_transcode::has_transcode<T0>(arg1, v2), 2);
        assert!(0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::blob_id(0x7a83dd22131cad38ded582a5cb5527e1ab95eec3c748e934585d6da4f61da563::recording_transcode::data<T1>(0x7a83dd22131cad38ded582a5cb5527e1ab95eec3c748e934585d6da4f61da563::recording_transcode::transcode<T0, T1>(arg1, v2))) == 0x2::bcs::peel_u256(&mut v0), 3);
    }

    entry fun seal_approve_owner<T0, T1>(arg0: vector<u8>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg2: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::RecordingAdminCap<T0>) {
        assert_identity<T0, T1>(arg0, arg1);
    }

    entry fun seal_approve_record<T0, T1>(arg0: vector<u8>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg2: &0xc809d0b656952107845bc20e5fb8a5ace24d9487682b4d3feaf83e7171d6ed79::record_access::RecordAccess, arg3: &0x2::tx_context::TxContext) {
        assert_identity<T0, T1>(arg0, arg1);
        assert!(0xc809d0b656952107845bc20e5fb8a5ace24d9487682b4d3feaf83e7171d6ed79::record_access::owner(arg2) == 0x2::tx_context::sender(arg3), 4);
        assert!(0x73c189fe3357bfd3eede39c646a2bcc277362708f3e8e209f1fcca9be748d42e::release_license::has_release_authorization<T0>(arg1, 0xc809d0b656952107845bc20e5fb8a5ace24d9487682b4d3feaf83e7171d6ed79::record_access::release_id(arg2)), 5);
    }

    // decompiled from Move bytecode v7
}

