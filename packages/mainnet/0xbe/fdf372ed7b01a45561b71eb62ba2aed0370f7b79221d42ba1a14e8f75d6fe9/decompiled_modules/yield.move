module 0xbefdf372ed7b01a45561b71eb62ba2aed0370f7b79221d42ba1a14e8f75d6fe9::yield {
    struct YieldVault has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        positions: 0x2::table::Table<0x2::object::ID, PositionRecord>,
    }

    struct PositionRecord has store {
        principal: u64,
        created_at: u64,
        protocol: u8,
    }

    struct DepositEvent has copy, drop {
        position_id: 0x2::object::ID,
        amount: u64,
        protocol: u8,
    }

    struct WithdrawEvent has copy, drop {
        position_id: 0x2::object::ID,
        principal: u64,
        interest: u64,
        total: u64,
        protocol: u8,
    }

    public fun active_position_count(arg0: &YieldVault) : u64 {
        0x2::table::length<0x2::object::ID, PositionRecord>(&arg0.positions)
    }

    public fun deposit(arg0: &mut YieldVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = if (arg2 == 0) {
            true
        } else if (arg2 == 1) {
            true
        } else {
            arg2 == 2
        };
        assert!(v0, 2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v2 = 0x2::object::new(arg4);
        let v3 = 0x2::object::uid_to_inner(&v2);
        0x2::object::delete(v2);
        let v4 = PositionRecord{
            principal  : v1,
            created_at : 0x2::clock::timestamp_ms(arg3),
            protocol   : arg2,
        };
        0x2::table::add<0x2::object::ID, PositionRecord>(&mut arg0.positions, v3, v4);
        let v5 = DepositEvent{
            position_id : v3,
            amount      : v1,
            protocol    : arg2,
        };
        0x2::event::emit<DepositEvent>(v5);
        v3
    }

    public fun get_principal(arg0: &YieldVault, arg1: 0x2::object::ID) : u64 {
        if (0x2::table::contains<0x2::object::ID, PositionRecord>(&arg0.positions, arg1)) {
            0x2::table::borrow<0x2::object::ID, PositionRecord>(&arg0.positions, arg1).principal
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = YieldVault{
            id        : 0x2::object::new(arg0),
            balance   : 0x2::balance::zero<0x2::sui::SUI>(),
            positions : 0x2::table::new<0x2::object::ID, PositionRecord>(arg0),
        };
        0x2::transfer::share_object<YieldVault>(v0);
    }

    public fun total_balance(arg0: &YieldVault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun withdraw(arg0: &mut YieldVault, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let PositionRecord {
            principal  : v0,
            created_at : _,
            protocol   : v2,
        } = 0x2::table::remove<0x2::object::ID, PositionRecord>(&mut arg0.positions, arg1);
        let v3 = 0;
        let v4 = v0 + v3;
        let v5 = WithdrawEvent{
            position_id : arg1,
            principal   : v0,
            interest    : v3,
            total       : v4,
            protocol    : v2,
        };
        0x2::event::emit<WithdrawEvent>(v5);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v4, arg3)
    }

    // decompiled from Move bytecode v7
}

