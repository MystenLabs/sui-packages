module 0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::round_manager {
    struct Round has store, key {
        id: 0x2::object::UID,
        index: u64,
        phase: u8,
        closes_at_ms: u64,
        entries: vector<vector<Entry>>,
        total: u64,
    }

    struct Entry has copy, drop, store {
        owner: address,
        amount: u64,
    }

    struct PlayerRecord has store {
        unclaimed_sui: u64,
        total_wins: u64,
        total_entries: u64,
        last_round: u64,
    }

    struct Global has store, key {
        id: 0x2::object::UID,
        admin: address,
        round: Round,
        paused: bool,
        fee_split: 0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::treasury::FeeSplit,
        vaults: 0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::treasury::Vaults,
        cap: 0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::faith::SupplyCap,
        idx: 0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::faith::RefiningIndex,
        buckets: 0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::faith::Buckets,
        godlode: 0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::godlode::Godlode,
        player_records: 0x2::table::Table<address, PlayerRecord>,
    }

    struct RoundSettled has copy, drop {
        index: u64,
        winning: u64,
        fee: u64,
        redistributed: u64,
    }

    struct EntryAdded has copy, drop {
        index: u64,
        owner: address,
        block_id: u64,
        amount: u64,
    }

    struct ClaimAllEvent has copy, drop {
        user: address,
        sui_claimed: u64,
        faith_claimed: u64,
    }

    struct RoundOpened has copy, drop {
        index: u64,
        closes_at_ms: u64,
    }

    struct PausedEvent has copy, drop {
        admin: address,
        paused: bool,
    }

    struct TreasurySplitUpdatedEvent has copy, drop {
        admin: address,
        faithed_bps: u64,
        manifest_bps: u64,
        ops_bps: u64,
    }

    struct AdminFaithedWithdrawEvent has copy, drop {
        admin: address,
        to: address,
        amount: u64,
    }

    struct AdminManifestWithdrawEvent has copy, drop {
        admin: address,
        to: address,
        amount: u64,
    }

    struct RoundMissed has copy, drop {
        index: u64,
        closes_at_ms: u64,
        settled_at_ms: u64,
        total: u64,
    }

    fun assert_admin(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x66ceb4e01d5dbfda6f6737dd484a9085851624604cae86ac4c4712af7627d24, 0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::errors::E_UNAUTH());
    }

    public entry fun claim_all_entry(arg0: &mut Global, arg1: &mut 0x2::coin::TreasuryCap<0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::faith::FAITH>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x66ceb4e01d5dbfda6f6737dd484a9085851624604cae86ac4c4712af7627d24, 0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::errors::E_UNAUTH());
        let v0 = claim_sui_internal(arg0, arg2, arg3);
        let v1 = ClaimAllEvent{
            user          : arg2,
            sui_claimed   : v0,
            faith_claimed : claim_faith_internal(arg0, arg1, arg2, arg3),
        };
        0x2::event::emit<ClaimAllEvent>(v1);
    }

    public entry fun claim_faith_entry(arg0: &mut Global, arg1: &mut 0x2::coin::TreasuryCap<0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::faith::FAITH>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x66ceb4e01d5dbfda6f6737dd484a9085851624604cae86ac4c4712af7627d24, 0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::errors::E_UNAUTH());
        claim_faith_internal(arg0, arg1, arg2, arg3);
    }

    fun claim_faith_internal(arg0: &mut Global, arg1: &mut 0x2::coin::TreasuryCap<0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::faith::FAITH>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::faith::claim_if_any(arg2, 1000, &mut arg0.cap, &mut arg0.idx, &mut arg0.buckets);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::faith::FAITH>>(0x2::coin::mint<0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::faith::FAITH>(arg1, v0, arg3), arg2);
        };
        v0
    }

    public entry fun claim_sui_entry(arg0: &mut Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x66ceb4e01d5dbfda6f6737dd484a9085851624604cae86ac4c4712af7627d24, 0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::errors::E_UNAUTH());
        let v0 = ClaimAllEvent{
            user          : arg1,
            sui_claimed   : claim_sui_internal(arg0, arg1, arg2),
            faith_claimed : 0,
        };
        0x2::event::emit<ClaimAllEvent>(v0);
    }

    fun claim_sui_internal(arg0: &mut Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0;
        if (0x2::table::contains<address, PlayerRecord>(&arg0.player_records, arg1)) {
            let v1 = 0x2::table::borrow_mut<address, PlayerRecord>(&mut arg0.player_records, arg1);
            v0 = v1.unclaimed_sui;
            v1.unclaimed_sui = 0;
        };
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::treasury::withdraw_faithed(&mut arg0.vaults, v0, arg2), arg1);
        };
        v0
    }

    public entry fun create_global_shared(arg0: address, arg1: 0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::faith::SupplyCap, arg2: 0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::faith::RefiningIndex, arg3: 0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::faith::Buckets, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::treasury::create(arg6);
        let v2 = Round{
            id           : 0x2::object::new(arg6),
            index        : 0,
            phase        : 0,
            closes_at_ms : 0,
            entries      : empty_entries(),
            total        : 0,
        };
        let v3 = Global{
            id             : 0x2::object::new(arg6),
            admin          : arg0,
            round          : v2,
            paused         : false,
            fee_split      : v0,
            vaults         : v1,
            cap            : arg1,
            idx            : arg2,
            buckets        : arg3,
            godlode        : 0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::godlode::create(arg4, arg5, arg6),
            player_records : 0x2::table::new<address, PlayerRecord>(arg6),
        };
        0x2::transfer::share_object<Global>(v3);
    }

    fun empty_entries() : vector<vector<Entry>> {
        let v0 = 0x1::vector::empty<vector<Entry>>();
        let v1 = 0;
        while (v1 < 25) {
            0x1::vector::push_back<vector<Entry>>(&mut v0, 0x1::vector::empty<Entry>());
            v1 = v1 + 1;
        };
        v0
    }

    fun empty_record(arg0: u64) : PlayerRecord {
        PlayerRecord{
            unclaimed_sui : 0,
            total_wins    : 0,
            total_entries : 0,
            last_round    : arg0,
        }
    }

    fun ensure_record(arg0: &mut 0x2::table::Table<address, PlayerRecord>, arg1: address, arg2: u64) : &mut PlayerRecord {
        if (!0x2::table::contains<address, PlayerRecord>(arg0, arg1)) {
            0x2::table::add<address, PlayerRecord>(arg0, arg1, empty_record(arg2));
        };
        let v0 = 0x2::table::borrow_mut<address, PlayerRecord>(arg0, arg1);
        v0.last_round = arg2;
        v0
    }

    fun enter(arg0: &mut Global, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = if (arg0.paused) {
            true
        } else if (arg0.round.phase != 1) {
            true
        } else {
            arg1 >= 25
        };
        if (v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v0);
            return
        };
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v3 = &mut arg0.player_records;
        let v4 = ensure_record(v3, v0, arg0.round.index);
        v4.total_entries = v4.total_entries + 1;
        arg0.round.total = arg0.round.total + v2;
        let v5 = Entry{
            owner  : v0,
            amount : v2,
        };
        0x1::vector::push_back<Entry>(0x1::vector::borrow_mut<vector<Entry>>(&mut arg0.round.entries, arg1), v5);
        let v6 = EntryAdded{
            index    : arg0.round.index,
            owner    : v0,
            block_id : arg1,
            amount   : v2,
        };
        0x2::event::emit<EntryAdded>(v6);
        0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::treasury::deposit_to_faithed(&mut arg0.vaults, arg2);
    }

    public entry fun enter_entry(arg0: &mut Global, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        enter(arg0, arg1, arg2, arg3);
    }

    public entry fun force_settle_entry(arg0: &mut Global, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg3);
        settle(arg0, arg1, arg2, arg3);
    }

    fun open_round(arg0: &mut Global, arg1: u64) {
        if (arg0.paused) {
            return
        };
        if (arg0.round.phase != 0) {
            return
        };
        arg0.round.index = arg0.round.index + 1;
        arg0.round.phase = 1;
        arg0.round.closes_at_ms = arg1;
        arg0.round.entries = empty_entries();
        arg0.round.total = 0;
        let v0 = RoundOpened{
            index        : arg0.round.index,
            closes_at_ms : arg1,
        };
        0x2::event::emit<RoundOpened>(v0);
    }

    public entry fun open_round_entry(arg0: &mut Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        open_round(arg0, arg1);
    }

    public entry fun set_fee_split_entry(arg0: &mut Global, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg4);
        assert!(arg0.paused, 0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::errors::E_NOT_PAUSED());
        0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::treasury::set_split(&mut arg0.fee_split, arg1, arg2, arg3);
        let v0 = TreasurySplitUpdatedEvent{
            admin        : 0x2::tx_context::sender(arg4),
            faithed_bps  : arg1,
            manifest_bps : arg2,
            ops_bps      : arg3,
        };
        0x2::event::emit<TreasurySplitUpdatedEvent>(v0);
    }

    public entry fun set_paused_entry(arg0: &mut Global, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg2);
        arg0.paused = arg1;
        let v0 = PausedEvent{
            admin  : 0x2::tx_context::sender(arg2),
            paused : arg1,
        };
        0x2::event::emit<PausedEvent>(v0);
    }

    fun settle(arg0: &mut Global, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg0.round.phase != 1) {
            return
        };
        let v0 = arg0.round.closes_at_ms;
        if (arg1 < v0) {
            return
        };
        if (arg1 > v0 + 600000) {
            arg0.round.phase = 0;
            let v1 = RoundMissed{
                index         : arg0.round.index,
                closes_at_ms  : v0,
                settled_at_ms : arg1,
                total         : arg0.round.total,
            };
            0x2::event::emit<RoundMissed>(v1);
            return
        };
        arg0.round.phase = 2;
        let v2 = 0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::rng_oracle::pick(arg2, 25);
        let v3 = arg0.round.total;
        let v4 = v3 / 10;
        let v5 = v3 - v4;
        let v6 = 0x1::vector::borrow<vector<Entry>>(&arg0.round.entries, v2);
        let v7 = 0x1::vector::length<Entry>(v6);
        if (v7 > 0 && v5 > 0) {
            let v8 = 0;
            while (v8 < v7) {
                let v9 = *0x1::vector::borrow<Entry>(v6, v8);
                let v10 = v5 * v9.amount / sum_block(v6);
                let v11 = v10;
                if (v10 == 0 && v5 > 0) {
                    v11 = 1;
                };
                let v12 = &mut arg0.player_records;
                let v13 = ensure_record(v12, v9.owner, arg0.round.index);
                v13.unclaimed_sui = v13.unclaimed_sui + v11;
                v13.total_wins = v13.total_wins + 1;
                0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::faith::accrue_to(v9.owner, v11, &mut arg0.cap, &arg0.idx, &mut arg0.buckets, arg3);
                v8 = v8 + 1;
            };
        };
        if (v4 > 0) {
            0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::treasury::split_and_route_internal(0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::treasury::withdraw_faithed(&mut arg0.vaults, v4, arg3), &arg0.fee_split, &mut arg0.vaults, arg3);
        };
        0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::godlode::accrue(&mut arg0.godlode);
        let (v14, v15) = 0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::godlode::maybe_hit(&mut arg0.godlode, arg2 + 7919);
        if (v14 && v7 > 0) {
            let v16 = 0;
            while (v16 < v7) {
                let v17 = *0x1::vector::borrow<Entry>(v6, v16);
                let v18 = v15 * v17.amount / sum_block(v6);
                let v19 = v18;
                if (v18 == 0 && v15 > 0) {
                    v19 = 1;
                };
                let v20 = &mut arg0.player_records;
                ensure_record(v20, v17.owner, arg0.round.index);
                0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::faith::accrue_to(v17.owner, v19, &mut arg0.cap, &arg0.idx, &mut arg0.buckets, arg3);
                v16 = v16 + 1;
            };
        };
        arg0.round.phase = 0;
        let v21 = RoundSettled{
            index         : arg0.round.index,
            winning       : v2,
            fee           : v4,
            redistributed : v5,
        };
        0x2::event::emit<RoundSettled>(v21);
    }

    public entry fun settle_entry(arg0: &mut Global, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        settle(arg0, arg1, arg2, arg3);
    }

    public entry fun share_global_entry(arg0: Global) {
        0x2::transfer::share_object<Global>(arg0);
    }

    fun sum_block(arg0: &vector<Entry>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Entry>(arg0)) {
            let v2 = *0x1::vector::borrow<Entry>(arg0, v1);
            v0 = v0 + v2.amount;
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun withdraw_faithed_entry(arg0: &mut Global, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg3);
        assert!(arg0.paused, 0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::errors::E_NOT_PAUSED());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::treasury::withdraw_faithed(&mut arg0.vaults, arg2, arg3), arg1);
        let v0 = AdminFaithedWithdrawEvent{
            admin  : 0x2::tx_context::sender(arg3),
            to     : arg1,
            amount : arg2,
        };
        0x2::event::emit<AdminFaithedWithdrawEvent>(v0);
    }

    public entry fun withdraw_manifest_cron_entry(arg0: &mut Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg2);
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::treasury::withdraw_manifest_buyback(&mut arg0.vaults, arg1, arg2), v0);
        let v1 = AdminManifestWithdrawEvent{
            admin  : v0,
            to     : v0,
            amount : arg1,
        };
        0x2::event::emit<AdminManifestWithdrawEvent>(v1);
    }

    public entry fun withdraw_manifest_entry(arg0: &mut Global, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg3);
        assert!(arg0.paused, 0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::errors::E_NOT_PAUSED());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::treasury::withdraw_manifest_buyback(&mut arg0.vaults, arg2, arg3), arg1);
        let v0 = AdminManifestWithdrawEvent{
            admin  : 0x2::tx_context::sender(arg3),
            to     : arg1,
            amount : arg2,
        };
        0x2::event::emit<AdminManifestWithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

