module 0xa6afb84b6d19fdf43de9a3f3ffd0a88772c9f21d02ef6edf0fb85bc298f298b7::allowance_vault {
    struct TokenBagKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct TierOverrideCap has store, key {
        id: 0x2::object::UID,
    }

    struct UserSlotEntry has store {
        is_plus: bool,
        active_vaults: vector<0x2::object::ID>,
    }

    struct UserVaultRegistry has key {
        id: 0x2::object::UID,
        slots: 0x2::table::Table<address, UserSlotEntry>,
    }

    struct AllowanceVault has key {
        id: 0x2::object::UID,
        owner: address,
        delegate: address,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        max_per_snipe_mist: u64,
        daily_limit_mist: u64,
        spent_today_mist: u64,
        day_index: u64,
        allowed_venues_bitmap: u64,
        expires_at_ms: u64,
        paused: bool,
        auto_tp_sl_custody: bool,
        in_flight: bool,
        total_snipes: u64,
    }

    struct SnipeReceipt<phantom T0> {
        vault_id: 0x2::object::ID,
        borrower: address,
        borrowed_mist: u64,
        min_tokens_out: u64,
    }

    struct ExitReceipt<phantom T0> {
        vault_id: 0x2::object::ID,
        borrower: address,
        sold_tokens: u64,
        min_sui_out_mist: u64,
    }

    struct VaultCreatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        delegate: address,
        initial_deposit_mist: u64,
        max_per_snipe_mist: u64,
        daily_limit_mist: u64,
        allowed_venues_bitmap: u64,
        expires_at_ms: u64,
        auto_tp_sl_custody: bool,
    }

    struct VaultDepositedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        amount_mist: u64,
        new_balance_mist: u64,
    }

    struct VaultWithdrawnEvent has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        amount_mist: u64,
        remaining_balance_mist: u64,
    }

    struct VaultPolicyUpdatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        max_per_snipe_mist: u64,
        daily_limit_mist: u64,
        allowed_venues_bitmap: u64,
        expires_at_ms: u64,
        auto_tp_sl_custody: bool,
    }

    struct VaultPauseChangedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        paused: bool,
    }

    struct VaultDelegateUpdatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        old_delegate: address,
        new_delegate: address,
    }

    struct SnipeExecutedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        executor: address,
        net_spent_mist: u64,
        tokens_received: u64,
        held_in_vault: bool,
    }

    struct ExitExecutedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        executor: address,
        tokens_sold: u64,
        sui_returned_mist: u64,
    }

    public fun active_slot_count(arg0: &UserVaultRegistry, arg1: address) : u64 {
        if (!0x2::table::contains<address, UserSlotEntry>(&arg0.slots, arg1)) {
            0
        } else {
            0x1::vector::length<0x2::object::ID>(&0x2::table::borrow<address, UserSlotEntry>(&arg0.slots, arg1).active_vaults)
        }
    }

    public fun allowed_venues_bitmap(arg0: &AllowanceVault) : u64 {
        arg0.allowed_venues_bitmap
    }

    fun assert_distinct_target_asset<T0>() {
        assert!(0x1::type_name::with_defining_ids<T0>() != 0x1::type_name::with_defining_ids<0x2::sui::SUI>(), 15);
    }

    fun assert_valid_policy(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        assert!(arg0 != @0x0, 11);
        assert!(arg1 > 0, 11);
        assert!(arg2 >= arg1, 11);
        assert!(arg3 > 0 && arg3 & 127 == arg3, 11);
        if (arg4 != 0) {
            assert!(arg4 > arg5, 11);
        };
    }

    public fun auto_tp_sl_custody(arg0: &AllowanceVault) : bool {
        arg0.auto_tp_sl_custody
    }

    public fun borrow_for_exit<T0>(arg0: &mut AllowanceVault, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, ExitReceipt<T0>) {
        assert!(!arg0.in_flight, 14);
        assert!(!arg0.paused, 3);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 == arg0.delegate || v0 == arg0.owner, 2);
        assert_distinct_target_asset<T0>();
        if (arg0.expires_at_ms != 0) {
            assert!(0x2::clock::timestamp_ms(arg4) < arg0.expires_at_ms, 4);
        };
        assert!(is_single_valid_venue_bit(arg3) && arg0.allowed_venues_bitmap & arg3 == arg3, 5);
        assert!(arg2 > 0, 10);
        let v1 = TokenBagKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists<TokenBagKey<T0>>(&arg0.id, v1), 13);
        let v2 = 0x2::balance::value<T0>(0x2::dynamic_field::borrow<TokenBagKey<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v1));
        assert!(arg1 > 0 && v2 >= arg1, 13);
        let v3 = if (v2 == arg1) {
            0x2::coin::from_balance<T0>(0x2::dynamic_field::remove<TokenBagKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v1), arg5)
        } else {
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<TokenBagKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v1), arg1), arg5)
        };
        arg0.in_flight = true;
        let v4 = ExitReceipt<T0>{
            vault_id         : 0x2::object::id<AllowanceVault>(arg0),
            borrower         : v0,
            sold_tokens      : arg1,
            min_sui_out_mist : arg2,
        };
        (v3, v4)
    }

    public fun borrow_for_snipe<T0>(arg0: &mut AllowanceVault, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, SnipeReceipt<T0>) {
        assert!(!arg0.in_flight, 14);
        assert!(!arg0.paused, 3);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 == arg0.delegate || v0 == arg0.owner, 2);
        assert_distinct_target_asset<T0>();
        let v1 = 0x2::clock::timestamp_ms(arg4);
        if (arg0.expires_at_ms != 0) {
            assert!(v1 < arg0.expires_at_ms, 4);
        };
        assert!(is_single_valid_venue_bit(arg3) && arg0.allowed_venues_bitmap & arg3 == arg3, 5);
        assert!(arg1 > 0 && arg1 <= arg0.max_per_snipe_mist, 6);
        let v2 = v1 / 86400000;
        let v3 = if (v2 > arg0.day_index) {
            0
        } else {
            arg0.spent_today_mist
        };
        assert!(v3 <= arg0.daily_limit_mist && arg1 <= arg0.daily_limit_mist - v3, 7);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= arg1, 8);
        arg0.in_flight = true;
        arg0.day_index = v2;
        arg0.spent_today_mist = v3 + arg1;
        let v4 = SnipeReceipt<T0>{
            vault_id       : 0x2::object::id<AllowanceVault>(arg0),
            borrower       : v0,
            borrowed_mist  : arg1,
            min_tokens_out : arg2,
        };
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, arg1), arg5), v4)
    }

    fun build_vault_internal(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : AllowanceVault {
        assert!(arg0 != @0x0, 11);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        assert_valid_policy(arg2, arg3, arg4, arg5, arg6, v0);
        let v1 = AllowanceVault{
            id                    : 0x2::object::new(arg9),
            owner                 : arg0,
            delegate              : arg2,
            sui_balance           : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            max_per_snipe_mist    : arg3,
            daily_limit_mist      : arg4,
            spent_today_mist      : 0,
            day_index             : v0 / 86400000,
            allowed_venues_bitmap : arg5,
            expires_at_ms         : arg6,
            paused                : false,
            auto_tp_sl_custody    : arg7,
            in_flight             : false,
            total_snipes          : 0,
        };
        let v2 = VaultCreatedEvent{
            vault_id              : 0x2::object::id<AllowanceVault>(&v1),
            owner                 : arg0,
            delegate              : arg2,
            initial_deposit_mist  : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            max_per_snipe_mist    : arg3,
            daily_limit_mist      : arg4,
            allowed_venues_bitmap : arg5,
            expires_at_ms         : arg6,
            auto_tp_sl_custody    : arg7,
        };
        0x2::event::emit<VaultCreatedEvent>(v2);
        v1
    }

    public fun create_registered_vault(arg0: &mut UserVaultRegistry, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg9);
        if (!0x2::table::contains<address, UserSlotEntry>(&arg0.slots, v0)) {
            let v1 = UserSlotEntry{
                is_plus       : false,
                active_vaults : 0x1::vector::empty<0x2::object::ID>(),
            };
            0x2::table::add<address, UserSlotEntry>(&mut arg0.slots, v0, v1);
        };
        let v2 = 0x2::table::borrow_mut<address, UserSlotEntry>(&mut arg0.slots, v0);
        let v3 = if (v2.is_plus) {
            20
        } else {
            3
        };
        assert!(0x1::vector::length<0x2::object::ID>(&v2.active_vaults) < v3, 12);
        let v4 = build_vault_internal(v0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v5 = 0x2::object::id<AllowanceVault>(&v4);
        0x1::vector::push_back<0x2::object::ID>(&mut v2.active_vaults, v5);
        0x2::transfer::share_object<AllowanceVault>(v4);
        v5
    }

    public fun create_vault(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = build_vault_internal(v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::share_object<AllowanceVault>(v1);
        0x2::object::id<AllowanceVault>(&v1)
    }

    public fun daily_limit_mist(arg0: &AllowanceVault) : u64 {
        arg0.daily_limit_mist
    }

    public fun day_index(arg0: &AllowanceVault) : u64 {
        arg0.day_index
    }

    public fun delegate(arg0: &AllowanceVault) : address {
        arg0.delegate
    }

    public fun deposit_sui(arg0: &mut AllowanceVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(!arg0.in_flight, 14);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = VaultDepositedEvent{
            vault_id         : 0x2::object::id<AllowanceVault>(arg0),
            owner            : arg0.owner,
            amount_mist      : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            new_balance_mist : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance),
        };
        0x2::event::emit<VaultDepositedEvent>(v0);
    }

    public fun expires_at_ms(arg0: &AllowanceVault) : u64 {
        arg0.expires_at_ms
    }

    public fun has_token_custody<T0>(arg0: &AllowanceVault) : bool {
        let v0 = TokenBagKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists<TokenBagKey<T0>>(&arg0.id, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UserVaultRegistry{
            id    : 0x2::object::new(arg0),
            slots : 0x2::table::new<address, UserSlotEntry>(arg0),
        };
        0x2::transfer::share_object<UserVaultRegistry>(v0);
        let v1 = TierOverrideCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<TierOverrideCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_in_flight(arg0: &AllowanceVault) : bool {
        arg0.in_flight
    }

    public fun is_paused(arg0: &AllowanceVault) : bool {
        arg0.paused
    }

    fun is_single_valid_venue_bit(arg0: u64) : bool {
        if (arg0 != 0) {
            if (arg0 & arg0 - 1 == 0) {
                arg0 & 127 == arg0
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun max_per_snipe_mist(arg0: &AllowanceVault) : u64 {
        arg0.max_per_snipe_mist
    }

    public fun owner(arg0: &AllowanceVault) : address {
        arg0.owner
    }

    public fun set_delegate(arg0: &mut AllowanceVault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.in_flight, 14);
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        assert!(arg1 != @0x0, 11);
        arg0.delegate = arg1;
        let v0 = VaultDelegateUpdatedEvent{
            vault_id     : 0x2::object::id<AllowanceVault>(arg0),
            owner        : arg0.owner,
            old_delegate : arg0.delegate,
            new_delegate : arg1,
        };
        0x2::event::emit<VaultDelegateUpdatedEvent>(v0);
    }

    public fun set_paused(arg0: &mut AllowanceVault, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.in_flight, 14);
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.paused = arg1;
        let v0 = VaultPauseChangedEvent{
            vault_id : 0x2::object::id<AllowanceVault>(arg0),
            owner    : arg0.owner,
            paused   : arg1,
        };
        0x2::event::emit<VaultPauseChangedEvent>(v0);
    }

    public fun set_user_plus_tier(arg0: &TierOverrideCap, arg1: &mut UserVaultRegistry, arg2: address, arg3: bool) {
        assert!(arg2 != @0x0, 11);
        if (!0x2::table::contains<address, UserSlotEntry>(&arg1.slots, arg2)) {
            let v0 = UserSlotEntry{
                is_plus       : arg3,
                active_vaults : 0x1::vector::empty<0x2::object::ID>(),
            };
            0x2::table::add<address, UserSlotEntry>(&mut arg1.slots, arg2, v0);
        } else {
            0x2::table::borrow_mut<address, UserSlotEntry>(&mut arg1.slots, arg2).is_plus = arg3;
        };
    }

    public fun settle_exit<T0>(arg0: &mut AllowanceVault, arg1: ExitReceipt<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let ExitReceipt {
            vault_id         : v0,
            borrower         : v1,
            sold_tokens      : v2,
            min_sui_out_mist : v3,
        } = arg1;
        assert!(arg0.in_flight && v0 == 0x2::object::id<AllowanceVault>(arg0), 9);
        assert!(0x2::tx_context::sender(arg4) == v1, 2);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v4 > 0 && v4 >= v3, 10);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg0.in_flight = false;
        if (0x2::coin::value<T0>(&arg3) > 0) {
            let v5 = TokenBagKey<T0>{dummy_field: false};
            if (!0x2::dynamic_field::exists<TokenBagKey<T0>>(&arg0.id, v5)) {
                0x2::dynamic_field::add<TokenBagKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v5, 0x2::coin::into_balance<T0>(arg3));
            } else {
                0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<TokenBagKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v5), 0x2::coin::into_balance<T0>(arg3));
            };
        } else {
            0x2::coin::destroy_zero<T0>(arg3);
        };
        let v6 = ExitExecutedEvent{
            vault_id          : v0,
            owner             : arg0.owner,
            executor          : v1,
            tokens_sold       : v2,
            sui_returned_mist : v4,
        };
        0x2::event::emit<ExitExecutedEvent>(v6);
    }

    public fun settle_snipe<T0>(arg0: &mut AllowanceVault, arg1: SnipeReceipt<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let SnipeReceipt {
            vault_id       : v0,
            borrower       : v1,
            borrowed_mist  : v2,
            min_tokens_out : v3,
        } = arg1;
        assert!(arg0.in_flight && v0 == 0x2::object::id<AllowanceVault>(arg0), 9);
        assert!(0x2::tx_context::sender(arg4) == v1, 2);
        let v4 = 0x2::coin::value<T0>(&arg3);
        assert!(v4 > 0 && v4 >= v3, 10);
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v6 = if (v5 > v2) {
            v2
        } else {
            v5
        };
        arg0.spent_today_mist = arg0.spent_today_mist - v6;
        arg0.total_snipes = arg0.total_snipes + 1;
        arg0.in_flight = false;
        let v7 = if (v2 > v5) {
            v2 - v5
        } else {
            0
        };
        if (arg0.auto_tp_sl_custody) {
            let v8 = TokenBagKey<T0>{dummy_field: false};
            if (!0x2::dynamic_field::exists<TokenBagKey<T0>>(&arg0.id, v8)) {
                0x2::dynamic_field::add<TokenBagKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v8, 0x2::coin::into_balance<T0>(arg3));
            } else {
                0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<TokenBagKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v8), 0x2::coin::into_balance<T0>(arg3));
            };
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, arg0.owner);
        };
        let v9 = SnipeExecutedEvent{
            vault_id        : v0,
            owner           : arg0.owner,
            executor        : v1,
            net_spent_mist  : v7,
            tokens_received : v4,
            held_in_vault   : arg0.auto_tp_sl_custody,
        };
        0x2::event::emit<SnipeExecutedEvent>(v9);
    }

    public fun spent_today_mist(arg0: &AllowanceVault) : u64 {
        arg0.spent_today_mist
    }

    public fun sui_balance_mist(arg0: &AllowanceVault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)
    }

    public fun token_custody_balance<T0>(arg0: &AllowanceVault) : u64 {
        let v0 = TokenBagKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists<TokenBagKey<T0>>(&arg0.id, v0)) {
            0
        } else {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<TokenBagKey<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v0))
        }
    }

    public fun total_snipes(arg0: &AllowanceVault) : u64 {
        arg0.total_snipes
    }

    public fun unregister_vault_slot(arg0: &mut UserVaultRegistry, arg1: &mut AllowanceVault, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.in_flight, 14);
        assert!(0x2::tx_context::sender(arg2) == arg1.owner, 1);
        arg1.paused = true;
        if (0x2::table::contains<address, UserSlotEntry>(&arg0.slots, arg1.owner)) {
            let v0 = 0x2::table::borrow_mut<address, UserSlotEntry>(&mut arg0.slots, arg1.owner);
            let v1 = 0x2::object::id<AllowanceVault>(arg1);
            let (v2, v3) = 0x1::vector::index_of<0x2::object::ID>(&v0.active_vaults, &v1);
            if (v2) {
                0x1::vector::swap_remove<0x2::object::ID>(&mut v0.active_vaults, v3);
            };
        };
    }

    public fun update_policy(arg0: &mut AllowanceVault, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.in_flight, 14);
        assert!(0x2::tx_context::sender(arg7) == arg0.owner, 1);
        assert_valid_policy(arg0.delegate, arg1, arg2, arg3, arg4, 0x2::clock::timestamp_ms(arg6));
        arg0.max_per_snipe_mist = arg1;
        arg0.daily_limit_mist = arg2;
        arg0.allowed_venues_bitmap = arg3;
        arg0.expires_at_ms = arg4;
        arg0.auto_tp_sl_custody = arg5;
        let v0 = VaultPolicyUpdatedEvent{
            vault_id              : 0x2::object::id<AllowanceVault>(arg0),
            owner                 : arg0.owner,
            max_per_snipe_mist    : arg1,
            daily_limit_mist      : arg2,
            allowed_venues_bitmap : arg3,
            expires_at_ms         : arg4,
            auto_tp_sl_custody    : arg5,
        };
        0x2::event::emit<VaultPolicyUpdatedEvent>(v0);
    }

    public fun venue_aftermath() : u64 {
        8
    }

    public fun venue_all_default() : u64 {
        127
    }

    public fun venue_blast_curve() : u64 {
        1
    }

    public fun venue_bluefin() : u64 {
        64
    }

    public fun venue_bluemove() : u64 {
        16
    }

    public fun venue_cetus() : u64 {
        2
    }

    public fun venue_suipump() : u64 {
        32
    }

    public fun venue_turbos() : u64 {
        4
    }

    public fun withdraw_all_sui(arg0: &mut AllowanceVault, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(!arg0.in_flight, 14);
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance);
        let v1 = VaultWithdrawnEvent{
            vault_id               : 0x2::object::id<AllowanceVault>(arg0),
            owner                  : arg0.owner,
            amount_mist            : v0,
            remaining_balance_mist : 0,
        };
        0x2::event::emit<VaultWithdrawnEvent>(v1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, v0), arg1)
    }

    public fun withdraw_all_tokens<T0>(arg0: &mut AllowanceVault, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.in_flight, 14);
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        let v0 = TokenBagKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists<TokenBagKey<T0>>(&arg0.id, v0), 13);
        0x2::coin::from_balance<T0>(0x2::dynamic_field::remove<TokenBagKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1)
    }

    public fun withdraw_sui(arg0: &mut AllowanceVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(!arg0.in_flight, 14);
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= arg1, 8);
        let v0 = VaultWithdrawnEvent{
            vault_id               : 0x2::object::id<AllowanceVault>(arg0),
            owner                  : arg0.owner,
            amount_mist            : arg1,
            remaining_balance_mist : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance),
        };
        0x2::event::emit<VaultWithdrawnEvent>(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, arg1), arg2)
    }

    public fun withdraw_tokens<T0>(arg0: &mut AllowanceVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.in_flight, 14);
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        let v0 = TokenBagKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists<TokenBagKey<T0>>(&arg0.id, v0), 13);
        let v1 = 0x2::balance::value<T0>(0x2::dynamic_field::borrow<TokenBagKey<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v0));
        assert!(v1 >= arg1, 13);
        if (v1 == arg1) {
            0x2::coin::from_balance<T0>(0x2::dynamic_field::remove<TokenBagKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg2)
        } else {
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<TokenBagKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1), arg2)
        }
    }

    // decompiled from Move bytecode v7
}

