module 0xfa543ceec1815fee65f95510ef1b89a40ef0c47ce6ecaea3a6a8bc9c2ede7116::pool {
    struct PoolCreationConfig has store, key {
        id: 0x2::object::UID,
        protocol_fee: u64,
    }

    struct PoolCreated<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        tick_size: u64,
        lot_size: u64,
        min_size: u64,
    }

    public fun create_permissionless_pool<T0, T1>(arg0: &mut 0xfa543ceec1815fee65f95510ef1b89a40ef0c47ce6ecaea3a6a8bc9c2ede7116::wrapper::Wrapper, arg1: &PoolCreationConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::registry::Registry, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xfa543ceec1815fee65f95510ef1b89a40ef0c47ce6ecaea3a6a8bc9c2ede7116::wrapper::verify_version(arg0);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::pool_creation_fee();
        let v1 = arg1.protocol_fee;
        assert!(0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg3) >= v0 + v1, 1);
        0xfa543ceec1815fee65f95510ef1b89a40ef0c47ce6ecaea3a6a8bc9c2ede7116::wrapper::join_protocol_fee<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::coin::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg3, v1, arg7)));
        0xfa543ceec1815fee65f95510ef1b89a40ef0c47ce6ecaea3a6a8bc9c2ede7116::helper::transfer_if_nonzero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3, 0x2::tx_context::sender(arg7));
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

    public fun update_pool_creation_protocol_fee(arg0: &mut PoolCreationConfig, arg1: 0xfa543ceec1815fee65f95510ef1b89a40ef0c47ce6ecaea3a6a8bc9c2ede7116::ticket::AdminTicket, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xfa543ceec1815fee65f95510ef1b89a40ef0c47ce6ecaea3a6a8bc9c2ede7116::ticket::validate_ticket(&arg1, 0xfa543ceec1815fee65f95510ef1b89a40ef0c47ce6ecaea3a6a8bc9c2ede7116::ticket::update_pool_creation_protocol_fee_ticket_type(), arg3, arg4);
        0xfa543ceec1815fee65f95510ef1b89a40ef0c47ce6ecaea3a6a8bc9c2ede7116::ticket::destroy_ticket(arg1);
        arg0.protocol_fee = arg2;
    }

    // decompiled from Move bytecode v6
}

