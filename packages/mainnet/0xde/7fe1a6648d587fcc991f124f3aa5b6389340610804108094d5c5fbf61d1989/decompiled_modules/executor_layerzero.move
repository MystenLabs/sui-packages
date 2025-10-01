module 0xde7fe1a6648d587fcc991f124f3aa5b6389340610804108094d5c5fbf61d1989::executor_layerzero {
    struct EXECUTOR_LAYERZERO has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXECUTOR_LAYERZERO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap>(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::new_package_cap<EXECUTOR_LAYERZERO>(&arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun init_executor(arg0: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap, arg1: address, arg2: vector<address>, arg3: address, arg4: address, arg5: u16, arg6: address, arg7: vector<address>, arg8: &mut 0xb8d08d3a9604c51ec6ad8ee39a05e9c3fed1335df755089f1d3f0e093b9a4ec8::worker_registry::WorkerRegistry, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(&arg0) == 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::original_package_of_type<EXECUTOR_LAYERZERO>(), 1);
        0x11da80425fb389d1090743a2a33a48c479f4fd218a25db2cdc072b768a47ce5::executor_worker::create_executor(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    // decompiled from Move bytecode v6
}

