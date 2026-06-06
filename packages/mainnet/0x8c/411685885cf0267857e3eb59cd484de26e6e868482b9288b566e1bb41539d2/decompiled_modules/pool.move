module 0x8c411685885cf0267857e3eb59cd484de26e6e868482b9288b566e1bb41539d2::pool {
    struct Pool has key {
        id: 0x2::object::UID,
        admin: address,
        treasury: address,
        fee_bps: u64,
        entry_fee_mist: u64,
        pot: 0x2::balance::Balance<0x2::sui::SUI>,
        total_passes: u64,
        alive_count: u64,
        phase: u8,
        roster_blob_id: vector<u8>,
        matchday_blob_id: vector<u8>,
        eliminated_players: vector<u32>,
        player_weight: 0x2::vec_map::VecMap<u32, u64>,
        weight_by_player: 0x2::vec_map::VecMap<u32, u64>,
        total_weight: u64,
        surviving_weight: u64,
        net_pot_mist: u64,
    }

    struct Pass has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        player_id: u32,
        weight: u64,
        minted_at_ms: u64,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        admin: address,
        treasury: address,
        fee_bps: u64,
        entry_fee_mist: u64,
        roster_blob_id: vector<u8>,
    }

    struct PassMinted has copy, drop {
        pool_id: 0x2::object::ID,
        pass_id: 0x2::object::ID,
        owner: address,
        player_id: u32,
        weight: u64,
    }

    struct PoolLocked has copy, drop {
        pool_id: 0x2::object::ID,
        total_passes: u64,
        pot_mist: u64,
    }

    struct PoolSettled has copy, drop {
        pool_id: 0x2::object::ID,
        matchday_blob_id: vector<u8>,
        eliminated_player_ids: vector<u32>,
        alive_count: u64,
        pot_mist: u64,
        net_pot_mist: u64,
        fee_mist: u64,
        surviving_weight: u64,
    }

    struct PassCashedOut has copy, drop {
        pool_id: 0x2::object::ID,
        pass_id: 0x2::object::ID,
        owner: address,
        payout_mist: u64,
    }

    struct PoolClosed has copy, drop {
        pool_id: 0x2::object::ID,
        leftover_mist: u64,
    }

    public fun admin(arg0: &Pool) : address {
        arg0.admin
    }

    public fun alive_count(arg0: &Pool) : u64 {
        arg0.alive_count
    }

    public fun cashout(arg0: &mut Pool, arg1: Pass, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.phase == 2, 0);
        assert!(0x2::object::id<Pool>(arg0) == arg1.pool_id, 4);
        assert!(!0x1::vector::contains<u32>(&arg0.eliminated_players, &arg1.player_id), 3);
        let v0 = if (arg0.surviving_weight == 0) {
            0
        } else {
            (((arg0.net_pot_mist as u128) * (arg1.weight as u128) / (arg0.surviving_weight as u128)) as u64)
        };
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.pot);
        let v2 = if (v0 > v1) {
            v1
        } else {
            v0
        };
        arg0.alive_count = arg0.alive_count - 1;
        let v3 = PassCashedOut{
            pool_id     : 0x2::object::id<Pool>(arg0),
            pass_id     : 0x2::object::id<Pass>(&arg1),
            owner       : 0x2::tx_context::sender(arg2),
            payout_mist : v2,
        };
        0x2::event::emit<PassCashedOut>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v2), arg2), 0x2::tx_context::sender(arg2));
        let Pass {
            id           : v4,
            pool_id      : _,
            player_id    : _,
            weight       : _,
            minted_at_ms : _,
        } = arg1;
        0x2::object::delete(v4);
    }

    public fun close_pool(arg0: &mut Pool, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
        assert!(arg0.phase == 2, 0);
        arg0.phase = 3;
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.pot);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v0), arg1), arg0.treasury);
        };
        let v1 = PoolClosed{
            pool_id       : 0x2::object::id<Pool>(arg0),
            leftover_mist : v0,
        };
        0x2::event::emit<PoolClosed>(v1);
    }

    public fun create_pool(arg0: u64, arg1: vector<u8>, arg2: address, arg3: vector<u32>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(1000 <= 10000, 7);
        let v0 = 0x1::vector::length<u32>(&arg3);
        assert!(v0 == 0x1::vector::length<u64>(&arg4), 6);
        let v1 = 0x2::vec_map::empty<u32, u64>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u32>(&arg3, v2);
            if (!0x2::vec_map::contains<u32, u64>(&v1, &v3)) {
                0x2::vec_map::insert<u32, u64>(&mut v1, v3, *0x1::vector::borrow<u64>(&arg4, v2));
            };
            v2 = v2 + 1;
        };
        let v4 = Pool{
            id                 : 0x2::object::new(arg5),
            admin              : 0x2::tx_context::sender(arg5),
            treasury           : arg2,
            fee_bps            : 1000,
            entry_fee_mist     : arg0,
            pot                : 0x2::balance::zero<0x2::sui::SUI>(),
            total_passes       : 0,
            alive_count        : 0,
            phase              : 0,
            roster_blob_id     : arg1,
            matchday_blob_id   : b"",
            eliminated_players : vector[],
            player_weight      : v1,
            weight_by_player   : 0x2::vec_map::empty<u32, u64>(),
            total_weight       : 0,
            surviving_weight   : 0,
            net_pot_mist       : 0,
        };
        let v5 = PoolCreated{
            pool_id        : 0x2::object::id<Pool>(&v4),
            admin          : v4.admin,
            treasury       : v4.treasury,
            fee_bps        : v4.fee_bps,
            entry_fee_mist : arg0,
            roster_blob_id : v4.roster_blob_id,
        };
        0x2::event::emit<PoolCreated>(v5);
        0x2::transfer::share_object<Pool>(v4);
    }

    public fun eliminated_players(arg0: &Pool) : &vector<u32> {
        &arg0.eliminated_players
    }

    public fun entry_fee_mist(arg0: &Pool) : u64 {
        arg0.entry_fee_mist
    }

    public fun fee_bps(arg0: &Pool) : u64 {
        arg0.fee_bps
    }

    public fun lock_pool(arg0: &mut Pool, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
        assert!(arg0.phase == 0, 0);
        arg0.phase = 1;
        let v0 = PoolLocked{
            pool_id      : 0x2::object::id<Pool>(arg0),
            total_passes : arg0.total_passes,
            pot_mist     : 0x2::balance::value<0x2::sui::SUI>(&arg0.pot),
        };
        0x2::event::emit<PoolLocked>(v0);
    }

    public fun matchday_blob_id(arg0: &Pool) : &vector<u8> {
        &arg0.matchday_blob_id
    }

    public fun mint_pass(arg0: &mut Pool, arg1: u32, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.phase == 0, 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg0.entry_fee_mist, 2);
        assert!(0x2::vec_map::contains<u32, u64>(&arg0.player_weight, &arg1), 5);
        let v0 = *0x2::vec_map::get<u32, u64>(&arg0.player_weight, &arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg0.total_passes = arg0.total_passes + 1;
        arg0.alive_count = arg0.alive_count + 1;
        arg0.total_weight = arg0.total_weight + v0;
        if (0x2::vec_map::contains<u32, u64>(&arg0.weight_by_player, &arg1)) {
            let v1 = 0x2::vec_map::get_mut<u32, u64>(&mut arg0.weight_by_player, &arg1);
            *v1 = *v1 + v0;
        } else {
            0x2::vec_map::insert<u32, u64>(&mut arg0.weight_by_player, arg1, v0);
        };
        let v2 = Pass{
            id           : 0x2::object::new(arg4),
            pool_id      : 0x2::object::id<Pool>(arg0),
            player_id    : arg1,
            weight       : v0,
            minted_at_ms : 0x2::clock::timestamp_ms(arg3),
        };
        let v3 = PassMinted{
            pool_id   : 0x2::object::id<Pool>(arg0),
            pass_id   : 0x2::object::id<Pass>(&v2),
            owner     : 0x2::tx_context::sender(arg4),
            player_id : arg1,
            weight    : v0,
        };
        0x2::event::emit<PassMinted>(v3);
        0x2::transfer::transfer<Pass>(v2, 0x2::tx_context::sender(arg4));
    }

    public fun net_pot_mist(arg0: &Pool) : u64 {
        arg0.net_pot_mist
    }

    public fun pass_minted_at_ms(arg0: &Pass) : u64 {
        arg0.minted_at_ms
    }

    public fun pass_player_id(arg0: &Pass) : u32 {
        arg0.player_id
    }

    public fun pass_pool_id(arg0: &Pass) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun pass_weight(arg0: &Pass) : u64 {
        arg0.weight
    }

    public fun phase(arg0: &Pool) : u8 {
        arg0.phase
    }

    public fun pot_value(arg0: &Pool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pot)
    }

    public fun roster_blob_id(arg0: &Pool) : &vector<u8> {
        &arg0.roster_blob_id
    }

    public fun settle_pool(arg0: &mut Pool, arg1: vector<u8>, arg2: vector<u32>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 1);
        assert!(arg0.phase == 1, 0);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u32>(&arg2)) {
            let v2 = *0x1::vector::borrow<u32>(&arg2, v1);
            if (0x2::vec_map::contains<u32, u64>(&arg0.weight_by_player, &v2)) {
                v0 = v0 + *0x2::vec_map::get<u32, u64>(&arg0.weight_by_player, &v2);
            };
            v1 = v1 + 1;
        };
        let v3 = if (arg0.total_weight >= v0) {
            arg0.total_weight - v0
        } else {
            0
        };
        arg0.surviving_weight = v3;
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&arg0.pot);
        let v5 = v4 * arg0.fee_bps / 10000;
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v5), arg4), arg0.treasury);
        };
        arg0.net_pot_mist = 0x2::balance::value<0x2::sui::SUI>(&arg0.pot);
        arg0.matchday_blob_id = arg1;
        arg0.eliminated_players = arg2;
        arg0.alive_count = arg3;
        arg0.phase = 2;
        let v6 = PoolSettled{
            pool_id               : 0x2::object::id<Pool>(arg0),
            matchday_blob_id      : arg0.matchday_blob_id,
            eliminated_player_ids : arg0.eliminated_players,
            alive_count           : arg0.alive_count,
            pot_mist              : v4,
            net_pot_mist          : arg0.net_pot_mist,
            fee_mist              : v5,
            surviving_weight      : arg0.surviving_weight,
        };
        0x2::event::emit<PoolSettled>(v6);
    }

    public fun surviving_weight(arg0: &Pool) : u64 {
        arg0.surviving_weight
    }

    public fun total_passes(arg0: &Pool) : u64 {
        arg0.total_passes
    }

    public fun total_weight(arg0: &Pool) : u64 {
        arg0.total_weight
    }

    public fun treasury(arg0: &Pool) : address {
        arg0.treasury
    }

    // decompiled from Move bytecode v7
}

