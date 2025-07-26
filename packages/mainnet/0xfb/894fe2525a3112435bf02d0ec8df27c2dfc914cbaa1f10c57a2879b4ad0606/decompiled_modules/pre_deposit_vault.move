module 0xfb894fe2525a3112435bf02d0ec8df27c2dfc914cbaa1f10c57a2879b4ad0606::pre_deposit_vault {
    struct PRE_DEPOSIT_VAULT has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct EmergencyState has key {
        id: 0x2::object::UID,
        is_paused: bool,
    }

    struct Treasury<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        total_deposited: u64,
        total_withdrawn: u64,
    }

    struct VaultConfig has key {
        id: 0x2::object::UID,
        early_withdraw_cooldown_ms: u64,
        supported_tokens: vector<0x1::type_name::TypeName>,
        token_symbols: vector<0x1::string::String>,
        token_decimals: vector<u8>,
    }

    struct VaultPosition<phantom T0> has store, key {
        id: 0x2::object::UID,
        amount: u64,
        deposit_time_ms: u64,
        lock_duration_ms: u64,
        unlock_time_ms: u64,
        is_early_withdraw_requested: bool,
        early_withdraw_unlock_time_ms: u64,
        token_symbol: 0x1::string::String,
        token_decimals: u8,
    }

    struct DepositEvent has copy, drop {
        position_id: 0x2::object::ID,
        user: address,
        token_type: 0x1::type_name::TypeName,
        token_symbol: 0x1::string::String,
        amount: u64,
        lock_duration_ms: u64,
        unlock_time_ms: u64,
        timestamp_ms: u64,
    }

    struct WithdrawEvent has copy, drop {
        position_id: 0x2::object::ID,
        user: address,
        token_type: 0x1::type_name::TypeName,
        token_symbol: 0x1::string::String,
        amount: u64,
        is_early_withdraw: bool,
        timestamp_ms: u64,
    }

    struct EarlyWithdrawRequestEvent has copy, drop {
        position_id: 0x2::object::ID,
        user: address,
        token_type: 0x1::type_name::TypeName,
        early_withdraw_unlock_time_ms: u64,
        timestamp_ms: u64,
    }

    struct LockExtensionEvent has copy, drop {
        position_id: 0x2::object::ID,
        user: address,
        token_type: 0x1::type_name::TypeName,
        new_lock_duration_ms: u64,
        new_unlock_time_ms: u64,
        timestamp_ms: u64,
    }

    public fun add_supported_token<T0>(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: 0x1::string::String, arg3: u8) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::vector::length<0x1::string::String>(&arg1.token_symbols);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg1.supported_tokens) == v1 && v1 == 0x1::vector::length<u8>(&arg1.token_decimals), 12);
        let (v2, _) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg1.supported_tokens, &v0);
        if (!v2) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.supported_tokens, v0);
            0x1::vector::push_back<0x1::string::String>(&mut arg1.token_symbols, arg2);
            0x1::vector::push_back<u8>(&mut arg1.token_decimals, arg3);
        };
    }

    public fun create_treasury<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury<T0>{
            id              : 0x2::object::new(arg1),
            balance         : 0x2::balance::zero<T0>(),
            total_deposited : 0,
            total_withdrawn : 0,
        };
        0x2::transfer::share_object<Treasury<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &VaultConfig, arg1: &EmergencyState, arg2: &mut Treasury<T0>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : VaultPosition<T0> {
        assert!(!arg1.is_paused, 10);
        assert!(arg4 >= 3600000, 7);
        assert!(arg4 <= 31536000000, 7);
        let v0 = 0x1::type_name::get<T0>();
        let (v1, v2) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.supported_tokens, &v0);
        assert!(v1, 6);
        let v3 = 0x2::coin::value<T0>(&arg3);
        assert!(v3 > 0, 1);
        let v4 = 0x2::clock::timestamp_ms(arg5);
        assert!(v4 <= 18446744073709551615 - arg4, 9);
        let v5 = v4 + arg4;
        let v6 = *0x1::vector::borrow<0x1::string::String>(&arg0.token_symbols, v2);
        0x2::balance::join<T0>(&mut arg2.balance, 0x2::coin::into_balance<T0>(arg3));
        assert!(arg2.total_deposited <= 18446744073709551615 - v3, 9);
        arg2.total_deposited = arg2.total_deposited + v3;
        let v7 = VaultPosition<T0>{
            id                            : 0x2::object::new(arg6),
            amount                        : v3,
            deposit_time_ms               : v4,
            lock_duration_ms              : arg4,
            unlock_time_ms                : v5,
            is_early_withdraw_requested   : false,
            early_withdraw_unlock_time_ms : 0,
            token_symbol                  : v6,
            token_decimals                : *0x1::vector::borrow<u8>(&arg0.token_decimals, v2),
        };
        let v8 = DepositEvent{
            position_id      : 0x2::object::id<VaultPosition<T0>>(&v7),
            user             : 0x2::tx_context::sender(arg6),
            token_type       : v0,
            token_symbol     : v6,
            amount           : v3,
            lock_duration_ms : arg4,
            unlock_time_ms   : v5,
            timestamp_ms     : v4,
        };
        0x2::event::emit<DepositEvent>(v8);
        v7
    }

    public fun emergency_pause(arg0: &AdminCap, arg1: &mut EmergencyState) {
        arg1.is_paused = true;
    }

    public fun emergency_unpause(arg0: &AdminCap, arg1: &mut EmergencyState) {
        arg1.is_paused = false;
    }

    public fun extend_lock<T0>(arg0: &mut VaultPosition<T0>, arg1: u64, arg2: &EmergencyState, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.is_paused, 10);
        assert!(!arg0.is_early_withdraw_requested, 4);
        assert!(arg1 > 0, 5);
        assert!(arg0.lock_duration_ms <= 31536000000 - arg1, 7);
        assert!(arg0.unlock_time_ms <= 18446744073709551615 - arg1, 9);
        assert!(arg0.lock_duration_ms <= 18446744073709551615 - arg1, 9);
        arg0.unlock_time_ms = arg0.unlock_time_ms + arg1;
        arg0.lock_duration_ms = arg0.lock_duration_ms + arg1;
        let v0 = LockExtensionEvent{
            position_id          : 0x2::object::id<VaultPosition<T0>>(arg0),
            user                 : 0x2::tx_context::sender(arg4),
            token_type           : 0x1::type_name::get<T0>(),
            new_lock_duration_ms : arg0.lock_duration_ms,
            new_unlock_time_ms   : arg0.unlock_time_ms,
            timestamp_ms         : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<LockExtensionEvent>(v0);
    }

    public fun get_config_info(arg0: &VaultConfig) : (u64, vector<0x1::type_name::TypeName>, vector<0x1::string::String>, vector<u8>) {
        (arg0.early_withdraw_cooldown_ms, arg0.supported_tokens, arg0.token_symbols, arg0.token_decimals)
    }

    public fun get_position_info<T0>(arg0: &VaultPosition<T0>) : (u64, u64, u64, u64, bool, u64, 0x1::string::String, u8) {
        (arg0.amount, arg0.deposit_time_ms, arg0.lock_duration_ms, arg0.unlock_time_ms, arg0.is_early_withdraw_requested, arg0.early_withdraw_unlock_time_ms, arg0.token_symbol, arg0.token_decimals)
    }

    public fun get_token_info<T0>(arg0: &VaultConfig) : (0x1::string::String, u8) {
        let v0 = 0x1::type_name::get<T0>();
        let (v1, v2) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.supported_tokens, &v0);
        if (v1) {
            (*0x1::vector::borrow<0x1::string::String>(&arg0.token_symbols, v2), *0x1::vector::borrow<u8>(&arg0.token_decimals, v2))
        } else {
            (0x1::string::utf8(b"UNKNOWN"), 9)
        }
    }

    public fun get_treasury_balance<T0>(arg0: &Treasury<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_treasury_stats<T0>(arg0: &Treasury<T0>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.balance), arg0.total_deposited, arg0.total_withdrawn)
    }

    fun init(arg0: PRE_DEPOSIT_VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"token_symbol"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"amount"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"unlock_time"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{token_symbol} Vault Position #{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A locked {token_symbol} position in the multi-token vault"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b""));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b""));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{token_symbol}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{amount}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{unlock_time}"));
        let v4 = 0x2::package::claim<PRE_DEPOSIT_VAULT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<VaultPosition<0x2::sui::SUI>>(&v4, v0, v2, arg1);
        0x2::display::update_version<VaultPosition<0x2::sui::SUI>>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<VaultPosition<0x2::sui::SUI>>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        let v7 = EmergencyState{
            id        : 0x2::object::new(arg1),
            is_paused : false,
        };
        let v8 = VaultConfig{
            id                         : 0x2::object::new(arg1),
            early_withdraw_cooldown_ms : 604800000,
            supported_tokens           : 0x1::vector::empty<0x1::type_name::TypeName>(),
            token_symbols              : 0x1::vector::empty<0x1::string::String>(),
            token_decimals             : 0x1::vector::empty<u8>(),
        };
        0x2::transfer::transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<VaultConfig>(v8);
        0x2::transfer::share_object<EmergencyState>(v7);
    }

    public fun is_contract_paused(arg0: &EmergencyState) : bool {
        arg0.is_paused
    }

    public fun is_token_supported<T0>(arg0: &VaultConfig) : bool {
        let v0 = 0x1::type_name::get<T0>();
        let (v1, _) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.supported_tokens, &v0);
        v1
    }

    public fun remove_supported_token<T0>(arg0: &AdminCap, arg1: &mut VaultConfig) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::vector::length<0x1::string::String>(&arg1.token_symbols);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg1.supported_tokens) == v1 && v1 == 0x1::vector::length<u8>(&arg1.token_decimals), 12);
        let (v2, v3) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg1.supported_tokens, &v0);
        if (v2) {
            0x1::vector::remove<0x1::type_name::TypeName>(&mut arg1.supported_tokens, v3);
            0x1::vector::remove<0x1::string::String>(&mut arg1.token_symbols, v3);
            0x1::vector::remove<u8>(&mut arg1.token_decimals, v3);
        };
    }

    public fun request_early_withdraw<T0>(arg0: &mut VaultPosition<T0>, arg1: &VaultConfig, arg2: &EmergencyState, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.is_paused, 10);
        assert!(!arg0.is_early_withdraw_requested, 4);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 <= 18446744073709551615 - arg1.early_withdraw_cooldown_ms, 9);
        arg0.is_early_withdraw_requested = true;
        arg0.early_withdraw_unlock_time_ms = v0 + arg1.early_withdraw_cooldown_ms;
        let v1 = EarlyWithdrawRequestEvent{
            position_id                   : 0x2::object::id<VaultPosition<T0>>(arg0),
            user                          : 0x2::tx_context::sender(arg4),
            token_type                    : 0x1::type_name::get<T0>(),
            early_withdraw_unlock_time_ms : arg0.early_withdraw_unlock_time_ms,
            timestamp_ms                  : v0,
        };
        0x2::event::emit<EarlyWithdrawRequestEvent>(v1);
    }

    public fun update_cooldown(arg0: &AdminCap, arg1: &mut VaultConfig, arg2: u64) {
        assert!(arg2 >= 60000, 8);
        assert!(arg2 <= 2592000000, 8);
        arg1.early_withdraw_cooldown_ms = arg2;
    }

    public fun withdraw<T0>(arg0: VaultPosition<T0>, arg1: &EmergencyState, arg2: &mut Treasury<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg1.is_paused, 10);
        let VaultPosition {
            id                            : v0,
            amount                        : v1,
            deposit_time_ms               : _,
            lock_duration_ms              : _,
            unlock_time_ms                : v4,
            is_early_withdraw_requested   : v5,
            early_withdraw_unlock_time_ms : v6,
            token_symbol                  : v7,
            token_decimals                : _,
        } = arg0;
        let v9 = v0;
        let v10 = 0x2::clock::timestamp_ms(arg3);
        let v11 = if (v5) {
            v6
        } else {
            v4
        };
        assert!(v10 >= v11, 2);
        assert!(0x2::balance::value<T0>(&arg2.balance) >= v1, 11);
        0x2::object::delete(v9);
        assert!(arg2.total_withdrawn <= 18446744073709551615 - v1, 9);
        arg2.total_withdrawn = arg2.total_withdrawn + v1;
        let v12 = WithdrawEvent{
            position_id       : 0x2::object::uid_to_inner(&v9),
            user              : 0x2::tx_context::sender(arg4),
            token_type        : 0x1::type_name::get<T0>(),
            token_symbol      : v7,
            amount            : v1,
            is_early_withdraw : v5,
            timestamp_ms      : v10,
        };
        0x2::event::emit<WithdrawEvent>(v12);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.balance, v1), arg4)
    }

    // decompiled from Move bytecode v6
}

