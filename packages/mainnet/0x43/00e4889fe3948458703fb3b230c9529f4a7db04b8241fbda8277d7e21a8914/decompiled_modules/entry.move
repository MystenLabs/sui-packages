module 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::entry {
    public entry fun cancel_order(arg0: &mut 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::OrderRegistry, arg1: &mut 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::vault::Vault, arg2: &mut 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::StopOrder, arg3: &mut 0x2::tx_context::TxContext) {
        0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::cancel_order(arg0, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::vault::withdraw_to_owner(arg1, 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::order_id(arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun complete_swap_execution<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::object::ID, arg3: address, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 100);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg3);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg3);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::executor::emit_swap_execution_event(arg2, arg3, arg4, v0, arg5, arg6);
        0x2::transfer::public_transfer<0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::executor::ExecutionReceipt>(0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::executor::create_swap_receipt(arg2, arg3, arg4, v0, arg5, arg6, arg7), arg3);
    }

    public entry fun complete_swap_execution_with_deep<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::object::ID, arg4: address, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg4);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg8));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        if (0x2::coin::value<T1>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, 0x2::tx_context::sender(arg8));
        } else {
            0x2::coin::destroy_zero<T1>(arg2);
        };
        0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::executor::emit_swap_execution_event(arg3, arg4, arg5, v0, arg6, arg7);
        0x2::transfer::public_transfer<0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::executor::ExecutionReceipt>(0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::executor::create_swap_receipt(arg3, arg4, arg5, v0, arg6, arg7, arg8), arg4);
    }

    public entry fun create_stop_loss_order(arg0: &mut 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::OrderRegistry, arg1: &mut 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::vault::Vault, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::create_stop_loss(arg0, 0x2::coin::value<0x2::sui::SUI>(&arg2), arg3, arg4, arg5);
        0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::vault::deposit(arg1, 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::order_id(&v0), arg2, arg5);
        0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::share_order(v0);
    }

    public entry fun create_take_profit_order(arg0: &mut 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::OrderRegistry, arg1: &mut 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::vault::Vault, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::create_take_profit(arg0, 0x2::coin::value<0x2::sui::SUI>(&arg2), arg3, arg4, arg5);
        0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::vault::deposit(arg1, 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::order_id(&v0), arg2, arg5);
        0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::share_order(v0);
    }

    public entry fun execute_order(arg0: &mut 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::OrderRegistry, arg1: &mut 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::StopOrder, arg2: &mut 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::vault::Vault, arg3: &0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::vault::ExecutorCap, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        execute_triggered_order(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun execute_order_for_swap(arg0: &mut 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::OrderRegistry, arg1: &mut 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::StopOrder, arg2: &mut 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::vault::Vault, arg3: &0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::vault::ExecutorCap, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, address, 0x2::object::ID, u64, u64) {
        0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::executor::execute_order_for_swap(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public entry fun execute_triggered_order(arg0: &mut 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::OrderRegistry, arg1: &mut 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::StopOrder, arg2: &mut 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::vault::Vault, arg3: &0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::vault::ExecutorCap, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::executor::execute_order(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let (_, v2, _, _, _) = 0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::executor::receipt_details(&v0);
        0x2::transfer::public_transfer<0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::executor::ExecutionReceipt>(v0, v2);
    }

    public fun price_precision() : u64 {
        0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::executor::price_precision()
    }

    public fun would_trigger(arg0: &0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::order_registry::StopOrder, arg1: u64) : bool {
        0x4300e4889fe3948458703fb3b230c9529f4a7db04b8241fbda8277d7e21a8914::executor::check_trigger(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

