module 0x9edc19a8bbb9271ee7ac99bbb364a2457106e14179842a9c6c3fe0a87db6d59f::dvn_layerzero {
    struct DVN_LAYERZERO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVN_LAYERZERO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap>(0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::new_package_cap<DVN_LAYERZERO>(&arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun init_dvn(arg0: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap, arg1: u32, arg2: address, arg3: address, arg4: address, arg5: u16, arg6: vector<address>, arg7: vector<vector<u8>>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(&arg0) == 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::original_package_of_type<DVN_LAYERZERO>(), 1);
        0x2::transfer::public_share_object<0x6810f5568936a9a2b5fcb043f59a3cbf681e06f0db61c90bf3ff5530d4f470c0::dvn::DVN>(0x6810f5568936a9a2b5fcb043f59a3cbf681e06f0db61c90bf3ff5530d4f470c0::dvn::create_dvn(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9));
    }

    // decompiled from Move bytecode v6
}

