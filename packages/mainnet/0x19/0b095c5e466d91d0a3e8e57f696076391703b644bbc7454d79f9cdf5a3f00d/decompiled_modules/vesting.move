module 0x190b095c5e466d91d0a3e8e57f696076391703b644bbc7454d79f9cdf5a3f00d::vesting {
    struct Vesting<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        suid: 0x2::balance::Balance<T0>,
        claim_time: u64,
        tge_percent: u64,
        cycle_percent: u64,
        cycle_time: u64,
        vesting_times: u64,
        claim_duration: u64,
    }

    struct UserData has store, key {
        id: 0x2::object::UID,
        amount: u64,
        latest_claim: u64,
        claimTimes: u64,
        claimed: u64,
    }

    entry fun add<T0>(arg0: &mut Vesting<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 0);
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = 0x1::vector::borrow<address>(&arg1, v0);
            let v2 = 0x1::vector::borrow<u64>(&arg2, v0);
            if (!0x2::dynamic_object_field::exists_<address>(&arg0.id, *v1)) {
                let v3 = UserData{
                    id           : 0x2::object::new(arg3),
                    amount       : *v2,
                    latest_claim : arg0.claim_time,
                    claimTimes   : 0,
                    claimed      : 0,
                };
                0x2::dynamic_object_field::add<address, UserData>(&mut arg0.id, *v1, v3);
            };
            v0 = v0 + 1;
        };
    }

    entry fun burn_suid_overdue<T0>(arg0: &0x2::clock::Clock, arg1: &mut Vesting<T0>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::borrow<address>(&arg2, v0);
            if (0x2::dynamic_object_field::exists_<address>(&arg1.id, *v1)) {
                let v2 = 0x2::dynamic_object_field::borrow_mut<address, UserData>(&mut arg1.id, *v1);
                if (v2.latest_claim + arg1.claim_duration < 0x2::clock::timestamp_ms(arg0)) {
                    0x2::transfer::public_freeze_object<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.suid, v2.amount - v2.claimed, arg3));
                    0x2::dynamic_object_field::borrow_mut<address, UserData>(&mut arg1.id, *v1).amount = 0;
                };
            };
            v0 = v0 + 1;
        };
    }

    entry fun claim<T0>(arg0: &0x2::clock::Clock, arg1: &mut Vesting<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_<address>(&arg1.id, 0x2::tx_context::sender(arg2)), 2);
        let v0 = 0x2::dynamic_object_field::borrow_mut<address, UserData>(&mut arg1.id, 0x2::tx_context::sender(arg2));
        let v1 = 0x2::clock::timestamp_ms(arg0);
        assert!(v0.amount > 0, 3);
        assert!(v0.latest_claim + arg1.claim_duration >= v1, 5);
        let v2 = if (arg1.claim_time == 0 || v0.claimTimes > arg1.vesting_times) {
            0
        } else {
            arg1.claim_time + v0.claimTimes * arg1.cycle_time
        };
        assert!(v2 > 0 && v2 < v1, 4);
        let v3 = if (v0.claimTimes == 0) {
            0x190b095c5e466d91d0a3e8e57f696076391703b644bbc7454d79f9cdf5a3f00d::math::mul_div(v0.amount, arg1.tge_percent, 10000)
        } else {
            0x190b095c5e466d91d0a3e8e57f696076391703b644bbc7454d79f9cdf5a3f00d::math::mul_div(v0.amount, arg1.cycle_percent, 10000)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.suid, v3, arg2), 0x2::tx_context::sender(arg2));
        v0.claimTimes = v0.claimTimes + 1;
        v0.latest_claim = v1;
        v0.claimed = v0.claimed + v3;
    }

    entry fun init_vesting<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = Vesting<T0>{
            id             : 0x2::object::new(arg8),
            owner          : 0x2::tx_context::sender(arg8),
            suid           : 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg0, arg1, arg8)),
            claim_time     : arg2,
            tge_percent    : arg3,
            cycle_percent  : arg4,
            cycle_time     : arg5,
            vesting_times  : arg6,
            claim_duration : arg7,
        };
        0x2::transfer::share_object<Vesting<T0>>(v0);
    }

    entry fun remove<T0>(arg0: &mut Vesting<T0>, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = 0x1::vector::borrow<address>(&arg1, v0);
            if (0x2::dynamic_object_field::exists_<address>(&arg0.id, *v1)) {
                0x2::dynamic_object_field::borrow_mut<address, UserData>(&mut arg0.id, *v1).amount = 0;
            };
            v0 = v0 + 1;
        };
    }

    entry fun settings<T0>(arg0: &mut Vesting<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg7), 0);
        arg0.claim_time = arg1;
        arg0.tge_percent = arg2;
        arg0.cycle_percent = arg3;
        arg0.cycle_time = arg4;
        arg0.vesting_times = arg5;
        arg0.claim_duration = arg6;
    }

    entry fun update_ticket<T0>(arg0: &mut Vesting<T0>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg6), 0);
        assert!(0x2::dynamic_object_field::exists_<address>(&arg0.id, arg1), 2);
        let v0 = 0x2::dynamic_object_field::borrow_mut<address, UserData>(&mut arg0.id, arg1);
        v0.amount = arg2;
        v0.latest_claim = arg3;
        v0.claimTimes = arg4;
        v0.claimed = arg5;
    }

    entry fun withdraw_token<T0>(arg0: &mut Vesting<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.suid, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

