module 0x9f09f3a9fb7411ca3836f146bbc6012c8823059f020307f99cf1ff057f55fb2::pool {
    struct PoolCreationConfig has store, key {
        id: 0x2::object::UID,
        protocol_fee: u64,
    }

    struct PoolCreated<phantom T0, phantom T1> has copy, drop, store {
        pool_id: 0x2::object::ID,
        tick_size: u64,
        lot_size: u64,
        min_size: u64,
    }

    public fun create_permissionless_pool<T0, T1>(arg0: &mut 0x9f09f3a9fb7411ca3836f146bbc6012c8823059f020307f99cf1ff057f55fb2::wrapper::Wrapper, arg1: &PoolCreationConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::registry::Registry, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x9f09f3a9fb7411ca3836f146bbc6012c8823059f020307f99cf1ff057f55fb2::wrapper::verify_version(arg0);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::pool_creation_fee();
        let v1 = arg1.protocol_fee;
        assert!(0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg3) >= v0 + v1, 1);
        0x9f09f3a9fb7411ca3836f146bbc6012c8823059f020307f99cf1ff057f55fb2::wrapper::join_protocol_fee<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::coin::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg3, v1, arg7)));
        0x9f09f3a9fb7411ca3836f146bbc6012c8823059f020307f99cf1ff057f55fb2::helper::transfer_if_nonzero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3, 0x2::tx_context::sender(arg7));
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

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolCreationConfig{
            id           : 0x2::object::new(arg0),
            protocol_fee : 100000000,
        };
        0x2::transfer::share_object<PoolCreationConfig>(v0);
    }

    public fun pool_creation_protocol_fee(arg0: &PoolCreationConfig) : u64 {
        arg0.protocol_fee
    }

    public fun update_pool_creation_protocol_fee(arg0: &mut PoolCreationConfig, arg1: 0x9f09f3a9fb7411ca3836f146bbc6012c8823059f020307f99cf1ff057f55fb2::wrapper::AdminTicket, arg2: &0x9f09f3a9fb7411ca3836f146bbc6012c8823059f020307f99cf1ff057f55fb2::admin::AdminCap, arg3: u64, arg4: vector<vector<u8>>, arg5: vector<u8>, arg6: u16, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x9f09f3a9fb7411ca3836f146bbc6012c8823059f020307f99cf1ff057f55fb2::multisig::check_if_sender_is_multisig_address(arg4, arg5, arg6, arg8), 2);
        0x9f09f3a9fb7411ca3836f146bbc6012c8823059f020307f99cf1ff057f55fb2::wrapper::validate_ticket(&arg1, 0x9f09f3a9fb7411ca3836f146bbc6012c8823059f020307f99cf1ff057f55fb2::wrapper::update_pool_creation_protocol_fee_ticket_type(), arg7, arg8);
        0x9f09f3a9fb7411ca3836f146bbc6012c8823059f020307f99cf1ff057f55fb2::wrapper::destroy_ticket(arg1);
        arg0.protocol_fee = arg3;
    }

    // decompiled from Move bytecode v6
}

