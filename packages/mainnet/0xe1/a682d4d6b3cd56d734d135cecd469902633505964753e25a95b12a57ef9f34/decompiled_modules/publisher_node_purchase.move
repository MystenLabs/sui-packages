module 0xe1a682d4d6b3cd56d734d135cecd469902633505964753e25a95b12a57ef9f34::publisher_node_purchase {
    struct PUBLISHER_NODE_PURCHASE has drop {
        dummy_field: bool,
    }

    struct Owner has store, key {
        id: 0x2::object::UID,
        owner_address: address,
    }

    struct PublisherDetails has store, key {
        id: 0x2::object::UID,
        user_details: 0x2::vec_map::VecMap<address, 0x2::vec_map::VecMap<0x1::string::String, NodeDetails>>,
    }

    struct PublisherNodesDetails has store, key {
        id: 0x2::object::UID,
        publisher_nodes: u64,
        total_publisher_node: u64,
    }

    struct NodeDetails has store {
        node_ids: vector<u64>,
        node_count: u64,
    }

    struct MaintainerRole has store, key {
        id: 0x2::object::UID,
        has_maintainer_access: 0x2::vec_set::VecSet<address>,
    }

    struct UpgradeVersion has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct CoinWrapper has store, key {
        id: 0x2::object::UID,
        coin: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    struct ChangedOwner has copy, drop {
        current_owner: address,
        new_owner: address,
    }

    struct RevertedAmount has copy, drop {
        amount: u64,
        user_address: address,
    }

    struct MaintainerRoleRevoked has copy, drop {
        revoke_address: address,
    }

    struct MaintainerRoleGranted has copy, drop {
        recipient: address,
    }

    struct GeneratePublisherNodes has copy, drop {
        node_ids: vector<u64>,
        website_id: 0x1::string::String,
        node_count: u64,
        user_address: address,
    }

    struct RemovePublisherNodes has copy, drop {
        node_ids: vector<u64>,
        website_id: 0x1::string::String,
        user_address: address,
    }

    struct PublisherPayment has copy, drop {
        amount: u64,
        website_id: 0x1::string::String,
        node_count: u64,
        publisher_id: 0x1::string::String,
    }

    struct Transfer has copy, drop {
        admin_address: address,
        amount: u64,
    }

    public entry fun transfer(arg0: &MaintainerRole, arg1: &mut CoinWrapper, arg2: address, arg3: &UpgradeVersion, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg3.version == 0, 2);
        assert!(0x2::vec_set::contains<address>(&arg0.has_maintainer_access, &v0), 11);
        assert!(@0x0 != arg2, 3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1.coin);
        assert!(v1 != 0, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1.coin, v1, arg4), arg2);
        let v2 = Transfer{
            admin_address : arg2,
            amount        : v1,
        };
        0x2::event::emit<Transfer>(v2);
    }

    fun add_website_detail(arg0: u64, arg1: address, arg2: u64, arg3: &mut PublisherNodesDetails, arg4: &mut 0x2::vec_map::VecMap<0x1::string::String, NodeDetails>, arg5: 0x1::string::String) : u64 {
        let v0 = 0;
        let v1 = 0x1::vector::empty<u64>();
        while (v0 < arg0) {
            let v2 = 0x2::vec_map::get_mut<0x1::string::String, NodeDetails>(arg4, &arg5);
            0x1::vector::push_back<u64>(&mut v2.node_ids, arg2 + 1);
            0x1::vector::push_back<u64>(&mut v1, arg2 + 1);
            arg2 = arg2 + 1;
            arg3.total_publisher_node = arg3.total_publisher_node + 1;
            v2.node_count = v2.node_count + 1;
            v0 = v0 + 1;
        };
        let v3 = GeneratePublisherNodes{
            node_ids     : v1,
            website_id   : arg5,
            node_count   : arg0,
            user_address : arg1,
        };
        0x2::event::emit<GeneratePublisherNodes>(v3);
        arg2
    }

    public entry fun change_owner(arg0: Owner, arg1: &mut MaintainerRole, arg2: address, arg3: &UpgradeVersion, arg4: 0x2::package::UpgradeCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.owner_address;
        assert!(arg3.version == 0, 2);
        assert!(@0x0 != arg2, 3);
        assert!(0x2::tx_context::sender(arg5) == v0, 1);
        assert!(arg2 != v0, 4);
        0x2::vec_set::remove<address>(&mut arg1.has_maintainer_access, &v0);
        0x2::vec_set::insert<address>(&mut arg1.has_maintainer_access, arg2);
        arg0.owner_address = arg2;
        0x2::transfer::public_transfer<Owner>(arg0, arg2);
        0x2::transfer::public_transfer<0x2::package::UpgradeCap>(arg4, arg2);
        let v1 = ChangedOwner{
            current_owner : v0,
            new_owner     : arg2,
        };
        0x2::event::emit<ChangedOwner>(v1);
    }

    public entry fun generate_publisher_node_ids(arg0: &MaintainerRole, arg1: &mut PublisherDetails, arg2: address, arg3: 0x1::string::String, arg4: u64, arg5: &mut PublisherNodesDetails, arg6: &UpgradeVersion, arg7: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(@0x0 != arg2, 3);
        assert!(0x2::vec_set::contains<address>(&arg0.has_maintainer_access, &v0), 11);
        assert!(arg4 != 0, 6);
        assert!(arg6.version == 0, 2);
        if (0x2::vec_map::contains<address, 0x2::vec_map::VecMap<0x1::string::String, NodeDetails>>(&arg1.user_details, &arg2)) {
            let v1 = 0x2::vec_map::get_mut<address, 0x2::vec_map::VecMap<0x1::string::String, NodeDetails>>(&mut arg1.user_details, &arg2);
            if (0x2::vec_map::contains<0x1::string::String, NodeDetails>(v1, &arg3)) {
                let v2 = arg5.publisher_nodes;
                let v3 = add_website_detail(arg4, arg2, v2, arg5, v1, arg3);
                arg5.publisher_nodes = v3;
            } else {
                let v4 = NodeDetails{
                    node_ids   : 0x1::vector::empty<u64>(),
                    node_count : 0,
                };
                0x2::vec_map::insert<0x1::string::String, NodeDetails>(v1, arg3, v4);
                let v5 = arg5.publisher_nodes;
                let v6 = add_website_detail(arg4, arg2, v5, arg5, v1, arg3);
                arg5.publisher_nodes = v6;
            };
        } else {
            let v7 = 0x2::vec_map::empty<0x1::string::String, NodeDetails>();
            let v8 = NodeDetails{
                node_ids   : 0x1::vector::empty<u64>(),
                node_count : 0,
            };
            0x2::vec_map::insert<0x1::string::String, NodeDetails>(&mut v7, arg3, v8);
            let v9 = arg5.publisher_nodes;
            let v10 = &mut v7;
            let v11 = add_website_detail(arg4, arg2, v9, arg5, v10, arg3);
            arg5.publisher_nodes = v11;
            0x2::vec_map::insert<address, 0x2::vec_map::VecMap<0x1::string::String, NodeDetails>>(&mut arg1.user_details, arg2, v7);
        };
    }

    public entry fun grant_maintainer_role(arg0: &Owner, arg1: &mut MaintainerRole, arg2: &UpgradeVersion, arg3: address, arg4: &0x2::tx_context::TxContext) {
        assert!(arg2.version == 0, 2);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner_address, 1);
        assert!(@0x0 != arg3, 3);
        assert!(!0x2::vec_set::contains<address>(&arg1.has_maintainer_access, &arg3), 12);
        0x2::vec_set::insert<address>(&mut arg1.has_maintainer_access, arg3);
        let v0 = MaintainerRoleGranted{recipient: arg3};
        0x2::event::emit<MaintainerRoleGranted>(v0);
    }

    fun init(arg0: PUBLISHER_NODE_PURCHASE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = Owner{
            id            : 0x2::object::new(arg1),
            owner_address : v0,
        };
        0x2::transfer::public_transfer<Owner>(v1, v0);
        let v2 = UpgradeVersion{
            id      : 0x2::object::new(arg1),
            version : 0,
        };
        0x2::transfer::share_object<UpgradeVersion>(v2);
        let v3 = CoinWrapper{
            id   : 0x2::object::new(arg1),
            coin : 0x2::coin::zero<0x2::sui::SUI>(arg1),
        };
        0x2::transfer::share_object<CoinWrapper>(v3);
        let v4 = PublisherDetails{
            id           : 0x2::object::new(arg1),
            user_details : 0x2::vec_map::empty<address, 0x2::vec_map::VecMap<0x1::string::String, NodeDetails>>(),
        };
        0x2::transfer::share_object<PublisherDetails>(v4);
        let v5 = PublisherNodesDetails{
            id                   : 0x2::object::new(arg1),
            publisher_nodes      : 0,
            total_publisher_node : 0,
        };
        0x2::transfer::share_object<PublisherNodesDetails>(v5);
        let v6 = MaintainerRole{
            id                    : 0x2::object::new(arg1),
            has_maintainer_access : 0x2::vec_set::empty<address>(),
        };
        0x2::vec_set::insert<address>(&mut v6.has_maintainer_access, v0);
        0x2::transfer::share_object<MaintainerRole>(v6);
    }

    public entry fun publisher_payment(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut CoinWrapper, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &UpgradeVersion, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(arg5.version == 0, 2);
        assert!(arg4 != 0, 6);
        assert!(v0 != 0, 5);
        0x2::coin::join<0x2::sui::SUI>(&mut arg1.coin, arg0);
        let v1 = PublisherPayment{
            amount       : v0,
            website_id   : arg2,
            node_count   : arg4,
            publisher_id : arg3,
        };
        0x2::event::emit<PublisherPayment>(v1);
    }

    public entry fun remove_publisher_node_ids(arg0: &MaintainerRole, arg1: &mut PublisherDetails, arg2: &mut PublisherNodesDetails, arg3: address, arg4: vector<u64>, arg5: 0x1::string::String, arg6: &UpgradeVersion, arg7: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(@0x0 != arg3, 3);
        assert!(0x2::vec_set::contains<address>(&arg0.has_maintainer_access, &v0), 11);
        assert!(arg6.version == 0, 2);
        assert!(0x2::vec_map::contains<address, 0x2::vec_map::VecMap<0x1::string::String, NodeDetails>>(&arg1.user_details, &arg3), 8);
        let v1 = 0x2::vec_map::get_mut<address, 0x2::vec_map::VecMap<0x1::string::String, NodeDetails>>(&mut arg1.user_details, &arg3);
        assert!(0x2::vec_map::contains<0x1::string::String, NodeDetails>(v1, &arg5), 9);
        let v2 = 0x2::vec_map::get_mut<0x1::string::String, NodeDetails>(v1, &arg5);
        let v3 = 0;
        let v4 = 0x1::vector::length<u64>(&arg4);
        while (v3 < v4) {
            let v5 = *0x1::vector::borrow<u64>(&arg4, v3);
            assert!(0x1::vector::contains<u64>(&v2.node_ids, &v5), 10);
            let (v6, v7) = 0x1::vector::index_of<u64>(&v2.node_ids, &v5);
            if (v6) {
                0x1::vector::remove<u64>(&mut v2.node_ids, v7);
            };
            v3 = v3 + 1;
        };
        arg2.publisher_nodes = arg2.publisher_nodes - v4;
        v2.node_count = v2.node_count - v4;
        let v8 = RemovePublisherNodes{
            node_ids     : arg4,
            website_id   : arg5,
            user_address : arg3,
        };
        0x2::event::emit<RemovePublisherNodes>(v8);
    }

    public entry fun revert(arg0: &MaintainerRole, arg1: &mut CoinWrapper, arg2: u64, arg3: address, arg4: &UpgradeVersion, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1.coin);
        assert!(v1 != 0, 5);
        assert!(arg2 != 0, 6);
        assert!(arg2 < v1, 7);
        assert!(arg4.version == 0, 2);
        assert!(0x2::vec_set::contains<address>(&arg0.has_maintainer_access, &v0), 11);
        assert!(@0x0 != arg3, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1.coin, arg2, arg5), arg3);
        let v2 = RevertedAmount{
            amount       : arg2,
            user_address : arg3,
        };
        0x2::event::emit<RevertedAmount>(v2);
    }

    public entry fun revoke_maintainer_role(arg0: &Owner, arg1: &mut MaintainerRole, arg2: &UpgradeVersion, arg3: address, arg4: &0x2::tx_context::TxContext) {
        assert!(arg2.version == 0, 2);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner_address, 1);
        assert!(@0x0 != arg3, 3);
        assert!(0x2::vec_set::contains<address>(&arg1.has_maintainer_access, &arg3), 11);
        assert!(arg3 != arg0.owner_address, 13);
        0x2::vec_set::remove<address>(&mut arg1.has_maintainer_access, &arg3);
        let v0 = MaintainerRoleRevoked{revoke_address: arg3};
        0x2::event::emit<MaintainerRoleRevoked>(v0);
    }

    entry fun upgrade_contract_version(arg0: &Owner, arg1: &mut UpgradeVersion, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner_address, 1);
        assert!(arg1.version < 0, 2);
        arg1.version = 0;
    }

    // decompiled from Move bytecode v6
}

