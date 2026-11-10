module 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::tensor {
    public fun add(arg0: &vector<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>, arg1: &vector<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>) : vector<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed> {
        assert!(0x1::vector::length<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0) == 0x1::vector::length<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg1), 0);
        let v0 = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0)) {
            0x1::vector::push_back<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(&mut v0, 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::add(*0x1::vector::borrow<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0, v1), *0x1::vector::borrow<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg1, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun argmax(arg0: &vector<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>, arg1: u64) : u64 {
        assert!(arg1 > 0 && arg1 <= 0x1::vector::length<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(arg0), 0);
        let v0 = 0;
        let v1 = 0;
        while (v1 < arg1) {
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

