module 0x7ff4435adc855d77182832c5f107ed1a65b7fc0a3ecd42db5c3dd4c108009893::lockup_contract {
    struct LockupContract has store, key {
        id: 0x2::object::UID,
        user_balances: 0x2::table::Table<address, 0x2::balance::Balance<0x2::sui::SUI>>,
        created_at: u64,
    }

    struct SuiLocked has copy, drop {
        user: address,
        amount: u64,
        timestamp: u64,
    }

    struct SuiWithdrawn has copy, drop {
        user: address,
        amount: u64,
        timestamp: u64,
    }

    struct ContractCreated has copy, drop {
        creator: address,
        timestamp: u64,
    }

    struct BalanceQueried has copy, drop {
        user: address,
        balance: u64,
        timestamp: u64,
    }

    public fun deposit_sui(arg0: &mut LockupContract, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        lock_sui(arg0, arg1, arg2);
    }

    public fun get_time_until_unlock(arg0: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg0);
        if (v0 >= 1757030400000) {
            0
        } else {
            1757030400000 - v0
        }
    }

    public fun get_unlock_timestamp() : u64 {
        1757030400000
    }

    public fun get_user_balance(arg0: &LockupContract, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = if (0x2::table::contains<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.user_balances, arg1)) {
            0x2::balance::value<0x2::sui::SUI>(0x2::table::borrow<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.user_balances, arg1))
        } else {
            0
        };
        let v1 = BalanceQueried{
            user      : arg1,
            balance   : v0,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<BalanceQueried>(v1);
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LockupContract{
            id            : 0x2::object::new(arg0),
            user_balances : 0x2::table::new<address, 0x2::balance::Balance<0x2::sui::SUI>>(arg0),
            created_at    : 0x2::tx_context::epoch_timestamp_ms(arg0),
        };
        let v1 = ContractCreated{
            creator   : 0x2::tx_context::sender(arg0),
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg0),
        };
        0x2::event::emit<ContractCreated>(v1);
        0x2::transfer::share_object<LockupContract>(v0);
    }

    public fun is_unlocked(arg0: &0x2::tx_context::TxContext) : bool {
        0x2::tx_context::epoch_timestamp_ms(arg0) >= 1757030400000
    }

    public fun lock_sui(arg0: &mut LockupContract, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(v0 > 0, 4);
        if (0x2::table::contains<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.user_balances, v1)) {
            0x2::balance::join<0x2::sui::SUI>(0x2::table::borrow_mut<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.user_balances, v1), 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        } else {
            0x2::table::add<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.user_balances, v1, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        };
        let v2 = SuiLocked{
            user      : v1,
            amount    : v0,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<SuiLocked>(v2);
    }

    public fun withdraw_sui(arg0: &mut LockupContract, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg1);
        let v1 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.user_balances, v1), 3);
        assert!(v0 >= 1757030400000, 2);
        let v2 = 0x2::table::remove<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.user_balances, v1);
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&v2);
        assert!(v3 > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg1), v1);
        let v4 = SuiWithdrawn{
            user      : v1,
            amount    : v3,
            timestamp : v0,
        };
        0x2::event::emit<SuiWithdrawn>(v4);
    }

    // decompiled from Move bytecode v6
}

