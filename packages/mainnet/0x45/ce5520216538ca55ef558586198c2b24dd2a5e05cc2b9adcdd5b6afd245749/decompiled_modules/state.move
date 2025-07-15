module 0x45ce5520216538ca55ef558586198c2b24dd2a5e05cc2b9adcdd5b6afd245749::state {
    struct RideInfo has copy, drop, store {
        ride_id: vector<u8>,
        rider_wallet: address,
        driver_wallet: 0x1::option::Option<address>,
        fare: u64,
        status: u8,
        requested_timestamp_ms: u64,
        last_updated_timestamp_ms: u64,
    }

    struct DailyStat has copy, drop, store {
        date_yyyymmdd: u32,
        requests: u64,
        matches: u64,
        completions: u64,
    }

    struct RideStats has store {
        total_requests: u64,
        total_matches: u64,
        total_completions: u64,
        unique_riders: 0x2::table::Table<address, bool>,
        daily_stats: 0x2::table::Table<u32, DailyStat>,
    }

    struct RideSyncState has store, key {
        id: 0x2::object::UID,
        is_paused: bool,
        rides: 0x2::table::Table<vector<u8>, RideInfo>,
        all_ride_ids: vector<vector<u8>>,
        stats: RideStats,
    }

    struct RoleManager has store, key {
        id: 0x2::object::UID,
        admins: 0x2::table::Table<address, bool>,
        riders: 0x2::table::Table<address, bool>,
        drivers: 0x2::table::Table<address, bool>,
        writers: 0x2::table::Table<address, bool>,
    }

    struct RideSyncAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RideStatusChanged has copy, drop {
        ride_info: RideInfo,
    }

    struct FullRideEmittedForIndexer has copy, drop {
        ride_info: RideInfo,
    }

    struct AdminActionLog has copy, drop {
        admin_address: address,
        action: vector<u8>,
        affected_address: address,
        role: vector<u8>,
    }

    struct ContractPaused has copy, drop {
        is_paused: bool,
    }

    public fun add_new_ride(arg0: &mut RideSyncState, arg1: vector<u8>, arg2: u64, arg3: address, arg4: u64) : RideInfo {
        let v0 = RideInfo{
            ride_id                   : arg1,
            rider_wallet              : arg3,
            driver_wallet             : 0x1::option::none<address>(),
            fare                      : arg2,
            status                    : 0,
            requested_timestamp_ms    : arg4,
            last_updated_timestamp_ms : arg4,
        };
        0x2::table::add<vector<u8>, RideInfo>(&mut arg0.rides, v0.ride_id, v0);
        0x1::vector::push_back<vector<u8>>(&mut arg0.all_ride_ids, v0.ride_id);
        let v1 = RideStatusChanged{ride_info: v0};
        0x2::event::emit<RideStatusChanged>(v1);
        v0
    }

    public fun admin_count(arg0: &RoleManager) : u64 {
        0x2::table::length<address, bool>(&arg0.admins)
    }

    public fun all_ride_ids(arg0: &RideSyncState) : &vector<vector<u8>> {
        &arg0.all_ride_ids
    }

    public fun assign_driver_to_ride(arg0: &mut RideSyncState, arg1: &vector<u8>, arg2: address, arg3: u64) : RideInfo {
        let v0 = 0x2::table::borrow_mut<vector<u8>, RideInfo>(&mut arg0.rides, *arg1);
        v0.driver_wallet = 0x1::option::some<address>(arg2);
        v0.status = 1;
        v0.last_updated_timestamp_ms = arg3;
        let v1 = RideStatusChanged{ride_info: *v0};
        0x2::event::emit<RideStatusChanged>(v1);
        *v0
    }

    public fun cancel_ride_status(arg0: &mut RideSyncState, arg1: &vector<u8>, arg2: u64) : RideInfo {
        let v0 = 0x2::table::borrow_mut<vector<u8>, RideInfo>(&mut arg0.rides, *arg1);
        v0.status = 3;
        v0.last_updated_timestamp_ms = arg2;
        let v1 = RideStatusChanged{ride_info: *v0};
        0x2::event::emit<RideStatusChanged>(v1);
        *v0
    }

    public fun complete_ride_status(arg0: &mut RideSyncState, arg1: &vector<u8>, arg2: u64) : RideInfo {
        let v0 = 0x2::table::borrow_mut<vector<u8>, RideInfo>(&mut arg0.rides, *arg1);
        v0.status = 2;
        v0.last_updated_timestamp_ms = arg2;
        let v1 = RideStatusChanged{ride_info: *v0};
        0x2::event::emit<RideStatusChanged>(v1);
        *v0
    }

    public fun daily_stats(arg0: &RideSyncState, arg1: u32) : 0x1::option::Option<DailyStat> {
        if (0x2::table::contains<u32, DailyStat>(&arg0.stats.daily_stats, arg1)) {
            0x1::option::some<DailyStat>(*0x2::table::borrow<u32, DailyStat>(&arg0.stats.daily_stats, arg1))
        } else {
            0x1::option::none<DailyStat>()
        }
    }

    public fun emit_full_ride_for_indexer(arg0: RideInfo) {
        let v0 = FullRideEmittedForIndexer{ride_info: arg0};
        0x2::event::emit<FullRideEmittedForIndexer>(v0);
    }

    public fun has_role(arg0: &RoleManager, arg1: address, arg2: &vector<u8>) : bool {
        let v0 = b"Admin";
        if (arg2 == &v0) {
            0x2::table::contains<address, bool>(&arg0.admins, arg1)
        } else {
            let v2 = b"Rider";
            if (arg2 == &v2) {
                0x2::table::contains<address, bool>(&arg0.riders, arg1)
            } else {
                let v3 = b"Driver";
                if (arg2 == &v3) {
                    0x2::table::contains<address, bool>(&arg0.drivers, arg1)
                } else {
                    let v4 = b"Writer";
                    arg2 == &v4 && 0x2::table::contains<address, bool>(&arg0.writers, arg1)
                }
            }
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = RideSyncAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<RideSyncAdminCap>(v1, v0);
        let v2 = 0x2::table::new<address, bool>(arg0);
        0x2::table::add<address, bool>(&mut v2, v0, true);
        let v3 = RoleManager{
            id      : 0x2::object::new(arg0),
            admins  : v2,
            riders  : 0x2::table::new<address, bool>(arg0),
            drivers : 0x2::table::new<address, bool>(arg0),
            writers : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::public_share_object<RoleManager>(v3);
        let v4 = RideStats{
            total_requests    : 0,
            total_matches     : 0,
            total_completions : 0,
            unique_riders     : 0x2::table::new<address, bool>(arg0),
            daily_stats       : 0x2::table::new<u32, DailyStat>(arg0),
        };
        let v5 = RideSyncState{
            id           : 0x2::object::new(arg0),
            is_paused    : false,
            rides        : 0x2::table::new<vector<u8>, RideInfo>(arg0),
            all_ride_ids : 0x1::vector::empty<vector<u8>>(),
            stats        : v4,
        };
        0x2::transfer::public_share_object<RideSyncState>(v5);
    }

    public fun is_paused(arg0: &RideSyncState) : bool {
        arg0.is_paused
    }

    public fun manage_role(arg0: &mut RoleManager, arg1: address, arg2: &vector<u8>, arg3: bool, arg4: address) {
        let v0 = if (arg3) {
            let v1 = b"Admin";
            if (arg2 == &v1) {
                if (!0x2::table::contains<address, bool>(&arg0.admins, arg1)) {
                    0x2::table::add<address, bool>(&mut arg0.admins, arg1, true);
                };
            } else {
                let v2 = b"Rider";
                if (arg2 == &v2) {
                    if (!0x2::table::contains<address, bool>(&arg0.riders, arg1)) {
                        0x2::table::add<address, bool>(&mut arg0.riders, arg1, true);
                    };
                } else {
                    let v3 = b"Driver";
                    if (arg2 == &v3) {
                        if (!0x2::table::contains<address, bool>(&arg0.drivers, arg1)) {
                            0x2::table::add<address, bool>(&mut arg0.drivers, arg1, true);
                        };
                    } else {
                        let v4 = b"Writer";
                        if (arg2 == &v4) {
                            if (!0x2::table::contains<address, bool>(&arg0.writers, arg1)) {
                                0x2::table::add<address, bool>(&mut arg0.writers, arg1, true);
                            };
                        };
                    };
                };
            };
            b"ASSIGN_ROLE"
        } else {
            let v5 = b"Admin";
            if (arg2 == &v5) {
                if (0x2::table::contains<address, bool>(&arg0.admins, arg1)) {
                    0x2::table::remove<address, bool>(&mut arg0.admins, arg1);
                };
            } else {
                let v6 = b"Rider";
                if (arg2 == &v6) {
                    if (0x2::table::contains<address, bool>(&arg0.riders, arg1)) {
                        0x2::table::remove<address, bool>(&mut arg0.riders, arg1);
                    };
                } else {
                    let v7 = b"Driver";
                    if (arg2 == &v7) {
                        if (0x2::table::contains<address, bool>(&arg0.drivers, arg1)) {
                            0x2::table::remove<address, bool>(&mut arg0.drivers, arg1);
                        };
                    } else {
                        let v8 = b"Writer";
                        if (arg2 == &v8) {
                            if (0x2::table::contains<address, bool>(&arg0.writers, arg1)) {
                                0x2::table::remove<address, bool>(&mut arg0.writers, arg1);
                            };
                        };
                    };
                };
            };
            b"REVOKE_ROLE"
        };
        let v9 = AdminActionLog{
            admin_address    : arg4,
            action           : v0,
            affected_address : arg1,
            role             : *arg2,
        };
        0x2::event::emit<AdminActionLog>(v9);
    }

    public fun remove_archived_ride(arg0: &mut RideSyncState, arg1: vector<u8>) {
        0x2::table::remove<vector<u8>, RideInfo>(&mut arg0.rides, arg1);
        let (v0, v1) = 0x1::vector::index_of<vector<u8>>(&arg0.all_ride_ids, &arg1);
        if (v0) {
            0x1::vector::remove<vector<u8>>(&mut arg0.all_ride_ids, v1);
        };
    }

    public fun ride_exists(arg0: &RideSyncState, arg1: &vector<u8>) : bool {
        0x2::table::contains<vector<u8>, RideInfo>(&arg0.rides, *arg1)
    }

    public fun ride_info(arg0: &RideSyncState, arg1: &vector<u8>) : RideInfo {
        *0x2::table::borrow<vector<u8>, RideInfo>(&arg0.rides, *arg1)
    }

    public fun ride_info_rider_wallet(arg0: &RideInfo) : address {
        arg0.rider_wallet
    }

    public fun ride_info_status(arg0: &RideInfo) : u8 {
        arg0.status
    }

    public fun set_paused(arg0: &mut RideSyncState, arg1: bool) {
        arg0.is_paused = arg1;
        let v0 = ContractPaused{is_paused: arg1};
        0x2::event::emit<ContractPaused>(v0);
    }

    public fun total_stats(arg0: &RideSyncState) : (u64, u64, u64) {
        (arg0.stats.total_requests, arg0.stats.total_matches, arg0.stats.total_completions)
    }

    public fun unique_rider_count(arg0: &RideSyncState) : u64 {
        0x2::table::length<address, bool>(&arg0.stats.unique_riders)
    }

    public fun update_stats(arg0: &mut RideSyncState, arg1: address, arg2: u8, arg3: u32) {
        let v0 = &mut arg0.stats;
        if (arg2 == 0) {
            v0.total_requests = v0.total_requests + 1;
            if (!0x2::table::contains<address, bool>(&v0.unique_riders, arg1)) {
                0x2::table::add<address, bool>(&mut v0.unique_riders, arg1, true);
            };
        } else if (arg2 == 1) {
            v0.total_matches = v0.total_matches + 1;
        } else if (arg2 == 2) {
            v0.total_completions = v0.total_completions + 1;
        };
        let v1 = if (0x2::table::contains<u32, DailyStat>(&v0.daily_stats, arg3)) {
            0x2::table::borrow_mut<u32, DailyStat>(&mut v0.daily_stats, arg3)
        } else {
            let v2 = DailyStat{
                date_yyyymmdd : arg3,
                requests      : 0,
                matches       : 0,
                completions   : 0,
            };
            0x2::table::add<u32, DailyStat>(&mut v0.daily_stats, arg3, v2);
            0x2::table::borrow_mut<u32, DailyStat>(&mut v0.daily_stats, arg3)
        };
        if (arg2 == 0) {
            v1.requests = v1.requests + 1;
        } else if (arg2 == 1) {
            v1.matches = v1.matches + 1;
        } else if (arg2 == 2) {
            v1.completions = v1.completions + 1;
        };
    }

    // decompiled from Move bytecode v6
}

