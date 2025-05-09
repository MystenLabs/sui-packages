module 0x55ab71dd81288556e39036109793e319beebece6b4093cc227d143a3fa29504e::auctionhouse {
    struct AuctionHouse has key {
        id: 0x2::object::UID,
        fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        owner: address,
        admins: vector<address>,
    }

    struct FeesWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct AdminAdded has copy, drop {
        admin: address,
    }

    struct AdminRemoved has copy, drop {
        admin: address,
    }

    struct AuctionHouseCreated has copy, drop {
        owner: address,
    }

    public entry fun add_admin(arg0: &mut AuctionHouse, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        let (v0, _) = 0x1::vector::index_of<address>(&arg0.admins, &arg1);
        if (!v0) {
            0x1::vector::push_back<address>(&mut arg0.admins, arg1);
            let v2 = AdminAdded{admin: arg1};
            0x2::event::emit<AdminAdded>(v2);
        };
    }

    public fun add_fee(arg0: &mut AuctionHouse, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_balance, arg1);
    }

    public fun get_owner(arg0: &AuctionHouse) : address {
        arg0.owner
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, v0);
        let v2 = AuctionHouse{
            id          : 0x2::object::new(arg0),
            fee_balance : 0x2::balance::zero<0x2::sui::SUI>(),
            owner       : v0,
            admins      : v1,
        };
        let v3 = AuctionHouseCreated{owner: v0};
        0x2::event::emit<AuctionHouseCreated>(v3);
        0x2::transfer::share_object<AuctionHouse>(v2);
    }

    public fun is_admin(arg0: &AuctionHouse, arg1: address) : bool {
        let (v0, _) = 0x1::vector::index_of<address>(&arg0.admins, &arg1);
        v0
    }

    public entry fun remove_admin(arg0: &mut AuctionHouse, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.admins, &arg1);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.admins, v1);
            let v2 = AdminRemoved{admin: arg1};
            0x2::event::emit<AdminRemoved>(v2);
        };
    }

    public entry fun update_owner(arg0: &mut AuctionHouse, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.owner = arg1;
    }

    public entry fun withdraw_fees(arg0: &mut AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.fee_balance);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.fee_balance, v0), arg1), arg0.owner);
        let v1 = FeesWithdrawn{
            amount    : v0,
            recipient : arg0.owner,
        };
        0x2::event::emit<FeesWithdrawn>(v1);
    }

    // decompiled from Move bytecode v6
}

