module 0x2bda1780dc59243386d205f1855cde689dbbb87003d71a2518832638589d48cf::balanced_crosschain {
    struct WitnessCarrier<T0: drop> has key {
        id: 0x2::object::UID,
        witness: T0,
    }

    struct Config<phantom T0> has store, key {
        id: 0x2::object::UID,
        icon_token_address: 0x1::string::String,
        version: u64,
        id_cap: 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::IDCap,
        xcall_manager_id: 0x2::object::ID,
        xcall_id: 0x2::object::ID,
        balanced_treasury_cap: 0x2::coin::TreasuryCap<T0>,
    }

    public(friend) fun execute_call<T0>(arg0: &mut Config<T0>, arg1: &0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::xcall_manager::Config, arg2: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u128, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::execute_call(arg2, get_idcap<T0>(arg0), arg4, arg5, arg6);
        let v1 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::execute_ticket::message(&v0);
        let v2 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::execute_ticket::protocols(&v0);
        if (0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::xcall_manager::verify_protocols(arg1, &v2) && 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::cross_transfer::get_method(&v1) == b"xCrossTransfer" && 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::execute_ticket::from(&v0) == 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::network_address::from_string(arg0.icon_token_address)) {
            let v3 = 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::cross_transfer::decode(&v1);
            let v4 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::network_address::from_string(0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::cross_transfer::to(&v3));
            let v5 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::network_address::addr(&v4);
            0x2::coin::mint_and_transfer<T0>(get_treasury_cap_mut<T0>(arg0), translate_incoming_amount(0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::cross_transfer::value(&v3)), 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::balanced_utils::address_from_hex_string(&v5), arg6);
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::execute_call_result(arg2, v0, true, arg3, arg6);
        } else {
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::execute_call_result(arg2, v0, false, arg3, arg6);
        };
    }

    public(friend) fun execute_rollback<T0>(arg0: &mut Config<T0>, arg1: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::execute_rollback(arg1, get_idcap<T0>(arg0), arg2, arg3);
        let v1 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::rollback_ticket::rollback(&v0);
        assert!(0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::cross_transfer::get_method(&v1) == b"xCrossTransferRevert", 4);
        let v2 = 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::cross_transfer_revert::decode(&v1);
        0x2::coin::mint_and_transfer<T0>(get_treasury_cap_mut<T0>(arg0), 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::cross_transfer_revert::value(&v2), 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::cross_transfer_revert::to(&v2), arg3);
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::execute_rollback_result(arg1, v0, true);
    }

    public(friend) fun configure<T0, T1: drop + store>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::xcall_manager::Config, arg2: &0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg3: WitnessCarrier<T1>, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::register_dapp<T1>(arg2, get_witness<T1>(arg3), arg6);
        let v1 = Config<T0>{
            id                    : 0x2::object::new(arg6),
            icon_token_address    : arg4,
            version               : arg5,
            id_cap                : v0,
            xcall_manager_id      : 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::xcall_manager::get_id(arg1),
            xcall_id              : 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_id_cap_xcall(&v0),
            balanced_treasury_cap : arg0,
        };
        0x2::transfer::share_object<Config<T0>>(v1);
    }

    public(friend) fun cross_transfer<T0>(arg0: &mut Config<T0>, arg1: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg2: &0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::xcall_manager::Config, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<T0>, arg5: 0x1::string::String, arg6: 0x1::option::Option<vector<u8>>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg4);
        assert!(v0 > 0, 1);
        let v1 = get_treasury_cap_mut<T0>(arg0);
        0x2::coin::burn<T0>(v1, arg4);
        let v2 = 0x2::tx_context::sender(arg7);
        let v3 = 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::cross_transfer::wrap_cross_transfer(0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::balanced_utils::address_to_hex_string(&v2), arg5, translate_outgoing_amount(v0), 0x1::option::get_with_default<vector<u8>>(&arg6, b""));
        let v4 = 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::cross_transfer_revert::wrap_cross_transfer_revert(v2, v0);
        let (v5, v6) = 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::xcall_manager::get_protocals(arg2);
        let v7 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::envelope::wrap_call_message_rollback(0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::cross_transfer::encode(&v3, b"xCrossTransfer"), 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::cross_transfer_revert::encode(&v4, b"xCrossTransferRevert"), v5, v6);
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::send_call(arg1, arg3, get_idcap<T0>(arg0), arg0.icon_token_address, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::envelope::encode(&v7), arg7);
    }

    public(friend) fun enforce_version<T0>(arg0: &Config<T0>, arg1: u64) {
        0x1::debug::print<u64>(&arg0.version);
        0x1::debug::print<u64>(&arg1);
        assert!(arg0.version == arg1, 7);
    }

    public(friend) fun execute_force_rollback<T0>(arg0: &Config<T0>, arg1: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u128, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::execute_call_result(arg1, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::execute_call(arg1, get_idcap<T0>(arg0), arg3, arg4, arg5), false, arg2, arg5);
    }

    public(friend) fun get_config_id<T0>(arg0: &Config<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun get_execute_call_params<T0>(arg0: &Config<T0>) : (0x2::object::ID, 0x2::object::ID) {
        (get_xcall_manager_id<T0>(arg0), get_xcall_id<T0>(arg0))
    }

    public(friend) fun get_execute_params<T0>(arg0: &Config<T0>, arg1: vector<u8>) : 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::balanced_utils::ExecuteParams {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = get_config_id<T0>(arg0);
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_utils::id_to_hex_string(&v1));
        let v2 = get_xcall_manager_id<T0>(arg0);
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_utils::id_to_hex_string(&v2));
        let v3 = get_xcall_id<T0>(arg0);
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_utils::id_to_hex_string(&v3));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"coin"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"request_id"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"data"));
        0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::balanced_utils::create_execute_params(0x1::vector::empty<0x1::string::String>(), v0)
    }

    public(friend) fun get_idcap<T0>(arg0: &Config<T0>) : &0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::IDCap {
        &arg0.id_cap
    }

    public(friend) fun get_rollback_params<T0>(arg0: &Config<T0>, arg1: vector<u8>) : 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::balanced_utils::ExecuteParams {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = get_config_id<T0>(arg0);
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_utils::id_to_hex_string(&v1));
        let v2 = get_xcall_id<T0>(arg0);
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_utils::id_to_hex_string(&v2));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"sn"));
        0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::balanced_utils::create_execute_params(0x1::vector::empty<0x1::string::String>(), v0)
    }

    public(friend) fun get_treasury_cap_for_testing<T0>(arg0: &mut Config<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        &mut arg0.balanced_treasury_cap
    }

    public(friend) fun get_treasury_cap_mut<T0>(arg0: &mut Config<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        &mut arg0.balanced_treasury_cap
    }

    public fun get_version<T0>(arg0: &mut Config<T0>) : u64 {
        arg0.version
    }

    fun get_witness<T0: drop + store>(arg0: WitnessCarrier<T0>) : T0 {
        let WitnessCarrier {
            id      : v0,
            witness : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    public(friend) fun get_xcall_id<T0>(arg0: &Config<T0>) : 0x2::object::ID {
        arg0.xcall_id
    }

    public(friend) fun get_xcall_manager_id<T0>(arg0: &Config<T0>) : 0x2::object::ID {
        arg0.xcall_manager_id
    }

    public(friend) fun migrate<T0>(arg0: &mut Config<T0>, arg1: &0x2::package::UpgradeCap, arg2: u64) {
        let v0 = get_version<T0>(arg0);
        assert!(v0 < arg2, 6);
        set_version<T0>(arg0, arg2);
    }

    fun set_version<T0>(arg0: &mut Config<T0>, arg1: u64) {
        arg0.version = arg1;
    }

    public(friend) fun transfer_witness<T0: drop + store>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = WitnessCarrier<T0>{
            id      : 0x2::object::new(arg1),
            witness : arg0,
        };
        0x2::transfer::transfer<WitnessCarrier<T0>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun translate_incoming_amount(arg0: u128) : u64 {
        ((arg0 / (0x1::u64::pow(10, 9) as u128)) as u64)
    }

    fun translate_outgoing_amount(arg0: u64) : u128 {
        (arg0 as u128) * (0x1::u64::pow(10, 9) as u128)
    }

    // decompiled from Move bytecode v6
}

