module 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::executor {
    struct OrderExecutedEvent has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        sui_amount: u64,
        execution_price: u64,
        timestamp: u64,
    }

    struct OrderExecutedWithSwapEvent has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        sui_sold: u64,
        usdc_received: u64,
        execution_price: u64,
        timestamp: u64,
    }

    struct ExecutionReceipt has store, key {
        id: 0x2::object::UID,
        order_id: 0x2::object::ID,
        owner: address,
        sui_sold: u64,
        usdc_received: u64,
        execution_price: u64,
        timestamp: u64,
    }

    public fun check_trigger(arg0: &0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::StopOrder, arg1: u64) : bool {
        0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::order_direction(arg0) == 0 && arg1 <= 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::order_trigger_price(arg0) || arg1 >= 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::order_trigger_price(arg0)
    }

    public fun create_swap_receipt(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : ExecutionReceipt {
        ExecutionReceipt{
            id              : 0x2::object::new(arg6),
            order_id        : arg0,
            owner           : arg1,
            sui_sold        : arg2,
            usdc_received   : arg3,
            execution_price : arg4,
            timestamp       : 0x2::clock::timestamp_ms(arg5),
        }
    }

    public fun emit_swap_execution_event(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        let v0 = OrderExecutedWithSwapEvent{
            order_id        : arg0,
            owner           : arg1,
            sui_sold        : arg2,
            usdc_received   : arg3,
            execution_price : arg4,
            timestamp       : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<OrderExecutedWithSwapEvent>(v0);
    }

    public fun execute_order(arg0: &mut 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::OrderRegistry, arg1: &mut 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::StopOrder, arg2: &mut 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::vault::Vault, arg3: &0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::vault::ExecutorCap, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : ExecutionReceipt {
        let (v0, v1) = execute_order_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, v2.owner);
        v2
    }

    public fun execute_order_for_swap(arg0: &mut 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::OrderRegistry, arg1: &mut 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::StopOrder, arg2: &mut 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::vault::Vault, arg3: &0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::vault::ExecutorCap, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, address, 0x2::object::ID, u64, u64) {
        assert!(0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::is_pending(arg1), 2);
        assert!(arg4 >= 1000000 && arg4 <= 1000000000000, 3);
        assert!(check_trigger(arg1, arg4), 0);
        let v0 = 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::order_id(arg1);
        let (v1, v2) = 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::vault::withdraw_for_execution(arg2, arg3, v0, arg6);
        0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::mark_executed(arg0, arg1, arg4);
        (v1, v2, v0, 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::order_amount(arg1), arg4)
    }

    fun execute_order_internal(arg0: &mut 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::OrderRegistry, arg1: &mut 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::StopOrder, arg2: &mut 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::vault::Vault, arg3: &0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::vault::ExecutorCap, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, ExecutionReceipt) {
        assert!(0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::is_pending(arg1), 2);
        assert!(arg4 >= 1000000 && arg4 <= 1000000000000, 3);
        assert!(check_trigger(arg1, arg4), 0);
        let v0 = 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::order_id(arg1);
        let v1 = 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::order_amount(arg1);
        let (v2, v3) = 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::vault::withdraw_for_execution(arg2, arg3, v0, arg6);
        0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::mark_executed(arg0, arg1, arg4);
        let v4 = 0x2::clock::timestamp_ms(arg5);
        let v5 = OrderExecutedEvent{
            order_id        : v0,
            owner           : v3,
            sui_amount      : v1,
            execution_price : arg4,
            timestamp       : v4,
        };
        0x2::event::emit<OrderExecutedEvent>(v5);
        let v6 = ExecutionReceipt{
            id              : 0x2::object::new(arg6),
            order_id        : v0,
            owner           : v3,
            sui_sold        : v1,
            usdc_received   : v1 * arg4 / 1000000000,
            execution_price : arg4,
            timestamp       : v4,
        };
        (v2, v6)
    }

    public entry fun execute_order_simple(arg0: &mut 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::OrderRegistry, arg1: &mut 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::StopOrder, arg2: &mut 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::vault::Vault, arg3: &0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::vault::ExecutorCap, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = execute_order_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = v1;
        let v3 = v2.owner;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, v3);
        0x2::transfer::public_transfer<ExecutionReceipt>(v2, v3);
    }

    public fun price_precision() : u64 {
        1000000000
    }

    public fun receipt_details(arg0: &ExecutionReceipt) : (0x2::object::ID, address, u64, u64, u64) {
        (arg0.order_id, arg0.owner, arg0.sui_sold, arg0.usdc_received, arg0.execution_price)
    }

    public fun receipt_execution_price(arg0: &ExecutionReceipt) : u64 {
        arg0.execution_price
    }

    public fun receipt_order_id(arg0: &ExecutionReceipt) : 0x2::object::ID {
        arg0.order_id
    }

    public fun receipt_owner(arg0: &ExecutionReceipt) : address {
        arg0.owner
    }

    public fun receipt_sui_sold(arg0: &ExecutionReceipt) : u64 {
        arg0.sui_sold
    }

    public fun receipt_timestamp(arg0: &ExecutionReceipt) : u64 {
        arg0.timestamp
    }

    public fun receipt_usdc_received(arg0: &ExecutionReceipt) : u64 {
        arg0.usdc_received
    }

    // decompiled from Move bytecode v6
}

