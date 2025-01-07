module 0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::time_distributor {
    struct Member<phantom T0> has store {
        weight: u32,
        unlocked_balance: 0x2::balance::Balance<T0>,
        unlocked_since_update: u64,
    }

    struct TimeDistributor<phantom T0, T1: copy> has store {
        tlb: 0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::time_locked_balance::TimeLockedBalance<T0>,
        members: 0x2::vec_map::VecMap<T1, Member<T0>>,
        total_weight: u64,
        unlocked_balance: 0x2::balance::Balance<T0>,
        update_ts_sec: u64,
    }

    public fun size<T0, T1: copy>(arg0: &TimeDistributor<T0, T1>) : u64 {
        0x2::vec_map::size<T1, Member<T0>>(&arg0.members)
    }

    public fun add_member<T0, T1: copy>(arg0: &mut TimeDistributor<T0, T1>, arg1: T1, arg2: u32, arg3: &0x2::clock::Clock) {
        add_members<T0, T1>(arg0, 0x1::vector::singleton<T1>(arg1), 0x1::vector::singleton<u32>(arg2), arg3);
    }

    public fun add_members<T0, T1: copy>(arg0: &mut TimeDistributor<T0, T1>, arg1: vector<T1>, arg2: vector<u32>, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::vector::length<T1>(&arg1);
        assert!(v0 > 0, 2);
        assert!(v0 == 0x1::vector::length<u32>(&arg2), 1);
        update<T0, T1>(arg0, arg3);
        0x1::vector::reverse<T1>(&mut arg1);
        0x1::vector::reverse<u32>(&mut arg2);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::pop_back<u32>(&mut arg2);
            assert!(v2 > 0, 0);
            let v3 = Member<T0>{
                weight                : v2,
                unlocked_balance      : 0x2::balance::zero<T0>(),
                unlocked_since_update : 0,
            };
            0x2::vec_map::insert<T1, Member<T0>>(&mut arg0.members, 0x1::vector::pop_back<T1>(&mut arg1), v3);
            arg0.total_weight = arg0.total_weight + (v2 as u64);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<T1>(arg1);
    }

    public fun change_unlock_per_second<T0, T1: copy>(arg0: &mut TimeDistributor<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) {
        if (arg1 != 0) {
            assert!(arg0.total_weight > 0, 3);
        };
        update<T0, T1>(arg0, arg2);
        0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::time_locked_balance::change_unlock_per_second<T0>(&mut arg0.tlb, arg1, arg2);
    }

    public fun change_unlock_start_ts_sec<T0, T1: copy>(arg0: &mut TimeDistributor<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) {
        update<T0, T1>(arg0, arg2);
        0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::time_locked_balance::change_unlock_start_ts_sec<T0>(&mut arg0.tlb, arg1, arg2);
    }

    public fun change_weight<T0, T1: copy>(arg0: &mut TimeDistributor<T0, T1>, arg1: &T1, arg2: u32, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::vector::singleton<u64>(0x2::vec_map::get_idx<T1, Member<T0>>(&arg0.members, arg1));
        change_weights_by_idxs<T0, T1>(arg0, v0, 0x1::vector::singleton<u32>(arg2), arg3);
    }

    public fun change_weights_by_idxs<T0, T1: copy>(arg0: &mut TimeDistributor<T0, T1>, arg1: vector<u64>, arg2: vector<u32>, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::vector::length<u64>(&arg1);
        assert!(v0 == 0x1::vector::length<u32>(&arg2), 1);
        assert!(v0 > 0, 2);
        update<T0, T1>(arg0, arg3);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u32>(&arg2, v1);
            assert!(v2 > 0, 0);
            let (_, v4) = 0x2::vec_map::get_entry_by_idx_mut<T1, Member<T0>>(&mut arg0.members, *0x1::vector::borrow<u64>(&arg1, v1));
            arg0.total_weight = arg0.total_weight - (v4.weight as u64) + (v2 as u64);
            v4.weight = v2;
            v1 = v1 + 1;
        };
    }

    public fun create<T0, T1: copy>(arg0: 0x2::balance::Balance<T0>, arg1: u64) : TimeDistributor<T0, T1> {
        TimeDistributor<T0, T1>{
            tlb              : 0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::time_locked_balance::create<T0>(arg0, arg1, 0),
            members          : 0x2::vec_map::empty<T1, Member<T0>>(),
            total_weight     : 0,
            unlocked_balance : 0x2::balance::zero<T0>(),
            update_ts_sec    : 0,
        }
    }

    public fun create_with_members<T0, T1: copy>(arg0: 0x2::balance::Balance<T0>, arg1: vector<T1>, arg2: vector<u32>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : TimeDistributor<T0, T1> {
        let v0 = create<T0, T1>(arg0, arg3);
        let v1 = &mut v0;
        add_members<T0, T1>(v1, arg1, arg2, arg5);
        let v2 = &mut v0;
        change_unlock_per_second<T0, T1>(v2, arg4, arg5);
        v0
    }

    public fun extraneous_locked_amount<T0, T1: copy>(arg0: &TimeDistributor<T0, T1>) : u64 {
        0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::time_locked_balance::extraneous_locked_amount<T0>(&arg0.tlb)
    }

    public fun final_unlock_ts_sec<T0, T1: copy>(arg0: &TimeDistributor<T0, T1>) : u64 {
        0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::time_locked_balance::final_unlock_ts_sec<T0>(&arg0.tlb)
    }

    fun member_unlock<T0, T1: copy>(arg0: &mut TimeDistributor<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::math::max(arg0.update_ts_sec, 0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::time_locked_balance::unlock_start_ts_sec<T0>(&arg0.tlb));
        let v1 = 0x2::math::min(0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::time_locked_balance::final_unlock_ts_sec<T0>(&arg0.tlb), 0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::primitives_util::timestamp_sec(arg2));
        let (_, v3) = 0x2::vec_map::get_entry_by_idx_mut<T1, Member<T0>>(&mut arg0.members, arg1);
        if (v0 < v1) {
            let v4 = muldiv((v1 - v0) * 0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::time_locked_balance::unlock_per_second<T0>(&arg0.tlb), (v3.weight as u64), (arg0.total_weight as u64)) - v3.unlocked_since_update;
            0x2::balance::join<T0>(&mut v3.unlocked_balance, 0x2::balance::split<T0>(&mut arg0.unlocked_balance, v4));
            v3.unlocked_since_update = v3.unlocked_since_update + v4;
        };
    }

    public fun member_withdraw_all<T0, T1: copy>(arg0: &mut TimeDistributor<T0, T1>, arg1: &T1, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::vec_map::get_idx<T1, Member<T0>>(&mut arg0.members, arg1);
        member_withdraw_all_by_idx<T0, T1>(arg0, v0, arg2)
    }

    public fun member_withdraw_all_by_idx<T0, T1: copy>(arg0: &mut TimeDistributor<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        0x2::balance::join<T0>(&mut arg0.unlocked_balance, 0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::time_locked_balance::withdraw_all<T0>(&mut arg0.tlb, arg2));
        member_unlock<T0, T1>(arg0, arg1, arg2);
        let (_, v1) = 0x2::vec_map::get_entry_by_idx_mut<T1, Member<T0>>(&mut arg0.members, arg1);
        0x2::balance::split<T0>(&mut v1.unlocked_balance, 0x2::balance::value<T0>(&v1.unlocked_balance))
    }

    fun muldiv(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun remove_member<T0, T1: copy>(arg0: &mut TimeDistributor<T0, T1>, arg1: &T1, arg2: &0x2::clock::Clock) : (T1, 0x2::balance::Balance<T0>) {
        let v0 = 0x2::vec_map::get_idx<T1, Member<T0>>(&mut arg0.members, arg1);
        remove_member_by_idx<T0, T1>(arg0, v0, arg2)
    }

    public fun remove_member_by_idx<T0, T1: copy>(arg0: &mut TimeDistributor<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : (T1, 0x2::balance::Balance<T0>) {
        update<T0, T1>(arg0, arg2);
        let (v0, v1) = 0x2::vec_map::remove_entry_by_idx<T1, Member<T0>>(&mut arg0.members, arg1);
        let Member {
            weight                : v2,
            unlocked_balance      : v3,
            unlocked_since_update : _,
        } = v1;
        arg0.total_weight = arg0.total_weight - (v2 as u64);
        if (arg0.total_weight == 0) {
            0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::time_locked_balance::change_unlock_per_second<T0>(&mut arg0.tlb, 0, arg2);
        };
        (v0, v3)
    }

    public fun skim_extraneous_balance<T0, T1: copy>(arg0: &mut TimeDistributor<T0, T1>) : 0x2::balance::Balance<T0> {
        0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::time_locked_balance::skim_extraneous_balance<T0>(&mut arg0.tlb)
    }

    public fun top_up<T0, T1: copy>(arg0: &mut TimeDistributor<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock) {
        if (0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::primitives_util::timestamp_sec(arg2) > 0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::time_locked_balance::final_unlock_ts_sec<T0>(&arg0.tlb)) {
            update<T0, T1>(arg0, arg2);
        };
        0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::time_locked_balance::top_up<T0>(&mut arg0.tlb, arg1, arg2);
    }

    public fun unlock_per_second<T0, T1: copy>(arg0: &TimeDistributor<T0, T1>) : u64 {
        0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::time_locked_balance::unlock_per_second<T0>(&arg0.tlb)
    }

    public fun unlock_start_ts_sec<T0, T1: copy>(arg0: &TimeDistributor<T0, T1>) : u64 {
        0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::time_locked_balance::unlock_start_ts_sec<T0>(&arg0.tlb)
    }

    fun update<T0, T1: copy>(arg0: &mut TimeDistributor<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = 0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::primitives_util::timestamp_sec(arg1);
        if (arg0.update_ts_sec == v0) {
            return
        };
        0x2::balance::join<T0>(&mut arg0.unlocked_balance, 0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::time_locked_balance::withdraw_all<T0>(&mut arg0.tlb, arg1));
        let v1 = 0;
        while (v1 < 0x2::vec_map::size<T1, Member<T0>>(&arg0.members)) {
            member_unlock<T0, T1>(arg0, v1, arg1);
            let (_, v3) = 0x2::vec_map::get_entry_by_idx_mut<T1, Member<T0>>(&mut arg0.members, v1);
            v3.unlocked_since_update = 0;
            v1 = v1 + 1;
        };
        0xaac1c38cc267b2541213479979cc66e087bc6768fd2d4d6cc3e453c42ff225bf::time_locked_balance::top_up<T0>(&mut arg0.tlb, 0x2::balance::split<T0>(&mut arg0.unlocked_balance, 0x2::balance::value<T0>(&arg0.unlocked_balance)), arg1);
        arg0.update_ts_sec = v0;
    }

    // decompiled from Move bytecode v6
}

