module 0xc5cdb37f8aa356a02c2b624ea1f95bfd1af12b759803eb288853bfbfd7301b74::sui_action_box {
    struct Config has store, key {
        id: 0x2::object::UID,
        owner: address,
        chain_id: u64,
        min_amount: u64,
        escrow_address: address,
        whitelist: vector<0x2::object::ID>,
    }

    struct ActionCreatedEvent has copy, drop {
        config_owner: address,
        action_id: vector<u8>,
        user: vector<u8>,
        kernel_app_address: vector<u8>,
        periphery_app_address: vector<u8>,
        calldata: vector<u8>,
        dest_chain_id: u64,
        amount_in: u64,
        source_chain_id: u64,
        block_number: u64,
    }

    struct ActionCreatedV2Event has copy, drop {
        master: address,
        user: vector<u8>,
        kernel_app_address: vector<u8>,
        kernel_app_calldata: vector<u8>,
        action_id: vector<u8>,
        amounts: vector<u64>,
        tokens: vector<vector<u8>>,
    }

    public entry fun add_to_whitelist(arg0: &mut Config, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1000);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.whitelist, arg1);
    }

    public entry fun create_action(arg0: &Config, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &0x2::clock::Clock) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg7) == arg6, 1002);
        assert!(arg6 >= arg0.min_amount, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg7, arg0.escrow_address);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v1, arg1);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&v0));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg0.chain_id));
        let v2 = ActionCreatedEvent{
            config_owner          : arg0.owner,
            action_id             : 0x2::hash::keccak256(&v1),
            user                  : arg1,
            kernel_app_address    : arg2,
            periphery_app_address : arg3,
            calldata              : arg4,
            dest_chain_id         : arg5,
            amount_in             : arg6,
            source_chain_id       : arg0.chain_id,
            block_number          : v0,
        };
        0x2::event::emit<ActionCreatedEvent>(v2);
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
        };
        0x2::event::emit<ActionCreatedV2Event>(v5);
    }

    public entry fun init_config(arg0: u64, arg1: u64, arg2: address, arg3: vector<0x2::object::ID>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id             : 0x2::object::new(arg4),
            owner          : 0x2::tx_context::sender(arg4),
            chain_id       : arg0,
            min_amount     : arg1,
            escrow_address : arg2,
            whitelist      : arg3,
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public entry fun set_chain_id(arg0: &mut Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1000);
        arg0.chain_id = arg1;
    }

    public entry fun set_min_amount(arg0: &mut Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1000);
        arg0.min_amount = arg1;
    }

    // decompiled from Move bytecode v6
}

