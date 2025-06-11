module 0x83a9d564f5f5342738a920de8dd1c4d8e88e39f1a8004f795f9ea3bc8ccf828e::valuerouter {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct RouterRegistry has key {
        id: 0x2::object::UID,
        routers: 0x2::table::Table<u32, RemoteRouter>,
    }

    struct RemoteRouter has store {
        address: address,
        domain: u32,
    }

    struct FeeConfig has key {
        id: 0x2::object::UID,
        fees: 0x2::table::Table<u32, u64>,
    }

    struct FeeVault<phantom T0: drop> has key {
        id: 0x2::object::UID,
        balance: 0x2::coin::Coin<T0>,
    }

    struct CallerInfo has key {
        id: 0x2::object::UID,
        noble_caller: vector<u8>,
        solana_caller: vector<u8>,
        solana_program_usdc_account: vector<u8>,
        solana_receiver: vector<u8>,
    }

    struct SwapMessage has drop, store {
        version: u16,
        bridge_nonce_hash: vector<u8>,
        sell_amount: u256,
        buy_token: vector<u8>,
        guaranteed_buy_amount: u256,
        recipient: address,
    }

    fun address_to_bytes(arg0: address) : vector<u8> {
        0x1::bcs::to_bytes<address>(&arg0)
    }

    public entry fun burnUSDC<T0: drop>(arg0: vector<0x2::coin::Coin<T0>>, arg1: u64, arg2: u32, arg3: &RouterRegistry, arg4: &mut 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg5: &mut 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg6: &0x2::deny_list::DenyList, arg7: &mut 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<T0>, arg8: &CallerInfo, arg9: vector<u8>, arg10: u256, arg11: address, arg12: &FeeConfig, arg13: &mut FeeVault<T0>, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = get_remote_router_by_domain(arg3, arg2);
        let v1 = get_fee(arg12, arg2);
        let v2 = if (0x1::vector::length<0x2::coin::Coin<T0>>(&arg0) > 1) {
            let v3 = 0x1::vector::remove<0x2::coin::Coin<T0>>(&mut arg0, 0);
            while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
                0x2::coin::join<T0>(&mut v3, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0));
            };
            v3
        } else {
            0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0)
        };
        let v4 = v2;
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
        let v5 = if (0x2::coin::value<T0>(&v4) > arg1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg14));
            0x2::coin::split<T0>(&mut v4, arg1, arg14)
        } else {
            assert!(0x2::coin::value<T0>(&v4) >= arg1, 0);
            v4
        };
        let v6 = v5;
        if (v1 > 0) {
            0x2::coin::join<T0>(&mut arg13.balance, 0x2::coin::split<T0>(&mut v6, v1, arg14));
        };
        let v7 = 0x83a9d564f5f5342738a920de8dd1c4d8e88e39f1a8004f795f9ea3bc8ccf828e::router_auth::new();
        let (v8, v9) = if (v0.domain == 4) {
            0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::deposit_for_burn_with_caller_with_package_auth<T0, 0x83a9d564f5f5342738a920de8dd1c4d8e88e39f1a8004f795f9ea3bc8ccf828e::router_auth::RouterAuth>(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::create_deposit_for_burn_with_caller_ticket<T0, 0x83a9d564f5f5342738a920de8dd1c4d8e88e39f1a8004f795f9ea3bc8ccf828e::router_auth::RouterAuth>(v7, v6, v0.domain, arg11, 0x2::address::from_bytes(arg8.noble_caller)), arg5, arg4, arg6, arg7, arg14)
        } else if (v0.domain == 5) {
            0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::deposit_for_burn_with_caller_with_package_auth<T0, 0x83a9d564f5f5342738a920de8dd1c4d8e88e39f1a8004f795f9ea3bc8ccf828e::router_auth::RouterAuth>(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::create_deposit_for_burn_with_caller_ticket<T0, 0x83a9d564f5f5342738a920de8dd1c4d8e88e39f1a8004f795f9ea3bc8ccf828e::router_auth::RouterAuth>(v7, v6, v0.domain, 0x2::address::from_bytes(arg8.solana_program_usdc_account), 0x2::address::from_bytes(arg8.solana_caller)), arg5, arg4, arg6, arg7, arg14)
        } else {
            0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::deposit_for_burn_with_caller_with_package_auth<T0, 0x83a9d564f5f5342738a920de8dd1c4d8e88e39f1a8004f795f9ea3bc8ccf828e::router_auth::RouterAuth>(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::create_deposit_for_burn_with_caller_ticket<T0, 0x83a9d564f5f5342738a920de8dd1c4d8e88e39f1a8004f795f9ea3bc8ccf828e::router_auth::RouterAuth>(v7, v6, v0.domain, v0.address, v0.address), arg5, arg4, arg6, arg7, arg14)
        };
        let v10 = v9;
        let v11 = v8;
        let v12 = if (v0.domain == 5) {
            0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::send_message::create_send_message_with_caller_ticket<0x83a9d564f5f5342738a920de8dd1c4d8e88e39f1a8004f795f9ea3bc8ccf828e::router_auth::RouterAuth>(v7, v0.domain, 0x2::address::from_bytes(arg8.solana_receiver), 0x2::address::from_bytes(arg8.solana_caller), encode_swap_message(1, encode_bridge_nonce(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::source_domain(&v10), 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::nonce(&v10)), 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::amount(&v11), 0x2::address::from_bytes(arg9), arg10, arg11))
        } else {
            0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::send_message::create_send_message_with_caller_ticket<0x83a9d564f5f5342738a920de8dd1c4d8e88e39f1a8004f795f9ea3bc8ccf828e::router_auth::RouterAuth>(v7, v0.domain, v0.address, v0.address, encode_swap_message(1, encode_bridge_nonce(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::source_domain(&v10), 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::nonce(&v10)), 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::burn_message::amount(&v11), 0x2::address::from_bytes(arg9), arg10, arg11))
        };
        0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::send_message::send_message_with_caller<0x83a9d564f5f5342738a920de8dd1c4d8e88e39f1a8004f795f9ea3bc8ccf828e::router_auth::RouterAuth>(v12, arg4);
    }

    public entry fun create_fee_vault<T0: drop>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeVault<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::coin::zero<T0>(arg1),
        };
        0x2::transfer::share_object<FeeVault<T0>>(v0);
    }

    public entry fun create_remote_router(arg0: &AdminCap, arg1: &mut RouterRegistry, arg2: address, arg3: u32, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = RemoteRouter{
            address : arg2,
            domain  : arg3,
        };
        0x2::table::add<u32, RemoteRouter>(&mut arg1.routers, arg3, v0);
    }

    fun encode_bridge_nonce(arg0: u32, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = b"Encoding bridge nonce:";
        0x1::debug::print<vector<u8>>(&v1);
        let v2 = b"domain:";
        0x1::debug::print<vector<u8>>(&v2);
        0x1::debug::print<u32>(&arg0);
        let v3 = b"nonce:";
        0x1::debug::print<vector<u8>>(&v3);
        0x1::debug::print<u64>(&arg1);
        let v4 = encode_u32(arg0);
        let v5 = encode_u64(arg1);
        let v6 = b"domain bytes:";
        0x1::debug::print<vector<u8>>(&v6);
        0x1::debug::print<vector<u8>>(&v4);
        let v7 = b"nonce bytes:";
        0x1::debug::print<vector<u8>>(&v7);
        0x1::debug::print<vector<u8>>(&v5);
        0x1::vector::append<u8>(&mut v0, v4);
        0x1::vector::append<u8>(&mut v0, v5);
        let v8 = b"combined bytes before hash:";
        0x1::debug::print<vector<u8>>(&v8);
        0x1::debug::print<vector<u8>>(&v0);
        let v9 = 0x2::hash::keccak256(&v0);
        let v10 = b"final hash:";
        0x1::debug::print<vector<u8>>(&v10);
        0x1::debug::print<vector<u8>>(&v9);
        v9
    }

    fun encode_swap_message(arg0: u32, arg1: vector<u8>, arg2: u256, arg3: address, arg4: u256, arg5: address) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, encode_u32(arg0));
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, u256_to_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, address_to_bytes(arg3));
        0x1::vector::append<u8>(&mut v0, u256_to_bytes(arg4));
        0x1::vector::append<u8>(&mut v0, address_to_bytes(arg5));
        let v1 = b"Final encoded swap message:";
        0x1::debug::print<vector<u8>>(&v1);
        0x1::debug::print<vector<u8>>(&v0);
        v0
    }

    fun encode_u32(arg0: u32) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 24 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 & 255) as u8));
        v0
    }

    fun encode_u64(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 56 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 48 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 40 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 32 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 24 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 & 255) as u8));
        v0
    }

    fun get_bytes_range(arg0: &vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        while (arg1 < arg2) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    public fun get_fee(arg0: &FeeConfig, arg1: u32) : u64 {
        if (0x2::table::contains<u32, u64>(&arg0.fees, arg1)) {
            *0x2::table::borrow<u32, u64>(&arg0.fees, arg1)
        } else {
            0
        }
    }

    public fun get_remote_router_by_domain(arg0: &RouterRegistry, arg1: u32) : &RemoteRouter {
        0x2::table::borrow<u32, RemoteRouter>(&arg0.routers, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = RouterRegistry{
            id      : 0x2::object::new(arg0),
            routers : 0x2::table::new<u32, RemoteRouter>(arg0),
        };
        0x2::transfer::share_object<RouterRegistry>(v1);
        let v2 = FeeConfig{
            id   : 0x2::object::new(arg0),
            fees : 0x2::table::new<u32, u64>(arg0),
        };
        0x2::transfer::share_object<FeeConfig>(v2);
        let v3 = CallerInfo{
            id                          : 0x2::object::new(arg0),
            noble_caller                : 0x1::vector::empty<u8>(),
            solana_caller               : 0x1::vector::empty<u8>(),
            solana_program_usdc_account : 0x1::vector::empty<u8>(),
            solana_receiver             : 0x1::vector::empty<u8>(),
        };
        0x2::transfer::share_object<CallerInfo>(v3);
    }

    public entry fun mintUSDC<T0: drop>(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg5: &mut 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg6: &0x2::deny_list::DenyList, arg7: &mut 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<T0>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x83a9d564f5f5342738a920de8dd1c4d8e88e39f1a8004f795f9ea3bc8ccf828e::router_auth::new();
        let (v1, v2) = 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::handle_receive_message::deconstruct_stamp_receipt_ticket_with_burn_message(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::handle_receive_message::handle_receive_message<T0>(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::receive_message::receive_message_with_package_auth<0x83a9d564f5f5342738a920de8dd1c4d8e88e39f1a8004f795f9ea3bc8ccf828e::router_auth::RouterAuth>(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::receive_message::create_receive_message_ticket<0x83a9d564f5f5342738a920de8dd1c4d8e88e39f1a8004f795f9ea3bc8ccf828e::router_auth::RouterAuth>(v0, arg0, arg1), arg4), arg5, arg6, arg7, arg8));
        let _ = v2;
        0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::receive_message::complete_receive_message(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::receive_message::stamp_receipt<0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::message_transmitter_authenticator::MessageTransmitterAuthenticator>(v1, arg4), arg4);
        let v4 = 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::receive_message::receive_message_with_package_auth<0x83a9d564f5f5342738a920de8dd1c4d8e88e39f1a8004f795f9ea3bc8ccf828e::router_auth::RouterAuth>(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::receive_message::create_receive_message_ticket<0x83a9d564f5f5342738a920de8dd1c4d8e88e39f1a8004f795f9ea3bc8ccf828e::router_auth::RouterAuth>(v0, arg2, arg3), arg4);
        let v5 = parse_swap_message(&v4);
        let v6 = v5.recipient;
        let v7 = b"Recipient address: ";
        0x1::debug::print<vector<u8>>(&v7);
        0x1::debug::print<address>(&v6);
        0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::receive_message::complete_receive_message(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::receive_message::stamp_receipt<0x83a9d564f5f5342738a920de8dd1c4d8e88e39f1a8004f795f9ea3bc8ccf828e::router_auth::RouterAuth>(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::receive_message::create_stamp_receipt_ticket<0x83a9d564f5f5342738a920de8dd1c4d8e88e39f1a8004f795f9ea3bc8ccf828e::router_auth::RouterAuth>(v0, v4), arg4), arg4);
    }

    fun parse_address_from_bytes32(arg0: vector<u8>) : address {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 0);
        let v0 = b"Recipient bytes length: ";
        0x1::debug::print<vector<u8>>(&v0);
        let v1 = 0x1::vector::length<u8>(&arg0);
        0x1::debug::print<u64>(&v1);
        let v2 = b"Recipient bytes: ";
        0x1::debug::print<vector<u8>>(&v2);
        0x1::debug::print<vector<u8>>(&arg0);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(&arg0)) {
            let v4 = b"byte ";
            0x1::debug::print<vector<u8>>(&v4);
            0x1::debug::print<u64>(&v3);
            let v5 = b": ";
            0x1::debug::print<vector<u8>>(&v5);
            let v6 = (*0x1::vector::borrow<u8>(&arg0, v3) as u64);
            0x1::debug::print<u64>(&v6);
            v3 = v3 + 1;
        };
        0x2::address::from_bytes(arg0)
    }

    fun parse_swap_message(arg0: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::receive_message::Receipt) : SwapMessage {
        let v0 = 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::receive_message::message_body(arg0);
        SwapMessage{
            version               : parse_u16(v0, 0),
            bridge_nonce_hash     : get_bytes_range(v0, 2, 34),
            sell_amount           : parse_u256(v0, 34),
            buy_token             : get_bytes_range(v0, 66, 98),
            guaranteed_buy_amount : parse_u256(v0, 98),
            recipient             : parse_address_from_bytes32(get_bytes_range(v0, 130, 162)),
        }
    }

    fun parse_u16(arg0: &vector<u8>, arg1: u64) : u16 {
        (*0x1::vector::borrow<u8>(arg0, arg1) as u16) << 8 | (*0x1::vector::borrow<u8>(arg0, arg1 + 1) as u16)
    }

    fun parse_u256(arg0: &vector<u8>, arg1: u64) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 32) {
            let v2 = v0 << 8;
            v0 = v2 + (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u256);
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun set_fee(arg0: &AdminCap, arg1: &mut FeeConfig, arg2: u32, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<u32, u64>(&arg1.fees, arg2)) {
            *0x2::table::borrow_mut<u32, u64>(&mut arg1.fees, arg2) = arg3;
        } else {
            0x2::table::add<u32, u64>(&mut arg1.fees, arg2, arg3);
        };
    }

    fun u256_to_bytes(arg0: u256) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 32;
        while (v1 > 0) {
            v1 = v1 - 1;
            0x1::vector::push_back<u8>(&mut v0, ((arg0 >> v1 * 8 & 255) as u8));
        };
        v0
    }

    public entry fun update_caller_info(arg0: &AdminCap, arg1: &mut CallerInfo, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>) {
        arg1.noble_caller = arg2;
        arg1.solana_caller = arg3;
        arg1.solana_program_usdc_account = arg4;
        arg1.solana_receiver = arg5;
    }

    public entry fun update_remote_router(arg0: &AdminCap, arg1: &mut RouterRegistry, arg2: u32, arg3: address, arg4: u32) {
        let v0 = 0x2::table::borrow_mut<u32, RemoteRouter>(&mut arg1.routers, arg2);
        v0.address = arg3;
        v0.domain = arg4;
    }

    public entry fun withdraw_fees<T0: drop>(arg0: &AdminCap, arg1: &mut FeeVault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1.balance, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

