module 0x8c4e6f80df3e0c16e82f9fb46d26e8763c77982a299cc427e6f136012398760a::dvn_layerzero {
    struct DVN_LAYERZERO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVN_LAYERZERO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap>(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::new_package_cap<DVN_LAYERZERO>(&arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun init_dvn(arg0: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap, arg1: u32, arg2: address, arg3: vector<address>, arg4: address, arg5: address, arg6: u16, arg7: vector<address>, arg8: vector<vector<u8>>, arg9: u64, arg10: &mut 0xb8d08d3a9604c51ec6ad8ee39a05e9c3fed1335df755089f1d3f0e093b9a4ec8::worker_registry::WorkerRegistry, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(&arg0) == 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::original_package_of_type<DVN_LAYERZERO>(), 1);
        0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::dvn::create_dvn(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    // decompiled from Move bytecode v6
}

