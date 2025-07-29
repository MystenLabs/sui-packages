module 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_node {
    struct BlizzardNode has store {
        node_id: 0x2::object::ID,
        staked_wal_vector: 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_big_vector::BigVector<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>,
        epoch_table: 0x2::table::Table<u32, u64>,
        last_synced_epoch: u32,
        last_synced_wal_value: u64,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : BlizzardNode {
        BlizzardNode{
            node_id               : arg0,
            staked_wal_vector     : 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_big_vector::new<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(300, arg1),
            epoch_table           : 0x2::table::new<u32, u64>(arg1),
            last_synced_epoch     : 0,
            last_synced_wal_value : 0,
        }
    }

    public(friend) fun add_staked_wal<T0>(arg0: &mut BlizzardNode, arg1: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal, arg2: u32) {
        assert!(arg0.last_synced_epoch == arg2, 13906834444926320639);
        let v0 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::activation_epoch(&arg1);
        let v1 = 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_big_vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&arg0.staked_wal_vector);
        let v2 = 0x2::table::contains<u32, u64>(&arg0.epoch_table, v0);
        let v3 = if (v2) {
            let v4 = 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_big_vector::borrow_mut<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&mut arg0.staked_wal_vector, *0x2::table::borrow<u32, u64>(&arg0.epoch_table, v0));
            0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::join(v4, arg1);
            staked_wal_address(v4)
        } else {
            0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_big_vector::push_back<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&mut arg0.staked_wal_vector, arg1);
            0x2::table::add<u32, u64>(&mut arg0.epoch_table, v0, v1);
            staked_wal_address(&arg1)
        };
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_events::staked_wal_added<T0>(0x2::object::id_to_address(&arg0.node_id), arg2, v3, v0, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::value(&arg1), v1, v2);
    }

    fun calculate_total_value(arg0: &BlizzardNode, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: u32) : u64 {
        if (0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_big_vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&arg0.staked_wal_vector) == 0) {
            return 0
        };
        let v0 = &arg0.staked_wal_vector;
        let v1 = 0;
        let v2 = 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_big_vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(v0);
        if (v2 != 0) {
            let v3 = (0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_big_vector::slice_size<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(v0) as u64);
            let v4 = 0;
            let v5 = 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_big_vector::borrow_slice<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(v0, v4);
            let v6 = 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_big_vector::get_slice_length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(v5);
            let v7 = 0;
            while (v7 < v2) {
                let v8 = 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_big_vector::borrow_from_slice<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(v5, v7 % v3);
                let v9 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::value(v8);
                let v10 = v1 + v9;
                v1 = v10 + 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::calculate_rewards(arg1, arg0.node_id, v9, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::activation_epoch(v8), arg2);
                if (v7 + 1 < v2 && v7 + 1 == v4 * v3 + v6) {
                    let v11 = 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_big_vector::get_slice_idx<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(v5) + 1;
                    v4 = v11;
                    let v12 = 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_big_vector::borrow_slice<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(v0, v11);
                    v5 = v12;
                    v6 = 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_big_vector::get_slice_length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(v12);
                };
                v7 = v7 + 1;
            };
        };
        v1
    }

    public(friend) fun epoch_table(arg0: &BlizzardNode) : &0x2::table::Table<u32, u64> {
        &arg0.epoch_table
    }

    public(friend) fun remove_staked_wals<T0>(arg0: &mut BlizzardNode, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: vector<0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_withdraw_ix::EpochValue>, arg3: &mut 0x2::tx_context::TxContext) : (u64, vector<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>) {
        let v0 = 0;
        let v1 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::epoch(arg1);
        assert!(arg0.last_synced_epoch == v1, 13906834621019979775);
        let v2 = 0x1::vector::empty<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>();
        0x1::vector::reverse<0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_withdraw_ix::EpochValue>(&mut arg2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_withdraw_ix::EpochValue>(&arg2)) {
            let v4 = 0x1::vector::pop_back<0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_withdraw_ix::EpochValue>(&mut arg2);
            let v5 = v2;
            let v6 = (0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_withdraw_ix::epoch(v4) as u64);
            let v7 = 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_withdraw_ix::value(v4);
            let v8 = *0x2::table::borrow<u32, u64>(&arg0.epoch_table, (v6 as u32));
            let v9 = 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_big_vector::borrow_mut<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&mut arg0.staked_wal_vector, v8);
            let v10 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::value(v9) == v7;
            let v11 = if (v10) {
                let v12 = 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_big_vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&arg0.staked_wal_vector) - 1;
                if (v12 == 0) {
                    0x2::table::remove<u32, u64>(&mut arg0.epoch_table, (v6 as u32));
                    0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_big_vector::pop_back<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&mut arg0.staked_wal_vector)
                } else {
                    let v13 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::activation_epoch(0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_big_vector::borrow<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&arg0.staked_wal_vector, v12));
                    if (v13 == (v6 as u32)) {
                        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_big_vector::pop_back<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&mut arg0.staked_wal_vector)
                    } else {
                        *0x2::table::borrow_mut<u32, u64>(&mut arg0.epoch_table, v13) = 0x2::table::remove<u32, u64>(&mut arg0.epoch_table, (v6 as u32));
                        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_big_vector::swap_remove<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&mut arg0.staked_wal_vector, v8)
                    }
                }
            } else {
                0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::split(v9, v7, arg3)
            };
            let v14 = v11;
            let v15 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::value(&v14);
            let v16 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::activation_epoch(&v14);
            let v17 = v15 + 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::calculate_rewards(arg1, arg0.node_id, v15, v16, v1);
            v0 = v0 + v17;
            0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_events::staked_wal_removed<T0>(0x2::object::id_to_address(&arg0.node_id), v1, staked_wal_address(&v14), v16, !v10, v15, v17);
            0x1::vector::push_back<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&mut v5, v14);
            v2 = v5;
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_withdraw_ix::EpochValue>(arg2);
        (v0, v2)
    }

    fun staked_wal_address(arg0: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal) : address {
        0x2::object::id_address<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(arg0)
    }

    public(friend) fun staked_wal_vector(arg0: &BlizzardNode) : &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_big_vector::BigVector<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal> {
        &arg0.staked_wal_vector
    }

    public(friend) fun sync(arg0: &mut BlizzardNode, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: u32) : u64 {
        if (arg0.last_synced_epoch == arg2) {
            return arg0.last_synced_wal_value
        };
        arg0.last_synced_epoch = arg2;
        let v0 = calculate_total_value(arg0, arg1, arg2);
        arg0.last_synced_wal_value = v0;
        v0
    }

    // decompiled from Move bytecode v6
}

