module 0x46884ecb2001a4c101dc96909caf268f078b252434584c1a371404927861d204::hop {
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

    struct AcceptedPayment has copy, drop {
        node_ids: vector<u64>,
        website_id: 0x1::string::String,
        node_count: u64,
        user_address: address,
    }

    struct PublisherPaymentEvent has copy, drop {
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

    public entry fun accept_payment(arg0: &Owner, arg1: &mut PublisherDetails, arg2: address, arg3: 0x1::string::String, arg4: u64, arg5: &UpgradeVersion, arg6: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.owner_address, 1);
        assert!(arg5.version == 0, 2);
        if (0x2::vec_map::contains<address, 0x2::vec_map::VecMap<0x1::string::String, NodeDetails>>(&arg1.user_details, &arg2)) {
            let v0 = 0x2::vec_map::get_mut<address, 0x2::vec_map::VecMap<0x1::string::String, NodeDetails>>(&mut arg1.user_details, &arg2);
            if (0x2::vec_map::contains<0x1::string::String, NodeDetails>(v0, &arg3)) {
                let v1 = 0;
                let v2 = 0x2::vec_map::get_mut<0x1::string::String, NodeDetails>(v0, &arg3);
                while (v1 < arg4) {
                    0x1::vector::push_back<u64>(&mut v2.node_ids, arg1.total_publisher_nodes + 1);
                    arg1.total_publisher_nodes = arg1.total_publisher_nodes + 1;
                    v1 = v1 + 1;
                };
            } else {
                let v3 = NodeDetails{
                    node_ids   : 0x1::vector::empty<u64>(),
                    node_count : 0,
                };
                0x2::vec_map::insert<0x1::string::String, NodeDetails>(v0, arg3, v3);
                arg1.total_publisher_nodes = add_website_detail(arg4, arg1.total_publisher_nodes, v0, arg3);
            };
        } else {
            let v4 = 0x2::vec_map::empty<0x1::string::String, NodeDetails>();
            let v5 = NodeDetails{
                node_ids   : 0x1::vector::empty<u64>(),
                node_count : 0,
            };
            0x2::vec_map::insert<0x1::string::String, NodeDetails>(&mut v4, arg3, v5);
            let v6 = &mut v4;
            arg1.total_publisher_nodes = add_website_detail(arg4, arg1.total_publisher_nodes, v6, arg3);
            0x2::vec_map::insert<address, 0x2::vec_map::VecMap<0x1::string::String, NodeDetails>>(&mut arg1.user_details, arg2, v4);
        };
        let v7 = AcceptedPayment{
            node_ids     : 0x2::vec_map::get<0x1::string::String, NodeDetails>(0x2::vec_map::get<address, 0x2::vec_map::VecMap<0x1::string::String, NodeDetails>>(&arg1.user_details, &arg2), &arg3).node_ids,
            website_id   : arg3,
            node_count   : arg4,
            user_address : arg2,
        };
        0x2::event::emit<AcceptedPayment>(v7);
    }

    fun add_website_detail(arg0: u64, arg1: u64, arg2: &mut 0x2::vec_map::VecMap<0x1::string::String, NodeDetails>, arg3: 0x1::string::String) : u64 {
        let v0 = 0;
        while (v0 < arg0) {
            let v1 = 0x2::vec_map::get_mut<0x1::string::String, NodeDetails>(arg2, &arg3);
            0x1::vector::push_back<u64>(&mut v1.node_ids, arg1 + 1);
            arg1 = arg1 + 1;
            v1.node_count = v1.node_count + 1;
            v0 = v0 + 1;
        };
        arg1
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
        assert!(v0 != 0, 5);
        0x2::coin::join<0x2::sui::SUI>(&mut arg1.coin, arg0);
        let v1 = PublisherPaymentEvent{
            amount     : v0,
            website_id : arg2,
            node_count : arg3,
        };
        0x2::event::emit<PublisherPaymentEvent>(v1);
    }

    public entry fun revert(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &UpgradeVersion, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(arg2.version == 0, 2);
        assert!(v0 != 0, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
        let v1 = RevertedAmount{
            amount       : v0,
            user_address : arg1,
        };
        0x2::event::emit<RevertedAmount>(v1);
    }

    entry fun upgrade_contract_version(arg0: &Owner, arg1: &mut UpgradeVersion, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner_address, 1);
        assert!(arg1.version < 0, 2);
        arg1.version = 0;
    }

    // decompiled from Move bytecode v6
}

