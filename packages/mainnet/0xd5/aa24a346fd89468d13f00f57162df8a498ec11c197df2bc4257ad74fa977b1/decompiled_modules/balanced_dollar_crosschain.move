module 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::balanced_dollar_crosschain {
    struct REGISTER_WITNESS has drop, store {
        dummy_field: bool,
    }

    struct WitnessCarrier has key {
        id: 0x2::object::UID,
        witness: REGISTER_WITNESS,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        icon_bnusd: 0x1::string::String,
        version: u64,
        id_cap: 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::IDCap,
        xcall_manager_id: 0x2::object::ID,
        xcall_id: 0x2::object::ID,
        balanced_treasury_cap: 0x2::coin::TreasuryCap<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR>,
    }

    entry fun execute_call(arg0: &mut Config, arg1: &0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::xcall_manager::Config, arg2: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u128, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        enforce_version(arg0);
        let v0 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::execute_call(arg2, get_idcap(arg0), arg4, arg5, arg6);
        let v1 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::execute_ticket::message(&v0);
        let v2 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::execute_ticket::protocols(&v0);
        if (0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::xcall_manager::verify_protocols(arg1, &v2) && 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::cross_transfer::get_method(&v1) == b"xCrossTransfer" && 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::execute_ticket::from(&v0) == 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::network_address::from_string(arg0.icon_bnusd)) {
            let v3 = 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::cross_transfer::decode(&v1);
            let v4 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::network_address::from_string(0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::cross_transfer::to(&v3));
            let v5 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::network_address::addr(&v4);
            0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::mint(get_treasury_cap_mut(arg0), 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::balanced_utils::address_from_hex_string(&v5), translate_incoming_amount(0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::cross_transfer::value(&v3)), arg6);
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::execute_call_result(arg2, v0, true, arg3, arg6);
        } else {
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::execute_call_result(arg2, v0, false, arg3, arg6);
        };
    }

    entry fun execute_rollback(arg0: &mut Config, arg1: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) {
        enforce_version(arg0);
        let v0 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::execute_rollback(arg1, get_idcap(arg0), arg2, arg3);
        let v1 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::rollback_ticket::rollback(&v0);
        assert!(0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::cross_transfer::get_method(&v1) == b"xCrossTransferRevert", 4);
        let v2 = 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::cross_transfer_revert::decode(&v1);
        0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::mint(get_treasury_cap_mut(arg0), 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::cross_transfer_revert::to(&v2), 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::cross_transfer_revert::value(&v2), arg3);
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::execute_rollback_result(arg1, v0, true);
    }

    entry fun configure(arg0: &AdminCap, arg1: 0x2::coin::TreasuryCap<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR>, arg2: &0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::xcall_manager::Config, arg3: &0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg4: WitnessCarrier, arg5: 0x1::string::String, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::register_dapp<REGISTER_WITNESS>(arg3, get_witness(arg4), arg7);
        let v1 = Config{
            id                    : 0x2::object::new(arg7),
            icon_bnusd            : arg5,
            version               : arg6,
            id_cap                : v0,
            xcall_manager_id      : 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::xcall_manager::get_id(arg2),
            xcall_id              : 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_id_cap_xcall(&v0),
            balanced_treasury_cap : arg1,
        };
        0x2::transfer::share_object<Config>(v1);
    }

    entry fun cross_transfer(arg0: &mut Config, arg1: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg2: &0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::xcall_manager::Config, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR>, arg5: 0x1::string::String, arg6: 0x1::option::Option<vector<u8>>, arg7: &mut 0x2::tx_context::TxContext) {
        enforce_version(arg0);
        let v0 = 0x2::coin::value<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR>(&arg4);
        assert!(v0 > 0, 1);
        let v1 = get_treasury_cap_mut(arg0);
        0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::burn(v1, arg4);
        let v2 = 0x2::tx_context::sender(arg7);
        let v3 = 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::cross_transfer::wrap_cross_transfer(0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::balanced_utils::address_to_hex_string(&v2), arg5, translate_outgoing_amount(v0), 0x1::option::get_with_default<vector<u8>>(&arg6, b""));
        let v4 = 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::cross_transfer_revert::wrap_cross_transfer_revert(v2, v0);
        let (v5, v6) = 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::xcall_manager::get_protocals(arg2);
        let v7 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::envelope::wrap_call_message_rollback(0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::cross_transfer::encode(&v3, b"xCrossTransfer"), 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::cross_transfer_revert::encode(&v4, b"xCrossTransferRevert"), v5, v6);
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::send_call(arg1, arg3, get_idcap(arg0), arg0.icon_bnusd, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::envelope::encode(&v7), arg7);
    }

    fun enforce_version(arg0: &Config) {
        assert!(arg0.version == 3, 7);
    }

    entry fun execute_force_rollback(arg0: &Config, arg1: &AdminCap, arg2: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u128, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        enforce_version(arg0);
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::execute_call_result(arg2, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::execute_call(arg2, get_idcap(arg0), arg4, arg5, arg6), false, arg3, arg6);
    }

    entry fun get_execute_call_params(arg0: &Config) : (0x2::object::ID, 0x2::object::ID) {
        (get_xcall_manager_id(arg0), get_xcall_id(arg0))
    }

    entry fun get_execute_params(arg0: &Config, arg1: vector<u8>) : 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::balanced_utils::ExecuteParams {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = get_xcall_manager_id(arg0);
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_utils::id_to_hex_string(&v1));
        let v2 = get_xcall_id(arg0);
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_utils::id_to_hex_string(&v2));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"coin"));
        0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::balanced_utils::create_execute_params(0x1::vector::empty<0x1::string::String>(), v0)
    }

    public(friend) fun get_idcap(arg0: &Config) : &0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::IDCap {
        enforce_version(arg0);
        &arg0.id_cap
    }

    entry fun get_rollback_params(arg0: &Config, arg1: vector<u8>) : 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::balanced_utils::ExecuteParams {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = get_xcall_id(arg0);
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_utils::id_to_hex_string(&v1));
        0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::balanced_utils::create_execute_params(0x1::vector::empty<0x1::string::String>(), v0)
    }

    fun get_treasury_cap_mut(arg0: &mut Config) : &mut 0x2::coin::TreasuryCap<0x3917a812fe4a6d6bc779c5ab53f8a80ba741f8af04121193fc44e0f662e2ceb::balanced_dollar::BALANCED_DOLLAR> {
        &mut arg0.balanced_treasury_cap
    }

    public fun get_version(arg0: &mut Config) : u64 {
        arg0.version
    }

    fun get_witness(arg0: WitnessCarrier) : REGISTER_WITNESS {
        let WitnessCarrier {
            id      : v0,
            witness : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    public fun get_xcall_id(arg0: &Config) : 0x2::object::ID {
        arg0.xcall_id
    }

    public fun get_xcall_manager_id(arg0: &Config) : 0x2::object::ID {
        arg0.xcall_manager_id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = REGISTER_WITNESS{dummy_field: false};
        let v2 = WitnessCarrier{
            id      : 0x2::object::new(arg0),
            witness : v1,
        };
        0x2::transfer::transfer<WitnessCarrier>(v2, 0x2::tx_context::sender(arg0));
    }

    entry fun migrate(arg0: &mut Config, arg1: &0x2::package::UpgradeCap) {
        let v0 = get_version(arg0);
        assert!(v0 < 3, 6);
        set_version(arg0, 3);
    }

    entry fun set_icon_bnusd(arg0: &mut Config, arg1: &AdminCap, arg2: 0x1::string::String) {
        enforce_version(arg0);
        arg0.icon_bnusd = arg2;
    }

    fun set_version(arg0: &mut Config, arg1: u64) {
        arg0.version = arg1;
    }

    fun translate_incoming_amount(arg0: u128) : u64 {
        ((arg0 / (0x2::math::pow(10, 9) as u128)) as u64)
    }

    fun translate_outgoing_amount(arg0: u64) : u128 {
        (arg0 as u128) * (0x2::math::pow(10, 9) as u128)
    }

    // decompiled from Move bytecode v6
}

