module 0x6f02b2206c0323f3d70fd7e00856700b445aab49862612fd3aa776b378d4e8ea::hop {
    struct HOP has drop {
        dummy_field: bool,
    }

    struct Owner has store, key {
        id: 0x2::object::UID,
        owner_address: address,
    }

    struct PublisherDetails has store, key {
        id: 0x2::object::UID,
        total_publisher_nodes: u64,
        user_details: 0x2::vec_map::VecMap<address, 0x2::vec_map::VecMap<0x1::string::String, NodeDetails>>,
    }

    struct NodeDetails has store {
        node_ids: vector<u64>,
        node_count: u64,
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

    struct GeneratePublisherNodes has copy, drop {
        node_ids: vector<u64>,
        website_id: 0x1::string::String,
        node_count: u64,
        user_address: address,
    }

    struct PublisherPayment has copy, drop {
        amount: u64,
        website_id: 0x1::string::String,
        node_count: u64,
    }

    struct Transfer has copy, drop {
        admin_address: address,
        amount: u64,
    }

    public entry fun transfer(arg0: &Owner, arg1: &mut CoinWrapper, arg2: address, arg3: &UpgradeVersion, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.version == 0, 2);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner_address, 1);
        assert!(@0x0 != arg2, 3);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1.coin);
        assert!(v0 != 0, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1.coin, v0, arg4), arg2);
        let v1 = Transfer{
            admin_address : arg2,
            amount        : v0,
        };
        0x2::event::emit<Transfer>(v1);
    }

    fun add_website_detail(arg0: u64, arg1: address, arg2: u64, arg3: &mut 0x2::vec_map::VecMap<0x1::string::String, NodeDetails>, arg4: 0x1::string::String) : u64 {
        let v0 = 0;
        let v1 = 0x1::vector::empty<u64>();
        while (v0 < arg0) {
            let v2 = 0x2::vec_map::get_mut<0x1::string::String, NodeDetails>(arg3, &arg4);
            0x1::vector::push_back<u64>(&mut v2.node_ids, arg2 + 1);
            0x1::vector::push_back<u64>(&mut v1, arg2 + 1);
            arg2 = arg2 + 1;
            v2.node_count = v2.node_count + 1;
            v0 = v0 + 1;
        };
        let v3 = GeneratePublisherNodes{
            node_ids     : v1,
            website_id   : arg4,
            node_count   : arg0,
            user_address : arg1,
        };
        0x2::event::emit<GeneratePublisherNodes>(v3);
        arg2
    }

    public entry fun change_owner(arg0: Owner, arg1: address, arg2: &UpgradeVersion, arg3: 0x2::package::UpgradeCap, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.owner_address;
        assert!(arg2.version == 0, 2);
        assert!(@0x0 != arg1, 3);
        assert!(0x2::tx_context::sender(arg4) == v0, 1);
        assert!(arg1 != v0, 4);
        arg0.owner_address = arg1;
        0x2::transfer::public_transfer<Owner>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::package::UpgradeCap>(arg3, arg1);
        let v1 = ChangedOwner{
            current_owner : v0,
            new_owner     : arg1,
        };
        0x2::event::emit<ChangedOwner>(v1);
    }

    public entry fun generate_publisher_node_ids(arg0: &Owner, arg1: &mut PublisherDetails, arg2: address, arg3: 0x1::string::String, arg4: u64, arg5: &UpgradeVersion, arg6: &0x2::tx_context::TxContext) {
        assert!(@0x0 != arg2, 3);
        assert!(0x2::tx_context::sender(arg6) == arg0.owner_address, 1);
        assert!(arg4 != 0, 6);
        assert!(arg5.version == 0, 2);
        if (0x2::vec_map::contains<address, 0x2::vec_map::VecMap<0x1::string::String, NodeDetails>>(&arg1.user_details, &arg2)) {
            let v0 = 0x2::vec_map::get_mut<address, 0x2::vec_map::VecMap<0x1::string::String, NodeDetails>>(&mut arg1.user_details, &arg2);
            if (0x2::vec_map::contains<0x1::string::String, NodeDetails>(v0, &arg3)) {
                arg1.total_publisher_nodes = add_website_detail(arg4, arg2, arg1.total_publisher_nodes, v0, arg3);
            } else {
                let v1 = NodeDetails{
                    node_ids   : 0x1::vector::empty<u64>(),
                    node_count : 0,
                };
                0x2::vec_map::insert<0x1::string::String, NodeDetails>(v0, arg3, v1);
                arg1.total_publisher_nodes = add_website_detail(arg4, arg2, arg1.total_publisher_nodes, v0, arg3);
            };
        } else {
            let v2 = 0x2::vec_map::empty<0x1::string::String, NodeDetails>();
            let v3 = NodeDetails{
                node_ids   : 0x1::vector::empty<u64>(),
                node_count : 0,
            };
            0x2::vec_map::insert<0x1::string::String, NodeDetails>(&mut v2, arg3, v3);
            let v4 = &mut v2;
            arg1.total_publisher_nodes = add_website_detail(arg4, arg2, arg1.total_publisher_nodes, v4, arg3);
            0x2::vec_map::insert<address, 0x2::vec_map::VecMap<0x1::string::String, NodeDetails>>(&mut arg1.user_details, arg2, v2);
        };
    }

    fun init(arg0: HOP, arg1: &mut 0x2::tx_context::TxContext) {
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
            id                    : 0x2::object::new(arg1),
            total_publisher_nodes : 0,
            user_details          : 0x2::vec_map::empty<address, 0x2::vec_map::VecMap<0x1::string::String, NodeDetails>>(),
        };
        0x2::transfer::share_object<PublisherDetails>(v4);
    }

    public entry fun publisher_payment(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut CoinWrapper, arg2: 0x1::string::String, arg3: u64, arg4: &UpgradeVersion, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(arg4.version == 0, 2);
        assert!(arg3 != 0, 6);
        assert!(v0 != 0, 5);
        0x2::coin::join<0x2::sui::SUI>(&mut arg1.coin, arg0);
        let v1 = PublisherPayment{
            amount     : v0,
            website_id : arg2,
            node_count : arg3,
        };
        0x2::event::emit<PublisherPayment>(v1);
    }

    public entry fun revert(arg0: &Owner, arg1: &mut CoinWrapper, arg2: u64, arg3: address, arg4: &UpgradeVersion, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1.coin) != 0, 5);
        assert!(arg4.version == 0, 2);
        assert!(0x2::tx_context::sender(arg5) == arg0.owner_address, 1);
        assert!(@0x0 != arg3, 3);
        assert!(arg2 != 0, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1.coin, arg2, arg5), arg3);
        let v0 = RevertedAmount{
            amount       : arg2,
            user_address : arg3,
        };
        0x2::event::emit<RevertedAmount>(v0);
    }

    entry fun upgrade_contract_version(arg0: &Owner, arg1: &mut UpgradeVersion, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner_address, 1);
        assert!(arg1.version < 0, 2);
        arg1.version = 0;
    }

    // decompiled from Move bytecode v6
}

