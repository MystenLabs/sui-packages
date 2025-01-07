module 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::airdrop {
    struct AirdropGlobal has key {
        id: 0x2::object::UID,
        start: u64,
        creator: address,
        balance_SHUI: 0x2::balance::Balance<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>,
        daily_claim_records_list: 0x2::table::Table<address, u64>,
        total_claim_amount: u64,
        now_days: u64,
        total_daily_claim_amount: u64,
    }

    struct TimeCap has key {
        id: 0x2::object::UID,
    }

    public entry fun claim_airdrop(arg0: &mut 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::mission::MissionGlobal, arg1: &mut AirdropGlobal, arg2: &0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::MetaIdentity, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::is_active(arg2), 7);
        assert!(arg1.start > 0, 5);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = get_per_amount_by_time(arg1, arg3);
        let v3 = get_now_days(arg3, arg1);
        if (v3 > arg1.now_days) {
            arg1.now_days = v3;
            arg1.total_daily_claim_amount = v2;
        } else {
            arg1.total_daily_claim_amount = arg1.total_daily_claim_amount + v2;
        };
        arg1.total_claim_amount = arg1.total_claim_amount + v2;
        assert!(arg1.total_daily_claim_amount < get_daily_limit(v3), 8);
        let v4 = 0;
        if (0x2::table::contains<address, u64>(&arg1.daily_claim_records_list, v1)) {
            v4 = *0x2::table::borrow<address, u64>(&arg1.daily_claim_records_list, v1);
        };
        assert!(v0 - v4 > 86400000, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>>(0x2::coin::from_balance<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>(0x2::balance::split<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>(&mut arg1.balance_SHUI, v2), arg4), 0x2::tx_context::sender(arg4));
        let v5 = &mut arg1.daily_claim_records_list;
        record_claim_time(v5, v0, v1);
        0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::mission::add_process(arg0, 0x1::string::utf8(b"claim airdrop"), arg2);
    }

    public entry fun claim_boat_whitelist_airdrop(arg0: &mut AirdropGlobal, arg1: &mut 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::boat_ticket::BoatTicket, arg2: &0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::MetaIdentity, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::metaIdentity::is_active(arg2), 7);
        assert!(!0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::boat_ticket::is_claimed(arg1), 9);
        assert!(0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::boat_ticket::get_index(arg1) <= 1000, 16);
        0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>>(0x2::coin::from_balance<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>(0x2::balance::split<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>(&mut arg0.balance_SHUI, 10000 * 1000000000), arg3), 0x2::tx_context::sender(arg3));
        0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::boat_ticket::record_white_list_clamed(arg1);
    }

    public fun get_airdrop_claimed(arg0: &AirdropGlobal, arg1: &0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::boat_ticket::BoatTicket, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        if (0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::boat_ticket::is_claimed(arg1)) {
            1
        } else {
            0
        }
    }

    public entry fun get_airdrop_diff_time(arg0: &AirdropGlobal, arg1: &0x2::clock::Clock, arg2: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.daily_claim_records_list, arg2)) {
            0x2::clock::timestamp_ms(arg1) - *0x2::table::borrow<address, u64>(&arg0.daily_claim_records_list, arg2)
        } else {
            0x2::clock::timestamp_ms(arg1)
        }
    }

    public entry fun get_culmulate_remain_amount(arg0: &0x2::clock::Clock, arg1: &AirdropGlobal) : u64 {
        assert!(arg1.start > 0, 5);
        let v0 = (0x2::clock::timestamp_ms(arg0) - arg1.start) / 86400000;
        if (v0 == 0) {
            0
        } else if (v0 <= 30) {
            v0 * 1000000 * 1000000000 - arg1.total_claim_amount
        } else if (v0 <= 60) {
            (30 + v0 * 2) * 1000000 * 1000000000 - arg1.total_claim_amount
        } else if (v0 <= 90) {
            (90 + v0 * 3) * 1000000 * 1000000000 - arg1.total_claim_amount
        } else if (v0 <= 120) {
            (180 + v0 * 4) * 1000000 * 1000000000 - arg1.total_claim_amount
        } else if (v0 <= 150) {
            (300 + v0 * 5) * 1000000 * 1000000000 - arg1.total_claim_amount
        } else {
            (450 + v0) * 1000000 * 1000000000 - arg1.total_claim_amount
        }
    }

    public entry fun get_daily_limit(arg0: u64) : u64 {
        if (arg0 >= 150) {
            1000000 * 1000000000
        } else {
            (arg0 / 30 + 1) * 1000000 * 1000000000
        }
    }

    public entry fun get_daily_remain_amount(arg0: &0x2::clock::Clock, arg1: &AirdropGlobal) : u64 {
        get_daily_limit((0x2::clock::timestamp_ms(arg0) - arg1.start) / 86400000) - arg1.total_daily_claim_amount
    }

    public fun get_now_days(arg0: &0x2::clock::Clock, arg1: &AirdropGlobal) : u64 {
        (0x2::clock::timestamp_ms(arg0) - arg1.start) / 86400000 + 1
    }

    public fun get_participator_num(arg0: &AirdropGlobal) : u64 {
        0x2::table::length<address, u64>(&arg0.daily_claim_records_list)
    }

    fun get_per_amount_by_time(arg0: &AirdropGlobal, arg1: &0x2::clock::Clock) : u64 {
        let v0 = get_phase_by_time(arg0, arg1);
        assert!(v0 >= 1 && v0 <= 6, 1);
        if (v0 == 6) {
            return 10
        };
        (60 - v0 * 10) * 1000000000
    }

    public fun get_phase_by_time(arg0: &AirdropGlobal, arg1: &0x2::clock::Clock) : u64 {
        let v0 = (0x2::clock::timestamp_ms(arg1) - arg0.start) / 30 * 86400000 + 1;
        let v1 = v0;
        if (v0 > 6) {
            v1 = 6;
        };
        v1
    }

    public entry fun get_total_claim_amount(arg0: &AirdropGlobal) : u64 {
        arg0.total_claim_amount
    }

    public entry fun get_total_daily_claim_amount(arg0: &AirdropGlobal) : u64 {
        arg0.total_daily_claim_amount
    }

    public entry fun get_total_shui_balance(arg0: &AirdropGlobal) : u64 {
        0x2::balance::value<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>(&arg0.balance_SHUI)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AirdropGlobal{
            id                       : 0x2::object::new(arg0),
            start                    : 0,
            creator                  : 0x2::tx_context::sender(arg0),
            balance_SHUI             : 0x2::balance::zero<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>(),
            daily_claim_records_list : 0x2::table::new<address, u64>(arg0),
            total_claim_amount       : 0,
            now_days                 : 0,
            total_daily_claim_amount : 0,
        };
        0x2::transfer::share_object<AirdropGlobal>(v0);
        let v1 = TimeCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<TimeCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun init_funds_from_main_contract(arg0: &mut AirdropGlobal, arg1: &mut 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::Global, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 2);
        0x2::balance::join<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>(&mut arg0.balance_SHUI, 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::extract_airdrop_balance(arg1, arg2));
    }

    public fun is_airdrop_claimed(arg0: &AirdropGlobal, arg1: &0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::boat_ticket::BoatTicket, arg2: &mut 0x2::tx_context::TxContext) : bool {
        0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::boat_ticket::is_claimed(arg1)
    }

    fun record_claim_time(arg0: &mut 0x2::table::Table<address, u64>, arg1: u64, arg2: address) {
        if (0x2::table::contains<address, u64>(arg0, arg2)) {
            0x2::table::remove<address, u64>(arg0, arg2);
        };
        0x2::table::add<address, u64>(arg0, arg2, arg1);
    }

    public entry fun start_timing(arg0: &mut AirdropGlobal, arg1: TimeCap, arg2: &0x2::clock::Clock) {
        arg0.start = 0x2::clock::timestamp_ms(arg2);
        let TimeCap { id: v0 } = arg1;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

