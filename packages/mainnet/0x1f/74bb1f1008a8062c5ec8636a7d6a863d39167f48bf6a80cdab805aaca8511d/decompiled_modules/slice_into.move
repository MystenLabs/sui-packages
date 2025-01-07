module 0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::slice_into {
    public(friend) fun slice_into(arg0: &mut vector<u8>, arg1: u64, arg2: &vector<u8>, arg3: u64, arg4: u64) {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(arg1 <= v0, 0);
        let v1 = 0;
        while (v1 < arg4 && arg1 < v0) {
            *0x1::vector::borrow_mut<u8>(arg0, arg1) = *0x1::vector::borrow<u8>(arg2, v1 + arg3);
            v1 = v1 + 1;
            arg1 = arg1 + 1;
        };
        while (v1 < arg4) {
            0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(arg2, v1 + arg3));
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

