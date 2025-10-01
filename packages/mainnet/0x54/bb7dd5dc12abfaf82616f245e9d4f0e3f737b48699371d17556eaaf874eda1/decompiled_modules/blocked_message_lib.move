module 0x54bb7dd5dc12abfaf82616f245e9d4f0e3f737b48699371d17556eaaf874eda1::blocked_message_lib {
    struct BLOCKED_MESSAGE_LIB has drop {
        dummy_field: bool,
    }

    struct BlockedMessageLib has key {
        id: 0x2::object::UID,
        call_cap: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap,
    }

    fun init(arg0: BLOCKED_MESSAGE_LIB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BlockedMessageLib{
            id       : 0x2::object::new(arg1),
            call_cap : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::new_package_cap<BLOCKED_MESSAGE_LIB>(&arg0, arg1),
        };
        0x2::transfer::share_object<BlockedMessageLib>(v0);
    }

    public fun quote(arg0: &BlockedMessageLib, arg1: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_quote::QuoteParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_fee::MessagingFee>) {
        abort 1
    }

    public fun send(arg0: &BlockedMessageLib, arg1: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_send::SendResult>) {
        abort 1
    }

    public fun set_config(arg0: &BlockedMessageLib, arg1: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_set_config::SetConfigParam, 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Void>) {
        abort 1
    }

    public fun version() : (u64, u8, u8) {
        (18446744073709551615, 255, 2)
    }

    // decompiled from Move bytecode v6
}

