module 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::network {
    struct Collar has store, key {
        id: 0x2::object::UID,
        network: address,
        symbol: 0x1::string::String,
    }

    struct Network has store, key {
        id: 0x2::object::UID,
        nineora: address,
        symbol: 0x1::string::String,
        owner: address,
        benefit: address,
        ctrl: u64,
        committee: 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::committee::Committee,
        collar: address,
        fee: u64,
    }

    public fun benefit_borrow(arg0: &Network) : address {
        arg0.benefit
    }

    public fun collar_borrow(arg0: &Network) : address {
        arg0.collar
    }

    public fun committee_borrow(arg0: &Network) : &0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::committee::Committee {
        &arg0.committee
    }

    public fun committee_borrow_mut(arg0: &mut Network) : &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::committee::Committee {
        &mut arg0.committee
    }

    public fun ctrl_borrow(arg0: &Network) : u64 {
        arg0.ctrl
    }

    public fun fee(arg0: &mut Network, arg1: u64) {
        assert!(arg0.fee >= arg1, 900009);
        arg0.fee = arg0.fee - arg1;
    }

    public fun nineora_borrow(arg0: &Network) : address {
        arg0.nineora
    }

    public fun owner_borrow(arg0: &Network) : address {
        arg0.owner
    }

    public entry fun public_create(arg0: address, arg1: vector<u8>, arg2: address, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg5);
        let v1 = Network{
            id        : 0x2::object::new(arg5),
            nineora   : arg0,
            symbol    : 0x1::string::utf8(arg1),
            owner     : arg2,
            benefit   : arg3,
            ctrl      : arg4,
            committee : 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::committee::new(arg5),
            collar    : 0x2::object::uid_to_address(&v0),
            fee       : 0,
        };
        let v2 = 0x2::object::id_address<Network>(&v1);
        let v3 = Collar{
            id      : v0,
            network : v2,
            symbol  : 0x1::string::utf8(arg1),
        };
        0x2::transfer::public_share_object<Network>(v1);
        0x2::transfer::public_transfer<Collar>(v3, arg0);
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::event::emit_network_born_event(v2);
    }

    public entry fun public_recharge(arg0: &mut Network, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.fee = arg0.fee + arg1;
    }

    public entry fun public_set_benefit(arg0: &mut Network, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        set_benefit(arg0, arg1);
    }

    public entry fun public_set_ctrl(arg0: &mut Network, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        set_ctrl(arg0, arg1);
    }

    public entry fun public_set_symbol(arg0: &mut Network, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        set_symbol(arg0, 0x1::string::utf8(arg1));
    }

    public fun set_benefit(arg0: &mut Network, arg1: address) {
        arg0.benefit = arg1;
    }

    public fun set_ctrl(arg0: &mut Network, arg1: u64) {
        arg0.ctrl = arg1;
    }

    public fun set_owner(arg0: Network, arg1: address) {
        arg0.owner = arg1;
        0x2::transfer::public_transfer<Network>(arg0, arg1);
    }

    public fun set_symbol(arg0: &mut Network, arg1: 0x1::string::String) {
        arg0.symbol = arg1;
    }

    public fun symbol_borrow(arg0: &Network) : 0x1::string::String {
        arg0.symbol
    }

    // decompiled from Move bytecode v6
}

