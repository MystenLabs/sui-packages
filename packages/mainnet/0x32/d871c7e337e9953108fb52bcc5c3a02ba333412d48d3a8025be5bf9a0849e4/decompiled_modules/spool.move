module 0x32d871c7e337e9953108fb52bcc5c3a02ba333412d48d3a8025be5bf9a0849e4::spool {
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
            wallet : @0x7abdad57cc5295f21f24a1dbfa9dbb4be22db002f0fd4494a4ae52db5ad8c23f,
            users  : 0x2::vec_map::empty<address, UserStake>(),
        };
        0x2::transfer::share_object<SPoolStorage>(v1);
    }

    public entry fun stake(arg0: &mut SPoolStorage, arg1: 0x2::coin::Coin<0xeb7a52ef523ec5099354a1ea4ada501f891323fe4d299085da5c0b7de5218c26::stsui::STSUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<0xeb7a52ef523ec5099354a1ea4ada501f891323fe4d299085da5c0b7de5218c26::stsui::STSUI>(&arg1);
        assert!(v1 > 0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xeb7a52ef523ec5099354a1ea4ada501f891323fe4d299085da5c0b7de5218c26::stsui::STSUI>>(arg1, arg0.wallet);
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

