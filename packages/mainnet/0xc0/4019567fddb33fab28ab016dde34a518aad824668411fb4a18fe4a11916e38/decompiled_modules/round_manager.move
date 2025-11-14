module 0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::round_manager {
    struct PlayerRecord has store {
        unclaimed_sui: u64,
        unclaimed_faith: u64,
        total_wins: u64,
        total_entries: u64,
        last_round: u64,
    }

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

    struct Global has store, key {
        id: 0x2::object::UID,
        admin: address,
        round: Round,
        fee_split: 0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::treasury::FeeSplit,
        vaults: 0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::treasury::Vaults,
        cap: 0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::SupplyCap,
        idx: 0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::RefiningIndex,
        buckets: 0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::Buckets,
        godlode: 0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::godlode::Godlode,
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

    public entry fun claim_all_entry(arg0: &mut Global, arg1: &mut 0x2::coin::TreasuryCap<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (!0x2::table::contains<address, PlayerRecord>(&arg0.player_records, v0)) {
            let v1 = ClaimAllEvent{
                user          : v0,
                sui_claimed   : 0,
                faith_claimed : 0,
            };
            0x2::event::emit<ClaimAllEvent>(v1);
            return
        };
        let v2 = 0x2::table::borrow_mut<address, PlayerRecord>(&mut arg0.player_records, v0);
        let v3 = v2.unclaimed_sui;
        let v4 = v2.unclaimed_faith;
        v2.unclaimed_sui = 0;
        v2.unclaimed_faith = 0;
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::treasury::withdraw_faithed(&mut arg0.vaults, v3, arg2), v0);
        };
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>>(0x2::coin::mint<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>(arg1, v4, arg2), v0);
        };
        let v5 = ClaimAllEvent{
            user          : v0,
            sui_claimed   : v3,
            faith_claimed : v4,
        };
        0x2::event::emit<ClaimAllEvent>(v5);
    }

    public entry fun create_global_shared(arg0: address, arg1: 0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::SupplyCap, arg2: 0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::RefiningIndex, arg3: 0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::Buckets, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::treasury::create(arg6);
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
            fee_split      : v0,
            vaults         : v1,
            cap            : arg1,
            idx            : arg2,
            buckets        : arg3,
            godlode        : 0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::godlode::create(arg4, arg5, arg6),
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
            unclaimed_sui   : 0,
            unclaimed_faith : 0,
            total_wins      : 0,
            total_entries   : 0,
            last_round      : arg0,
        }
    }

    fun ensure_record(arg0: &mut 0x2::table::Table<address, PlayerRecord>, arg1: address, arg2: u64) : &mut PlayerRecord {
        if (!0x2::table::contains<address, PlayerRecord>(arg0, arg1)) {
            0x2::table::add<address, PlayerRecord>(arg0, arg1, empty_record(arg2));
        };
        0x2::table::borrow_mut<address, PlayerRecord>(arg0, arg1)
    }

    fun enter(arg0: &mut Global, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.round.phase == 1, 0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::errors::E_NOT_OPEN());
        assert!(arg1 < 25, 0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::errors::E_BAD_BLOCK());
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
        0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::treasury::deposit_to_faithed(&mut arg0.vaults, arg2);
    }

    public entry fun enter_entry(arg0: &mut Global, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        enter(arg0, arg1, arg2, arg3);
    }

    fun open_round(arg0: &mut Global, arg1: u64) {
        assert!(arg0.round.phase == 0, 0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::errors::E_STILL_OPEN());
        arg0.round.index = arg0.round.index + 1;
        arg0.round.phase = 1;
        arg0.round.closes_at_ms = arg1;
        arg0.round.entries = empty_entries();
        arg0.round.total = 0;
    }

    public entry fun open_round_entry(arg0: &mut Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        open_round(arg0, arg1);
    }

    fun settle(arg0: &mut Global, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.round.phase == 1, 0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::errors::E_NOT_SETTLING());
        assert!(arg1 >= arg0.round.closes_at_ms, 0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::errors::E_STILL_OPEN());
        arg0.round.phase = 2;
        let v0 = 0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::rng_oracle::pick(arg2, 25);
        let v1 = arg0.round.total / 10;
        let v2 = arg0.round.total - v1;
        let v3 = 0x1::vector::borrow<vector<Entry>>(&arg0.round.entries, v0);
        let v4 = 0x1::vector::length<Entry>(v3);
        if (v4 > 0 && v2 > 0) {
            let v5 = 0;
            while (v5 < v4) {
                let v6 = *0x1::vector::borrow<Entry>(v3, v5);
                let v7 = v2 * v6.amount / sum_block(v3);
                let v8 = &mut arg0.player_records;
                let v9 = ensure_record(v8, v6.owner, arg0.round.index);
                v9.unclaimed_sui = v9.unclaimed_sui + v7;
                v9.unclaimed_faith = v9.unclaimed_faith + v7;
                v9.total_wins = v9.total_wins + 1;
                v5 = v5 + 1;
            };
        };
        0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::treasury::split_and_route_internal(0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::treasury::withdraw_faithed(&mut arg0.vaults, v1, arg3), &arg0.fee_split, &mut arg0.vaults, arg3);
        0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::godlode::accrue(&mut arg0.godlode);
        let (v10, v11) = 0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::godlode::maybe_hit(&mut arg0.godlode, arg2);
        if (v10 && v4 > 0) {
            let v12 = 0;
            while (v12 < v4) {
                let v13 = *0x1::vector::borrow<Entry>(v3, v12);
                let v14 = &mut arg0.player_records;
                let v15 = ensure_record(v14, v13.owner, arg0.round.index);
                v15.unclaimed_faith = v15.unclaimed_faith + v11 * v13.amount / sum_block(v3);
                v12 = v12 + 1;
            };
        };
        arg0.round.phase = 0;
        let v16 = RoundSettled{
            index         : arg0.round.index,
            winning       : v0,
            fee           : v1,
            redistributed : v2,
        };
        0x2::event::emit<RoundSettled>(v16);
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

    // decompiled from Move bytecode v6
}

