module 0xcf5c5e48f8daabddebc95bb10943747f02924a5b9d85f5359efa76e235c34b97::round_manager {
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
        fee_split: 0xcf5c5e48f8daabddebc95bb10943747f02924a5b9d85f5359efa76e235c34b97::treasury::FeeSplit,
        vaults: 0xcf5c5e48f8daabddebc95bb10943747f02924a5b9d85f5359efa76e235c34b97::treasury::Vaults,
        cap: 0xcf5c5e48f8daabddebc95bb10943747f02924a5b9d85f5359efa76e235c34b97::faith::SupplyCap,
        idx: 0xcf5c5e48f8daabddebc95bb10943747f02924a5b9d85f5359efa76e235c34b97::faith::RefiningIndex,
        buckets: 0xcf5c5e48f8daabddebc95bb10943747f02924a5b9d85f5359efa76e235c34b97::faith::Buckets,
        godlode: 0xcf5c5e48f8daabddebc95bb10943747f02924a5b9d85f5359efa76e235c34b97::godlode::Godlode,
        manifest_treasury: address,
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

    public entry fun bump_refining_entry(arg0: &mut Global, arg1: u128) {
        0xcf5c5e48f8daabddebc95bb10943747f02924a5b9d85f5359efa76e235c34b97::faith::bump_index(arg1, &mut arg0.idx);
    }

    public entry fun claim_faith(arg0: &mut Global, arg1: &mut 0x2::coin::TreasuryCap<0xcf5c5e48f8daabddebc95bb10943747f02924a5b9d85f5359efa76e235c34b97::faith::FAITH>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0xcf5c5e48f8daabddebc95bb10943747f02924a5b9d85f5359efa76e235c34b97::faith::claim(v0, 1000, &mut arg0.cap, &mut arg0.idx, &mut arg0.buckets);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xcf5c5e48f8daabddebc95bb10943747f02924a5b9d85f5359efa76e235c34b97::faith::FAITH>>(0x2::coin::mint<0xcf5c5e48f8daabddebc95bb10943747f02924a5b9d85f5359efa76e235c34b97::faith::FAITH>(arg1, v1, arg2), v0);
        let v2 = ClaimMinted{
            owner  : v0,
            amount : v1,
        };
        0x2::event::emit<ClaimMinted>(v2);
    }

    public entry fun create_global(arg0: address, arg1: address, arg2: 0xcf5c5e48f8daabddebc95bb10943747f02924a5b9d85f5359efa76e235c34b97::faith::SupplyCap, arg3: 0xcf5c5e48f8daabddebc95bb10943747f02924a5b9d85f5359efa76e235c34b97::faith::RefiningIndex, arg4: 0xcf5c5e48f8daabddebc95bb10943747f02924a5b9d85f5359efa76e235c34b97::faith::Buckets, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xcf5c5e48f8daabddebc95bb10943747f02924a5b9d85f5359efa76e235c34b97::treasury::create(arg7);
        let v2 = Round{
            id           : 0x2::object::new(arg7),
            index        : 0,
            phase        : 0,
            closes_at_ms : 0,
            entries      : empty_entries(),
            total        : 0,
        };
        let v3 = Global{
            id                : 0x2::object::new(arg7),
            admin             : arg1,
            round             : v2,
            fee_split         : v0,
            vaults            : v1,
            cap               : arg2,
            idx               : arg3,
            buckets           : arg4,
            godlode           : 0xcf5c5e48f8daabddebc95bb10943747f02924a5b9d85f5359efa76e235c34b97::godlode::create(arg5, arg6, arg7),
            manifest_treasury : arg0,
        };
        0x2::transfer::transfer<Global>(v3, 0x2::tx_context::sender(arg7));
    }

    fun empty_entries() : vector<vector<Entry>> {
        let v0 = 0x1::vector::empty<vector<Entry>>();
        let v1 = 0;
        while (v1 < 20) {
            0x1::vector::push_back<vector<Entry>>(&mut v0, 0x1::vector::empty<Entry>());
            v1 = v1 + 1;
        };
        v0
    }

    fun enter(arg0: &mut Global, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.round.phase == 1, 0xcf5c5e48f8daabddebc95bb10943747f02924a5b9d85f5359efa76e235c34b97::errors::E_NOT_OPEN());
        assert!(arg1 < 20, 0xcf5c5e48f8daabddebc95bb10943747f02924a5b9d85f5359efa76e235c34b97::errors::E_BAD_BLOCK());
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        arg0.round.total = arg0.round.total + v0;
        let v1 = Entry{
            owner  : 0x2::tx_context::sender(arg3),
            amount : v0,
        };
        0xcf5c5e48f8daabddebc95bb10943747f02924a5b9d85f5359efa76e235c34b97::treasury::deposit_to_faithed(&mut arg0.vaults, arg2);
        0x1::vector::push_back<Entry>(0x1::vector::borrow_mut<vector<Entry>>(&mut arg0.round.entries, arg1), v1);
        let v2 = EntryAdded{
            index    : arg0.round.index,
            owner    : 0x2::tx_context::sender(arg3),
            block_id : arg1,
            amount   : v0,
        };
        0x2::event::emit<EntryAdded>(v2);
    }

    public entry fun enter_entry(arg0: &mut Global, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        enter(arg0, arg1, arg2, arg3);
    }

    public fun init_module(arg0: &mut 0x2::tx_context::TxContext) {
    }

    fun open_round(arg0: &mut Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.round.phase == 0, 0xcf5c5e48f8daabddebc95bb10943747f02924a5b9d85f5359efa76e235c34b97::errors::E_STILL_OPEN());
        arg0.round.index = arg0.round.index + 1;
        arg0.round.phase = 1;
        arg0.round.closes_at_ms = arg1;
        arg0.round.entries = empty_entries();
        arg0.round.total = 0;
    }

    public entry fun open_round_entry(arg0: &mut Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        open_round(arg0, arg1, arg2);
    }

    fun settle(arg0: &mut Global, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.round.phase == 1, 0xcf5c5e48f8daabddebc95bb10943747f02924a5b9d85f5359efa76e235c34b97::errors::E_NOT_SETTLING());
        assert!(arg1 >= arg0.round.closes_at_ms, 0xcf5c5e48f8daabddebc95bb10943747f02924a5b9d85f5359efa76e235c34b97::errors::E_STILL_OPEN());
        arg0.round.phase = 2;
        let v0 = 0xcf5c5e48f8daabddebc95bb10943747f02924a5b9d85f5359efa76e235c34b97::rng_oracle::pick(arg2, 20);
        let v1 = arg0.round.total / 10;
        let v2 = arg0.round.total - v1;
        let v3 = 0x1::vector::borrow<vector<Entry>>(&arg0.round.entries, v0);
        let v4 = 0x1::vector::length<Entry>(v3);
        if (v4 > 0) {
            let v5 = 0;
            while (v5 < v4) {
                let v6 = *0x1::vector::borrow<Entry>(v3, v5);
                let v7 = v2 * v6.amount / sum_block(v3);
                0xcf5c5e48f8daabddebc95bb10943747f02924a5b9d85f5359efa76e235c34b97::treasury::pay_from_faithed(&mut arg0.vaults, v6.owner, v7, arg3);
                0xcf5c5e48f8daabddebc95bb10943747f02924a5b9d85f5359efa76e235c34b97::faith::accrue_to(v6.owner, ((1000000000 * v7 / v2) as u64), &mut arg0.cap, &arg0.idx, &mut arg0.buckets, arg3);
                v5 = v5 + 1;
            };
        };
        0xcf5c5e48f8daabddebc95bb10943747f02924a5b9d85f5359efa76e235c34b97::treasury::split_and_route(0xcf5c5e48f8daabddebc95bb10943747f02924a5b9d85f5359efa76e235c34b97::treasury::withdraw_faithed(&mut arg0.vaults, v1, arg3), arg0.manifest_treasury, &arg0.fee_split, &mut arg0.vaults, arg3);
        0xcf5c5e48f8daabddebc95bb10943747f02924a5b9d85f5359efa76e235c34b97::godlode::accrue(&mut arg0.godlode);
        let (v8, v9) = 0xcf5c5e48f8daabddebc95bb10943747f02924a5b9d85f5359efa76e235c34b97::godlode::maybe_hit(&mut arg0.godlode, arg2);
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
                0xcf5c5e48f8daabddebc95bb10943747f02924a5b9d85f5359efa76e235c34b97::faith::accrue_to(v12.owner, v9 * v12.amount / sum_block(v3), &mut arg0.cap, &arg0.idx, &mut arg0.buckets, arg3);
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

    // decompiled from Move bytecode v6
}

