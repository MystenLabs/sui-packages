module 0x5eab2e99a8fa5f8fa8f5d5ceb74c0c7a953d773dc11200a4dc4bec57ec0527e::router {
    struct OnRampSet has copy, drop {
        dest_chain_selector: u64,
        on_ramp_info: OnRampInfo,
    }

    struct RouterState has key {
        id: 0x2::object::UID,
        on_ramp_infos: vector<OnRampInfo>,
    }

    struct OnRampInfo has copy, drop, store {
        onramp_address: address,
        onramp_version: vector<u8>,
    }

    public fun create_default_test_on_ramp_info() : OnRampInfo {
        create_test_on_ramp_info(@0x1, x"010600")
    }

    public fun create_test_chain_selectors() : vector<u64> {
        vector[1, 137, 42161, 10]
    }

    public fun create_test_on_ramp_info(arg0: address, arg1: vector<u8>) : OnRampInfo {
        OnRampInfo{
            onramp_address : arg0,
            onramp_version : arg1,
        }
    }

    public fun create_test_on_ramp_info_with_version(arg0: address, arg1: u8, arg2: u8, arg3: u8) : OnRampInfo {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, arg1);
        0x1::vector::push_back<u8>(v1, arg2);
        0x1::vector::push_back<u8>(v1, arg3);
        create_test_on_ramp_info(arg0, v0)
    }

    public fun create_test_onramp_addresses() : vector<address> {
        vector[@0x1, @0x2, @0x3, @0x4]
    }

    public fun create_test_onramp_versions() : vector<vector<u8>> {
        vector[x"010600", x"010500", x"010400", x"010300"]
    }

    public fun emit_on_ramp_set_event(arg0: u64, arg1: OnRampInfo) {
        let v0 = OnRampSet{
            dest_chain_selector : arg0,
            on_ramp_info        : arg1,
        };
        0x2::event::emit<OnRampSet>(v0);
    }

    public fun get_mock_onramp_address() : address {
        @0x1
    }

    // decompiled from Move bytecode v6
}

