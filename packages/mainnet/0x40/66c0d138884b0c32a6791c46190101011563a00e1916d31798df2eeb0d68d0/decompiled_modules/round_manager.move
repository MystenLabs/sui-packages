module 0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::round_manager {
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
        fee_split: 0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::treasury::FeeSplit,
        vaults_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        idx_id: 0x2::object::ID,
        buckets_id: 0x2::object::ID,
        godlode_id: 0x2::object::ID,
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

    public entry fun create_global(arg0: address, arg1: address, arg2: 0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::faith::SupplyCap, arg3: 0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::faith::RefiningIndex, arg4: 0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::faith::Buckets, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::treasury::create(arg7);
        let v2 = v1;
        let v3 = 0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::godlode::create(arg5, arg6, arg7);
        let v4 = Round{
            id           : 0x2::object::new(arg7),
            index        : 0,
            phase        : 0,
            closes_at_ms : 0,
            entries      : empty_entries(),
            total        : 0,
        };
        let v5 = Global{
            id                : 0x2::object::new(arg7),
            admin             : arg1,
            round             : v4,
            fee_split         : v0,
            vaults_id         : 0x2::object::id<0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::treasury::Vaults>(&v2),
            cap_id            : 0x2::object::id<0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::faith::SupplyCap>(&arg2),
            idx_id            : 0x2::object::id<0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::faith::RefiningIndex>(&arg3),
            buckets_id        : 0x2::object::id<0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::faith::Buckets>(&arg4),
            godlode_id        : 0x2::object::id<0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::godlode::Godlode>(&v3),
            manifest_treasury : arg0,
        };
        0x2::transfer::public_transfer<0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::treasury::Vaults>(v2, arg1);
        0x2::transfer::public_transfer<0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::faith::SupplyCap>(arg2, arg1);
        0x2::transfer::public_transfer<0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::faith::RefiningIndex>(arg3, arg1);
        0x2::transfer::public_transfer<0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::faith::Buckets>(arg4, arg1);
        0x2::transfer::public_transfer<0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::godlode::Godlode>(v3, arg1);
        0x2::transfer::public_transfer<Global>(v5, 0x2::tx_context::sender(arg7));
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

    public entry fun enter_entry(arg0: &mut Global, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.round.phase == 1, 0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::errors::E_NOT_OPEN());
        assert!(arg1 < 20, 0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::errors::E_BAD_BLOCK());
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        arg0.round.total = arg0.round.total + v0;
        Entry{owner: 0x2::tx_context::sender(arg3), amount: v0};
        let v1 = EntryAdded{
            index    : arg0.round.index,
            owner    : 0x2::tx_context::sender(arg3),
            block_id : arg1,
            amount   : v0,
        };
        0x2::event::emit<EntryAdded>(v1);
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
    }

    public entry fun open_round_entry(arg0: &mut Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.round.phase == 0, 0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::errors::E_STILL_OPEN());
        arg0.round.index = arg0.round.index + 1;
        arg0.round.phase = 1;
        arg0.round.closes_at_ms = arg1;
        arg0.round.entries = empty_entries();
        arg0.round.total = 0;
    }

    public entry fun settle_entry(arg0: &mut Global, arg1: &mut 0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::treasury::Vaults, arg2: &mut 0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::faith::SupplyCap, arg3: &mut 0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::faith::RefiningIndex, arg4: &mut 0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::faith::Buckets, arg5: &mut 0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::godlode::Godlode, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.round.phase == 1, 0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::errors::E_NOT_SETTLING());
        assert!(arg6 >= arg0.round.closes_at_ms, 0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::errors::E_STILL_OPEN());
        arg0.round.phase = 2;
        let v0 = 0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::rng_oracle::pick(arg7, 20);
        let v1 = arg0.round.total / 10;
        let v2 = arg0.round.total - v1;
        let v3 = 0x1::vector::borrow<vector<Entry>>(&arg0.round.entries, v0);
        let v4 = 0x1::vector::length<Entry>(v3);
        if (v4 > 0) {
            let v5 = 0;
            while (v5 < v4) {
                let v6 = *0x1::vector::borrow<Entry>(v3, v5);
                let v7 = v2 * v6.amount / sum_block(v3);
                0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::treasury::pay_from_faithed(arg1, v6.owner, v7, arg8);
                0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::faith::accrue_to(v6.owner, ((1000000000 * v7 / v2) as u64), arg2, arg3, arg4, arg8);
                v5 = v5 + 1;
            };
        };
        0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::treasury::split_and_route(0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::treasury::withdraw_faithed(arg1, v1, arg8), arg0.manifest_treasury, &arg0.fee_split, arg1, arg8);
        0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::godlode::accrue(arg5);
        let (v8, v9) = 0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::godlode::maybe_hit(arg5, arg7);
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
                0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::faith::accrue_to(v12.owner, v9 * v12.amount / sum_block(v3), arg2, arg3, arg4, arg8);
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

