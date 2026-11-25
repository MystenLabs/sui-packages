module 0xcd22dacf4d38126acb78ad21f04093b1fe9a81d23376ebb2f70b36eaf6dc4f5f::seal {
    entry fun seal_approve(arg0: vector<u8>, arg1: &0xcd22dacf4d38126acb78ad21f04093b1fe9a81d23376ebb2f70b36eaf6dc4f5f::record_audience::RecordAudience, arg2: &0xc809d0b656952107845bc20e5fb8a5ace24d9487682b4d3feaf83e7171d6ed79::record_access::RecordAccess, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::object::id<0xcd22dacf4d38126acb78ad21f04093b1fe9a81d23376ebb2f70b36eaf6dc4f5f::record_audience::RecordAudience>(arg1);
        assert!(0x2::bcs::peel_address(&mut v0) == 0x2::object::id_to_address(&v1), 0);
        0x2::bcs::peel_u256(&mut v0);
        let v2 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v2), 0);
        assert!(0xc809d0b656952107845bc20e5fb8a5ace24d9487682b4d3feaf83e7171d6ed79::record_access::owner(arg2) == 0x2::tx_context::sender(arg3), 1);
        assert!(0xcd22dacf4d38126acb78ad21f04093b1fe9a81d23376ebb2f70b36eaf6dc4f5f::record_audience::admits(arg1, 0xc809d0b656952107845bc20e5fb8a5ace24d9487682b4d3feaf83e7171d6ed79::record_access::release_id(arg2), 0xc809d0b656952107845bc20e5fb8a5ace24d9487682b4d3feaf83e7171d6ed79::record_access::edition(arg2), 0xc809d0b656952107845bc20e5fb8a5ace24d9487682b4d3feaf83e7171d6ed79::record_access::number(arg2)), 2);
    }

    // decompiled from Move bytecode v7
}

