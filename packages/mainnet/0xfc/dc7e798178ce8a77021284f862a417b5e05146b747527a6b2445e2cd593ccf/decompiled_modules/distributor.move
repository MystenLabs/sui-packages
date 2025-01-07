module 0xfcdc7e798178ce8a77021284f862a417b5e05146b747527a6b2445e2cd593ccf::distributor {
    struct VestingSchedule has store, key {
        id: 0x2::object::UID,
        clift: u64,
        duration: u64,
        amounts: 0x2::table::Table<address, u64>,
        released: 0x2::table::Table<address, u64>,
    }

    struct Distribute has copy, drop {
        amount: u64,
        receiver: address,
    }

    public(friend) fun new<T0>(arg0: u64, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : VestingSchedule {
        assert!(arg0 > 0x2::clock::timestamp_ms(arg3) && arg1 > 0, 0);
        let v0 = VestingSchedule{
            id       : 0x2::object::new(arg4),
            clift    : arg0,
            duration : arg1,
            amounts  : 0x2::table::new<address, u64>(arg4),
            released : 0x2::table::new<address, u64>(arg4),
        };
        0x2::dynamic_field::add<0xfcdc7e798178ce8a77021284f862a417b5e05146b747527a6b2445e2cd593ccf::utils::Marker<T0>, 0x2::balance::Balance<T0>>(&mut v0.id, 0xfcdc7e798178ce8a77021284f862a417b5e05146b747527a6b2445e2cd593ccf::utils::marker<T0>(), 0x2::coin::into_balance<T0>(arg2));
        v0
    }

    public fun amount_of(arg0: &VestingSchedule, arg1: address) : u64 {
        *0x2::table::borrow<address, u64>(&arg0.amounts, arg1)
    }

    public(friend) fun distribute(arg0: &mut VestingSchedule, arg1: address, arg2: u64) {
        assert!(!0x2::table::contains<address, u64>(&arg0.amounts, arg1), 2);
        0x2::table::add<address, u64>(&mut arg0.amounts, arg1, arg2);
        let v0 = Distribute{
            amount   : arg2,
            receiver : arg1,
        };
        0x2::event::emit<Distribute>(v0);
    }

    public(friend) fun recover<T0>(arg0: &mut VestingSchedule, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0xfcdc7e798178ce8a77021284f862a417b5e05146b747527a6b2445e2cd593ccf::utils::Marker<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, 0xfcdc7e798178ce8a77021284f862a417b5e05146b747527a6b2445e2cd593ccf::utils::marker<T0>()), arg1)
    }

    public fun releasable_amount(arg0: &VestingSchedule, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        let v0 = if (!0x2::table::contains<address, u64>(&arg0.released, arg1)) {
            0
        } else {
            *0x2::table::borrow<address, u64>(&arg0.released, arg1)
        };
        vested_amount(arg0, arg1, arg2) - v0
    }

    public entry fun release<T0: drop>(arg0: &mut VestingSchedule, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = releasable_amount(arg0, v0, arg1);
        assert!(v1 > 0, 1);
        released(arg0, v0, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0xfcdc7e798178ce8a77021284f862a417b5e05146b747527a6b2445e2cd593ccf::utils::Marker<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, 0xfcdc7e798178ce8a77021284f862a417b5e05146b747527a6b2445e2cd593ccf::utils::marker<T0>()), v1), arg2), v0);
    }

    fun released(arg0: &mut VestingSchedule, arg1: address, arg2: u64) {
        if (!0x2::table::contains<address, u64>(&arg0.released, arg1)) {
            0x2::table::add<address, u64>(&mut arg0.released, arg1, arg2);
        } else {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.released, arg1);
            *v0 = *v0 + arg2;
        };
    }

    public fun vested_amount(arg0: &VestingSchedule, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (v0 < arg0.clift) {
            0
        } else if (v0 >= arg0.clift + arg0.duration) {
            *0x2::table::borrow<address, u64>(&arg0.amounts, arg1)
        } else {
            (((*0x2::table::borrow<address, u64>(&arg0.amounts, arg1) as u256) * ((v0 - arg0.clift) as u256) / (arg0.duration as u256)) as u64)
        }
    }

    // decompiled from Move bytecode v6
}

