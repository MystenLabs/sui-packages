module 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::node {
    struct Node<T0: store> has store, key {
        id: 0x2::object::UID,
        network: address,
        superior: address,
        owner: address,
        benefit: address,
        ctrl: u64,
        node: T0,
    }

    public fun owner_borrow<T0: store>(arg0: &Node<T0>) : address {
        arg0.owner
    }

    public fun add_node<T0: store, T1: store>(arg0: &Node<T1>, arg1: address, arg2: u64, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Node<T0>{
            id       : 0x2::object::new(arg4),
            network  : arg0.network,
            superior : 0x2::object::id_address<Node<T1>>(arg0),
            owner    : arg0.owner,
            benefit  : arg1,
            ctrl     : arg2,
            node     : arg3,
        };
        0x2::transfer::public_transfer<Node<T0>>(v0, arg0.owner);
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::event::emit_node_born_event(0x2::object::id_address<Node<T0>>(&v0));
    }

    public fun benefit_borrow<T0: store>(arg0: &Node<T0>) : address {
        arg0.benefit
    }

    public fun check_superior<T0: store>(arg0: &Node<T0>, arg1: address) {
        assert!(arg0.superior == arg1, 91100001);
    }

    public fun create_node<T0: store>(arg0: &mut 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::network::Network, arg1: address, arg2: u64, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::network::fee(arg0, 1000);
        let v0 = 0x2::object::id_address<0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::network::Network>(arg0);
        let v1 = 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::network::owner_borrow(arg0);
        let v2 = Node<T0>{
            id       : 0x2::object::new(arg4),
            network  : v0,
            superior : v0,
            owner    : v1,
            benefit  : arg1,
            ctrl     : arg2,
            node     : arg3,
        };
        0x2::transfer::public_transfer<Node<T0>>(v2, v1);
        0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::event::emit_node_born_event(0x2::object::id_address<Node<T0>>(&v2));
    }

    public fun ctrl_borrow<T0: store>(arg0: &Node<T0>) : u64 {
        arg0.ctrl
    }

    public fun network_borrow<T0: store>(arg0: &Node<T0>) : address {
        arg0.network
    }

    public fun node_borrow<T0: store>(arg0: &Node<T0>) : &T0 {
        &arg0.node
    }

    public fun node_borrow_mut<T0: store>(arg0: &mut Node<T0>) : &mut T0 {
        &mut arg0.node
    }

    public fun set_benefit<T0: store>(arg0: &mut Node<T0>, arg1: address) {
        arg0.benefit = arg1;
    }

    public fun set_ctrl<T0: store>(arg0: &mut Node<T0>, arg1: u64) {
        arg0.ctrl = arg1;
    }

    public fun set_network<T0: store>(arg0: &mut Node<T0>, arg1: address) {
        arg0.network = arg1;
    }

    public fun set_owner<T0: store>(arg0: Node<T0>, arg1: address) {
        arg0.owner = arg1;
        0x2::transfer::public_transfer<Node<T0>>(arg0, arg1);
    }

    public fun set_superior<T0: store>(arg0: &mut Node<T0>, arg1: address) {
        arg0.superior = arg1;
    }

    public fun superior_borrow<T0: store>(arg0: &Node<T0>) : address {
        arg0.superior
    }

    // decompiled from Move bytecode v6
}

