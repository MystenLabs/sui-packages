module 0x3da3386079d83df4be389a0ec5f8f4a7db2a720623e6701c5dbbe77e2c3e28bc::sui_action_box {
    struct Config has store, key {
        id: 0x2::object::UID,
        owner: address,
        chain_id: u64,
        whitelist: vector<0x2::object::ID>,
    }

    struct ActionCreatedV2Event has copy, drop {
        master: address,
        user: vector<u8>,
        kernel_app_address: vector<u8>,
        kernel_app_calldata: vector<u8>,
        action_id: vector<u8>,
        amounts: vector<u64>,
        tokens: vector<vector<u8>>,
        config_id: 0x2::object::ID,
    }

    public entry fun add_to_whitelist(arg0: &mut Config, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1000);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.whitelist, arg1);
    }

    public entry fun create_action_v2<T0: store + key>(arg0: &Config, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u64>, arg5: vector<vector<u8>>, arg6: u64, arg7: &T0, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg0.whitelist)) {
            if (*0x1::vector::borrow<0x2::object::ID>(&arg0.whitelist, v1) == 0x2::object::id<T0>(arg7)) {
                v0 = true;
                break
            };
            v1 = v1 + 1;
        };
        assert!(v0, 1003);
        let v2 = 0x2::clock::timestamp_ms(arg8);
        let v3 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v3, arg1);
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&v2));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&arg0.chain_id));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&arg6));
        let v4 = 0x2::tx_context::sender(arg9);
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<address>(&v4));
        let v5 = ActionCreatedV2Event{
            master              : arg0.owner,
            user                : arg1,
            kernel_app_address  : arg2,
            kernel_app_calldata : arg3,
            action_id           : 0x2::hash::keccak256(&v3),
            amounts             : arg4,
            tokens              : arg5,
            config_id           : 0x2::object::id<Config>(arg0),
        };
        0x2::event::emit<ActionCreatedV2Event>(v5);
    }

    public entry fun init_config(arg0: u64, arg1: vector<0x2::object::ID>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id        : 0x2::object::new(arg2),
            owner     : 0x2::tx_context::sender(arg2),
            chain_id  : arg0,
            whitelist : arg1,
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public entry fun set_chain_id(arg0: &mut Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1000);
        arg0.chain_id = arg1;
    }

    // decompiled from Move bytecode v6
}

