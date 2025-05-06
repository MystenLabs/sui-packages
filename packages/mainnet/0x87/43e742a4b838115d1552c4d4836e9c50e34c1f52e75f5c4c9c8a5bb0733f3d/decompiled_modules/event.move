module 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::event {
    struct EventTip has copy, drop {
        tip: 0x1::string::String,
    }

    struct Event<T0: copy + drop> has copy, drop {
        biz: u16,
        memo: 0x1::string::String,
        data: T0,
    }

    struct NetworkBornEvent has copy, drop {
        network: address,
    }

    struct NodeBornEvent has copy, drop {
        node: address,
    }

    struct BusinessBornEvent has copy, drop {
        business: address,
    }

    struct TokenBornEvent has copy, drop {
        token: address,
    }

    struct AssetBornEvent has copy, drop {
        asset: address,
    }

    public fun emit<T0: copy + drop>(arg0: u16, arg1: 0x1::string::String, arg2: T0) {
        let v0 = Event<T0>{
            biz  : arg0,
            memo : arg1,
            data : arg2,
        };
        0x2::event::emit<Event<T0>>(v0);
    }

    public fun emit_asset_born_event(arg0: address) {
        let v0 = AssetBornEvent{asset: arg0};
        0x2::event::emit<AssetBornEvent>(v0);
    }

    public fun emit_business_born_event(arg0: address) {
        let v0 = BusinessBornEvent{business: arg0};
        0x2::event::emit<BusinessBornEvent>(v0);
    }

    public fun emit_network_born_event(arg0: address) {
        let v0 = NetworkBornEvent{network: arg0};
        0x2::event::emit<NetworkBornEvent>(v0);
    }

    public fun emit_node_born_event(arg0: address) {
        let v0 = NodeBornEvent{node: arg0};
        0x2::event::emit<NodeBornEvent>(v0);
    }

    public fun emit_token_born_event(arg0: address) {
        let v0 = TokenBornEvent{token: arg0};
        0x2::event::emit<TokenBornEvent>(v0);
    }

    public fun new_event_tip(arg0: 0x1::string::String) : EventTip {
        EventTip{tip: arg0}
    }

    // decompiled from Move bytecode v6
}

