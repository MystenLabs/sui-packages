module 0x3af84dc1d696592e08f42dd8fa6b323fde8080195c7b6cd56fe53018782395fe::dvn_layerzero {
    struct DVN_LAYERZERO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVN_LAYERZERO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::CallCap>(0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::new_package_cap<DVN_LAYERZERO>(&arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun init_dvn(arg0: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::CallCap, arg1: u32, arg2: address, arg3: address, arg4: address, arg5: u16, arg6: vector<address>, arg7: vector<vector<u8>>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::id(&arg0) == 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::original_package_of_type<DVN_LAYERZERO>(), 1);
        0x2::transfer::public_share_object<0x47e44a6c44436603a3e1f9cbbe91c47f92247fbd0254a696cd7da4627af381b9::dvn::DVN>(0x47e44a6c44436603a3e1f9cbbe91c47f92247fbd0254a696cd7da4627af381b9::dvn::create_dvn(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9));
    }

    // decompiled from Move bytecode v6
}

