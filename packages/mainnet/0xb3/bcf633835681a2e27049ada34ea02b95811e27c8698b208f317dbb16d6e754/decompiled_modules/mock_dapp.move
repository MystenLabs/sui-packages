module 0xb3bcf633835681a2e27049ada34ea02b95811e27c8698b208f317dbb16d6e754::mock_dapp {
    struct REGISTER_WITNESS has drop, store {
        dummy_field: bool,
    }

    struct WitnessCarrier has key {
        id: 0x2::object::UID,
        witness: REGISTER_WITNESS,
    }

    public entry fun execute_call(arg0: &mut 0xb3bcf633835681a2e27049ada34ea02b95811e27c8698b208f317dbb16d6e754::dapp_state::DappState, arg1: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u128, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::execute_call(arg1, 0xb3bcf633835681a2e27049ada34ea02b95811e27c8698b208f317dbb16d6e754::dapp_state::get_xcall_cap(arg0), arg3, arg4, arg5);
        let v1 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::execute_ticket::message(&v0);
        let v2 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::execute_ticket::from(&v0);
        if (v1 == b"rollback") {
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::execute_call_result(arg1, v0, false, arg2, arg5);
        } else if (v1 == b"reply-response") {
            let v3 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg5);
            send_message(arg0, arg1, v3, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::network_address::to_string(&v2), 0x1::vector::empty<u8>(), 0x1::vector::empty<u8>(), arg5);
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::execute_call_result(arg1, v0, true, arg2, arg5);
        } else {
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::execute_call_result(arg1, v0, true, arg2, arg5);
        };
    }

    public entry fun execute_rollback(arg0: &mut 0xb3bcf633835681a2e27049ada34ea02b95811e27c8698b208f317dbb16d6e754::dapp_state::DappState, arg1: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) {
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::execute_rollback_result(arg1, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::execute_rollback(arg1, 0xb3bcf633835681a2e27049ada34ea02b95811e27c8698b208f317dbb16d6e754::dapp_state::get_xcall_cap(arg0), arg2, arg3), true);
    }

    public entry fun add_connection(arg0: &mut 0xb3bcf633835681a2e27049ada34ea02b95811e27c8698b208f317dbb16d6e754::dapp_state::DappState, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0xb3bcf633835681a2e27049ada34ea02b95811e27c8698b208f317dbb16d6e754::dapp_state::add_connection(arg0, arg1, arg2, arg3, arg4);
    }

    fun get_witness(arg0: WitnessCarrier) : REGISTER_WITNESS {
        let WitnessCarrier {
            id      : v0,
            witness : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = REGISTER_WITNESS{dummy_field: false};
        let v1 = WitnessCarrier{
            id      : 0x2::object::new(arg0),
            witness : v0,
        };
        0x2::transfer::transfer<WitnessCarrier>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun register_xcall(arg0: &0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg1: WitnessCarrier, arg2: &mut 0x2::tx_context::TxContext) {
        0xb3bcf633835681a2e27049ada34ea02b95811e27c8698b208f317dbb16d6e754::dapp_state::share(0xb3bcf633835681a2e27049ada34ea02b95811e27c8698b208f317dbb16d6e754::dapp_state::new(0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::register_dapp<REGISTER_WITNESS>(arg0, get_witness(arg1), arg2), arg2));
    }

    public entry fun send_message(arg0: &0xb3bcf633835681a2e27049ada34ea02b95811e27c8698b208f317dbb16d6e754::dapp_state::DappState, arg1: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x1::string::String, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::network_address::from_string(arg3);
        let v1 = 0xb3bcf633835681a2e27049ada34ea02b95811e27c8698b208f317dbb16d6e754::dapp_state::get_connection(arg0, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::network_address::net_id(&v0));
        let v2 = if (arg5 == 0x1::vector::empty<u8>()) {
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::envelope::wrap_call_message(arg4, 0xb3bcf633835681a2e27049ada34ea02b95811e27c8698b208f317dbb16d6e754::dapp_state::get_connection_source(&v1), 0xb3bcf633835681a2e27049ada34ea02b95811e27c8698b208f317dbb16d6e754::dapp_state::get_connection_dest(&v1))
        } else {
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::envelope::wrap_call_message_rollback(arg4, arg5, 0xb3bcf633835681a2e27049ada34ea02b95811e27c8698b208f317dbb16d6e754::dapp_state::get_connection_source(&v1), 0xb3bcf633835681a2e27049ada34ea02b95811e27c8698b208f317dbb16d6e754::dapp_state::get_connection_dest(&v1))
        };
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::send_call(arg1, arg2, 0xb3bcf633835681a2e27049ada34ea02b95811e27c8698b208f317dbb16d6e754::dapp_state::get_xcall_cap(arg0), 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::network_address::to_string(&v0), 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::envelope::encode(&v2), arg6);
    }

    // decompiled from Move bytecode v6
}

