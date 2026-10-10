module 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::history {
    struct UserReleaseData has copy, drop, store {
        total_amount: u64,
        released_amount: u64,
        last_release_time: u64,
    }

    struct HistoryStore has key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<address, UserReleaseData>,
        total_imported_amount: u64,
        total_released_amount: u64,
        version: u64,
    }

    fun add_to_user_balance<T0, T1>(arg0: &mut 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::sunset::Contract<T0, T1>, arg1: address, arg2: u64) {
        0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::sunset::add_repurchase_points<T0, T1>(arg0, arg1, arg2);
    }

    public(friend) fun batch_import_users(arg0: &mut HistoryStore, arg1: vector<address>, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<u64>) {
        check_version(arg0.version);
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 2);
        assert!(v0 == 0x1::vector::length<u64>(&arg4), 2);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<address>(&arg1, v1);
            let v3 = *0x1::vector::borrow<u64>(&arg2, v1);
            let v4 = *0x1::vector::borrow<u64>(&arg3, v1);
            assert!(v4 <= v3, 2);
            let v5 = UserReleaseData{
                total_amount      : v3,
                released_amount   : v4,
                last_release_time : *0x1::vector::borrow<u64>(&arg4, v1),
            };
            if (0x2::table::contains<address, UserReleaseData>(&arg0.users, v2)) {
                let v6 = 0x2::table::borrow_mut<address, UserReleaseData>(&mut arg0.users, v2);
                if (v3 >= v6.total_amount) {
                    arg0.total_imported_amount = arg0.total_imported_amount + v3 - v6.total_amount;
                } else {
                    arg0.total_imported_amount = arg0.total_imported_amount - v6.total_amount - v3;
                };
                if (v4 >= v6.released_amount) {
                    arg0.total_released_amount = arg0.total_released_amount + v4 - v6.released_amount;
                } else {
                    arg0.total_released_amount = arg0.total_released_amount - v6.released_amount - v4;
                };
                *v6 = v5;
            } else {
                0x2::table::add<address, UserReleaseData>(&mut arg0.users, v2, v5);
                arg0.total_imported_amount = arg0.total_imported_amount + v3;
                arg0.total_released_amount = arg0.total_released_amount + v4;
            };
            v1 = v1 + 1;
        };
    }

    fun calc_daily_release_amount(arg0: u64, arg1: u64) : u64 {
        if (arg1 >= arg0) {
            return 0
        };
        let v0 = arg0 - arg1;
        let v1 = arg0 * 40 / 10000;
        if (v1 >= v0) {
            v0
        } else {
            v1
        }
    }

    fun check_version(arg0: u64) {
        assert!(arg0 == 1, 100);
    }

    public fun claim_release<T0, T1>(arg0: &mut HistoryStore, arg1: &mut 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::sunset::Contract<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg0.version);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, UserReleaseData>(&arg0.users, v1), 3);
        let v2 = 0x2::table::borrow_mut<address, UserReleaseData>(&mut arg0.users, v1);
        assert!(v2.last_release_time == 0 || v0 >= v2.last_release_time && v0 - v2.last_release_time >= 86400000, 5);
        let v3 = calc_daily_release_amount(v2.total_amount, v2.released_amount);
        if (v3 > 0) {
            assert!(v2.released_amount + v3 <= v2.total_amount, 4);
            add_to_user_balance<T0, T1>(arg1, v1, v3);
            v2.released_amount = v2.released_amount + v3;
            arg0.total_released_amount = arg0.total_released_amount + v3;
        };
        v2.last_release_time = v0;
    }

    fun create_history_store(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HistoryStore{
            id                    : 0x2::object::new(arg0),
            users                 : 0x2::table::new<address, UserReleaseData>(arg0),
            total_imported_amount : 0,
            total_released_amount : 0,
            version               : 1,
        };
        0x2::transfer::share_object<HistoryStore>(v0);
    }

    public fun get_claimable_amount(arg0: &HistoryStore, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        if (!0x2::table::contains<address, UserReleaseData>(&arg0.users, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, UserReleaseData>(&arg0.users, arg1);
        if (v0.released_amount >= v0.total_amount) {
            return 0
        };
        let v1 = 0x2::clock::timestamp_ms(arg2);
        if (v0.last_release_time != 0 && (v1 < v0.last_release_time || v1 - v0.last_release_time < 86400000)) {
            return 0
        };
        calc_daily_release_amount(v0.total_amount, v0.released_amount)
    }

    public fun get_total_imported_amount(arg0: &HistoryStore) : u64 {
        arg0.total_imported_amount
    }

    public fun get_total_released_amount(arg0: &HistoryStore) : u64 {
        arg0.total_released_amount
    }

    public fun get_user_data(arg0: &HistoryStore, arg1: address) : UserReleaseData {
        if (0x2::table::contains<address, UserReleaseData>(&arg0.users, arg1)) {
            *0x2::table::borrow<address, UserReleaseData>(&arg0.users, arg1)
        } else {
            UserReleaseData{total_amount: 0, released_amount: 0, last_release_time: 0}
        }
    }

    public(friend) fun init_history_store(arg0: &mut 0x2::tx_context::TxContext) {
        create_history_store(arg0);
    }

    public fun user_released_amount(arg0: &HistoryStore, arg1: address) : u64 {
        let v0 = get_user_data(arg0, arg1);
        v0.released_amount
    }

    public fun user_total_amount(arg0: &HistoryStore, arg1: address) : u64 {
        let v0 = get_user_data(arg0, arg1);
        v0.total_amount
    }

    // decompiled from Move bytecode v7
}

