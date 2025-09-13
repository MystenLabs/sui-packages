module 0xbea4abb98df843c3b51a0a727e79a078c2747f586098ef1eee45f101fe09a442::executor_layerzero {
    struct EXECUTOR_LAYERZERO has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXECUTOR_LAYERZERO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::CallCap>(0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::new_package_cap<EXECUTOR_LAYERZERO>(&arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun init_executor(arg0: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::CallCap, arg1: address, arg2: address, arg3: address, arg4: u16, arg5: address, arg6: vector<address>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::id(&arg0) == 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::original_package_of_type<EXECUTOR_LAYERZERO>(), 1);
        0x2::transfer::public_share_object<0x8d9ea9aa165f57b65b46174132d3db456ac05f083f76600f25de2a0b81f3eff7::executor_worker::Executor>(0x8d9ea9aa165f57b65b46174132d3db456ac05f083f76600f25de2a0b81f3eff7::executor_worker::create_executor(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7));
    }

    // decompiled from Move bytecode v6
}

