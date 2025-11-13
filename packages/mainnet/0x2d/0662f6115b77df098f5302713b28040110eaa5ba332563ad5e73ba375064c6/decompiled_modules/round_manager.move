module 0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::round_manager {
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
        fee_split: 0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::treasury::FeeSplit,
        vaults: 0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::treasury::Vaults,
        cap: 0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::faith::SupplyCap,
        idx: 0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::faith::RefiningIndex,
        buckets: 0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::faith::Buckets,
        godlode: 0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::godlode::Godlode,
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

    struct ClaimMinted has copy, drop {
        owner: address,
        amount: u64,
    }

    struct ClaimRecorded has copy, drop {
        owner: address,
        amount: u64,
        round_index: u64,
    }

    struct ClaimAllEvent has copy, drop {
        user: address,
        sui_claimed: u64,
        faith_claimed: u64,
    }

    public entry fun admin_mint_to_many_entry(arg0: &mut Global, arg1: &mut 0x2::coin::TreasuryCap<0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::faith::FAITH>, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::errors::E_UNAUTH());
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::errors::E_LENGTH_MISMATCH());
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u64>(&arg3, v1);
            if (v2 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::faith::FAITH>>(0x2::coin::mint<0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::faith::FAITH>(arg1, v2, arg4), *0x1::vector::borrow<address>(&arg2, v1));
            };
            v1 = v1 + 1;
        };
    }

    public entry fun bump_refining_entry(arg0: &mut Global, arg1: u128) {
        0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::faith::bump_index(arg1, &mut arg0.idx);
    }

    public entry fun claim_all_entry(arg0: &mut Global, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = ClaimAllEvent{
            user          : v0,
            sui_claimed   : 0,
            faith_claimed : 0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::faith::claim(v0, 1000, &mut arg0.cap, &mut arg0.idx, &mut arg0.buckets),
        };
        0x2::event::emit<ClaimAllEvent>(v1);
    }

    public entry fun claim_faith(arg0: &mut Global, arg1: &mut 0x2::coin::TreasuryCap<0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::faith::FAITH>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::faith::claim(v0, 1000, &mut arg0.cap, &mut arg0.idx, &mut arg0.buckets);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::faith::FAITH>>(0x2::coin::mint<0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::faith::FAITH>(arg1, v1, arg2), v0);
        let v2 = ClaimMinted{
            owner  : v0,
            amount : v1,
        };
        0x2::event::emit<ClaimMinted>(v2);
    }

    public entry fun claim_record_entry(arg0: &mut Global, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = ClaimRecorded{
            owner       : v0,
            amount      : 0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::faith::claim(v0, 1000, &mut arg0.cap, &mut arg0.idx, &mut arg0.buckets),
            round_index : arg0.round.index,
        };
        0x2::event::emit<ClaimRecorded>(v1);
    }

    public entry fun create_global_shared(arg0: address, arg1: 0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::faith::SupplyCap, arg2: 0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::faith::RefiningIndex, arg3: 0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::faith::Buckets, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::treasury::create(arg6);
        let v2 = Round{
            id           : 0x2::object::new(arg6),
            index        : 0,
            phase        : 0,
            closes_at_ms : 0,
            entries      : empty_entries(),
            total        : 0,
        };
        let v3 = Global{
            id        : 0x2::object::new(arg6),
            admin     : arg0,
            round     : v2,
            fee_split : v0,
            vaults    : v1,
            cap       : arg1,
            idx       : arg2,
            buckets   : arg3,
            godlode   : 0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::godlode::create(arg4, arg5, arg6),
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

    fun enter(arg0: &mut Global, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.round.phase == 1, 0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::errors::E_NOT_OPEN());
        assert!(arg1 < 25, 0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::errors::E_BAD_BLOCK());
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        arg0.round.total = arg0.round.total + v0;
        let v1 = Entry{
            owner  : 0x2::tx_context::sender(arg3),
            amount : v0,
        };
        0x1::vector::push_back<Entry>(0x1::vector::borrow_mut<vector<Entry>>(&mut arg0.round.entries, arg1), v1);
        let v2 = EntryAdded{
            index    : arg0.round.index,
            owner    : 0x2::tx_context::sender(arg3),
            block_id : arg1,
            amount   : v0,
        };
        0x2::event::emit<EntryAdded>(v2);
        0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::treasury::deposit_to_faithed(&mut arg0.vaults, arg2);
    }

    public entry fun enter_entry(arg0: &mut Global, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        enter(arg0, arg1, arg2, arg3);
    }

    fun open_round(arg0: &mut Global, arg1: u64) {
        assert!(arg0.round.phase == 0, 0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::errors::E_STILL_OPEN());
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
        assert!(arg0.round.phase == 1, 0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::errors::E_NOT_SETTLING());
        assert!(arg1 >= arg0.round.closes_at_ms, 0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::errors::E_STILL_OPEN());
        arg0.round.phase = 2;
        let v0 = 0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::rng_oracle::pick(arg2, 25);
        let v1 = arg0.round.total / 10;
        let v2 = arg0.round.total - v1;
        let v3 = 0x1::vector::borrow<vector<Entry>>(&arg0.round.entries, v0);
        let v4 = 0x1::vector::length<Entry>(v3);
        if (v4 > 0 && v2 > 0) {
            let v5 = 0;
            while (v5 < v4) {
                let v6 = *0x1::vector::borrow<Entry>(v3, v5);
                let v7 = v2 * v6.amount / sum_block(v3);
                0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::treasury::pay_from_faithed(&mut arg0.vaults, v6.owner, v7, arg3);
                0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::faith::accrue_to(v6.owner, ((1000000000 * v7 / v2) as u64), &mut arg0.cap, &mut arg0.idx, &mut arg0.buckets, arg3);
                v5 = v5 + 1;
            };
        };
        0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::treasury::split_and_route_internal(0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::treasury::withdraw_faithed(&mut arg0.vaults, v1, arg3), &arg0.fee_split, &mut arg0.vaults, arg3);
        0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::godlode::accrue(&mut arg0.godlode);
        let (v8, v9) = 0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::godlode::maybe_hit(&mut arg0.godlode, arg2);
        let v10 = if (v8) {
            if (v4 > 0) {
                v2 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v10) {
            let v11 = 0;
            while (v11 < v4) {
                let v12 = *0x1::vector::borrow<Entry>(v3, v11);
                0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::faith::accrue_to(v12.owner, v9 * v12.amount / sum_block(v3), &mut arg0.cap, &mut arg0.idx, &mut arg0.buckets, arg3);
                v11 = v11 + 1;
            };
        };
        arg0.round.phase = 0;
        let v13 = RoundSettled{
            index         : arg0.round.index,
            winning       : v0,
            fee           : v1,
            redistributed : v2,
        };
        0x2::event::emit<RoundSettled>(v13);
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

    public fun withdraw_faithed(arg0: &mut Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::treasury::withdraw_faithed(&mut arg0.vaults, arg1, arg2)
    }

    public fun withdraw_manifest(arg0: &mut Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::treasury::withdraw_manifest_buyback(&mut arg0.vaults, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

