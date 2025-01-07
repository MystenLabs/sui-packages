module 0x6c073f9bcb63af5a4d1120e36a1f01e1110fa20c3768776e818739f09b45fdb5::launchpad {
    struct Wallet<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct LaunchCap has store, key {
        id: 0x2::object::UID,
    }

    struct Phase has store, key {
        id: 0x2::object::UID,
        started_at_ms: u64,
        ended_at_ms: u64,
        price: u64,
        allocation: u64,
        total_sold: u64,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        mint_cap: 0x6c073f9bcb63af5a4d1120e36a1f01e1110fa20c3768776e818739f09b45fdb5::fossil::MintCap,
        phases: vector<Phase>,
        max_buy_per_tx: u64,
    }

    struct Buy has copy, drop {
        amount: u64,
        sender: address,
    }

    public entry fun buy<T0>(arg0: &mut Listing, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x6c073f9bcb63af5a4d1120e36a1f01e1110fa20c3768776e818739f09b45fdb5::supply::Supply, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= arg0.max_buy_per_tx, 2);
        let (v0, v1) = get_current_phase_index_of(arg0, arg4);
        assert!(v0, 1);
        let v2 = 0x1::vector::borrow_mut<Phase>(&mut arg0.phases, v1);
        assert!(v2.allocation >= v2.total_sold + arg2, 3);
        let v3 = Wallet<T0>{dummy_field: false};
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<Wallet<T0>, 0x2::balance::Balance<T0>>(&mut v2.id, v3), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, arg2 * v2.price, arg5)));
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg5));
        };
        v2.total_sold = v2.total_sold + arg2;
        let v4 = &mut arg0.mint_cap;
        mint_nft(v4, arg3, arg2, arg5);
        let v5 = Buy{
            amount : arg2,
            sender : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<Buy>(v5);
    }

    public entry fun create_phase<T0>(arg0: &LaunchCap, arg1: &mut Listing, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x1::vector::length<Phase>(&arg1.phases) == 0) {
            0x2::clock::timestamp_ms(arg6)
        } else {
            0x1::vector::borrow<Phase>(&arg1.phases, 0x1::vector::length<Phase>(&arg1.phases) - 1).ended_at_ms
        };
        assert!(arg2 > v0 && arg3 > arg2, 0);
        let v1 = Phase{
            id            : 0x2::object::new(arg7),
            started_at_ms : arg2,
            ended_at_ms   : arg3,
            price         : arg4,
            allocation    : arg5,
            total_sold    : 0,
        };
        let v2 = Wallet<T0>{dummy_field: false};
        0x2::dynamic_field::add<Wallet<T0>, 0x2::balance::Balance<T0>>(&mut v1.id, v2, 0x2::balance::zero<T0>());
        0x1::vector::push_back<Phase>(&mut arg1.phases, v1);
    }

    public fun get_current_phase_index_of(arg0: &Listing, arg1: &0x2::clock::Clock) : (bool, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<Phase>(&arg0.phases)) {
            let v2 = 0x1::vector::borrow<Phase>(&arg0.phases, v1);
            if (v0 >= v2.started_at_ms && v0 < v2.ended_at_ms) {
                return (true, v1)
            };
            v1 = v1 + 1;
        };
        (false, 0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Listing{
            id             : 0x2::object::new(arg0),
            mint_cap       : 0x6c073f9bcb63af5a4d1120e36a1f01e1110fa20c3768776e818739f09b45fdb5::fossil::new_mint_cap(arg0),
            phases         : 0x1::vector::empty<Phase>(),
            max_buy_per_tx : 5,
        };
        0x2::transfer::share_object<Listing>(v0);
        let v1 = LaunchCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<LaunchCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun mint_nft(arg0: &mut 0x6c073f9bcb63af5a4d1120e36a1f01e1110fa20c3768776e818739f09b45fdb5::fossil::MintCap, arg1: &mut 0x6c073f9bcb63af5a4d1120e36a1f01e1110fa20c3768776e818739f09b45fdb5::supply::Supply, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg2) {
            0x6c073f9bcb63af5a4d1120e36a1f01e1110fa20c3768776e818739f09b45fdb5::fossil::mint_and_transfer(arg0, arg1, arg3);
            v0 = v0 + 1;
        };
    }

    public entry fun withdraw<T0>(arg0: &LaunchCap, arg1: &mut Listing, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow_mut<Phase>(&mut arg1.phases, arg2);
        assert!(0x2::clock::timestamp_ms(arg3) > v0.ended_at_ms, 4);
        let v1 = Wallet<T0>{dummy_field: false};
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x2::dynamic_field::borrow_mut<Wallet<T0>, 0x2::balance::Balance<T0>>(&mut v0.id, v1)), arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

