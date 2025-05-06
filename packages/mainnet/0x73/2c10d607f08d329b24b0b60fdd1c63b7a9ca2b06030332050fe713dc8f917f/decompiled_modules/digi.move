module 0x732c10d607f08d329b24b0b60fdd1c63b7a9ca2b06030332050fe713dc8f917f::digi {
    struct DIGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIGI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"DIGI";
        let (v1, v2) = 0x2::coin::create_currency<DIGI>(arg0, 2, v0, b"DIGI", x"44494749207365727665732061732074686520666f756e646174696f6e616c206163636f756e74696e6720616e6420736574746c656d656e7420746f6b656e2077697468696e2044414b41e28099732065636f73797374656d2c20656e61626c696e67207265616c2d74696d6520696e7465722d706172747920636c656172696e6720616e64206175746f6d61746564206c6564676572207265636f6e63696c696174696f6e2e20497420706f7765727320696e737469747574696f6e616c2d67726164652066696e616e6369616c206f7065726174696f6e732c207265647563696e672063726f73732d706c6174666f726d206672696374696f6e207768696c6520656e737572696e672061756469742d70726f6f66207472616e73616374696f6e20747261636b696e67207468726f75676820696d6d757461626c6520626c6f636b636861696e207265636f7264732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreido6jbnkwc6gtxysbzateff3gjkoxmz62eqcje7nffi2wt4wfku6u")), arg1);
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::token::create_token<DIGI>(@0x3f2620474648cb8f054e65dac2723c3253922a9181db7d3edd7cf4fa830c3a73, v0, 0x2::tx_context::sender(arg1), v1, v2, 18446744073709551615, arg1);
    }

    public(friend) fun mint<T0: copy + drop>(arg0: &0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::token::Token<DIGI>, arg1: &mut 0x2::coin::TreasuryCap<DIGI>, arg2: u64, arg3: address, arg4: u16, arg5: 0x1::string::String, arg6: T0, arg7: &mut 0x2::tx_context::TxContext) {
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::token::mint_transfer<DIGI, T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun public_mint(arg0: &0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::token::Token<DIGI>, arg1: &mut 0x2::coin::TreasuryCap<DIGI>, arg2: u64, arg3: address, arg4: u16, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        mint<0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::event::EventTip>(arg0, arg1, arg2, arg3, arg4, arg5, 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::event::new_event_tip(arg6), arg7);
    }

    // decompiled from Move bytecode v6
}

