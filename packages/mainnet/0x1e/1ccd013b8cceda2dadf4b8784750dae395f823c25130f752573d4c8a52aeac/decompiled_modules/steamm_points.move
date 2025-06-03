module 0xf4e0686b311e9b9d6da7e61fc42dae4254828f5ee3ded8ab5480ecd27e46ff08::steamm_points {
    struct SteammPointsManager<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin_id: 0x2::object::ID,
        balance: 0x2::balance::Balance<T0>,
        ratio: Ratio,
    }

    struct AdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        manager_id: 0x2::object::ID,
    }

    struct Ratio has copy, drop, store {
        numerator: u64,
        denominator: u64,
    }

    struct BurnEvent has copy, drop, store {
        manager_id: 0x2::object::ID,
        claim_amount: u64,
        points_burned: u64,
    }

    public fun new<T0: drop>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (SteammPointsManager<T0>, AdminCap<T0>) {
        let v0 = 0x2::object::new(arg2);
        let v1 = Ratio{
            numerator   : arg0,
            denominator : arg1,
        };
        let v2 = SteammPointsManager<T0>{
            id       : 0x2::object::new(arg2),
            version  : 0,
            admin_id : 0x2::object::uid_to_inner(&v0),
            balance  : 0x2::balance::zero<T0>(),
            ratio    : v1,
        };
        let v3 = AdminCap<T0>{
            id         : v0,
            manager_id : 0x2::object::uid_to_inner(&v2.id),
        };
        (v2, v3)
    }

    public(friend) fun assert_version<T0: drop>(arg0: &SteammPointsManager<T0>) {
        assert!(arg0.version == 0, 999);
    }

    public(friend) fun assert_version_and_upgrade<T0: drop>(arg0: &mut SteammPointsManager<T0>) {
        if (arg0.version < 0) {
            arg0.version = 0;
        };
        assert_version<T0>(arg0);
    }

    public fun burn_points<T0: drop>(arg0: &mut SteammPointsManager<T0>, arg1: 0x2::coin::Coin<0xd86d5f22641acb7a2880b3884bfe8e98bf3f8e74af3e38fb3eec7b758766d628::steamm_point::STEAMM_POINT>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version_and_upgrade<T0>(arg0);
        let v0 = arg0.ratio;
        let v1 = 0x2::coin::value<0xd86d5f22641acb7a2880b3884bfe8e98bf3f8e74af3e38fb3eec7b758766d628::steamm_point::STEAMM_POINT>(&arg1) * v0.numerator / v0.denominator;
        assert!(v1 <= 0x2::balance::value<T0>(&arg0.balance), 1);
        let v2 = BurnEvent{
            manager_id    : 0x2::object::uid_to_inner(&arg0.id),
            claim_amount  : v1,
            points_burned : 0x2::coin::value<0xd86d5f22641acb7a2880b3884bfe8e98bf3f8e74af3e38fb3eec7b758766d628::steamm_point::STEAMM_POINT>(&arg1),
        };
        0x2::event::emit<BurnEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd86d5f22641acb7a2880b3884bfe8e98bf3f8e74af3e38fb3eec7b758766d628::steamm_point::STEAMM_POINT>>(arg1, @0x0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v1), arg2)
    }

    public fun destroy<T0: drop>(arg0: AdminCap<T0>, arg1: SteammPointsManager<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = &mut arg1;
        assert_version_and_upgrade<T0>(v0);
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.admin_id, 0);
        assert!(arg0.manager_id == 0x2::object::uid_to_inner(&arg1.id), 0);
        let SteammPointsManager {
            id       : v1,
            version  : _,
            admin_id : _,
            balance  : v4,
            ratio    : _,
        } = arg1;
        0x2::object::delete(v1);
        let AdminCap {
            id         : v6,
            manager_id : _,
        } = arg0;
        0x2::object::delete(v6);
        0x2::coin::from_balance<T0>(v4, arg2)
    }

    public fun fund<T0: drop>(arg0: &AdminCap<T0>, arg1: &mut SteammPointsManager<T0>, arg2: 0x2::coin::Coin<T0>) {
        assert_version_and_upgrade<T0>(arg1);
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.admin_id, 0);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun migrate<T0: drop>(arg0: &AdminCap<T0>, arg1: &mut SteammPointsManager<T0>) {
        assert!(arg1.version < 0, 999);
        arg1.version = 0;
    }

    // decompiled from Move bytecode v6
}

