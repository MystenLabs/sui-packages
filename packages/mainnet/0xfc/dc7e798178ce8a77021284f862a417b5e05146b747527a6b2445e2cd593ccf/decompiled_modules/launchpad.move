module 0xfcdc7e798178ce8a77021284f862a417b5e05146b747527a6b2445e2cd593ccf::launchpad {
    struct LaunchCap has store, key {
        id: 0x2::object::UID,
    }

    struct Launchpad has store, key {
        id: 0x2::object::UID,
        min_commitment: u64,
        max_commitment: u64,
        started_at_ms: u64,
        ended_at_ms: u64,
        soft_cap: u64,
        hard_cap: u64,
        min_sale_amount: u64,
        max_sale_amount: u64,
        fixed_price: u64,
        total_commited_amount: u64,
        commitments: 0x2::table::Table<address, u64>,
        version: u64,
    }

    struct Commit has copy, drop {
        amount: u64,
        sender: address,
    }

    struct Claim has copy, drop {
        sale_amount: u64,
        refund_amount: u64,
        sender: address,
    }

    public entry fun recover<T0>(arg0: &LaunchCap, arg1: &mut Launchpad, arg2: &mut 0xfcdc7e798178ce8a77021284f862a417b5e05146b747527a6b2445e2cd593ccf::distributor::VestingSchedule, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) >= arg1.ended_at_ms && arg1.total_commited_amount <= arg1.hard_cap, 7);
        let v0 = if (arg1.total_commited_amount <= arg1.soft_cap) {
            arg1.max_sale_amount
        } else if (arg1.total_commited_amount <= arg1.hard_cap) {
            arg1.max_sale_amount - 0xfcdc7e798178ce8a77021284f862a417b5e05146b747527a6b2445e2cd593ccf::utils::mul_div_u64(arg1.total_commited_amount, 1000000000000, arg1.fixed_price)
        } else {
            0
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xfcdc7e798178ce8a77021284f862a417b5e05146b747527a6b2445e2cd593ccf::distributor::recover<T0>(arg2, v0), arg4), 0x2::tx_context::sender(arg4));
    }

    fun assert_version(arg0: &Launchpad) {
        assert!(arg0.version == 1, 999);
    }

    fun assert_version_and_upgrade(arg0: &mut Launchpad) {
        if (arg0.version < 1) {
            arg0.version = 1;
        };
        assert_version(arg0);
    }

    public entry fun claim<T0>(arg0: &mut Launchpad, arg1: &mut 0xfcdc7e798178ce8a77021284f862a417b5e05146b747527a6b2445e2cd593ccf::distributor::VestingSchedule, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.ended_at_ms, 1);
        assert!(0x2::table::contains<address, u64>(&arg0.commitments, v0), 3);
        assert!(*0x2::table::borrow<address, u64>(&arg0.commitments, v0) > 0, 4);
        let v1 = *0x2::table::borrow<address, u64>(&arg0.commitments, v0);
        let (v2, v3) = if (arg0.total_commited_amount <= arg0.soft_cap) {
            (0, v1)
        } else if (arg0.total_commited_amount <= arg0.hard_cap) {
            (0xfcdc7e798178ce8a77021284f862a417b5e05146b747527a6b2445e2cd593ccf::utils::mul_div_u64(v1, 1000000000000, arg0.fixed_price), 0)
        } else {
            let v4 = 0xfcdc7e798178ce8a77021284f862a417b5e05146b747527a6b2445e2cd593ccf::utils::mul_div_u64(v1, arg0.max_sale_amount, arg0.total_commited_amount);
            (v4, v1 - 0xfcdc7e798178ce8a77021284f862a417b5e05146b747527a6b2445e2cd593ccf::utils::mul_div_u64(v4, arg0.fixed_price, 1000000000000) + 1)
        };
        let v5 = Claim{
            sale_amount   : v2,
            refund_amount : v3,
            sender        : v0,
        };
        0x2::event::emit<Claim>(v5);
        if (v2 > 0) {
            0xfcdc7e798178ce8a77021284f862a417b5e05146b747527a6b2445e2cd593ccf::distributor::distribute(arg1, v0, v2);
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0xfcdc7e798178ce8a77021284f862a417b5e05146b747527a6b2445e2cd593ccf::utils::Marker<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, 0xfcdc7e798178ce8a77021284f862a417b5e05146b747527a6b2445e2cd593ccf::utils::marker<T0>()), v3), arg3), v0);
        };
        set_claimed(arg0, v0);
    }

    public entry fun collect<T0>(arg0: &LaunchCap, arg1: &mut Launchpad, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.ended_at_ms && arg1.total_commited_amount > arg1.soft_cap, 8);
        if (arg1.total_commited_amount <= arg1.hard_cap) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0xfcdc7e798178ce8a77021284f862a417b5e05146b747527a6b2445e2cd593ccf::utils::Marker<T0>, 0x2::balance::Balance<T0>>(&mut arg1.id, 0xfcdc7e798178ce8a77021284f862a417b5e05146b747527a6b2445e2cd593ccf::utils::marker<T0>()), arg1.total_commited_amount), arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0xfcdc7e798178ce8a77021284f862a417b5e05146b747527a6b2445e2cd593ccf::utils::Marker<T0>, 0x2::balance::Balance<T0>>(&mut arg1.id, 0xfcdc7e798178ce8a77021284f862a417b5e05146b747527a6b2445e2cd593ccf::utils::marker<T0>()), arg1.hard_cap), arg3), 0x2::tx_context::sender(arg3));
        };
    }

    public entry fun commit<T0>(arg0: &mut Launchpad, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg0);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.started_at_ms, 0);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.ended_at_ms, 2);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<T0>(&arg1);
        let v2 = commit_(arg0, v0, v1);
        assert!(v2 >= arg0.min_commitment, 5);
        assert!(v2 <= arg0.max_commitment, 6);
        arg0.total_commited_amount = arg0.total_commited_amount + v1;
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0xfcdc7e798178ce8a77021284f862a417b5e05146b747527a6b2445e2cd593ccf::utils::Marker<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, 0xfcdc7e798178ce8a77021284f862a417b5e05146b747527a6b2445e2cd593ccf::utils::marker<T0>()), 0x2::coin::into_balance<T0>(arg1));
        let v3 = Commit{
            amount : v1,
            sender : v0,
        };
        0x2::event::emit<Commit>(v3);
    }

    fun commit_(arg0: &mut Launchpad, arg1: address, arg2: u64) : u64 {
        if (!0x2::table::contains<address, u64>(&arg0.commitments, arg1)) {
            0x2::table::add<address, u64>(&mut arg0.commitments, arg1, arg2);
            arg2
        } else {
            let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.commitments, arg1);
            *v1 = *v1 + arg2;
            *v1
        }
    }

    public fun commited_of(arg0: &Launchpad, arg1: address) : u64 {
        if (!0x2::table::contains<address, u64>(&arg0.commitments, arg1)) {
            0
        } else {
            *0x2::table::borrow<address, u64>(&arg0.commitments, arg1)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LaunchCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<LaunchCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun init_launchpad<T0, T1>(arg0: &LaunchCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: 0x2::coin::Coin<T1>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0x2::clock::timestamp_ms(arg11) && arg4 > arg3 && arg2 > arg1 && arg5 > 0 && arg6 > arg5 && arg7 > 0, 9);
        let v0 = Launchpad{
            id                    : 0x2::object::new(arg12),
            min_commitment        : arg1,
            max_commitment        : arg2,
            started_at_ms         : arg3,
            ended_at_ms           : arg4,
            soft_cap              : arg5,
            hard_cap              : arg6,
            min_sale_amount       : 0xfcdc7e798178ce8a77021284f862a417b5e05146b747527a6b2445e2cd593ccf::utils::mul_div_u64(arg5, 1000000000000, arg7),
            max_sale_amount       : 0xfcdc7e798178ce8a77021284f862a417b5e05146b747527a6b2445e2cd593ccf::utils::mul_div_u64(arg6, 1000000000000, arg7),
            fixed_price           : arg7,
            total_commited_amount : 0,
            commitments           : 0x2::table::new<address, u64>(arg12),
            version               : 1,
        };
        0x2::dynamic_field::add<0xfcdc7e798178ce8a77021284f862a417b5e05146b747527a6b2445e2cd593ccf::utils::Marker<T0>, 0x2::balance::Balance<T0>>(&mut v0.id, 0xfcdc7e798178ce8a77021284f862a417b5e05146b747527a6b2445e2cd593ccf::utils::marker<T0>(), 0x2::balance::zero<T0>());
        0x2::transfer::share_object<Launchpad>(v0);
        0x2::transfer::public_share_object<0xfcdc7e798178ce8a77021284f862a417b5e05146b747527a6b2445e2cd593ccf::distributor::VestingSchedule>(0xfcdc7e798178ce8a77021284f862a417b5e05146b747527a6b2445e2cd593ccf::distributor::new<T1>(arg8, arg9, arg10, arg11, arg12));
    }

    fun set_claimed(arg0: &mut Launchpad, arg1: address) {
        *0x2::table::borrow_mut<address, u64>(&mut arg0.commitments, arg1) = 0;
    }

    public entry fun set_max_commitment(arg0: &LaunchCap, arg1: &mut Launchpad, arg2: u64) {
        arg1.max_commitment = arg2;
    }

    public entry fun set_min_commitment(arg0: &LaunchCap, arg1: &mut Launchpad, arg2: u64) {
        arg1.min_commitment = arg2;
    }

    public fun total_commited(arg0: &Launchpad) : u64 {
        arg0.total_commited_amount
    }

    public fun uid(arg0: &Launchpad) : &0x2::object::UID {
        &arg0.id
    }

    public entry fun upgrade(arg0: &LaunchCap, arg1: &mut Launchpad) {
        assert!(arg1.version < 1, 1000);
        arg1.version = 1;
    }

    // decompiled from Move bytecode v6
}

