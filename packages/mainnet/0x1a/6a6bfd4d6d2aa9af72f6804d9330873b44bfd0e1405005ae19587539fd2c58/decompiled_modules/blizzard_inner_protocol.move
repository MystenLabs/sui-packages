module 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_inner_protocol {
    struct FeeBalances<phantom T0> has store {
        fee: 0x2::balance::Balance<T0>,
        protocol: 0x2::balance::Balance<T0>,
    }

    struct BlizzardStateV1<phantom T0> has store, key {
        id: 0x2::object::UID,
        paused: bool,
        wal_fees: FeeBalances<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>,
        lst_fees: FeeBalances<T0>,
        historic_rate: 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_historic_rate::HistoricRate,
        treasury: 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_treasury::BlizzardTreasury<T0>,
        total_wal_value: u64,
        allowed_nodes: 0x2::vec_set::VecSet<0x2::object::ID>,
        nodes: 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_extended_field::ExtendedField<0x2::vec_map::VecMap<0x2::object::ID, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_node::BlizzardNode>>,
        last_synced_epoch: u32,
        metadata: 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_extended_field::ExtendedField<0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_metadata::BlizzardMetadata>,
        fee_config: 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_fee::BlizzardFee,
    }

    public(friend) fun mint<T0>(arg0: &mut BlizzardStateV1<T0>, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg3: 0x2::object::ID, arg4: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_is_unpaused<T0>(arg0);
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::assert_pkg_version(arg4);
        let (v0, v1, v2, v3) = sync_stake_and_update_state<T0>(arg0, arg1, arg2, arg3, arg5);
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_events::mint<T0>(v0, v1, v2, v3, 0x2::object::id_to_address(&arg3), arg0.last_synced_epoch);
        0x2::coin::mint<T0>(0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_treasury::inner_mut<T0>(&mut arg0.treasury), v1, arg5)
    }

    public(friend) fun update_description<T0>(arg0: &mut BlizzardStateV1<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: 0x1::string::String, arg3: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::assert_pkg_version(arg3);
        0x2::coin::update_description<T0>(0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_treasury::inner_mut<T0>(&mut arg0.treasury), arg1, arg2);
    }

    public(friend) fun update_icon_url<T0>(arg0: &mut BlizzardStateV1<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: 0x1::ascii::String, arg3: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::assert_pkg_version(arg3);
        0x2::coin::update_icon_url<T0>(0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_treasury::inner_mut<T0>(&mut arg0.treasury), arg1, arg2);
    }

    public(friend) fun update_name<T0>(arg0: &mut BlizzardStateV1<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: 0x1::string::String, arg3: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::assert_pkg_version(arg3);
        0x2::coin::update_name<T0>(0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_treasury::inner_mut<T0>(&mut arg0.treasury), arg1, arg2);
    }

    public(friend) fun update_symbol<T0>(arg0: &mut BlizzardStateV1<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: 0x1::ascii::String, arg3: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::assert_pkg_version(arg3);
        0x2::coin::update_symbol<T0>(0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_treasury::inner_mut<T0>(&mut arg0.treasury), arg1, arg2);
    }

    public(friend) fun add_node<T0>(arg0: &mut BlizzardStateV1<T0>, arg1: 0x2::object::ID, arg2: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions, arg3: &mut 0x2::tx_context::TxContext) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::assert_pkg_version(arg2);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allowed_nodes, arg1);
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_events::add_node<T0>(0x2::object::id_to_address(&arg1), arg0.last_synced_epoch);
        safe_register_node<T0>(arg0, arg1, arg3);
    }

    public(friend) fun burn_lst<T0>(arg0: &mut BlizzardStateV1<T0>, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: 0x2::coin::Coin<T0>, arg3: vector<0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_withdraw_ix::IX>, arg4: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, vector<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>) {
        assert_is_unpaused<T0>(arg0);
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::assert_pkg_version(arg4);
        sync_exchange_rate<T0>(arg0, arg1);
        let v0 = 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_fee::burn(&arg0.fee_config);
        let v1 = &mut arg2;
        let (v2, v3) = take_lst_fee<T0>(arg0, v1, v0, arg5);
        let v4 = 0x2::coin::value<T0>(&arg2);
        assert!(v4 > 0, 17);
        let (v5, v6) = remove_staked_wal<T0>(arg0, arg1, arg3, arg5);
        let v7 = v6;
        let v8 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::epoch(arg1);
        let v9 = 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_historic_rate::borrow_mut(&mut arg0.historic_rate, v8);
        let v10 = 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_exchange_rate::to_lst_up(v9, v5);
        0x2::coin::burn<T0>(0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_treasury::inner_mut<T0>(&mut arg0.treasury), arg2);
        assert!(0x1::vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&v7) > 0, 13906835325394616319);
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_exchange_rate::sub_lst_down(v9, v10);
        arg0.total_wal_value = arg0.total_wal_value - v5;
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_events::burn_lst<T0>(v5, v10 + v2, v2, v3, v8);
        (0x2::coin::split<T0>(&mut arg2, v4 - v10, arg5), v7)
    }

    public(friend) fun mint_after_votes_finished<T0>(arg0: &mut BlizzardStateV1<T0>, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg3: 0x2::object::ID, arg4: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) : 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_stake_nft::BlizzardStakeNFT {
        assert_is_unpaused<T0>(arg0);
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::assert_pkg_version(arg4);
        let (v0, v1, v2, v3) = sync_and_stake<T0>(arg0, arg1, arg2, arg3, arg5);
        let v4 = v0;
        let v5 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::activation_epoch(&v4);
        assert!(v5 == 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::epoch(arg1) + 2, 12);
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_events::mint_after_votes_finished<T0>(v1, v2, v3, 0x2::object::id_to_address(&arg3), v5, arg0.last_synced_epoch);
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_stake_nft::new<T0>(v4, *0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_extended_field::borrow<0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_metadata::BlizzardMetadata>(&arg0.metadata), arg5)
    }

    public(friend) fun pause<T0>(arg0: &mut BlizzardStateV1<T0>, arg1: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::assert_pkg_version(arg1);
        arg0.paused = true;
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_events::pause<T0>(arg0.last_synced_epoch);
    }

    public(friend) fun remove_node<T0>(arg0: &mut BlizzardStateV1<T0>, arg1: 0x2::object::ID, arg2: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions, arg3: &mut 0x2::tx_context::TxContext) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::assert_pkg_version(arg2);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.allowed_nodes, &arg1);
        assert!(0x2::vec_set::size<0x2::object::ID>(&arg0.allowed_nodes) > 0, 13906836480740818943);
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_events::remove_node<T0>(0x2::object::id_to_address(&arg1), arg0.last_synced_epoch);
    }

    public(friend) fun sync_exchange_rate<T0>(arg0: &mut BlizzardStateV1<T0>, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking) {
        let v0 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::epoch(arg1);
        if (arg0.last_synced_epoch == v0) {
            return
        };
        let v1 = 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_extended_field::borrow_mut<0x2::vec_map::VecMap<0x2::object::ID, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_node::BlizzardNode>>(&mut arg0.nodes);
        let v2 = 0;
        let v3 = 0x2::vec_map::keys<0x2::object::ID, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_node::BlizzardNode>(v1);
        0x1::vector::reverse<0x2::object::ID>(&mut v3);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x2::object::ID>(&v3)) {
            let v5 = 0x1::vector::pop_back<0x2::object::ID>(&mut v3);
            v2 = v2 + 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_node::sync(0x2::vec_map::get_mut<0x2::object::ID, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_node::BlizzardNode>(v1, &v5), arg1, v0);
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(v3);
        arg0.total_wal_value = v2;
        arg0.last_synced_epoch = v0;
        let v6 = if (arg0.total_wal_value == 0) {
            0
        } else {
            0x2::coin::total_supply<T0>(0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_treasury::inner<T0>(&arg0.treasury))
        };
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_historic_rate::add_epoch(&mut arg0.historic_rate, v0, v2, v6);
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_events::sync_exchange_rate<T0>(v0, v2, v6);
    }

    public(friend) fun transmute<T0>(arg0: &mut BlizzardStateV1<T0>, arg1: &mut BlizzardStateV1<0xb1b0650a8862e30e3f604fd6c5838bc25464b8d3d827fbd58af7cb9685b832bf::wwal::WWAL>, arg2: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg3: 0x2::coin::Coin<T0>, arg4: vector<0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_withdraw_ix::IX>, arg5: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0xb1b0650a8862e30e3f604fd6c5838bc25464b8d3d827fbd58af7cb9685b832bf::wwal::WWAL>) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::assert_pkg_version(arg5);
        assert_is_unpaused<T0>(arg0);
        assert_is_unpaused<0xb1b0650a8862e30e3f604fd6c5838bc25464b8d3d827fbd58af7cb9685b832bf::wwal::WWAL>(arg1);
        sync_exchange_rate<T0>(arg0, arg2);
        sync_exchange_rate<0xb1b0650a8862e30e3f604fd6c5838bc25464b8d3d827fbd58af7cb9685b832bf::wwal::WWAL>(arg1, arg2);
        let v0 = 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_fee::transmute(&arg0.fee_config);
        let v1 = &mut arg3;
        let (v2, v3) = take_lst_fee<T0>(arg0, v1, v0, arg6);
        let v4 = 0x2::coin::value<T0>(&arg3);
        assert!(v4 > 0, 17);
        let (v5, v6) = remove_staked_wal<T0>(arg0, arg2, arg4, arg6);
        let v7 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::epoch(arg2);
        let v8 = 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_historic_rate::borrow_mut(&mut arg0.historic_rate, v7);
        let v9 = 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_exchange_rate::to_lst_up(v8, v5);
        let v10 = 0x2::coin::split<T0>(&mut arg3, v4 - v9, arg6);
        0x2::coin::burn<T0>(0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_treasury::inner_mut<T0>(&mut arg0.treasury), arg3);
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_exchange_rate::sub_lst_down(v8, v9);
        arg0.total_wal_value = arg0.total_wal_value - v5;
        let v11 = v6;
        0x1::vector::reverse<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&mut v11);
        let v12 = 0;
        while (v12 < 0x1::vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&v11)) {
            let v13 = 0x1::vector::pop_back<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&mut v11);
            let v14 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::node_id(&v13);
            safe_register_node<0xb1b0650a8862e30e3f604fd6c5838bc25464b8d3d827fbd58af7cb9685b832bf::wwal::WWAL>(arg1, v14, arg6);
            let v15 = 0x2::vec_map::get_mut<0x2::object::ID, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_node::BlizzardNode>(0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_extended_field::borrow_mut<0x2::vec_map::VecMap<0x2::object::ID, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_node::BlizzardNode>>(&mut arg1.nodes), &v14);
            0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_node::sync(v15, arg2, v7);
            0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_node::add_staked_wal<0xb1b0650a8862e30e3f604fd6c5838bc25464b8d3d827fbd58af7cb9685b832bf::wwal::WWAL>(v15, v13, v7);
            v12 = v12 + 1;
        };
        0x1::vector::destroy_empty<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(v11);
        let v16 = 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_exchange_rate::add_wal_down(0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_historic_rate::borrow_mut(&mut arg1.historic_rate, v7), v5);
        arg1.total_wal_value = arg1.total_wal_value + v5;
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_events::transmute<T0, 0xb1b0650a8862e30e3f604fd6c5838bc25464b8d3d827fbd58af7cb9685b832bf::wwal::WWAL>(v9 + v2, v16, v5, v7, v2, v3);
        (v10, 0x2::coin::mint<0xb1b0650a8862e30e3f604fd6c5838bc25464b8d3d827fbd58af7cb9685b832bf::wwal::WWAL>(0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_treasury::inner_mut<0xb1b0650a8862e30e3f604fd6c5838bc25464b8d3d827fbd58af7cb9685b832bf::wwal::WWAL>(&mut arg1.treasury), v16, arg6))
    }

    public(friend) fun unpause<T0>(arg0: &mut BlizzardStateV1<T0>, arg1: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::assert_pkg_version(arg1);
        arg0.paused = false;
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_events::unpause<T0>(arg0.last_synced_epoch);
    }

    public(friend) fun allowed_nodes<T0>(arg0: &BlizzardStateV1<T0>) : vector<0x2::object::ID> {
        0x2::vec_set::into_keys<0x2::object::ID>(arg0.allowed_nodes)
    }

    fun assert_is_unpaused<T0>(arg0: &BlizzardStateV1<T0>) {
        assert!(!arg0.paused, 20);
    }

    public(friend) fun burn_stake_nft<T0>(arg0: &mut BlizzardStateV1<T0>, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_stake_nft::BlizzardStakeNFT, arg3: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_is_unpaused<T0>(arg0);
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_stake_nft::assert_type<T0>(&arg2);
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::assert_pkg_version(arg3);
        sync_exchange_rate<T0>(arg0, arg1);
        let v0 = 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_stake_nft::destroy(arg2);
        let v1 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::epoch(arg1);
        let v2 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::activation_epoch(&v0);
        let v3 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::node_id(&v0);
        let v4 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::value(&v0);
        assert!(v1 >= v2 - 1, 13);
        let v5 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::calculate_rewards(arg1, v3, v4, v2, v1) + v4;
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_node::add_staked_wal<T0>(0x2::vec_map::get_mut<0x2::object::ID, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_node::BlizzardNode>(0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_extended_field::borrow_mut<0x2::vec_map::VecMap<0x2::object::ID, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_node::BlizzardNode>>(&mut arg0.nodes), &v3), v0, v1);
        arg0.total_wal_value = arg0.total_wal_value + v5;
        let v6 = 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_exchange_rate::add_wal_down(0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_historic_rate::borrow_mut(&mut arg0.historic_rate, v1), v5);
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_events::burn_blizzard_stake_nft<T0>(0x2::object::id_to_address(&v3), arg0.last_synced_epoch, v2, v5, v6);
        0x2::coin::mint<T0>(0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_treasury::inner_mut<T0>(&mut arg0.treasury), v6, arg4)
    }

    public(friend) fun claim_fees<T0>(arg0: &mut BlizzardStateV1<T0>, arg1: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, 0x2::coin::Coin<T0>) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::assert_pkg_version(arg1);
        (0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::balance::withdraw_all<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.wal_fees.fee), arg2), 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.lst_fees.fee), arg2))
    }

    public(friend) fun claim_protocol_fees<T0>(arg0: &mut BlizzardStateV1<T0>, arg1: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, 0x2::coin::Coin<T0>) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::assert_pkg_version(arg1);
        (0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::balance::withdraw_all<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.wal_fees.protocol), arg2), 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.lst_fees.protocol), arg2))
    }

    fun emit_new_fee<T0>(arg0: &BlizzardStateV1<T0>) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_events::new_fee<T0>(0x17264709505b1a94908171fa3ec688c472dd59edd8acb38091d1b10cfb85fc43::bps::value(0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_fee::mint(&arg0.fee_config)), 0x17264709505b1a94908171fa3ec688c472dd59edd8acb38091d1b10cfb85fc43::bps::value(0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_fee::burn(&arg0.fee_config)), 0x17264709505b1a94908171fa3ec688c472dd59edd8acb38091d1b10cfb85fc43::bps::value(0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_fee::transmute(&arg0.fee_config)), 0x17264709505b1a94908171fa3ec688c472dd59edd8acb38091d1b10cfb85fc43::bps::value(0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_fee::protocol(&arg0.fee_config)), arg0.last_synced_epoch);
    }

    public(friend) fun fee_config<T0>(arg0: &BlizzardStateV1<T0>) : &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_fee::BlizzardFee {
        &arg0.fee_config
    }

    public(friend) fun new_state_v1<T0>(arg0: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg1: address, arg2: &0x2::coin::CoinMetadata<T0>, arg3: 0x2::coin::TreasuryCap<T0>, arg4: address, arg5: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions, arg6: &mut 0x2::tx_context::TxContext) : BlizzardStateV1<T0> {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::assert_pkg_version(arg5);
        assert!(0x2::coin::get_decimals<T0>(arg2) == 9, 14);
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_acl::new<T0>(arg4, arg6);
        let v0 = 0x2::object::new(arg6);
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_events::new_lst<T0>(arg1, 0x2::object::uid_to_address(&v0), 0x2::object::id_address<0x2::coin::CoinMetadata<T0>>(arg2), 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::epoch(arg0));
        let v1 = FeeBalances<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>{
            fee      : 0x2::balance::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(),
            protocol : 0x2::balance::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(),
        };
        let v2 = FeeBalances<T0>{
            fee      : 0x2::balance::zero<T0>(),
            protocol : 0x2::balance::zero<T0>(),
        };
        BlizzardStateV1<T0>{
            id                : v0,
            paused            : false,
            wal_fees          : v1,
            lst_fees          : v2,
            historic_rate     : 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_historic_rate::new(0, arg6),
            treasury          : 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_treasury::new<T0>(arg3, arg6),
            total_wal_value   : 0,
            allowed_nodes     : 0x2::vec_set::empty<0x2::object::ID>(),
            nodes             : 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_extended_field::new<0x2::vec_map::VecMap<0x2::object::ID, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_node::BlizzardNode>>(0x2::vec_map::empty<0x2::object::ID, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_node::BlizzardNode>(), arg6),
            last_synced_epoch : 0,
            metadata          : 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_extended_field::new<0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_metadata::BlizzardMetadata>(0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_metadata::new<T0>(arg2), arg6),
            fee_config        : 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_fee::new(),
        }
    }

    fun remove_staked_wal<T0>(arg0: &mut BlizzardStateV1<T0>, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: vector<0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_withdraw_ix::IX>, arg3: &mut 0x2::tx_context::TxContext) : (u64, vector<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>) {
        let v0 = 0;
        let v1 = 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_extended_field::borrow_mut<0x2::vec_map::VecMap<0x2::object::ID, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_node::BlizzardNode>>(&mut arg0.nodes);
        let v2 = 0x1::vector::empty<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>();
        0x1::vector::reverse<0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_withdraw_ix::IX>(&mut arg2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_withdraw_ix::IX>(&arg2)) {
            let v4 = 0x1::vector::pop_back<0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_withdraw_ix::IX>(&mut arg2);
            let v5 = v2;
            let v6 = 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_withdraw_ix::node_id(v4);
            let (v7, v8) = 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_node::remove_staked_wals<T0>(0x2::vec_map::get_mut<0x2::object::ID, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_node::BlizzardNode>(v1, &v6), arg1, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_withdraw_ix::epoch_values(v4), arg3);
            0x1::vector::append<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&mut v5, v8);
            v0 = v0 + v7;
            v2 = v5;
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_withdraw_ix::IX>(arg2);
        (v0, v2)
    }

    fun safe_register_node<T0>(arg0: &mut BlizzardStateV1<T0>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::vec_map::contains<0x2::object::ID, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_node::BlizzardNode>(0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_extended_field::borrow<0x2::vec_map::VecMap<0x2::object::ID, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_node::BlizzardNode>>(&arg0.nodes), &arg1)) {
            0x2::vec_map::insert<0x2::object::ID, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_node::BlizzardNode>(0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_extended_field::borrow_mut<0x2::vec_map::VecMap<0x2::object::ID, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_node::BlizzardNode>>(&mut arg0.nodes), arg1, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_node::new(arg1, arg2));
        };
    }

    public(friend) fun set_burn_fee<T0>(arg0: &mut BlizzardStateV1<T0>, arg1: u64, arg2: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::assert_pkg_version(arg2);
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_fee::set_burn(&mut arg0.fee_config, arg1);
        emit_new_fee<T0>(arg0);
    }

    public(friend) fun set_mint_fee<T0>(arg0: &mut BlizzardStateV1<T0>, arg1: u64, arg2: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::assert_pkg_version(arg2);
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_fee::set_mint(&mut arg0.fee_config, arg1);
        emit_new_fee<T0>(arg0);
    }

    public(friend) fun set_protocol_fee<T0>(arg0: &mut BlizzardStateV1<T0>, arg1: u64, arg2: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::assert_pkg_version(arg2);
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_fee::set_protocol(&mut arg0.fee_config, arg1);
        emit_new_fee<T0>(arg0);
    }

    public(friend) fun set_transmute_fee<T0>(arg0: &mut BlizzardStateV1<T0>, arg1: u64, arg2: &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::AllowedVersions) {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_allowed_versions::assert_pkg_version(arg2);
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_fee::set_transmute(&mut arg0.fee_config, arg1);
        emit_new_fee<T0>(arg0);
    }

    public(friend) fun staked_wal_vector_at_node<T0>(arg0: &BlizzardStateV1<T0>, arg1: &0x2::object::ID) : &0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_big_vector::BigVector<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal> {
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_node::staked_wal_vector(0x2::vec_map::get<0x2::object::ID, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_node::BlizzardNode>(0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_extended_field::borrow<0x2::vec_map::VecMap<0x2::object::ID, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_node::BlizzardNode>>(&arg0.nodes), arg1))
    }

    fun sync_and_stake<T0>(arg0: &mut BlizzardStateV1<T0>, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) : (0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal, u64, u64, u64) {
        sync_exchange_rate<T0>(arg0, arg1);
        let v0 = 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_fee::mint(&arg0.fee_config);
        let v1 = &mut arg2;
        let (v2, v3) = take_wal_fee<T0>(arg0, v1, v0, arg4);
        let v4 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg2);
        assert!(v4 > 0, 7);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_nodes, &arg3), 6);
        (0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::stake_with_pool(arg1, arg2, arg3, arg4), v4 + v2, v2, v3)
    }

    public(friend) fun sync_node_exchange_rate<T0>(arg0: &mut BlizzardStateV1<T0>, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: 0x2::object::ID) {
        let v0 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::epoch(arg1);
        if (arg0.last_synced_epoch == v0) {
            return
        };
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_node::sync(0x2::vec_map::get_mut<0x2::object::ID, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_node::BlizzardNode>(0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_extended_field::borrow_mut<0x2::vec_map::VecMap<0x2::object::ID, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_node::BlizzardNode>>(&mut arg0.nodes), &arg2), arg1, v0);
    }

    fun sync_stake_and_update_state<T0>(arg0: &mut BlizzardStateV1<T0>, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64) {
        let (v0, v1, v2, v3) = sync_and_stake<T0>(arg0, arg1, arg2, arg3, arg4);
        let v4 = v0;
        let v5 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::epoch(arg1);
        assert!(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::activation_epoch(&v4) == v5 + 1, 8);
        0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_node::add_staked_wal<T0>(0x2::vec_map::get_mut<0x2::object::ID, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_node::BlizzardNode>(0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_extended_field::borrow_mut<0x2::vec_map::VecMap<0x2::object::ID, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_node::BlizzardNode>>(&mut arg0.nodes), &arg3), v4, v5);
        arg0.total_wal_value = arg0.total_wal_value + v1 - v2;
        let v6 = 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_exchange_rate::add_wal_down(0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_historic_rate::borrow_mut(&mut arg0.historic_rate, v5), v1 - v2);
        assert!(v6 != 0, 13906836905942581247);
        (v1, v6, v2, v3)
    }

    fun take_fee<T0>(arg0: &mut FeeBalances<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: 0x17264709505b1a94908171fa3ec688c472dd59edd8acb38091d1b10cfb85fc43::bps::BPS, arg3: 0x17264709505b1a94908171fa3ec688c472dd59edd8acb38091d1b10cfb85fc43::bps::BPS, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x17264709505b1a94908171fa3ec688c472dd59edd8acb38091d1b10cfb85fc43::bps::calc_up(arg2, 0x2::coin::value<T0>(arg1));
        let v1 = 0x17264709505b1a94908171fa3ec688c472dd59edd8acb38091d1b10cfb85fc43::bps::calc_up(arg3, v0);
        0x2::balance::join<T0>(&mut arg0.protocol, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, v1, arg4)));
        0x2::balance::join<T0>(&mut arg0.fee, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, v0 - v1, arg4)));
        (v0, v1)
    }

    fun take_lst_fee<T0>(arg0: &mut BlizzardStateV1<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: 0x17264709505b1a94908171fa3ec688c472dd59edd8acb38091d1b10cfb85fc43::bps::BPS, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = &mut arg0.lst_fees;
        take_fee<T0>(v0, arg1, arg2, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_fee::protocol(&arg0.fee_config), arg3)
    }

    fun take_wal_fee<T0>(arg0: &mut BlizzardStateV1<T0>, arg1: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg2: 0x17264709505b1a94908171fa3ec688c472dd59edd8acb38091d1b10cfb85fc43::bps::BPS, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = &mut arg0.wal_fees;
        take_fee<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v0, arg1, arg2, 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_fee::protocol(&arg0.fee_config), arg3)
    }

    public(friend) fun to_lst_at_epoch<T0>(arg0: &BlizzardStateV1<T0>, arg1: u32, arg2: u64, arg3: bool) : 0x1::option::Option<u64> {
        if (!0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_historic_rate::contains(&arg0.historic_rate, arg1)) {
            return 0x1::option::none<u64>()
        };
        let v0 = if (arg3) {
            0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_exchange_rate::to_lst_up(0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_historic_rate::borrow(&arg0.historic_rate, arg1), arg2)
        } else {
            0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_exchange_rate::to_lst_down(0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_historic_rate::borrow(&arg0.historic_rate, arg1), arg2)
        };
        0x1::option::some<u64>(v0)
    }

    public(friend) fun to_wal_at_epoch<T0>(arg0: &BlizzardStateV1<T0>, arg1: u32, arg2: u64, arg3: bool) : 0x1::option::Option<u64> {
        if (!0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_historic_rate::contains(&arg0.historic_rate, arg1)) {
            return 0x1::option::none<u64>()
        };
        let v0 = if (arg3) {
            0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_exchange_rate::to_wal_up(0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_historic_rate::borrow(&arg0.historic_rate, arg1), arg2)
        } else {
            0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_exchange_rate::to_wal_down(0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_historic_rate::borrow(&arg0.historic_rate, arg1), arg2)
        };
        0x1::option::some<u64>(v0)
    }

    // decompiled from Move bytecode v6
}

