module 0x3615c20d2375363f642d99cec657e69799b118d580f115760c731f0568900770::points {
    struct PointsManager<phantom T0> has store, key {
        id: 0x2::object::UID,
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

    public fun new<T0: drop>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (PointsManager<T0>, AdminCap<T0>) {
        let v0 = 0x2::object::new(arg2);
        let v1 = Ratio{
            numerator   : arg0,
            denominator : arg1,
        };
        let v2 = PointsManager<T0>{
            id       : 0x2::object::new(arg2),
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

    public fun burn_points<T0: drop>(arg0: &mut PointsManager<T0>, arg1: 0x2::coin::Coin<0x86f166ac3a336248929979d19252c12170b8dce87e5e71004e35c49ece02c247::suilend_point::SUILEND_POINT>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = arg0.ratio;
        let v1 = 0x2::coin::value<0x86f166ac3a336248929979d19252c12170b8dce87e5e71004e35c49ece02c247::suilend_point::SUILEND_POINT>(&arg1) * v0.numerator / v0.denominator;
        assert!(v1 <= 0x2::balance::value<T0>(&arg0.balance), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x86f166ac3a336248929979d19252c12170b8dce87e5e71004e35c49ece02c247::suilend_point::SUILEND_POINT>>(arg1, @0x0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v1), arg2)
    }

    public fun destroy<T0: drop>(arg0: AdminCap<T0>, arg1: PointsManager<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.admin_id, 0);
        assert!(arg0.manager_id == 0x2::object::uid_to_inner(&arg1.id), 0);
        let PointsManager {
            id       : v0,
            admin_id : _,
            balance  : v2,
            ratio    : _,
        } = arg1;
        0x2::object::delete(v0);
        let AdminCap {
            id         : v4,
            manager_id : _,
        } = arg0;
        0x2::object::delete(v4);
        0x2::coin::from_balance<T0>(v2, arg2)
    }

    public fun fund<T0: drop>(arg0: &AdminCap<T0>, arg1: &mut PointsManager<T0>, arg2: 0x2::coin::Coin<T0>) {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.admin_id, 0);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg2));
    }

    // decompiled from Move bytecode v6
}

