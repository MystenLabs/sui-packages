module 0xd07270fc99b3e94d487171a5cdf03a633084c7f90a6e085f732f909f62901617::simple_bridge {
    struct SIMPLE_BRIDGE has drop {
        dummy_field: bool,
    }

    struct SimpleBridgeConfig has key {
        id: 0x2::object::UID,
        admin: address,
        treasury_cap: 0x2::coin::TreasuryCap<SIMPLE_BRIDGE>,
        bridge_state: 0xd07270fc99b3e94d487171a5cdf03a633084c7f90a6e085f732f909f62901617::types::BridgeState,
        min_bridge_amount: u64,
        max_bridge_amount: u64,
        bridge_fee: u64,
        attestors: vector<address>,
    }

    public entry fun add_attestor(arg0: &mut SimpleBridgeConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3);
        if (!0x1::vector::contains<address>(&arg0.attestors, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.attestors, arg1);
        };
    }

    public entry fun bridge_in_simple(arg0: &mut SimpleBridgeConfig, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 >= arg0.min_bridge_amount && arg3 <= arg0.max_bridge_amount, 2);
        assert!(!0xd07270fc99b3e94d487171a5cdf03a633084c7f90a6e085f732f909f62901617::types::is_bridge_paused(&arg0.bridge_state), 1);
        assert!(!0xd07270fc99b3e94d487171a5cdf03a633084c7f90a6e085f732f909f62901617::types::is_event_processed(&arg0.bridge_state, &arg1), 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<SIMPLE_BRIDGE>>(0x2::coin::mint<SIMPLE_BRIDGE>(&mut arg0.treasury_cap, arg3 - arg3 * arg0.bridge_fee / 10000, arg5), arg4);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg1)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg1, v1));
            v1 = v1 + 1;
        };
        0xd07270fc99b3e94d487171a5cdf03a633084c7f90a6e085f732f909f62901617::types::update_bridge_in_stats(&mut arg0.bridge_state, arg3);
        0xd07270fc99b3e94d487171a5cdf03a633084c7f90a6e085f732f909f62901617::types::mark_event_processed(&mut arg0.bridge_state, arg1);
        0xd07270fc99b3e94d487171a5cdf03a633084c7f90a6e085f732f909f62901617::types::emit_bridge_in_event(v0, arg4, arg3, arg2);
    }

    public entry fun bridge_out_simple(arg0: &mut SimpleBridgeConfig, arg1: 0x2::coin::Coin<SIMPLE_BRIDGE>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0xd07270fc99b3e94d487171a5cdf03a633084c7f90a6e085f732f909f62901617::types::is_bridge_paused(&arg0.bridge_state), 1);
        let v0 = 0x2::coin::value<SIMPLE_BRIDGE>(&arg1);
        assert!(v0 >= arg0.min_bridge_amount && v0 <= arg0.max_bridge_amount, 2);
        0x2::coin::burn<SIMPLE_BRIDGE>(&mut arg0.treasury_cap, arg1);
        0xd07270fc99b3e94d487171a5cdf03a633084c7f90a6e085f732f909f62901617::types::update_bridge_out_stats(&mut arg0.bridge_state, v0);
        0xd07270fc99b3e94d487171a5cdf03a633084c7f90a6e085f732f909f62901617::types::emit_bridge_out_event(arg2, 0x2::tx_context::sender(arg4), arg3, v0);
    }

    public fun get_attestors(arg0: &SimpleBridgeConfig) : &vector<address> {
        &arg0.attestors
    }

    public fun get_bridge_stats(arg0: &SimpleBridgeConfig) : (u64, u64, bool) {
        (0xd07270fc99b3e94d487171a5cdf03a633084c7f90a6e085f732f909f62901617::types::get_total_bridged_in(&arg0.bridge_state), 0xd07270fc99b3e94d487171a5cdf03a633084c7f90a6e085f732f909f62901617::types::get_total_bridged_out(&arg0.bridge_state), 0xd07270fc99b3e94d487171a5cdf03a633084c7f90a6e085f732f909f62901617::types::is_bridge_paused(&arg0.bridge_state))
    }

    fun init(arg0: SIMPLE_BRIDGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMPLE_BRIDGE>(arg0, 0, b"UNCH", b"Unchained Token", b"Bridged Unchained tokens on Sui", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SIMPLE_BRIDGE>>(v1, 0x2::tx_context::sender(arg1));
        let v2 = SimpleBridgeConfig{
            id                : 0x2::object::new(arg1),
            admin             : 0x2::tx_context::sender(arg1),
            treasury_cap      : v0,
            bridge_state      : 0xd07270fc99b3e94d487171a5cdf03a633084c7f90a6e085f732f909f62901617::types::init_bridge_state(arg1),
            min_bridge_amount : 1,
            max_bridge_amount : 1000000,
            bridge_fee        : 10,
            attestors         : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<SimpleBridgeConfig>(v2);
    }

    public fun is_attestor(arg0: &SimpleBridgeConfig, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.attestors, &arg1)
    }

    public entry fun pause_bridge(arg0: &mut SimpleBridgeConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 3);
        0xd07270fc99b3e94d487171a5cdf03a633084c7f90a6e085f732f909f62901617::types::set_bridge_paused(&mut arg0.bridge_state, true);
    }

    public entry fun remove_attestor(arg0: &mut SimpleBridgeConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.attestors)) {
            if (*0x1::vector::borrow<address>(&arg0.attestors, v0) == arg1) {
                0x1::vector::swap_remove<address>(&mut arg0.attestors, v0);
                break
            };
            v0 = v0 + 1;
        };
    }

    public entry fun set_fee(arg0: &mut SimpleBridgeConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3);
        arg0.bridge_fee = arg1;
    }

    public entry fun set_limits(arg0: &mut SimpleBridgeConfig, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 3);
        arg0.min_bridge_amount = arg1;
        arg0.max_bridge_amount = arg2;
    }

    public entry fun unpause_bridge(arg0: &mut SimpleBridgeConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 3);
        0xd07270fc99b3e94d487171a5cdf03a633084c7f90a6e085f732f909f62901617::types::set_bridge_paused(&mut arg0.bridge_state, false);
    }

    // decompiled from Move bytecode v6
}

