module 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::xcall_manager {
    struct REGISTER_WITNESS has drop, store {
        dummy_field: bool,
    }

    struct WitnessCarrier has key {
        id: 0x2::object::UID,
        witness: REGISTER_WITNESS,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        icon_governance: 0x1::string::String,
        sources: vector<0x1::string::String>,
        destinations: vector<0x1::string::String>,
        proposed_protocol_to_remove: 0x1::string::String,
        version: u64,
        id_cap: 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::IDCap,
        xcall_id: 0x2::object::ID,
        whitelist_actions: 0x2::bag::Bag,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    entry fun execute_call(arg0: &mut Config, arg1: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u128, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        enforce_version(arg0);
        let v0 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::execute_call(arg1, &arg0.id_cap, arg3, arg4, arg5);
        let v1 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::execute_ticket::message(&v0);
        let v2 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::execute_ticket::protocols(&v0);
        if (!verify_protocols_unordered(&arg0.sources, &v2)) {
            verify_protocol_recovery(&v2, arg0);
        };
        if (0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::configure_protocol::get_method(&v1) == b"ConfigureProtocols" && 0x2::bag::contains<vector<u8>>(&arg0.whitelist_actions, arg4) && 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::execute_ticket::from(&v0) == 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::network_address::from_string(arg0.icon_governance)) {
            0x2::bag::remove<vector<u8>, bool>(&mut arg0.whitelist_actions, arg4);
            let v3 = 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::configure_protocol::decode(&v1);
            arg0.sources = 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::configure_protocol::sources(&v3);
            arg0.destinations = 0x8e5eea2ec2d387432a423813107bd873dfb05c2ed22a9c8f61d55211b759560b::configure_protocol::destinations(&v3);
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::execute_call_result(arg1, v0, true, arg2, arg5);
        } else {
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::execute_call_result(arg1, v0, false, arg2, arg5);
        };
    }

    entry fun configure(arg0: &AdminCap, arg1: &0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg2: WitnessCarrier, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main::register_dapp<REGISTER_WITNESS>(arg1, get_witness(arg2), arg7);
        let v1 = Config{
            id                          : 0x2::object::new(arg7),
            icon_governance             : arg3,
            sources                     : arg4,
            destinations                : arg5,
            proposed_protocol_to_remove : 0x1::string::utf8(b""),
            version                     : arg6,
            id_cap                      : v0,
            xcall_id                    : 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_id_cap_xcall(&v0),
            whitelist_actions           : 0x2::bag::new(arg7),
        };
        0x2::transfer::share_object<Config>(v1);
    }

    fun enforce_version(arg0: &Config) {
        assert!(arg0.version == 2, 4);
    }

    entry fun get_execute_call_params(arg0: &Config) : 0x2::object::ID {
        get_xcall_id(arg0)
    }

    public fun get_id(arg0: &Config) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun get_idcap(arg0: &Config) : &0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::IDCap {
        enforce_version(arg0);
        &arg0.id_cap
    }

    public fun get_modified_protocols(arg0: &Config) : vector<0x1::string::String> {
        enforce_version(arg0);
        assert!(arg0.proposed_protocol_to_remove != 0x1::string::utf8(b""), 0);
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg0.sources)) {
            let v2 = *0x1::vector::borrow<0x1::string::String>(&arg0.sources, v1);
            if (arg0.proposed_protocol_to_remove != v2) {
                0x1::vector::push_back<0x1::string::String>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_protocals(arg0: &Config) : (vector<0x1::string::String>, vector<0x1::string::String>) {
        enforce_version(arg0);
        (arg0.sources, arg0.destinations)
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
        assert!(v0 < 2, 3);
        set_version(arg0, 2);
    }

    entry fun propose_removal(arg0: &mut Config, arg1: &AdminCap, arg2: 0x1::string::String) {
        enforce_version(arg0);
        arg0.proposed_protocol_to_remove = arg2;
    }

    entry fun remove_action(arg0: &mut Config, arg1: &AdminCap, arg2: vector<u8>) {
        enforce_version(arg0);
        if (!0x2::bag::contains<vector<u8>>(&arg0.whitelist_actions, arg2)) {
            abort 6
        };
        0x2::bag::remove<vector<u8>, bool>(&mut arg0.whitelist_actions, arg2);
    }

    entry fun set_destinations(arg0: &mut Config, arg1: &AdminCap, arg2: vector<0x1::string::String>) {
        enforce_version(arg0);
        arg0.destinations = arg2;
    }

    entry fun set_icon_governance(arg0: &mut Config, arg1: &AdminCap, arg2: 0x1::string::String) {
        enforce_version(arg0);
        arg0.icon_governance = arg2;
    }

    entry fun set_sources(arg0: &mut Config, arg1: &AdminCap, arg2: vector<0x1::string::String>) {
        enforce_version(arg0);
        arg0.sources = arg2;
    }

    fun set_version(arg0: &mut Config, arg1: u64) {
        arg0.version = arg1;
    }

    fun verify_protocol_recovery(arg0: &vector<0x1::string::String>, arg1: &Config) {
        let v0 = get_modified_protocols(arg1);
        assert!(verify_protocols_unordered(&v0, arg0), 1);
    }

    public fun verify_protocols(arg0: &Config, arg1: &vector<0x1::string::String>) : bool {
        enforce_version(arg0);
        verify_protocols_unordered(&arg0.sources, arg1)
    }

    fun verify_protocols_unordered(arg0: &vector<0x1::string::String>, arg1: &vector<0x1::string::String>) : bool {
        let v0 = 0x1::vector::length<0x1::string::String>(arg0);
        if (v0 != 0x1::vector::length<0x1::string::String>(arg1)) {
            false
        } else {
            let v2 = true;
            let v3 = 0;
            while (v3 < v0) {
                if (!0x1::vector::contains<0x1::string::String>(arg0, 0x1::vector::borrow<0x1::string::String>(arg1, v3))) {
                    v2 = false;
                    break
                };
                v3 = v3 + 1;
            };
            v2
        }
    }

    entry fun whitelist_action(arg0: &mut Config, arg1: &AdminCap, arg2: vector<u8>) {
        enforce_version(arg0);
        if (0x2::bag::contains<vector<u8>>(&arg0.whitelist_actions, arg2)) {
            abort 5
        };
        0x2::bag::add<vector<u8>, bool>(&mut arg0.whitelist_actions, arg2, true);
    }

    // decompiled from Move bytecode v6
}

