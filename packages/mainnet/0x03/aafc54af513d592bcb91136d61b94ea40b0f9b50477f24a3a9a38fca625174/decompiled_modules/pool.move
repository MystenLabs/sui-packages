module 0xd7ca30ad715278a28f01c572ac7be3168e9800321f1b3f96eb9d13dfc856419c::pool {
    struct CreatePoolConfig has store, key {
        id: 0x2::object::UID,
        protocol_fee: u64,
    }

    struct PoolCreated<phantom T0, phantom T1> has copy, drop, store {
        pool_id: 0x2::object::ID,
        tick_size: u64,
        lot_size: u64,
        min_size: u64,
    }

    public fun create_permissionless_pool<T0, T1>(arg0: &mut 0xd7ca30ad715278a28f01c572ac7be3168e9800321f1b3f96eb9d13dfc856419c::wrapper::Wrapper, arg1: &CreatePoolConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::registry::Registry, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        abort 1000
    }

    public fun create_permissionless_pool_v2<T0, T1>(arg0: &mut 0xd7ca30ad715278a28f01c572ac7be3168e9800321f1b3f96eb9d13dfc856419c::wrapper::Wrapper, arg1: &CreatePoolConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::registry::Registry, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::pool_creation_fee();
        let v1 = arg1.protocol_fee;
        assert!(0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg3) >= v0 + v1, 1);
        0xd7ca30ad715278a28f01c572ac7be3168e9800321f1b3f96eb9d13dfc856419c::wrapper::join_protocol_fee<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::coin::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg3, v1, arg7)));
        0xd7ca30ad715278a28f01c572ac7be3168e9800321f1b3f96eb9d13dfc856419c::helper::transfer_if_nonzero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3, 0x2::tx_context::sender(arg7));
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::create_permissionless_pool<T0, T1>(arg2, arg4, arg5, arg6, 0x2::coin::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg3, v0, arg7), arg7);
        let v3 = PoolCreated<T0, T1>{
            pool_id   : v2,
            tick_size : arg4,
            lot_size  : arg5,
            min_size  : arg6,
        };
        0x2::event::emit<PoolCreated<T0, T1>>(v3);
        v2
    }

    public fun create_pool_creation_config(arg0: &0xd7ca30ad715278a28f01c572ac7be3168e9800321f1b3f96eb9d13dfc856419c::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        abort 1000
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

    public fun update_create_pool_protocol_fee(arg0: &0xd7ca30ad715278a28f01c572ac7be3168e9800321f1b3f96eb9d13dfc856419c::admin::AdminCap, arg1: &mut CreatePoolConfig, arg2: u64) {
        abort 1000
    }

    public fun update_create_pool_protocol_fee_v2(arg0: &mut CreatePoolConfig, arg1: &0xd7ca30ad715278a28f01c572ac7be3168e9800321f1b3f96eb9d13dfc856419c::admin::AdminCap, arg2: u64) {
        arg0.protocol_fee = arg2;
    }

    // decompiled from Move bytecode v6
}

