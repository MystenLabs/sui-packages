module 0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::round_manager {
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
        fee_split: 0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::treasury::FeeSplit,
        vaults: 0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::treasury::Vaults,
        cap: 0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::faith::SupplyCap,
        idx: 0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::faith::RefiningIndex,
        buckets: 0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::faith::Buckets,
        godlode: 0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::godlode::Godlode,
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

    fun assert_admin(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0xa6612285e0f01c917ca2da511c39cc985cc5507845701073b051a0557c8cd141, 0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::errors::E_UNAUTH());
    }

    public entry fun claim_all_entry(arg0: &mut Global, arg1: &mut 0x2::coin::TreasuryCap<0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::faith::FAITH>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0xa6612285e0f01c917ca2da511c39cc985cc5507845701073b051a0557c8cd141, 0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::errors::E_UNAUTH());
        let v0 = 0;
        if (0x2::table::contains<address, PlayerRecord>(&arg0.player_records, arg2)) {
            let v1 = 0x2::table::borrow_mut<address, PlayerRecord>(&mut arg0.player_records, arg2);
            v0 = v1.unclaimed_sui;
            v1.unclaimed_sui = 0;
        };
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::treasury::withdraw_faithed(&mut arg0.vaults, v0, arg3), arg2);
        };
        let v2 = 0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::faith::claim_if_any(arg2, 1000, &mut arg0.cap, &mut arg0.idx, &mut arg0.buckets);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::faith::FAITH>>(0x2::coin::mint<0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::faith::FAITH>(arg1, v2, arg3), arg2);
        };
        let v3 = ClaimAllEvent{
            user          : arg2,
            sui_claimed   : v0,
            faith_claimed : v2,
        };
        0x2::event::emit<ClaimAllEvent>(v3);
    }

    public entry fun create_global_shared(arg0: address, arg1: 0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::faith::SupplyCap, arg2: 0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::faith::RefiningIndex, arg3: 0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::faith::Buckets, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::treasury::create(arg6);
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
            godlode        : 0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::godlode::create(arg4, arg5, arg6),
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
        0x2::table::borrow_mut<address, PlayerRecord>(arg0, arg1)
    }

    fun enter(arg0: &mut Global, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::errors::E_PAUSED());
        assert!(arg0.round.phase == 1, 0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::errors::E_NOT_OPEN());
        assert!(arg1 < 25, 0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::errors::E_BAD_BLOCK());
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v2 = &mut arg0.player_records;
        let v3 = ensure_record(v2, v0, arg0.round.index);
        v3.total_entries = v3.total_entries + 1;
        arg0.round.total = arg0.round.total + v1;
        let v4 = Entry{
            owner  : v0,
            amount : v1,
        };
        0x1::vector::push_back<Entry>(0x1::vector::borrow_mut<vector<Entry>>(&mut arg0.round.entries, arg1), v4);
        let v5 = EntryAdded{
            index    : arg0.round.index,
            owner    : v0,
            block_id : arg1,
            amount   : v1,
        };
        0x2::event::emit<EntryAdded>(v5);
        0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::treasury::deposit_to_faithed(&mut arg0.vaults, arg2);
    }

    public entry fun enter_entry(arg0: &mut Global, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        enter(arg0, arg1, arg2, arg3);
    }

    fun open_round(arg0: &mut Global, arg1: u64) {
        assert!(!arg0.paused, 0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::errors::E_PAUSED());
        assert!(arg0.round.phase == 0, 0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::errors::E_STILL_OPEN());
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
        assert!(arg0.paused, 0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::errors::E_NOT_PAUSED());
        0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::treasury::set_split(&mut arg0.fee_split, arg1, arg2, arg3);
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
        if (arg1 < arg0.round.closes_at_ms) {
            return
        };
        arg0.round.phase = 2;
        let v0 = 0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::rng_oracle::pick(arg2, 25);
        let v1 = arg0.round.total;
        let v2 = v1 / 10;
        let v3 = v1 - v2;
        let v4 = 0x1::vector::borrow<vector<Entry>>(&arg0.round.entries, v0);
        let v5 = 0x1::vector::length<Entry>(v4);
        if (v5 > 0 && v3 > 0) {
            let v6 = 0;
            while (v6 < v5) {
                let v7 = *0x1::vector::borrow<Entry>(v4, v6);
                let v8 = v3 * v7.amount / sum_block(v4);
                let v9 = v8;
                if (v8 == 0 && v3 > 0) {
                    v9 = 1;
                };
                let v10 = &mut arg0.player_records;
                let v11 = ensure_record(v10, v7.owner, arg0.round.index);
                v11.unclaimed_sui = v11.unclaimed_sui + v9;
                v11.total_wins = v11.total_wins + 1;
                0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::faith::accrue_to(v7.owner, v9, &mut arg0.cap, &arg0.idx, &mut arg0.buckets, arg3);
                v6 = v6 + 1;
            };
        };
        if (v2 > 0) {
            0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::treasury::split_and_route_internal(0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::treasury::withdraw_faithed(&mut arg0.vaults, v2, arg3), &arg0.fee_split, &mut arg0.vaults, arg3);
        };
        0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::godlode::accrue(&mut arg0.godlode);
        let (v12, v13) = 0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::godlode::maybe_hit(&mut arg0.godlode, arg2 + 7919);
        if (v12 && v5 > 0) {
            let v14 = 0;
            while (v14 < v5) {
                let v15 = *0x1::vector::borrow<Entry>(v4, v14);
                let v16 = v13 * v15.amount / sum_block(v4);
                let v17 = v16;
                if (v16 == 0 && v13 > 0) {
                    v17 = 1;
                };
                let v18 = &mut arg0.player_records;
                ensure_record(v18, v15.owner, arg0.round.index);
                0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::faith::accrue_to(v15.owner, v17, &mut arg0.cap, &arg0.idx, &mut arg0.buckets, arg3);
                v14 = v14 + 1;
            };
        };
        arg0.round.phase = 0;
        let v19 = RoundSettled{
            index         : arg0.round.index,
            winning       : v0,
            fee           : v2,
            redistributed : v3,
        };
        0x2::event::emit<RoundSettled>(v19);
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
        assert!(arg0.paused, 0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::errors::E_NOT_PAUSED());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::treasury::withdraw_faithed(&mut arg0.vaults, arg2, arg3), arg1);
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
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::treasury::withdraw_manifest_buyback(&mut arg0.vaults, arg1, arg2), v0);
        let v1 = AdminManifestWithdrawEvent{
            admin  : v0,
            to     : v0,
            amount : arg1,
        };
        0x2::event::emit<AdminManifestWithdrawEvent>(v1);
    }

    public entry fun withdraw_manifest_entry(arg0: &mut Global, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg3);
        assert!(arg0.paused, 0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::errors::E_NOT_PAUSED());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::treasury::withdraw_manifest_buyback(&mut arg0.vaults, arg2, arg3), arg1);
        let v0 = AdminManifestWithdrawEvent{
            admin  : 0x2::tx_context::sender(arg3),
            to     : arg1,
            amount : arg2,
        };
        0x2::event::emit<AdminManifestWithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

