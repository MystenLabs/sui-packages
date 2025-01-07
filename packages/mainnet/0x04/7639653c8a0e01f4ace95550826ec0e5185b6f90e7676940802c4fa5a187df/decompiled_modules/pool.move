module 0x47639653c8a0e01f4ace95550826ec0e5185b6f90e7676940802c4fa5a187df::pool {
    struct PoolAdminCap has key {
        id: 0x2::object::UID,
    }

    struct UserStake has drop, store {
        amount: u64,
    }

    struct PoolStorage has key {
        id: 0x2::object::UID,
        wallet: address,
        users: 0x2::vec_map::VecMap<address, UserStake>,
    }

    struct StakeEvent has copy, drop {
        user_address: address,
        amount: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PoolAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = PoolStorage{
            id     : 0x2::object::new(arg0),
            wallet : @0x7abdad57cc5295f21f24a1dbfa9dbb4be22db002f0fd4494a4ae52db5ad8c23f,
            users  : 0x2::vec_map::empty<address, UserStake>(),
        };
        0x2::transfer::share_object<PoolStorage>(v1);
    }

    public entry fun stake(arg0: &mut PoolStorage, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 > 0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.wallet);
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

    public entry fun transfer_ownership(arg0: PoolAdminCap, arg1: address) {
        0x2::transfer::transfer<PoolAdminCap>(arg0, arg1);
    }

    public entry fun update_wallet(arg0: &mut PoolAdminCap, arg1: &mut PoolStorage, arg2: address) {
        arg1.wallet = arg2;
    }

    // decompiled from Move bytecode v6
}

