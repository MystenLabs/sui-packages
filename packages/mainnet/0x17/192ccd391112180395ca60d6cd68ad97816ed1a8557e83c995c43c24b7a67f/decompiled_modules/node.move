module 0x17192ccd391112180395ca60d6cd68ad97816ed1a8557e83c995c43c24b7a67f::node {
    struct Nodes has store, key {
        id: 0x2::object::UID,
        nodes: 0x2::vec_map::VecMap<u8, Node>,
        users: 0x2::vec_map::VecMap<address, User>,
        receiver: address,
        coin_type: 0x1::type_name::TypeName,
        node_index: u8,
        node_num_index: u64,
        limits: 0x2::vec_map::VecMap<u64, 0x2::vec_map::VecMap<u64, u64>>,
    }

    struct Node has drop, store {
        rank: u8,
        name: vector<u8>,
        description: vector<u8>,
        limit: u64,
        price: u64,
        total_quantity: u64,
        purchased_quantity: u64,
        is_open: bool,
    }

    struct User has store {
        rank: u8,
        node_num: u64,
        is_invalid: bool,
    }

    struct NodeInfo has copy, drop {
        rank: u8,
        name: vector<u8>,
        description: vector<u8>,
        limit: u64,
        price: u64,
        total_quantity: u64,
        purchased_quantity: u64,
        is_open: bool,
    }

    struct Buy has copy, drop {
        sender: address,
        rank: u8,
        node_num: u64,
    }

    struct Transfer has copy, drop {
        sender: address,
        receiver: address,
        rank: u8,
        node_num: u64,
    }

    public(friend) fun new<T0>(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Nodes{
            id             : 0x2::object::new(arg1),
            nodes          : 0x2::vec_map::empty<u8, Node>(),
            users          : 0x2::vec_map::empty<address, User>(),
            receiver       : arg0,
            coin_type      : 0x1::type_name::get<T0>(),
            node_index     : 0,
            node_num_index : 0,
            limits         : 0x2::vec_map::empty<u64, 0x2::vec_map::VecMap<u64, u64>>(),
        };
        0x2::transfer::public_share_object<Nodes>(v0);
    }

    entry fun transfer(arg0: &mut Nodes, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = nodes_rank(arg0, v0);
        let v2 = 0x2::vec_map::get<u8, Node>(&arg0.nodes, &v1);
        assert_not_buy_node(&arg0.users, v0);
        assert_already_buy_node(&arg0.users, arg1);
        let v3 = 0x2::vec_map::get_mut<address, User>(&mut arg0.users, &v0);
        let v4 = v3.node_num;
        v3.rank = 0;
        v3.node_num = 0;
        v3.is_invalid = false;
        if (0x2::vec_map::contains<address, User>(&arg0.users, &arg1)) {
            let v5 = 0x2::vec_map::get_mut<address, User>(&mut arg0.users, &arg1);
            v5.rank = v1;
            v5.node_num = v4;
            v5.is_invalid = true;
        } else {
            let v6 = User{
                rank       : v2.rank,
                node_num   : v4,
                is_invalid : true,
            };
            0x2::vec_map::insert<address, User>(&mut arg0.users, arg1, v6);
        };
        let v7 = Transfer{
            sender   : v0,
            receiver : arg1,
            rank     : v1,
            node_num : v4,
        };
        0x2::event::emit<Transfer>(v7);
    }

    public(friend) fun insert(arg0: &mut Nodes, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64) {
        arg0.node_index = arg0.node_index + 1;
        let v0 = arg0.node_index;
        let v1 = Node{
            rank               : v0,
            name               : arg1,
            description        : arg2,
            limit              : arg3,
            price              : arg4,
            total_quantity     : arg5,
            purchased_quantity : 0,
            is_open            : true,
        };
        0x2::vec_map::insert<u8, Node>(&mut arg0.nodes, v0, v1);
    }

    public(friend) fun remove(arg0: &mut Nodes, arg1: u8) {
        let (_, _) = 0x2::vec_map::remove<u8, Node>(&mut arg0.nodes, &arg1);
    }

    public fun assert_already_buy_node(arg0: &0x2::vec_map::VecMap<address, User>, arg1: address) {
        let v0 = 0x2::vec_map::contains<address, User>(arg0, &arg1);
        assert!(!v0, 2);
        if (v0) {
            assert!(!0x2::vec_map::get<address, User>(arg0, &arg1).is_invalid, 2);
        };
    }

    public fun assert_exceeds_purchase_limit(arg0: &Node, arg1: u64) {
        assert!(arg0.limit - arg1 > 0, 5);
    }

    public fun assert_invalid_coin_type<T0>(arg0: 0x1::type_name::TypeName) {
        assert!(0x1::type_name::get<T0>() == arg0, 6);
    }

    public fun assert_node_not_open(arg0: &Node) {
        assert!(arg0.is_open, 7);
    }

    public fun assert_node_sold_out(arg0: &Node) {
        assert!(arg0.total_quantity - arg0.purchased_quantity > 0, 4);
    }

    public fun assert_not_buy_node(arg0: &0x2::vec_map::VecMap<address, User>, arg1: address) {
        if (0x2::vec_map::contains<address, User>(arg0, &arg1)) {
            assert!(0x2::vec_map::get<address, User>(arg0, &arg1).is_invalid, 3);
        };
    }

    entry fun buy<T0>(arg0: &mut Nodes, arg1: &0x17192ccd391112180395ca60d6cd68ad97816ed1a8557e83c995c43c24b7a67f::invite::Invite, arg2: u8, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_invalid_coin_type<T0>(arg0.coin_type);
        let v0 = 0x2::tx_context::sender(arg4);
        0x17192ccd391112180395ca60d6cd68ad97816ed1a8557e83c995c43c24b7a67f::invite::assert_not_bind_inviter(arg1, v0);
        arg0.node_num_index = arg0.node_num_index + 1;
        let v1 = 0x2::vec_map::get_mut<u8, Node>(&mut arg0.nodes, &arg2);
        assert!(0x2::coin::value<T0>(&arg3) >= v1.price, 1);
        assert_already_buy_node(&arg0.users, v0);
        assert_node_sold_out(v1);
        assert_node_not_open(v1);
        let v2 = User{
            rank       : v1.rank,
            node_num   : arg0.node_num_index,
            is_invalid : true,
        };
        0x2::vec_map::insert<address, User>(&mut arg0.users, v0, v2);
        v1.purchased_quantity = v1.purchased_quantity + 1;
        let v3 = 0x2::coin::value<T0>(&arg3) - v1.price;
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v3, arg4), v0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v1.price * 0x17192ccd391112180395ca60d6cd68ad97816ed1a8557e83c995c43c24b7a67f::invite::inviter_fee(arg1) / 10000, arg4), 0x17192ccd391112180395ca60d6cd68ad97816ed1a8557e83c995c43c24b7a67f::invite::inviters(arg1, v0));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, arg0.receiver);
        let v4 = Buy{
            sender   : v0,
            rank     : arg2,
            node_num : arg0.node_num_index,
        };
        0x2::event::emit<Buy>(v4);
    }

    public fun is_already_buy_node(arg0: &Nodes, arg1: address) : bool {
        0x2::vec_map::contains<address, User>(&arg0.users, &arg1) && 0x2::vec_map::get<address, User>(&arg0.users, &arg1).is_invalid
    }

    public(friend) fun modify(arg0: &mut Nodes, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: bool) {
        let v0 = 0x2::vec_map::get_mut<u8, Node>(&mut arg0.nodes, &arg1);
        v0.rank = arg1;
        v0.name = arg2;
        v0.description = arg3;
        v0.price = arg4;
        v0.limit = arg5;
        v0.total_quantity = arg6;
        v0.is_open = arg7;
    }

    public(friend) fun modify_nodes<T0>(arg0: &mut Nodes, arg1: address) {
        arg0.receiver = arg1;
        arg0.coin_type = 0x1::type_name::get<T0>();
    }

    public fun node_list(arg0: &Nodes) {
        let v0 = 1;
        while (v0 < (0x2::vec_map::size<u8, Node>(&arg0.nodes) as u8) + 1) {
            let v1 = 0x2::vec_map::get<u8, Node>(&arg0.nodes, &v0);
            let v2 = NodeInfo{
                rank               : v1.rank,
                name               : v1.name,
                description        : v1.description,
                limit              : v1.limit,
                price              : v1.price,
                total_quantity     : v1.total_quantity,
                purchased_quantity : v1.purchased_quantity,
                is_open            : v1.is_open,
            };
            0x2::event::emit<NodeInfo>(v2);
            v0 = v0 + 1;
        };
    }

    public fun nodes_rank(arg0: &Nodes, arg1: address) : u8 {
        0x2::vec_map::get<address, User>(&arg0.users, &arg1).rank
    }

    public fun receiver(arg0: &Nodes) : address {
        arg0.receiver
    }

    public fun remaining_quantity_of_claim(arg0: &Nodes, arg1: address, arg2: u64) : u64 {
        if (0x2::vec_map::contains<address, User>(&arg0.users, &arg1)) {
            let v1 = 0x2::vec_map::get<address, User>(&arg0.users, &arg1);
            if (0x2::vec_map::contains<u8, Node>(&arg0.nodes, &v1.rank)) {
                if (0x2::vec_map::contains<u64, 0x2::vec_map::VecMap<u64, u64>>(&arg0.limits, &v1.node_num)) {
                    let v2 = 0x2::vec_map::get<u64, 0x2::vec_map::VecMap<u64, u64>>(&arg0.limits, &v1.node_num);
                    if (0x2::vec_map::contains<u64, u64>(v2, &arg2)) {
                        0x2::vec_map::get<u8, Node>(&arg0.nodes, &v1.rank).limit - *0x2::vec_map::get<u64, u64>(v2, &arg2)
                    } else {
                        0x2::vec_map::get<u8, Node>(&arg0.nodes, &v1.rank).limit
                    }
                } else {
                    0x2::vec_map::get<u8, Node>(&arg0.nodes, &v1.rank).limit
                }
            } else {
                0
            }
        } else {
            0
        }
    }

    public(friend) fun update_purchased_quantity(arg0: &mut Nodes, arg1: address, arg2: u64) {
        assert_not_buy_node(&arg0.users, arg1);
        let v0 = 0x2::vec_map::get_mut<address, User>(&mut arg0.users, &arg1);
        if (0x2::vec_map::contains<u64, 0x2::vec_map::VecMap<u64, u64>>(&arg0.limits, &v0.node_num)) {
            let v1 = 0x2::vec_map::get_mut<u64, 0x2::vec_map::VecMap<u64, u64>>(&mut arg0.limits, &v0.node_num);
            if (0x2::vec_map::contains<u64, u64>(v1, &arg2)) {
                let (_, _) = 0x2::vec_map::remove<u64, u64>(v1, &arg2);
                0x2::vec_map::insert<u64, u64>(v1, arg2, *0x2::vec_map::get<u64, u64>(v1, &arg2) + 1);
            } else {
                0x2::vec_map::insert<u64, u64>(v1, arg2, 1);
            };
        } else {
            let v4 = 0x2::vec_map::empty<u64, u64>();
            0x2::vec_map::insert<u64, u64>(&mut v4, arg2, 1);
            0x2::vec_map::insert<u64, 0x2::vec_map::VecMap<u64, u64>>(&mut arg0.limits, v0.node_num, v4);
        };
    }

    // decompiled from Move bytecode v6
}

