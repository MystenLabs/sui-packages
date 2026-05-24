module 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::history {
    struct UserReleaseData has copy, drop, store {
        total_amount: u64,
        released_amount: u64,
        last_release_time: u64,
    }

    struct HistoryStore has key {
        id: 0x2::object::UID,
        robot: address,
        users: 0x2::table::Table<address, UserReleaseData>,
        total_imported_amount: u64,
        total_released_amount: u64,
        version: u64,
    }

    fun add_to_user_balance<T0>(arg0: &mut 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::sunset::Contract<T0>, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::sunset::add_contract_balance_by_rebot<T0>(arg0, arg1, arg2, arg3);
    }

    public(friend) fun batch_import_users(arg0: &mut HistoryStore, arg1: vector<address>, arg2: vector<u64>, arg3: &0x2::clock::Clock) {
        check_version(arg0.version);
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 2);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<address>(&arg1, v1);
            let v3 = *0x1::vector::borrow<u64>(&arg2, v1);
            let v4 = UserReleaseData{
                total_amount      : v3,
                released_amount   : 0,
                last_release_time : 0x2::clock::timestamp_ms(arg3),
            };
            if (0x2::table::contains<address, UserReleaseData>(&arg0.users, v2)) {
                let v5 = 0x2::table::borrow_mut<address, UserReleaseData>(&mut arg0.users, v2);
                if (v3 >= v5.total_amount) {
                    arg0.total_imported_amount = arg0.total_imported_amount + v3 - v5.total_amount;
                } else {
                    arg0.total_imported_amount = arg0.total_imported_amount - v5.total_amount - v3;
                };
                *v5 = v4;
            } else {
                0x2::table::add<address, UserReleaseData>(&mut arg0.users, v2, v4);
                arg0.total_imported_amount = arg0.total_imported_amount + v3;
            };
            v1 = v1 + 1;
        };
    }

    fun calc_daily_release_amount(arg0: u64, arg1: u64) : u64 {
        if (arg1 >= arg0) {
            return 0
        };
        let v0 = arg0 - arg1;
        let v1 = arg0 * 10 / 10000;
        if (v1 >= v0) {
            v0
        } else {
            v1
        }
    }

    fun check_version(arg0: u64) {
        assert!(arg0 == 1, 100);
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

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HistoryStore{
            id                    : 0x2::object::new(arg0),
            robot                 : @0xa30fc092c673a46dac2d30e984ff73ac298276b8b660a333f2804258116239d6,
            users                 : 0x2::table::new<address, UserReleaseData>(arg0),
            total_imported_amount : 0,
            total_released_amount : 0,
            version               : 1,
        };
        0x2::transfer::share_object<HistoryStore>(v0);
    }

    public fun robot_batch_release<T0>(arg0: &mut HistoryStore, arg1: vector<address>, arg2: &mut 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::sunset::Contract<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg0.version);
        assert!(0x2::tx_context::sender(arg4) == arg0.robot, 1);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg1)) {
            let v2 = *0x1::vector::borrow<address>(&arg1, v1);
            assert!(0x2::table::contains<address, UserReleaseData>(&arg0.users, v2), 3);
            let v3 = 0x2::table::borrow_mut<address, UserReleaseData>(&mut arg0.users, v2);
            assert!(v0 >= v3.last_release_time && v0 - v3.last_release_time >= 86400000, 5);
            let v4 = calc_daily_release_amount(v3.total_amount, v3.released_amount);
            if (v4 > 0) {
                assert!(v3.released_amount + v4 <= v3.total_amount, 4);
                add_to_user_balance<T0>(arg2, v2, v4, arg4);
                v3.released_amount = v3.released_amount + v4;
                arg0.total_released_amount = arg0.total_released_amount + v4;
            };
            v3.last_release_time = v0;
            v1 = v1 + 1;
        };
    }

    public(friend) fun set_robot(arg0: &mut HistoryStore, arg1: address) {
        arg0.robot = arg1;
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

