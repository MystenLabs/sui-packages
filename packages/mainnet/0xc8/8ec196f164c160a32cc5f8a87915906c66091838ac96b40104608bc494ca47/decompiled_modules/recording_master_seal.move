module 0xc88ec196f164c160a32cc5f8a87915906c66091838ac96b40104608bc494ca47::recording_master_seal {
    entry fun seal_approve<T0>(arg0: vector<u8>, arg1: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>, arg2: &0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::RecordingAdminCap<T0>) {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::object::id<0xd958fc04212d0be5c92fd89964e6d2fa1065be489b19eaf7668f77ca46c6dba::recording::Recording<T0>>(arg1);
        assert!(0x2::bcs::peel_address(&mut v0) == 0x2::object::id_to_address(&v1), 0);
        let v2 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v2), 1);
        assert!(0x139e6ee3f98645506a5e8a5f6258922b46eb97d645ecb371bce1b3082707145e::recording_master::has_master<T0>(arg1, 0x2::bcs::peel_u256(&mut v0)), 2);
    }

    // decompiled from Move bytecode v7
}

