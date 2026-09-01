module 0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::access {
    fun assert_id_belongs_to_bucket(arg0: &vector<u8>, arg1: &0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::kraterion::KraterionBucket) {
        assert!(0x1::vector::length<u8>(arg0) >= 32, 1);
        let v0 = 0x2::object::uid_to_bytes(0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::kraterion::id(arg1));
        let v1 = 0;
        while (v1 < 32) {
            assert!(*0x1::vector::borrow<u8>(arg0, v1) == *0x1::vector::borrow<u8>(&v0, v1), 1);
            v1 = v1 + 1;
        };
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::kraterion::KraterionBucket, arg2: &0x2::tx_context::TxContext) {
        assert_id_belongs_to_bucket(&arg0, arg1);
        let v0 = 0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::kraterion::encryption_mode(arg1);
        if (v0 == 0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::kraterion::encryption_mode_public()) {
            return
        };
        assert!(v0 == 0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::kraterion::encryption_mode_private(), 2);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(v1 == 0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::kraterion::owner(arg1) || 0x1::vector::contains<address>(0xcd9329e9693fecbcdb1d505d537e007c08d08f77dc65094cf149bc3018ce3396::kraterion::api_addresses(arg1), &v1), 0);
    }

    // decompiled from Move bytecode v7
}

