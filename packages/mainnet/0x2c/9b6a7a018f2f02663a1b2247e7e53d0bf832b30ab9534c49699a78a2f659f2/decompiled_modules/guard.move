module 0x2c9b6a7a018f2f02663a1b2247e7e53d0bf832b30ab9534c49699a78a2f659f2::guard {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Guard<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        collected_fees: 0x2::balance::Balance<T0>,
        auctioneer_pub_key: address,
        package_version: u64,
    }

    struct GuardCreated<phantom T0, phantom T1> has copy, drop {
        guard_id: 0x2::object::ID,
        auctioneer_pub_key: address,
    }

    struct GuardPackageVersionUpdated has copy, drop {
        guard_id: 0x2::object::ID,
        new_package_version: u64,
    }

    struct AuctioneerUpdated has copy, drop {
        guard_id: 0x2::object::ID,
        auctioneer_pub_key: address,
    }

    public fun collect_protocol_fees<T0, T1>(arg0: &AdminCap, arg1: &mut Guard<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x2::balance::value<T0>(&arg1.collected_fees) == 0) {
            abort 1
        };
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.collected_fees), arg2)
    }

    public fun create_guard<T0, T1>(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Guard<T0, T1>{
            id                 : 0x2::object::new(arg2),
            collected_fees     : 0x2::balance::zero<T0>(),
            auctioneer_pub_key : arg1,
            package_version    : 1,
        };
        let v1 = GuardCreated<T0, T1>{
            guard_id           : 0x2::object::id<Guard<T0, T1>>(&v0),
            auctioneer_pub_key : arg1,
        };
        0x2::event::emit<GuardCreated<T0, T1>>(v1);
        0x2::transfer::share_object<Guard<T0, T1>>(v0);
    }

    public(friend) fun ensure_guard_id<T0, T1>(arg0: &Guard<T0, T1>, arg1: 0x2::object::ID) {
        assert!(0x2::object::id<Guard<T0, T1>>(arg0) == arg1, 2);
    }

    public(friend) fun ensure_guard_version<T0, T1>(arg0: &Guard<T0, T1>) {
        assert!(arg0.package_version == 1, 9000);
    }

    public(friend) fun get_actioneer<T0, T1>(arg0: &Guard<T0, T1>) : address {
        arg0.auctioneer_pub_key
    }

    public(friend) fun increase_collected_fees<T0, T1>(arg0: &mut Guard<T0, T1>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.collected_fees, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun send_coins_and_destroy_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun set_auctioneer_pub_key<T0, T1>(arg0: &AdminCap, arg1: &mut Guard<T0, T1>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.auctioneer_pub_key = arg2;
        let v0 = AuctioneerUpdated{
            guard_id           : 0x2::object::id<Guard<T0, T1>>(arg1),
            auctioneer_pub_key : arg2,
        };
        0x2::event::emit<AuctioneerUpdated>(v0);
    }

    public fun update_guard_package_version<T0, T1>(arg0: &AdminCap, arg1: &mut Guard<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.package_version = 1;
        let v0 = GuardPackageVersionUpdated{
            guard_id            : 0x2::object::id<Guard<T0, T1>>(arg1),
            new_package_version : 1,
        };
        0x2::event::emit<GuardPackageVersionUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

