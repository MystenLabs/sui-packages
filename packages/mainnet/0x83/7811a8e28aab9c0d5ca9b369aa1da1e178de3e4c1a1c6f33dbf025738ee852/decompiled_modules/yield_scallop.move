module 0xbefdf372ed7b01a45561b71eb62ba2aed0370f7b79221d42ba1a14e8f75d6fe9::yield_scallop {
    struct ScallopYieldVault has key {
        id: 0x2::object::UID,
        scoin_balance: 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x2::sui::SUI>>,
        positions: 0x2::table::Table<0x2::object::ID, PositionRecord>,
    }

    struct PositionRecord has store {
        principal: u64,
        scoin_amount: u64,
        protocol: u8,
    }

    struct ScallopDepositEvent has copy, drop {
        position_id: 0x2::object::ID,
        amount: u64,
        scoin_amount: u64,
    }

    struct ScallopWithdrawEvent has copy, drop {
        position_id: 0x2::object::ID,
        principal: u64,
        interest: u64,
        total: u64,
    }

    struct ScallopYieldVaultGeneric<phantom T0> has key {
        id: 0x2::object::UID,
        scoin_balance: 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>,
        positions: 0x2::table::Table<0x2::object::ID, PositionRecord>,
    }

    public fun active_position_count(arg0: &ScallopYieldVault) : u64 {
        0x2::table::length<0x2::object::ID, PositionRecord>(&arg0.positions)
    }

    public fun active_position_count_generic<T0>(arg0: &ScallopYieldVaultGeneric<T0>) : u64 {
        0x2::table::length<0x2::object::ID, PositionRecord>(&arg0.positions)
    }

    public fun deposit_generic<T0>(arg0: &mut ScallopYieldVaultGeneric<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg2, arg3, arg1, arg4, arg5);
        let v2 = 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v1);
        0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg0.scoin_balance, 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v1));
        let v3 = 0x2::object::new(arg5);
        let v4 = 0x2::object::uid_to_inner(&v3);
        0x2::object::delete(v3);
        let v5 = PositionRecord{
            principal    : v0,
            scoin_amount : v2,
            protocol     : 1,
        };
        0x2::table::add<0x2::object::ID, PositionRecord>(&mut arg0.positions, v4, v5);
        let v6 = ScallopDepositEvent{
            position_id  : v4,
            amount       : v0,
            scoin_amount : v2,
        };
        0x2::event::emit<ScallopDepositEvent>(v6);
        v4
    }

    public fun deposit_scallop(arg0: &mut ScallopYieldVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<0x2::sui::SUI>(arg2, arg3, arg1, arg4, arg5);
        let v2 = 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x2::sui::SUI>>(&v1);
        0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x2::sui::SUI>>(&mut arg0.scoin_balance, 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x2::sui::SUI>>(v1));
        let v3 = 0x2::object::new(arg5);
        let v4 = 0x2::object::uid_to_inner(&v3);
        0x2::object::delete(v3);
        let v5 = PositionRecord{
            principal    : v0,
            scoin_amount : v2,
            protocol     : 1,
        };
        0x2::table::add<0x2::object::ID, PositionRecord>(&mut arg0.positions, v4, v5);
        let v6 = ScallopDepositEvent{
            position_id  : v4,
            amount       : v0,
            scoin_amount : v2,
        };
        0x2::event::emit<ScallopDepositEvent>(v6);
        v4
    }

    public fun get_principal(arg0: &ScallopYieldVault, arg1: 0x2::object::ID) : u64 {
        if (0x2::table::contains<0x2::object::ID, PositionRecord>(&arg0.positions, arg1)) {
            0x2::table::borrow<0x2::object::ID, PositionRecord>(&arg0.positions, arg1).principal
        } else {
            0
        }
    }

    public fun get_principal_generic<T0>(arg0: &ScallopYieldVaultGeneric<T0>, arg1: 0x2::object::ID) : u64 {
        if (0x2::table::contains<0x2::object::ID, PositionRecord>(&arg0.positions, arg1)) {
            0x2::table::borrow<0x2::object::ID, PositionRecord>(&arg0.positions, arg1).principal
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ScallopYieldVault{
            id            : 0x2::object::new(arg0),
            scoin_balance : 0x2::balance::zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x2::sui::SUI>>(),
            positions     : 0x2::table::new<0x2::object::ID, PositionRecord>(arg0),
        };
        0x2::transfer::share_object<ScallopYieldVault>(v0);
    }

    public fun init_vault_generic<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ScallopYieldVaultGeneric<T0>{
            id            : 0x2::object::new(arg0),
            scoin_balance : 0x2::balance::zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(),
            positions     : 0x2::table::new<0x2::object::ID, PositionRecord>(arg0),
        };
        0x2::transfer::share_object<ScallopYieldVaultGeneric<T0>>(v0);
    }

    public fun total_scoin_balance(arg0: &ScallopYieldVault) : u64 {
        0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x2::sui::SUI>>(&arg0.scoin_balance)
    }

    public fun total_scoin_balance_generic<T0>(arg0: &ScallopYieldVaultGeneric<T0>) : u64 {
        0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg0.scoin_balance)
    }

    public fun withdraw_generic<T0>(arg0: &mut ScallopYieldVaultGeneric<T0>, arg1: 0x2::object::ID, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let PositionRecord {
            principal    : v0,
            scoin_amount : v1,
            protocol     : _,
        } = 0x2::table::remove<0x2::object::ID, PositionRecord>(&mut arg0.positions, arg1);
        let v3 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg2, arg3, 0x2::coin::take<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg0.scoin_balance, v1, arg5), arg4, arg5);
        let v4 = 0x2::coin::value<T0>(&v3);
        let v5 = ScallopWithdrawEvent{
            position_id : arg1,
            principal   : v0,
            interest    : v4 - v0,
            total       : v4,
        };
        0x2::event::emit<ScallopWithdrawEvent>(v5);
        v3
    }

    public fun withdraw_scallop(arg0: &mut ScallopYieldVault, arg1: 0x2::object::ID, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let PositionRecord {
            principal    : v0,
            scoin_amount : v1,
            protocol     : _,
        } = 0x2::table::remove<0x2::object::ID, PositionRecord>(&mut arg0.positions, arg1);
        let v3 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<0x2::sui::SUI>(arg2, arg3, 0x2::coin::take<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<0x2::sui::SUI>>(&mut arg0.scoin_balance, v1, arg5), arg4, arg5);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&v3);
        let v5 = ScallopWithdrawEvent{
            position_id : arg1,
            principal   : v0,
            interest    : v4 - v0,
            total       : v4,
        };
        0x2::event::emit<ScallopWithdrawEvent>(v5);
        v3
    }

    // decompiled from Move bytecode v7
}

