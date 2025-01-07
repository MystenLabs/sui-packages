module 0x7b3a7de13d964418ae657530ec7b706dd53d386790f5182fdd47f9e417f176d8::spool {
    struct SPoolAdminCap has key {
        id: 0x2::object::UID,
    }

    struct UserStake has drop, store {
        amount: u64,
    }

    struct SPoolStorage has key {
        id: 0x2::object::UID,
        wallet: address,
        users: 0x2::vec_map::VecMap<address, UserStake>,
    }

    struct StakeEvent has copy, drop {
        user_address: address,
        amount: u64,
    }

    struct UnstakeEvent has copy, drop {
        user_address: address,
        amount: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SPoolAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SPoolAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = SPoolStorage{
            id     : 0x2::object::new(arg0),
            wallet : @0xd5b23adeca3369d179ad70844704dad5f7b2c672f7d8ba79ae62402a9b5981e6,
            users  : 0x2::vec_map::empty<address, UserStake>(),
        };
        0x2::transfer::share_object<SPoolStorage>(v1);
    }

    public entry fun stake(arg0: &mut SPoolStorage, arg1: 0x2::coin::Coin<0x22000a5c0d6d2375b7ea4e51df4a54f793693d7ec868e72153d3088595ff9701::stsui::STSUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<0x22000a5c0d6d2375b7ea4e51df4a54f793693d7ec868e72153d3088595ff9701::stsui::STSUI>(&arg1);
        assert!(v1 > 0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x22000a5c0d6d2375b7ea4e51df4a54f793693d7ec868e72153d3088595ff9701::stsui::STSUI>>(arg1, arg0.wallet);
        if (!0x2::vec_map::contains<address, UserStake>(&arg0.users, &v0)) {
            let v2 = UserStake{amount: v1};
            0x2::vec_map::insert<address, UserStake>(&mut arg0.users, v0, v2);
        } else {
            let v3 = 0x2::vec_map::get_mut<address, UserStake>(&mut arg0.users, &v0);
            v3.amount = v3.amount + v1;
        };
        let v4 = StakeEvent{
            user_address : v0,
            amount       : v1,
        };
        0x2::event::emit<StakeEvent>(v4);
    }

    public entry fun transfer_ownership(arg0: SPoolAdminCap, arg1: address) {
        0x2::transfer::transfer<SPoolAdminCap>(arg0, arg1);
    }

    public entry fun update_wallet(arg0: &mut SPoolAdminCap, arg1: &mut SPoolStorage, arg2: address) {
        arg1.wallet = arg2;
    }

    // decompiled from Move bytecode v6
}

