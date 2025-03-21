module 0xb1179101dc49281dec9cb071091b9af10eec8b9cbf060a5d4f3b1dd8329dbc53::token_lock {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct TokenLock<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        unlock_time: u64,
        owner: address,
        recipient: address,
        description: 0x1::string::String,
        vesting_type: u8,
        vesting_period_ms: u64,
        vesting_portions: u64,
        last_claim_time: u64,
        claimed_portions: u64,
        fee_paid: bool,
    }

    struct Reward<phantom T0> has store, key {
        id: 0x2::object::UID,
        lock_id: address,
        balance: 0x2::balance::Balance<T0>,
        provider: address,
        description: 0x1::string::String,
    }

    struct Config has key {
        id: 0x2::object::UID,
        admin: address,
        fee_type: u8,
        fee_percentage: u64,
        fee_token_type: 0x1::string::String,
        fee_token_amount: u64,
        fee_recipient: address,
        total_locks_created: u64,
        total_tokens_locked: 0x2::table::Table<0x1::string::String, u64>,
    }

    struct TokensLocked<phantom T0> has copy, drop {
        lock_id: address,
        owner: address,
        recipient: address,
        amount: u64,
        unlock_time: u64,
        vesting_type: u8,
    }

    struct TokensUnlocked<phantom T0> has copy, drop {
        lock_id: address,
        owner: address,
        recipient: address,
        amount: u64,
    }

    struct VestingClaimed<phantom T0> has copy, drop {
        lock_id: address,
        owner: address,
        recipient: address,
        amount: u64,
        portion: u64,
        remaining_portions: u64,
    }

    struct RewardAdded<phantom T0> has copy, drop {
        reward_id: address,
        lock_id: address,
        provider: address,
        amount: u64,
    }

    struct FeePaid<phantom T0> has copy, drop {
        lock_id: address,
        fee_type: u8,
        amount: u64,
        recipient: address,
    }

    public fun add_reward<T0, T1>(arg0: &TokenLock<T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : Reward<T0> {
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let v1 = 0x2::balance::value<T0>(&v0);
        assert!(v1 > 0, 8);
        let v2 = 0x2::object::new(arg3);
        let v3 = 0x2::tx_context::sender(arg3);
        let v4 = Reward<T0>{
            id          : v2,
            lock_id     : 0x2::object::uid_to_address(&arg0.id),
            balance     : v0,
            provider    : v3,
            description : arg2,
        };
        let v5 = RewardAdded<T0>{
            reward_id : 0x2::object::uid_to_address(&v2),
            lock_id   : 0x2::object::uid_to_address(&arg0.id),
            provider  : v3,
            amount    : v1,
        };
        0x2::event::emit<RewardAdded<T0>>(v5);
        v4
    }

    public entry fun batch_create_locks<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: vector<u64>, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut Config, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 7);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 3);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 + *0x1::vector::borrow<u64>(&arg2, v2);
            v2 = v2 + 1;
        };
        assert!(0x2::coin::value<T0>(&arg0) >= v1, 2);
        v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<address>(&arg1, v2);
            let v4 = *0x1::vector::borrow<u64>(&arg2, v2);
            if (v4 > 0) {
                let v5 = 0x2::coin::split<T0>(&mut arg0, v4, arg7);
                let (v6, v7) = create_lock_internal<T0>(v5, v4, *0x1::vector::borrow<u64>(&arg3, v2), v3, arg4, arg5, arg6, arg7);
                let v8 = v7;
                if (0x2::coin::value<T0>(&v8) > 0) {
                    0x2::coin::join<T0>(&mut arg0, v8);
                } else {
                    0x2::coin::destroy_zero<T0>(v8);
                };
                0x2::transfer::public_transfer<TokenLock<T0>>(v6, v3);
            };
            v2 = v2 + 1;
        };
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun claim_reward<T0>(arg0: Reward<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let Reward {
            id          : v0,
            lock_id     : _,
            balance     : v2,
            provider    : _,
            description : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::coin::from_balance<T0>(v2, arg1)
    }

    public fun claim_vesting<T0>(arg0: &mut TokenLock<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.recipient, 6);
        assert!(arg0.vesting_type == 1, 4);
        assert!(arg0.vesting_portions > 0, 4);
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(v0 >= arg0.unlock_time, 1);
        let v1 = (v0 - arg0.unlock_time) / arg0.vesting_period_ms;
        let v2 = if (v1 > arg0.vesting_portions) {
            arg0.vesting_portions
        } else {
            v1
        };
        let v3 = v2 - arg0.claimed_portions;
        assert!(v3 > 0, 1);
        let v4 = 0x2::balance::value<T0>(&arg0.balance) / arg0.vesting_portions * v3;
        arg0.claimed_portions = arg0.claimed_portions + v3;
        arg0.last_claim_time = v0;
        let v5 = VestingClaimed<T0>{
            lock_id            : 0x2::object::uid_to_address(&arg0.id),
            owner              : arg0.owner,
            recipient          : arg0.recipient,
            amount             : v4,
            portion            : v3,
            remaining_portions : arg0.vesting_portions - arg0.claimed_portions,
        };
        0x2::event::emit<VestingClaimed<T0>>(v5);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v4), arg2)
    }

    public entry fun create_lock_entry<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: address, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut Config, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_lock_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v2 = v1;
        if (0x2::coin::value<T0>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<T0>(v2);
        };
        0x2::transfer::public_transfer<TokenLock<T0>>(v0, 0x2::tx_context::sender(arg7));
    }

    fun create_lock_internal<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: address, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut Config, arg7: &mut 0x2::tx_context::TxContext) : (TokenLock<T0>, 0x2::coin::Coin<T0>) {
        assert!(arg2 > 0x2::clock::timestamp_ms(arg5), 3);
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(arg1 <= v0, 2);
        let v1 = if (arg1 < v0) {
            0x2::coin::split<T0>(&mut arg0, arg1, arg7)
        } else {
            let v2 = arg0;
            arg0 = 0x2::coin::zero<T0>(arg7);
            v2
        };
        let v3 = 0x2::tx_context::sender(arg7);
        let v4 = if (arg3 == @0x0) {
            v3
        } else {
            arg3
        };
        let v5 = TokenLock<T0>{
            id                : 0x2::object::new(arg7),
            balance           : 0x2::coin::into_balance<T0>(v1),
            unlock_time       : arg2,
            owner             : v3,
            recipient         : v4,
            description       : arg4,
            vesting_type      : 0,
            vesting_period_ms : 0,
            vesting_portions  : 0,
            last_claim_time   : 0,
            claimed_portions  : 0,
            fee_paid          : false,
        };
        arg6.total_locks_created = arg6.total_locks_created + 1;
        update_total_locked<T0>(arg6, arg1, true);
        let v6 = TokensLocked<T0>{
            lock_id      : 0x2::object::uid_to_address(&v5.id),
            owner        : v3,
            recipient    : v4,
            amount       : arg1,
            unlock_time  : arg2,
            vesting_type : 0,
        };
        0x2::event::emit<TokensLocked<T0>>(v6);
        (v5, arg0)
    }

    public entry fun create_lock_with_vesting_entry<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: 0x1::string::String, arg8: &0x2::clock::Clock, arg9: &mut Config, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_lock_with_vesting_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v2 = v1;
        if (0x2::coin::value<T0>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg10));
        } else {
            0x2::coin::destroy_zero<T0>(v2);
        };
        0x2::transfer::public_transfer<TokenLock<T0>>(v0, 0x2::tx_context::sender(arg10));
    }

    fun create_lock_with_vesting_internal<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: 0x1::string::String, arg8: &0x2::clock::Clock, arg9: &mut Config, arg10: &mut 0x2::tx_context::TxContext) : (TokenLock<T0>, 0x2::coin::Coin<T0>) {
        assert!(arg2 > 0x2::clock::timestamp_ms(arg8), 3);
        assert!(arg4 > 0, 10);
        assert!(arg3 <= arg2, 4);
        assert!(arg3 + arg4 <= arg2, 4);
        assert!(arg5 > 0, 4);
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(arg1 <= v0, 2);
        let v1 = if (arg1 < v0) {
            0x2::coin::split<T0>(&mut arg0, arg1, arg10)
        } else {
            let v2 = arg0;
            arg0 = 0x2::coin::zero<T0>(arg10);
            v2
        };
        let v3 = 0x2::tx_context::sender(arg10);
        let v4 = if (arg6 == @0x0) {
            v3
        } else {
            arg6
        };
        let v5 = TokenLock<T0>{
            id                : 0x2::object::new(arg10),
            balance           : 0x2::coin::into_balance<T0>(v1),
            unlock_time       : arg2,
            owner             : v3,
            recipient         : v4,
            description       : arg7,
            vesting_type      : 1,
            vesting_period_ms : arg4,
            vesting_portions  : arg5,
            last_claim_time   : 0,
            claimed_portions  : 0,
            fee_paid          : false,
        };
        arg9.total_locks_created = arg9.total_locks_created + 1;
        update_total_locked<T0>(arg9, arg1, true);
        let v6 = TokensLocked<T0>{
            lock_id      : 0x2::object::uid_to_address(&v5.id),
            owner        : v3,
            recipient    : v4,
            amount       : arg1,
            unlock_time  : arg2,
            vesting_type : 1,
        };
        0x2::event::emit<TokensLocked<T0>>(v6);
        (v5, arg0)
    }

    public fun get_amount<T0>(arg0: &TokenLock<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_claimed_portions<T0>(arg0: &TokenLock<T0>) : u64 {
        arg0.claimed_portions
    }

    fun get_coin_type_name<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    public fun get_description<T0>(arg0: &TokenLock<T0>) : 0x1::string::String {
        arg0.description
    }

    public fun get_fee_percentage(arg0: &Config) : u64 {
        arg0.fee_percentage
    }

    public fun get_fee_token_amount(arg0: &Config) : u64 {
        arg0.fee_token_amount
    }

    public fun get_fee_type(arg0: &Config) : u8 {
        arg0.fee_type
    }

    public fun get_owner<T0>(arg0: &TokenLock<T0>) : address {
        arg0.owner
    }

    public fun get_recipient<T0>(arg0: &TokenLock<T0>) : address {
        arg0.recipient
    }

    public fun get_total_locks_created(arg0: &Config) : u64 {
        arg0.total_locks_created
    }

    public fun get_total_tokens_locked<T0>(arg0: &Config) : u64 {
        let v0 = get_coin_type_name<T0>();
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.total_tokens_locked, v0)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.total_tokens_locked, v0)
        } else {
            0
        }
    }

    public fun get_unlock_time<T0>(arg0: &TokenLock<T0>) : u64 {
        arg0.unlock_time
    }

    public fun get_vesting_period<T0>(arg0: &TokenLock<T0>) : u64 {
        arg0.vesting_period_ms
    }

    public fun get_vesting_portions<T0>(arg0: &TokenLock<T0>) : u64 {
        arg0.vesting_portions
    }

    public fun get_vesting_type<T0>(arg0: &TokenLock<T0>) : u8 {
        arg0.vesting_type
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = Config{
            id                  : 0x2::object::new(arg0),
            admin               : v0,
            fee_type            : 0,
            fee_percentage      : 10,
            fee_token_type      : 0x1::string::utf8(b""),
            fee_token_amount    : 0,
            fee_recipient       : v0,
            total_locks_created : 0,
            total_tokens_locked : 0x2::table::new<0x1::string::String, u64>(arg0),
        };
        0x2::transfer::share_object<Config>(v2);
    }

    public fun is_fee_paid<T0>(arg0: &TokenLock<T0>) : bool {
        arg0.fee_paid
    }

    public fun is_unlockable<T0>(arg0: &TokenLock<T0>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.unlock_time
    }

    public fun pay_fee<T0, T1>(arg0: &mut TokenLock<T1>, arg1: 0x2::coin::Coin<T0>, arg2: &Config, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.fee_paid, 5);
        if (arg2.fee_type == 0) {
            let v0 = 0x2::balance::value<T1>(&arg0.balance) * arg2.fee_percentage / 10000;
            assert!(0x2::coin::value<T0>(&arg1) >= v0, 9);
            arg0.fee_paid = true;
            let v1 = FeePaid<T0>{
                lock_id   : 0x2::object::uid_to_address(&arg0.id),
                fee_type  : 0,
                amount    : v0,
                recipient : arg2.fee_recipient,
            };
            0x2::event::emit<FeePaid<T0>>(v1);
            arg1
        } else if (arg2.fee_type == 1) {
            assert!(0x2::coin::value<T0>(&arg1) >= arg2.fee_token_amount, 9);
            arg0.fee_paid = true;
            let v2 = FeePaid<T0>{
                lock_id   : 0x2::object::uid_to_address(&arg0.id),
                fee_type  : 1,
                amount    : arg2.fee_token_amount,
                recipient : arg2.fee_recipient,
            };
            0x2::event::emit<FeePaid<T0>>(v2);
            arg1
        } else {
            arg1
        }
    }

    public entry fun pay_fee_and_transfer<T0, T1>(arg0: &mut TokenLock<T1>, arg1: 0x2::coin::Coin<T0>, arg2: &Config, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(pay_fee<T0, T1>(arg0, arg1, arg2, arg3), arg2.fee_recipient);
    }

    public entry fun transfer_admin(arg0: AdminCap, arg1: address, arg2: &mut Config, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg2.admin, 6);
        arg2.admin = arg1;
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun unlock<T0>(arg0: TokenLock<T0>, arg1: &0x2::clock::Clock, arg2: &mut Config, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let TokenLock {
            id                : v0,
            balance           : v1,
            unlock_time       : v2,
            owner             : v3,
            recipient         : v4,
            description       : _,
            vesting_type      : v6,
            vesting_period_ms : _,
            vesting_portions  : v8,
            last_claim_time   : _,
            claimed_portions  : v10,
            fee_paid          : v11,
        } = arg0;
        let v12 = v1;
        let v13 = v0;
        let v14 = 0x2::tx_context::sender(arg3);
        assert!(v14 == v3 || v14 == v4, 6);
        assert!(0x2::clock::timestamp_ms(arg1) >= v2, 11);
        if (v6 == 1) {
            assert!(v10 == v8 || v14 == v3, 1);
        };
        assert!(v11, 9);
        let v15 = 0x2::balance::value<T0>(&v12);
        update_total_locked<T0>(arg2, v15, false);
        let v16 = TokensUnlocked<T0>{
            lock_id   : 0x2::object::uid_to_address(&v13),
            owner     : v3,
            recipient : v4,
            amount    : v15,
        };
        0x2::event::emit<TokensUnlocked<T0>>(v16);
        0x2::object::delete(v13);
        if (v14 == v3 && v3 != v4) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v12, arg3), v4);
            0x2::coin::zero<T0>(arg3)
        } else {
            0x2::coin::from_balance<T0>(v12, arg3)
        }
    }

    public entry fun update_fee_settings(arg0: &AdminCap, arg1: &mut Config, arg2: u8, arg3: u64, arg4: 0x1::string::String, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg1.admin, 6);
        if (arg2 == 0) {
            assert!(arg3 >= 10 && arg3 <= 300, 5);
        };
        arg1.fee_type = arg2;
        arg1.fee_percentage = arg3;
        arg1.fee_token_type = arg4;
        arg1.fee_token_amount = arg5;
        arg1.fee_recipient = arg6;
    }

    fun update_total_locked<T0>(arg0: &mut Config, arg1: u64, arg2: bool) {
        let v0 = get_coin_type_name<T0>();
        if (!0x2::table::contains<0x1::string::String, u64>(&arg0.total_tokens_locked, v0)) {
            0x2::table::add<0x1::string::String, u64>(&mut arg0.total_tokens_locked, v0, 0);
        };
        let v1 = *0x2::table::borrow<0x1::string::String, u64>(&arg0.total_tokens_locked, v0);
        if (arg2) {
            0x2::table::remove<0x1::string::String, u64>(&mut arg0.total_tokens_locked, v0);
            0x2::table::add<0x1::string::String, u64>(&mut arg0.total_tokens_locked, v0, v1 + arg1);
        } else if (arg1 > v1) {
            0x2::table::remove<0x1::string::String, u64>(&mut arg0.total_tokens_locked, v0);
            0x2::table::add<0x1::string::String, u64>(&mut arg0.total_tokens_locked, v0, 0);
        } else {
            0x2::table::remove<0x1::string::String, u64>(&mut arg0.total_tokens_locked, v0);
            0x2::table::add<0x1::string::String, u64>(&mut arg0.total_tokens_locked, v0, v1 - arg1);
        };
    }

    // decompiled from Move bytecode v6
}

