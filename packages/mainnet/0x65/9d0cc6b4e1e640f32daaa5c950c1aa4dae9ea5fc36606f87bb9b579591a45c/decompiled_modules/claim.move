module 0x659d0cc6b4e1e640f32daaa5c950c1aa4dae9ea5fc36606f87bb9b579591a45c::claim {
    struct GlobalStorage has key {
        id: 0x2::object::UID,
        pools: 0x2::object_bag::ObjectBag,
    }

    struct ClaimPool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        total_burn_coin: u64,
        fixed_sale_amount: u64,
        burn_coin: 0x2::balance::Balance<T0>,
        claim_coin: 0x2::balance::Balance<T1>,
    }

    struct ClaimBSWTAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct EventRegisterPool<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        total_burn_coin: u64,
        fixed_sale_amount: u64,
        claim_coin_amount: u64,
    }

    public entry fun claim<T0, T1>(arg0: &mut GlobalStorage, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 10003);
        let v1 = borrow_mut_pool<T0, T1>(arg0);
        0x2::balance::join<T0>(&mut v1.burn_coin, 0x2::coin::into_balance<T0>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut v1.claim_coin, v1.fixed_sale_amount / v1.total_burn_coin / v0, arg2), 0x2::tx_context::sender(arg2));
    }

    fun borrow_mut_pool<T0, T1>(arg0: &mut GlobalStorage) : &mut ClaimPool<T0, T1> {
        0x2::object_bag::borrow_mut<0x1::type_name::TypeName, ClaimPool<T0, T1>>(&mut arg0.pools, 0x1::type_name::get<ClaimPool<T0, T1>>())
    }

    public fun emergency_withdraw<T0, T1>(arg0: &ClaimBSWTAdminCap, arg1: &mut GlobalStorage, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = borrow_mut_pool<T0, T1>(arg1);
        (0x2::coin::take<T0>(&mut v0.burn_coin, 0x2::balance::value<T0>(&v0.burn_coin), arg2), 0x2::coin::take<T1>(&mut v0.claim_coin, 0x2::balance::value<T1>(&mut v0.claim_coin), arg2))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ClaimBSWTAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<ClaimBSWTAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GlobalStorage{
            id    : 0x2::object::new(arg0),
            pools : 0x2::object_bag::new(arg0),
        };
        0x2::transfer::share_object<GlobalStorage>(v1);
    }

    public entry fun register_pool<T0, T1>(arg0: &ClaimBSWTAdminCap, arg1: &mut GlobalStorage, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 10001);
        assert!(!0x2::object_bag::contains<0x1::type_name::TypeName>(&arg1.pools, 0x1::type_name::get<ClaimPool<T0, T1>>()), 10002);
        let v0 = 0x2::coin::value<T1>(&arg3);
        assert!(v0 > 0, 10004);
        let v1 = ClaimPool<T0, T1>{
            id                : 0x2::object::new(arg4),
            total_burn_coin   : arg2,
            fixed_sale_amount : v0,
            burn_coin         : 0x2::balance::zero<T0>(),
            claim_coin        : 0x2::coin::into_balance<T1>(arg3),
        };
        0x2::object_bag::add<0x1::type_name::TypeName, ClaimPool<T0, T1>>(&mut arg1.pools, 0x1::type_name::get<ClaimPool<T0, T1>>(), v1);
        let v2 = EventRegisterPool<T0, T1>{
            pool_id           : 0x2::object::uid_to_inner(&v1.id),
            total_burn_coin   : arg2,
            fixed_sale_amount : v0,
            claim_coin_amount : v0,
        };
        0x2::event::emit<EventRegisterPool<T0, T1>>(v2);
    }

    // decompiled from Move bytecode v6
}

