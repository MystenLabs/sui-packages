module 0x2111256b15f5d0a20f6352084dac268c737b47c113b4da5eacb316f8a536f9bf::executor_layerzero {
    struct EXECUTOR_LAYERZERO has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXECUTOR_LAYERZERO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap>(0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::new_package_cap<EXECUTOR_LAYERZERO>(&arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun init_executor(arg0: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap, arg1: address, arg2: address, arg3: address, arg4: u16, arg5: address, arg6: vector<address>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::id(&arg0) == 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::original_package_of_type<EXECUTOR_LAYERZERO>(), 1);
        0x2::transfer::public_share_object<0x749420cc42b47d3db83fe316eb8accd8126bed9a779c0b7e06fa084c7fa1d76d::executor_worker::Executor>(0x749420cc42b47d3db83fe316eb8accd8126bed9a779c0b7e06fa084c7fa1d76d::executor_worker::create_executor(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7));
    }

    // decompiled from Move bytecode v6
}

