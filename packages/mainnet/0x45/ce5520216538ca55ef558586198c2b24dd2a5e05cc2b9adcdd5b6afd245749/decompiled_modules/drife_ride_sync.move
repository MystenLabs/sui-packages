module 0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::drife_ride_sync {
    public entry fun archive_ride(arg0: &mut 0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::RideSyncState, arg1: &0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::RoleManager, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        let v0 = b"Admin";
        assert_has_role(arg1, 0x2::tx_context::sender(arg3), &v0);
        assert!(0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::ride_exists(arg0, &arg2), 103);
        let v1 = 0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::ride_info(arg0, &arg2);
        let v2 = 0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::ride_info_status(&v1);
        assert!(v2 == 2 || v2 == 3, 108);
        0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::remove_archived_ride(arg0, arg2);
    }

    fun assert_has_role(arg0: &0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::RoleManager, arg1: address, arg2: &vector<u8>) {
        assert!(0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::has_role(arg0, arg1, arg2), 101);
    }

    public entry fun assign_role(arg0: &mut 0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::RoleManager, arg1: address, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = b"Admin";
        assert_has_role(arg0, v0, &v1);
        assert!(is_valid_role(&arg2), 106);
        0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::manage_role(arg0, arg1, &arg2, true, v0);
    }

    public entry fun cancel_ride(arg0: &mut 0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::RideSyncState, arg1: &0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::RoleManager, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(!0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::is_paused(arg0), 100);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = b"Rider";
        let v2 = if (0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::has_role(arg1, v0, &v1)) {
            true
        } else {
            let v3 = b"Driver";
            if (0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::has_role(arg1, v0, &v3)) {
                true
            } else {
                let v4 = b"Admin";
                0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::has_role(arg1, v0, &v4)
            }
        };
        assert!(v2, 101);
        assert!(0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::ride_exists(arg0, &arg2), 103);
        let v5 = 0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::ride_info(arg0, &arg2);
        let v6 = 0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::ride_info_status(&v5);
        assert!(v6 == 0 || v6 == 1, 104);
        0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::cancel_ride_status(arg0, &arg2, 0x2::clock::timestamp_ms(arg3));
    }

    public entry fun complete_ride(arg0: &mut 0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::RideSyncState, arg1: &0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::RoleManager, arg2: vector<u8>, arg3: u32, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(!0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::is_paused(arg0), 100);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = b"Rider";
        let v2 = if (0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::has_role(arg1, v0, &v1)) {
            true
        } else {
            let v3 = b"Driver";
            if (0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::has_role(arg1, v0, &v3)) {
                true
            } else {
                let v4 = b"Admin";
                0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::has_role(arg1, v0, &v4)
            }
        };
        assert!(v2, 101);
        assert!(0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::ride_exists(arg0, &arg2), 103);
        let v5 = 0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::ride_info(arg0, &arg2);
        assert!(0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::ride_info_status(&v5) == 1, 104);
        let v6 = 0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::complete_ride_status(arg0, &arg2, 0x2::clock::timestamp_ms(arg4));
        0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::update_stats(arg0, 0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::ride_info_rider_wallet(&v6), 2, arg3);
    }

    public entry fun emit_full_ride(arg0: &0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::RideSyncState, arg1: vector<u8>) {
        assert!(0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::ride_exists(arg0, &arg1), 103);
        0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::emit_full_ride_for_indexer(0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::ride_info(arg0, &arg1));
    }

    public fun get_all_ride_ids(arg0: &0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::RideSyncState) : vector<vector<u8>> {
        *0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::all_ride_ids(arg0)
    }

    public fun get_daily_stats(arg0: &0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::RideSyncState, arg1: u32) : 0x1::option::Option<0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::DailyStat> {
        0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::daily_stats(arg0, arg1)
    }

    public fun get_ride_info(arg0: &0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::RideSyncState, arg1: vector<u8>) : 0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::RideInfo {
        0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::ride_info(arg0, &arg1)
    }

    public fun get_rides_paginated(arg0: &0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::RideSyncState, arg1: u64, arg2: u64) : vector<0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::RideInfo> {
        let v0 = 0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::all_ride_ids(arg0);
        let v1 = 0x1::vector::empty<0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::RideInfo>();
        let v2 = if (arg1 + arg2 > 0x1::vector::length<vector<u8>>(v0)) {
            0x1::vector::length<vector<u8>>(v0)
        } else {
            arg1 + arg2
        };
        while (arg1 < v2) {
            let v3 = *0x1::vector::borrow<vector<u8>>(v0, arg1);
            0x1::vector::push_back<0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::RideInfo>(&mut v1, 0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::ride_info(arg0, &v3));
            arg1 = arg1 + 1;
        };
        v1
    }

    public fun get_total_stats(arg0: &0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::RideSyncState) : (u64, u64, u64) {
        0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::total_stats(arg0)
    }

    public fun get_unique_rider_count(arg0: &0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::RideSyncState) : u64 {
        0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::unique_rider_count(arg0)
    }

    public fun is_paused_view(arg0: &0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::RideSyncState) : bool {
        0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::is_paused(arg0)
    }

    fun is_valid_role(arg0: &vector<u8>) : bool {
        let v0 = b"Admin";
        if (arg0 == &v0) {
            true
        } else {
            let v2 = b"Rider";
            if (arg0 == &v2) {
                true
            } else {
                let v3 = b"Driver";
                if (arg0 == &v3) {
                    true
                } else {
                    let v4 = b"Writer";
                    arg0 == &v4
                }
            }
        }
    }

    public entry fun match_driver(arg0: &mut 0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::RideSyncState, arg1: &0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::RoleManager, arg2: vector<u8>, arg3: address, arg4: u32, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(!0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::is_paused(arg0), 100);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = b"Driver";
        let v2 = if (0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::has_role(arg1, v0, &v1)) {
            true
        } else {
            let v3 = b"Writer";
            if (0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::has_role(arg1, v0, &v3)) {
                true
            } else {
                let v4 = b"Admin";
                0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::has_role(arg1, v0, &v4)
            }
        };
        assert!(v2, 101);
        assert!(0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::ride_exists(arg0, &arg2), 103);
        let v5 = 0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::ride_info(arg0, &arg2);
        assert!(0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::ride_info_status(&v5) == 0, 104);
        let v6 = 0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::assign_driver_to_ride(arg0, &arg2, arg3, 0x2::clock::timestamp_ms(arg5));
        0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::update_stats(arg0, 0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::ride_info_rider_wallet(&v6), 1, arg4);
    }

    public entry fun pause(arg0: &mut 0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::RideSyncState, arg1: &0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::RoleManager, arg2: &0x2::tx_context::TxContext) {
        let v0 = b"Admin";
        assert_has_role(arg1, 0x2::tx_context::sender(arg2), &v0);
        0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::set_paused(arg0, true);
    }

    public entry fun request_ride(arg0: &mut 0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::RideSyncState, arg1: &0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::RoleManager, arg2: vector<u8>, arg3: u64, arg4: u32, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(!0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::is_paused(arg0), 100);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = b"Rider";
        let v2 = if (0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::has_role(arg1, v0, &v1)) {
            true
        } else {
            let v3 = b"Admin";
            0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::has_role(arg1, v0, &v3)
        };
        assert!(v2, 101);
        assert!(!0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::ride_exists(arg0, &arg2), 102);
        assert!(arg3 > 0, 105);
        0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::add_new_ride(arg0, arg2, arg3, v0, 0x2::clock::timestamp_ms(arg5));
        0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::update_stats(arg0, v0, 0, arg4);
    }

    public entry fun revoke_role(arg0: &mut 0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::RoleManager, arg1: address, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = b"Admin";
        assert_has_role(arg0, v0, &v1);
        if (arg2 == b"Admin") {
            assert!(0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::admin_count(arg0) > 1 || arg1 != v0, 107);
        };
        assert!(is_valid_role(&arg2), 106);
        0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::manage_role(arg0, arg1, &arg2, false, v0);
    }

    public entry fun unpause(arg0: &mut 0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::RideSyncState, arg1: &0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::RoleManager, arg2: &0x2::tx_context::TxContext) {
        let v0 = b"Admin";
        assert_has_role(arg1, 0x2::tx_context::sender(arg2), &v0);
        0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state::set_paused(arg0, false);
    }

    // decompiled from Move bytecode v6
}

