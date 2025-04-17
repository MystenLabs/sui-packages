module 0xb0b694debf10213ad925f201ead1001dbcd06d7a744d6a5fe0196c41029f1629::pool {
    struct CreatePoolConfig has store, key {
        id: 0x2::object::UID,
        protocol_fee: u64,
    }

    public fun create_permissionless_pool<T0, T1>(arg0: &mut 0xb0b694debf10213ad925f201ead1001dbcd06d7a744d6a5fe0196c41029f1629::wrapper::Wrapper, arg1: &CreatePoolConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::registry::Registry, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::pool_creation_fee();
        let v1 = arg1.protocol_fee;
        assert!(0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg6) >= v0 + v1, 9223372333207584770);
        0xb0b694debf10213ad925f201ead1001dbcd06d7a744d6a5fe0196c41029f1629::wrapper::join_protocol_fee<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::coin::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg6, v1, arg7)));
        0xb0b694debf10213ad925f201ead1001dbcd06d7a744d6a5fe0196c41029f1629::helper::transfer_if_nonzero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg6, 0x2::tx_context::sender(arg7));
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::create_permissionless_pool<T0, T1>(arg2, arg3, arg4, arg5, 0x2::coin::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg6, v0, arg7), arg7)
    }

    public fun get_create_pool_protocol_fee(arg0: &CreatePoolConfig) : u64 {
        arg0.protocol_fee
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CreatePoolConfig{
            id           : 0x2::object::new(arg0),
            protocol_fee : 100000000,
        };
        0x2::transfer::share_object<CreatePoolConfig>(v0);
    }

    public fun update_create_pool_protocol_fee(arg0: &0xb0b694debf10213ad925f201ead1001dbcd06d7a744d6a5fe0196c41029f1629::admin::AdminCap, arg1: &mut CreatePoolConfig, arg2: u64) {
        arg1.protocol_fee = arg2;
    }

    // decompiled from Move bytecode v6
}

