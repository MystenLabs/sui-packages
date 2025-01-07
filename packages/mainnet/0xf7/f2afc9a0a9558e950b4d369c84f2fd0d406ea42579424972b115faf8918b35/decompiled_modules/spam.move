module 0xf7f2afc9a0a9558e950b4d369c84f2fd0d406ea42579424972b115faf8918b35::spam {
    struct SPAM has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Director has store, key {
        id: 0x2::object::UID,
        paused: bool,
        tx_count: u64,
        shares_count: u64,
        epoch_reward: u64,
        treasury: 0x2::coin::TreasuryCap<SPAM>,
        epoch_counters: 0x2::table::Table<u64, EpochCounter>,
    }

    struct EpochCounter has store {
        epoch: u64,
        epoch_reward: u64,
        tx_count: u64,
        tx_shares: u64,
        inv_shares: u64,
        user_counts: 0x2::table::Table<address, u64>,
    }

    struct UserCounter has key {
        id: 0x2::object::UID,
        epoch: u64,
        tx_count: u64,
        tx_shares: u64,
        inv_shares: u64,
        inv_address: address,
        registered: bool,
    }

    struct Stats has copy, drop {
        epoch: u64,
        paused: bool,
        tx_count: u64,
        shares_count: u64,
        supply: u64,
        epochs: vector<EpochStats>,
    }

    struct EpochStats has copy, drop {
        epoch: u64,
        tx_count: u64,
        tx_shares: u64,
        inv_shares: u64,
    }

    public fun admin_destroy(arg0: AdminCap) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun admin_pause(arg0: &mut Director, arg1: &AdminCap) {
        arg0.paused = true;
    }

    public fun admin_resume(arg0: &mut Director, arg1: &AdminCap) {
        arg0.paused = false;
    }

    public fun claim_user_counter(arg0: &mut Director, arg1: UserCounter, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SPAM> {
        assert!(arg1.epoch <= 0x2::tx_context::epoch(arg2) - 2, 100);
        assert!(arg1.registered == true, 104);
        let v0 = 0x2::table::borrow_mut<u64, EpochCounter>(&mut arg0.epoch_counters, arg1.epoch);
        destroy_user_counter(arg1);
        0x2::coin::mint<SPAM>(&mut arg0.treasury, (((v0.epoch_reward as u128) * (0x2::table::remove<address, u64>(&mut v0.user_counts, 0x2::tx_context::sender(arg2)) as u128) / ((v0.tx_shares + v0.inv_shares) as u128)) as u64), arg2)
    }

    public fun destroy_user_counter(arg0: UserCounter) {
        let UserCounter {
            id          : v0,
            epoch       : _,
            tx_count    : _,
            tx_shares   : _,
            inv_shares  : _,
            inv_address : _,
            registered  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun get_or_create_epoch_counter(arg0: &mut Director, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : &mut EpochCounter {
        if (!0x2::table::contains<u64, EpochCounter>(&arg0.epoch_counters, arg1)) {
            let v0 = if (!0x2::table::contains<u64, EpochCounter>(&arg0.epoch_counters, arg1 - 1)) {
                arg0.epoch_reward
            } else {
                0x2::table::borrow<u64, EpochCounter>(&arg0.epoch_counters, arg1 - 1).epoch_reward * 90 / 100
            };
            let v1 = EpochCounter{
                epoch        : arg1,
                epoch_reward : v0,
                tx_count     : 0,
                tx_shares    : 0,
                inv_shares   : 0,
                user_counts  : 0x2::table::new<address, u64>(arg2),
            };
            0x2::table::add<u64, EpochCounter>(&mut arg0.epoch_counters, arg1, v1);
        };
        0x2::table::borrow_mut<u64, EpochCounter>(&mut arg0.epoch_counters, arg1)
    }

    entry fun increment_user_counter(arg0: &mut UserCounter, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.epoch == 0x2::tx_context::epoch(arg1), 100);
        if (arg0.inv_address == 0x2::tx_context::sender(arg1)) {
            arg0.tx_count = arg0.tx_count + 1;
            arg0.tx_shares = arg0.tx_shares + 10;
        } else {
            arg0.tx_count = arg0.tx_count + 1;
            arg0.tx_shares = arg0.tx_shares + 10;
            arg0.inv_shares = arg0.inv_shares + 2;
        };
    }

    fun init(arg0: SPAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPAM>(arg0, 4, b"SPAM2", b"SPAM2", b"The original Proof of Spam coin,SPAM 2.0 now.", 0x1::option::some<0x2::url::Url>(0xf7f2afc9a0a9558e950b4d369c84f2fd0d406ea42579424972b115faf8918b35::icon::get_icon_url()), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPAM>>(v1);
        let v2 = Director{
            id             : 0x2::object::new(arg1),
            paused         : true,
            tx_count       : 0,
            shares_count   : 0,
            epoch_reward   : 10000000000,
            treasury       : v0,
            epoch_counters : 0x2::table::new<u64, EpochCounter>(arg1),
        };
        0x2::coin::mint_and_transfer<SPAM>(&mut v2.treasury, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::share_object<Director>(v2);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
    }

    entry fun new_user_counter(arg0: &Director, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.paused == false, 101);
        let v0 = UserCounter{
            id          : 0x2::object::new(arg2),
            epoch       : 0x2::tx_context::epoch(arg2),
            tx_count    : 1,
            tx_shares   : 10,
            inv_shares  : 0,
            inv_address : arg1,
            registered  : false,
        };
        0x2::transfer::transfer<UserCounter>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun register_user_counter(arg0: &mut Director, arg1: &mut UserCounter, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.paused == false, 101);
        assert!(arg1.registered == false, 103);
        let v0 = 0x2::tx_context::epoch(arg2) - 1;
        assert!(arg1.epoch == v0, 100);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = get_or_create_epoch_counter(arg0, v0, arg2);
        let v3 = arg1.inv_shares + arg1.tx_shares;
        if (0x2::table::contains<address, u64>(&v2.user_counts, v1)) {
            let v4 = 0x2::table::borrow_mut<address, u64>(&mut v2.user_counts, v1);
            *v4 = *v4 + (v3 as u64);
        } else {
            0x2::table::add<address, u64>(&mut v2.user_counts, v1, v3);
        };
        let v5 = 0;
        let v6 = arg1.inv_address;
        if (v1 != v6) {
            let v7 = (arg1.tx_count as u64) * 3;
            v5 = v7;
            if (0x2::table::contains<address, u64>(&v2.user_counts, v6)) {
                let v8 = 0x2::table::borrow_mut<address, u64>(&mut v2.user_counts, v6);
                *v8 = *v8 + v7;
            } else {
                0x2::table::add<address, u64>(&mut v2.user_counts, v6, v7);
            };
        };
        v2.tx_count = v2.tx_count + arg1.tx_count;
        v2.tx_shares = v2.tx_shares + arg1.tx_shares;
        v2.inv_shares = v2.inv_shares + arg1.inv_shares + v5;
        arg0.tx_count = arg0.tx_count + arg1.tx_count;
        arg0.shares_count = arg0.shares_count + v3 + v5;
        arg1.registered = true;
    }

    public fun stats_for_recent_epochs(arg0: &Director, arg1: u64, arg2: &0x2::tx_context::TxContext) : Stats {
        let v0 = 0x2::tx_context::epoch(arg2);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < arg1 && v2 < v0) {
            let v3 = v2 + 1;
            v2 = v3;
            0x1::vector::push_back<u64>(&mut v1, v0 - v3);
        };
        stats_for_specific_epochs(arg0, v1, arg2)
    }

    public fun stats_for_specific_epochs(arg0: &Director, arg1: vector<u64>, arg2: &0x2::tx_context::TxContext) : Stats {
        let v0 = 0x1::vector::empty<EpochStats>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1)) {
            let v2 = *0x1::vector::borrow<u64>(&arg1, v1);
            if (0x2::table::contains<u64, EpochCounter>(&arg0.epoch_counters, v2)) {
                let v3 = 0x2::table::borrow<u64, EpochCounter>(&arg0.epoch_counters, v2);
                let v4 = EpochStats{
                    epoch      : v3.epoch,
                    tx_count   : v3.tx_count,
                    tx_shares  : v3.tx_shares,
                    inv_shares : v3.inv_shares,
                };
                0x1::vector::push_back<EpochStats>(&mut v0, v4);
            } else {
                let v5 = EpochStats{
                    epoch      : v2,
                    tx_count   : 0,
                    tx_shares  : 0,
                    inv_shares : 0,
                };
                0x1::vector::push_back<EpochStats>(&mut v0, v5);
            };
            v1 = v1 + 1;
        };
        Stats{
            epoch        : 0x2::tx_context::epoch(arg2),
            paused       : arg0.paused,
            tx_count     : arg0.tx_count,
            shares_count : arg0.shares_count,
            supply       : 0x2::coin::total_supply<SPAM>(&arg0.treasury),
            epochs       : v0,
        }
    }

    // decompiled from Move bytecode v6
}

