module 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::business {
    struct Collar has store, key {
        id: 0x2::object::UID,
        business: address,
        symbol: 0x1::string::String,
    }

    struct Business<T0: store> has store, key {
        id: 0x2::object::UID,
        network: address,
        symbol: 0x1::string::String,
        owner: address,
        benefit: address,
        ctrl: u64,
        committee: 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::committee::Committee,
        collar: address,
        business: T0,
    }

    public fun benefit_borrow<T0: store>(arg0: &Business<T0>) : address {
        arg0.benefit
    }

    public fun business_borrow<T0: store>(arg0: &Business<T0>) : &T0 {
        &arg0.business
    }

    public fun business_borrow_mut<T0: store>(arg0: &mut Business<T0>) : &mut T0 {
        &mut arg0.business
    }

    public fun committee_borrow<T0: store>(arg0: &Business<T0>) : &0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::committee::Committee {
        &arg0.committee
    }

    public fun committee_borrow_mut<T0: store>(arg0: &mut Business<T0>) : &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::committee::Committee {
        &mut arg0.committee
    }

    public fun create_business<T0: store>(arg0: address, arg1: vector<u8>, arg2: address, arg3: address, arg4: u64, arg5: T0, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg6);
        let v1 = Business<T0>{
            id        : 0x2::object::new(arg6),
            network   : arg0,
            symbol    : 0x1::string::utf8(arg1),
            owner     : arg2,
            benefit   : arg3,
            ctrl      : arg4,
            committee : 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::committee::new(arg6),
            collar    : 0x2::object::uid_to_address(&v0),
            business  : arg5,
        };
        let v2 = 0x2::object::id_address<Business<T0>>(&v1);
        let v3 = Collar{
            id       : v0,
            business : v2,
            symbol   : 0x1::string::utf8(arg1),
        };
        0x2::transfer::public_transfer<Business<T0>>(v1, arg2);
        0x2::transfer::public_transfer<Collar>(v3, arg0);
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::event::emit_business_born_event(v2);
    }

    public fun ctrl_borrow<T0: store>(arg0: &Business<T0>) : u64 {
        arg0.ctrl
    }

    public fun network_borrow<T0: store>(arg0: &Business<T0>) : address {
        arg0.network
    }

    public fun owner_borrow<T0: store>(arg0: &Business<T0>) : address {
        arg0.owner
    }

    public fun set_benefit<T0: store>(arg0: &mut Business<T0>, arg1: address) {
        arg0.benefit = arg1;
    }

    public fun set_ctrl<T0: store>(arg0: &mut Business<T0>, arg1: u64) {
        arg0.ctrl = arg1;
    }

    public fun set_network<T0: store>(arg0: &mut Business<T0>, arg1: address) {
        arg0.network = arg1;
    }

    public fun set_owner<T0: store>(arg0: Business<T0>, arg1: address) {
        arg0.owner = arg1;
        0x2::transfer::public_transfer<Business<T0>>(arg0, arg1);
    }

    public fun set_symbol<T0: store>(arg0: &mut Business<T0>, arg1: 0x1::string::String) {
        arg0.symbol = arg1;
    }

    public fun symbol_borrow<T0: store>(arg0: &Business<T0>) : 0x1::string::String {
        arg0.symbol
    }

    // decompiled from Move bytecode v6
}

