module 0x46bce10b7234a5ec3406d0955645161415d5eff869061d309f337cd38f0d21a0::strategy {
    struct ProtocolInfo has copy, drop, store {
        strategy_id: u8,
        name: 0x1::string::String,
        has_rewards: bool,
    }

    struct StrategyRegistry has key {
        id: 0x2::object::UID,
        protocols: 0x2::vec_map::VecMap<u8, ProtocolInfo>,
    }

    struct ProtocolRegisteredEvent has copy, drop {
        strategy_id: u8,
        name: 0x1::string::String,
    }

    public fun count_available(arg0: &StrategyRegistry) : u64 {
        0x2::vec_map::length<u8, ProtocolInfo>(&arg0.protocols)
    }

    public fun create_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StrategyRegistry{
            id        : 0x2::object::new(arg0),
            protocols : 0x2::vec_map::empty<u8, ProtocolInfo>(),
        };
        0x2::transfer::share_object<StrategyRegistry>(v0);
    }

    public fun decode_strategy(arg0: u8) : (u8, u8) {
        (arg0 >> 4, arg0 & 15)
    }

    public fun encode_strategy(arg0: u8, arg1: u8) : u8 {
        arg0 << 4 | arg1
    }

    public fun get_protocol_info(arg0: &StrategyRegistry, arg1: u8) : ProtocolInfo {
        assert!(0x2::vec_map::contains<u8, ProtocolInfo>(&arg0.protocols, &arg1), 401);
        *0x2::vec_map::get<u8, ProtocolInfo>(&arg0.protocols, &arg1)
    }

    public fun has_rewards(arg0: &StrategyRegistry, arg1: u8) : bool {
        assert!(0x2::vec_map::contains<u8, ProtocolInfo>(&arg0.protocols, &arg1), 401);
        0x2::vec_map::get<u8, ProtocolInfo>(&arg0.protocols, &arg1).has_rewards
    }

    public fun is_available(arg0: &StrategyRegistry, arg1: u8) : bool {
        0x2::vec_map::contains<u8, ProtocolInfo>(&arg0.protocols, &arg1)
    }

    public fun list_available(arg0: &StrategyRegistry) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<u8, ProtocolInfo>(&arg0.protocols)) {
            let (v2, _) = 0x2::vec_map::get_entry_by_idx<u8, ProtocolInfo>(&arg0.protocols, v1);
            0x1::vector::push_back<u8>(&mut v0, *v2);
            v1 = v1 + 1;
        };
        v0
    }

    public fun name(arg0: &ProtocolInfo) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun register_protocol(arg0: &mut StrategyRegistry, arg1: &0x14de5ce960a411ab210ea069c1c73f9cb86d69ff0773ee0fa5a3bd5e96f00b6b::vault::AdminCap, arg2: u8, arg3: 0x1::string::String, arg4: bool) {
        assert!(arg2 != 0, 402);
        assert!(!0x2::vec_map::contains<u8, ProtocolInfo>(&arg0.protocols, &arg2), 400);
        let v0 = ProtocolInfo{
            strategy_id : arg2,
            name        : arg3,
            has_rewards : arg4,
        };
        0x2::vec_map::insert<u8, ProtocolInfo>(&mut arg0.protocols, arg2, v0);
        let v1 = ProtocolRegisteredEvent{
            strategy_id : arg2,
            name        : arg3,
        };
        0x2::event::emit<ProtocolRegisteredEvent>(v1);
    }

    public fun stable_usdc() : u8 {
        1
    }

    public fun stable_usdsui() : u8 {
        2
    }

    public(friend) fun update_has_rewards(arg0: &mut StrategyRegistry, arg1: &0x14de5ce960a411ab210ea069c1c73f9cb86d69ff0773ee0fa5a3bd5e96f00b6b::vault::AdminCap, arg2: u8, arg3: bool) {
        assert!(0x2::vec_map::contains<u8, ProtocolInfo>(&arg0.protocols, &arg2), 401);
        0x2::vec_map::get_mut<u8, ProtocolInfo>(&mut arg0.protocols, &arg2).has_rewards = arg3;
    }

    // decompiled from Move bytecode v6
}

