module 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::cluster_connection {
    struct Message has copy, drop {
        to: 0x1::string::String,
        conn_sn: u128,
        msg: vector<u8>,
        connection_id: 0x1::string::String,
    }

    public(friend) fun connect(arg0: &mut 0x2::tx_context::TxContext) : 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::cluster_state_optimized::State {
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::cluster_state_optimized::create(arg0)
    }

    public fun get_fee(arg0: &0x2::bag::Bag, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: bool) : u64 {
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::cluster_state_optimized::get_fee(0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::cluster_state_optimized::get_state(arg0, arg1), &arg2, arg3)
    }

    public(friend) fun get_next_connection_sn(arg0: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::cluster_state_optimized::State) : u128 {
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::cluster_state_optimized::get_next_conn_sn(arg0)
    }

    public(friend) fun send_message(arg0: &mut 0x2::bag::Bag, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x1::string::String, arg4: u128, arg5: vector<u8>, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        if (!arg6) {
            v0 = get_fee(arg0, arg1, arg3, arg4 > 0);
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v0, 10);
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::cluster_state_optimized::deposit(0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::cluster_state_optimized::get_state_mut(arg0, arg1), 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v1 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::cluster_state_optimized::get_state_mut(arg0, arg1);
        let v2 = Message{
            to            : arg3,
            conn_sn       : get_next_connection_sn(v1),
            msg           : arg5,
            connection_id : arg1,
        };
        0x2::event::emit<Message>(v2);
    }

    // decompiled from Move bytecode v6
}

