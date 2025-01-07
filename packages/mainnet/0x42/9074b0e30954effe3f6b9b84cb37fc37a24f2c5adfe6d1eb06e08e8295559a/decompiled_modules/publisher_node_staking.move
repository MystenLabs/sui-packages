module 0x429074b0e30954effe3f6b9b84cb37fc37a24f2c5adfe6d1eb06e08e8295559a::publisher_node_staking {
    struct PublisherNodeVault has store, key {
        id: 0x2::object::UID,
        total_staked: 0x2::coin::Coin<0x212f28dbcb0aec4c7d65489844011cf892f01b13b3488052c89091cb54800ee2::hydro_token_test::HYDRO_TOKEN_TEST>,
        user_node_ids: 0x2::vec_map::VecMap<address, vector<0x1::string::String>>,
        user_stake_info: 0x2::vec_map::VecMap<address, u64>,
        user_nodes_data: 0x2::vec_map::VecMap<0x1::string::String, PublisherNode>,
        locking_period: u64,
    }

    struct PublisherNode has copy, drop, store {
        id: 0x1::string::String,
        price: u64,
        locking_period: u64,
        owner_address: address,
        timestamp: u64,
    }

    struct Owner has store, key {
        id: 0x2::object::UID,
        owner_address: address,
    }

    struct UpgradeVersion has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct Staked has copy, drop {
        staker: address,
        total_stake: u64,
    }

    struct RegisteredPublisherNode has copy, drop {
        user: address,
        no_of_nodes: u64,
        nodes_data: vector<PublisherNode>,
    }

    struct ChangedOwner has copy, drop {
        current_owner: address,
        new_owner: address,
    }

    struct PUBLISHER_NODE_STAKING has drop {
        dummy_field: bool,
    }

    public entry fun change_owner(arg0: 0x2::package::UpgradeCap, arg1: Owner, arg2: address, arg3: &UpgradeVersion, arg4: &0x2::tx_context::TxContext) {
        let v0 = arg1.owner_address;
        assert!(0x2::tx_context::sender(arg4) == v0, 3);
        assert!(arg3.version == 0, 2);
        assert!(@0x0 != arg2, 4);
        assert!(arg2 != v0, 8);
        arg1.owner_address = arg2;
        0x2::transfer::public_transfer<Owner>(arg1, arg2);
        0x2::transfer::public_transfer<0x2::package::UpgradeCap>(arg0, arg2);
        let v1 = ChangedOwner{
            current_owner : v0,
            new_owner     : arg2,
        };
        0x2::event::emit<ChangedOwner>(v1);
    }

    public entry fun configure_lock_period(arg0: &Owner, arg1: &mut PublisherNodeVault, arg2: u64, arg3: &UpgradeVersion, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner_address, 3);
        assert!(arg3.version == 0, 2);
        arg1.locking_period = arg2;
    }

    fun init(arg0: PUBLISHER_NODE_STAKING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = Owner{
            id            : 0x2::object::new(arg1),
            owner_address : v0,
        };
        let v2 = UpgradeVersion{
            id      : 0x2::object::new(arg1),
            version : 0,
        };
        let v3 = PublisherNodeVault{
            id              : 0x2::object::new(arg1),
            total_staked    : 0x2::coin::zero<0x212f28dbcb0aec4c7d65489844011cf892f01b13b3488052c89091cb54800ee2::hydro_token_test::HYDRO_TOKEN_TEST>(arg1),
            user_node_ids   : 0x2::vec_map::empty<address, vector<0x1::string::String>>(),
            user_stake_info : 0x2::vec_map::empty<address, u64>(),
            user_nodes_data : 0x2::vec_map::empty<0x1::string::String, PublisherNode>(),
            locking_period  : 31536000000,
        };
        0x2::transfer::share_object<PublisherNodeVault>(v3);
        0x2::transfer::public_transfer<Owner>(v1, v0);
        0x2::transfer::share_object<UpgradeVersion>(v2);
    }

    public fun map_publisher_node(arg0: address, arg1: u64, arg2: &mut PublisherNodeVault, arg3: PublisherNode) {
        if (0x2::vec_map::contains<address, vector<0x1::string::String>>(&arg2.user_node_ids, &arg0)) {
            0x1::vector::push_back<0x1::string::String>(0x2::vec_map::get_mut<address, vector<0x1::string::String>>(&mut arg2.user_node_ids, &arg0), arg3.id);
            let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg2.user_stake_info, &arg0);
            0x2::vec_map::insert<address, u64>(&mut arg2.user_stake_info, arg0, *0x2::vec_map::get_mut<address, u64>(&mut arg2.user_stake_info, &arg0) + arg1);
            0x2::vec_map::insert<0x1::string::String, PublisherNode>(&mut arg2.user_nodes_data, arg3.id, arg3);
        } else {
            let v2 = 0x1::vector::empty<0x1::string::String>();
            0x1::vector::push_back<0x1::string::String>(&mut v2, arg3.id);
            0x2::vec_map::insert<address, vector<0x1::string::String>>(&mut arg2.user_node_ids, arg0, v2);
            0x2::vec_map::insert<address, u64>(&mut arg2.user_stake_info, arg0, arg1);
            0x2::vec_map::insert<0x1::string::String, PublisherNode>(&mut arg2.user_nodes_data, arg3.id, arg3);
        };
    }

    public fun register_publisher_node(arg0: vector<0x1::string::String>, arg1: u64, arg2: u64, arg3: address, arg4: &mut PublisherNodeVault, arg5: &0x2::clock::Clock, arg6: &UpgradeVersion) {
        assert!(arg6.version == 0, 2);
        assert!(arg3 != @0x0, 4);
        assert!(arg2 != 0, 5);
        let v0 = 0x1::vector::empty<PublisherNode>();
        let v1 = 0;
        while (v1 < arg2) {
            let v2 = PublisherNode{
                id             : 0x1::vector::pop_back<0x1::string::String>(&mut arg0),
                price          : arg1,
                locking_period : arg4.locking_period,
                owner_address  : arg3,
                timestamp      : 0x2::clock::timestamp_ms(arg5),
            };
            0x1::vector::push_back<PublisherNode>(&mut v0, v2);
            map_publisher_node(arg3, arg1, arg4, v2);
            v1 = v1 + 1;
        };
        let v3 = RegisteredPublisherNode{
            user        : arg3,
            no_of_nodes : arg2,
            nodes_data  : v0,
        };
        0x2::event::emit<RegisteredPublisherNode>(v3);
        let v4 = Staked{
            staker      : arg3,
            total_stake : *0x2::vec_map::get<address, u64>(&arg4.user_stake_info, &arg3),
        };
        0x2::event::emit<Staked>(v4);
    }

    public entry fun restake(arg0: &Owner, arg1: address, arg2: vector<0x1::string::String>, arg3: &mut PublisherNodeVault, arg4: &0x2::clock::Clock, arg5: &UpgradeVersion, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner_address == 0x2::tx_context::sender(arg6), 3);
        assert!(arg5.version == 0, 2);
        assert!(0x2::vec_map::contains<address, vector<0x1::string::String>>(&arg3.user_node_ids, &arg1), 6);
        let v0 = 0;
        let v1 = 0x2::clock::timestamp_ms(arg4);
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            let v2 = 0x1::vector::borrow<0x1::string::String>(&arg2, v0);
            assert!(0x2::vec_map::contains<0x1::string::String, PublisherNode>(&arg3.user_nodes_data, v2), 9);
            let v3 = 0x2::vec_map::get<0x1::string::String, PublisherNode>(&arg3.user_nodes_data, v2);
            assert!(v3.locking_period <= v1 - v3.timestamp, 7);
            let v4 = 0x2::vec_map::get_mut<0x1::string::String, PublisherNode>(&mut arg3.user_nodes_data, v2);
            v4.timestamp = v1;
            v4.locking_period = arg3.locking_period;
            v0 = v0 + 1;
        };
    }

    public entry fun stake(arg0: &Owner, arg1: address, arg2: 0x2::coin::Coin<0x212f28dbcb0aec4c7d65489844011cf892f01b13b3488052c89091cb54800ee2::hydro_token_test::HYDRO_TOKEN_TEST>, arg3: u64, arg4: vector<0x1::string::String>, arg5: &mut PublisherNodeVault, arg6: &0x2::clock::Clock, arg7: &UpgradeVersion, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x212f28dbcb0aec4c7d65489844011cf892f01b13b3488052c89091cb54800ee2::hydro_token_test::HYDRO_TOKEN_TEST>(&arg2);
        assert!(arg0.owner_address == 0x2::tx_context::sender(arg8), 3);
        assert!(arg7.version == 0, 2);
        assert!(0x1::vector::length<0x1::string::String>(&arg4) == arg3, 10);
        assert!(v0 != 0, 1);
        0x2::coin::join<0x212f28dbcb0aec4c7d65489844011cf892f01b13b3488052c89091cb54800ee2::hydro_token_test::HYDRO_TOKEN_TEST>(&mut arg5.total_staked, arg2);
        register_publisher_node(arg4, v0 / arg3, arg3, arg1, arg5, arg6, arg7);
    }

    public entry fun unstake(arg0: &Owner, arg1: address, arg2: &mut PublisherNodeVault, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &UpgradeVersion, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner_address == 0x2::tx_context::sender(arg6), 3);
        assert!(arg5.version == 0, 2);
        assert!(0x2::vec_map::contains<address, vector<0x1::string::String>>(&arg2.user_node_ids, &arg1), 6);
        let v0 = 0x2::vec_map::get_mut<address, vector<0x1::string::String>>(&mut arg2.user_node_ids, &arg1);
        let (_, v2) = 0x1::vector::index_of<0x1::string::String>(v0, &arg3);
        0x1::vector::remove<0x1::string::String>(v0, v2);
        assert!(0x2::vec_map::contains<0x1::string::String, PublisherNode>(&arg2.user_nodes_data, &arg3), 9);
        let v3 = 0x2::vec_map::get<0x1::string::String, PublisherNode>(&arg2.user_nodes_data, &arg3);
        assert!(v3.locking_period <= 0x2::clock::timestamp_ms(arg4) - v3.timestamp, 7);
        let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg2.user_stake_info, &arg1);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, PublisherNode>(&mut arg2.user_nodes_data, &arg3);
        0x2::vec_map::insert<address, u64>(&mut arg2.user_stake_info, arg1, *0x2::vec_map::get<address, u64>(&arg2.user_stake_info, &arg1) - v3.price);
    }

    entry fun upgrade_contract_version(arg0: &Owner, arg1: &mut UpgradeVersion, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner_address, 3);
        assert!(arg1.version < 0, 2);
        arg1.version = 0;
    }

    // decompiled from Move bytecode v6
}

