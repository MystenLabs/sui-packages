module 0x3ba83cbc3e8ccdf3191cdc7cf5d113b30793a3b0cf61c8392ea404f706bb016b::dao_vault {
    struct ManagerCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct PauserCap has store, key {
        id: 0x2::object::UID,
    }

    struct TotalValueLocked has drop {
        pos0: u64,
    }

    struct TotalValueLockedCalculation {
        remaining_coins: vector<0x1::ascii::String>,
        value: u64,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        lp_supply: u64,
        balance_storage: 0x2::bag::Bag,
        lp_balance: 0x2::table::Table<address, u64>,
        required_votes: u64,
        paused: bool,
        deposit_coins: 0x2::vec_set::VecSet<0x1::ascii::String>,
        swap_coins: 0x2::vec_set::VecSet<0x1::ascii::String>,
    }

    struct Withdrawal {
        vault_id: 0x2::object::ID,
        owner: address,
        lp_balance: u64,
        coins: vector<0x1::ascii::String>,
    }

    struct Deposited has copy, drop {
        vault: 0x2::object::ID,
        depositor: address,
        amount: u64,
        lp_tokens_minted: u64,
    }

    struct Withdrawn has copy, drop {
        vault: 0x2::object::ID,
        withdrawer: address,
        amount: u64,
    }

    struct Borrowed has copy, drop {
        vault: 0x2::object::ID,
        borrower: address,
        coin_type_name: 0x1::ascii::String,
        usd_value: u64,
    }

    struct Returned has copy, drop {
        vault: 0x2::object::ID,
        returner: address,
        coin_type_name: 0x1::ascii::String,
        usd_value: u64,
    }

    struct FlashLoanForSwap {
        vault_id: 0x2::object::ID,
        borrow_usd_value: u64,
        borrow_coin_type_name: 0x1::ascii::String,
    }

    public fun add_deposit_coin<T0>(arg0: &mut Vault, arg1: &ManagerCap) {
        assert!(arg1.vault_id == 0x2::object::id<Vault>(arg0), 5);
        process_add_deposit_coin<T0>(arg0);
    }

    public fun add_swap_coin<T0>(arg0: &mut Vault, arg1: &ManagerCap, arg2: &0x3ba83cbc3e8ccdf3191cdc7cf5d113b30793a3b0cf61c8392ea404f706bb016b::coin_registry::CoinRegistry) {
        assert!(arg1.vault_id == 0x2::object::id<Vault>(arg0), 5);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x3ba83cbc3e8ccdf3191cdc7cf5d113b30793a3b0cf61c8392ea404f706bb016b::coin_registry::allowed_coin(arg2, &v0), 22);
        process_add_swap_coin<T0>(arg0, v0);
    }

    fun append_balance<T0>(arg0: &mut Vault, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.balance_storage, 0x1::type_name::into_string(0x1::type_name::get<T0>())), arg1);
    }

    fun burn_lp(arg0: &mut Vault, arg1: address, arg2: u64) {
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.lp_balance, arg1);
        assert!(*v0 >= arg2, 3);
        arg0.lp_supply = arg0.lp_supply - arg2;
        *v0 = *v0 - arg2;
        if (*v0 == 0) {
            0x2::table::remove<address, u64>(&mut arg0.lp_balance, arg1);
        };
    }

    public fun calculate_total_value_locked_in_usd<T0>(arg0: &Vault, arg1: &0x3ba83cbc3e8ccdf3191cdc7cf5d113b30793a3b0cf61c8392ea404f706bb016b::coin_registry::CoinRegistry, arg2: &mut TotalValueLockedCalculation, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock) {
        let v0 = 0x1::vector::pop_back<0x1::ascii::String>(&mut arg2.remaining_coins);
        arg2.value = arg2.value + 0x2::balance::value<T0>(0x2::bag::borrow<0x1::ascii::String, 0x2::balance::Balance<T0>>(&arg0.balance_storage, v0)) * 0x3ba83cbc3e8ccdf3191cdc7cf5d113b30793a3b0cf61c8392ea404f706bb016b::price::usd_price(0x3ba83cbc3e8ccdf3191cdc7cf5d113b30793a3b0cf61c8392ea404f706bb016b::coin_registry::get_price_feed_id(arg1, &v0), arg4, arg5) / 0x2::math::pow(10, 0x2::coin::get_decimals<T0>(arg3));
    }

    public fun deposit_coin<T0>(arg0: &mut Vault, arg1: &0x3ba83cbc3e8ccdf3191cdc7cf5d113b30793a3b0cf61c8392ea404f706bb016b::coin_registry::CoinRegistry, arg2: TotalValueLocked, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        let v0 = 0x2::coin::value<T0>(&arg5);
        assert!(v0 > 0, 2);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v2 = usd_to_shares(arg0, arg2, 0x2::coin::value<T0>(&arg5) * 0x3ba83cbc3e8ccdf3191cdc7cf5d113b30793a3b0cf61c8392ea404f706bb016b::price::usd_price(0x3ba83cbc3e8ccdf3191cdc7cf5d113b30793a3b0cf61c8392ea404f706bb016b::coin_registry::get_price_feed_id(arg1, &v1), arg4, arg6) / 0x2::math::pow(10, 0x2::coin::get_decimals<T0>(arg3)));
        assert!(v2 > 0, 2);
        append_balance<T0>(arg0, 0x2::coin::into_balance<T0>(arg5));
        mint_lp(arg0, 0x2::tx_context::sender(arg7), v2);
        let v3 = Deposited{
            vault            : 0x2::object::id<Vault>(arg0),
            depositor        : 0x2::tx_context::sender(arg7),
            amount           : v0,
            lp_tokens_minted : v2,
        };
        0x2::event::emit<Deposited>(v3);
    }

    public fun execute_withdrawal<T0>(arg0: &mut Vault, arg1: &mut Withdrawal, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.vault_id, 17);
        assert!(0x1::vector::pop_back<0x1::ascii::String>(&mut arg1.coins) == 0x1::type_name::into_string(0x1::type_name::get<T0>()), 13906835342574485503);
        let v0 = arg1.lp_balance;
        let v1 = v0 * 100 / total_shares(arg0);
        let v2 = take_balance<T0>(arg0, v1);
        let v3 = Withdrawn{
            vault      : 0x2::object::id<Vault>(arg0),
            withdrawer : 0x2::tx_context::sender(arg2),
            amount     : v0,
        };
        0x2::event::emit<Withdrawn>(v3);
        0x2::coin::from_balance<T0>(v2, arg2)
    }

    public fun finalize_tvl_calculation(arg0: TotalValueLockedCalculation) : TotalValueLocked {
        let TotalValueLockedCalculation {
            remaining_coins : v0,
            value           : v1,
        } = arg0;
        0x1::vector::destroy_empty<0x1::ascii::String>(v0);
        TotalValueLocked{pos0: v1}
    }

    public fun finalize_withdrawal(arg0: &mut Vault, arg1: Withdrawal) {
        let Withdrawal {
            vault_id   : v0,
            owner      : v1,
            lp_balance : v2,
            coins      : v3,
        } = arg1;
        assert!(0x2::object::uid_to_inner(&arg0.id) == v0, 17);
        burn_lp(arg0, v1, v2);
        0x1::vector::destroy_empty<0x1::ascii::String>(v3);
    }

    public fun flashloan_for_swap<T0>(arg0: &mut Vault, arg1: &ManagerCap, arg2: &0x3ba83cbc3e8ccdf3191cdc7cf5d113b30793a3b0cf61c8392ea404f706bb016b::coin_registry::CoinRegistry, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoanForSwap) {
        assert!(arg5 > 0, 2);
        assert!(arg1.vault_id == 0x2::object::id<Vault>(arg0), 5);
        assert!(!arg0.paused, 1);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = arg5 * 0x3ba83cbc3e8ccdf3191cdc7cf5d113b30793a3b0cf61c8392ea404f706bb016b::price::usd_price(0x3ba83cbc3e8ccdf3191cdc7cf5d113b30793a3b0cf61c8392ea404f706bb016b::coin_registry::get_price_feed_id(arg2, &v0), arg4, arg6) / 0x2::math::pow(10, 0x2::coin::get_decimals<T0>(arg3));
        let v2 = take_balance<T0>(arg0, arg5);
        let v3 = Borrowed{
            vault          : 0x2::object::id<Vault>(arg0),
            borrower       : 0x2::tx_context::sender(arg7),
            coin_type_name : v0,
            usd_value      : v1,
        };
        0x2::event::emit<Borrowed>(v3);
        let v4 = FlashLoanForSwap{
            vault_id              : 0x2::object::uid_to_inner(&arg0.id),
            borrow_usd_value      : v1,
            borrow_coin_type_name : v0,
        };
        (0x2::coin::from_balance<T0>(v2, arg7), v4)
    }

    fun get_liquidity_provider_balance(arg0: &Vault, arg1: address) : u64 {
        *0x2::table::borrow<address, u64>(&arg0.lp_balance, arg1)
    }

    fun has_balance(arg0: &Vault, arg1: 0x1::ascii::String) : bool {
        0x2::bag::contains<0x1::ascii::String>(&arg0.balance_storage, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PauserCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PauserCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun init_balance<T0>(arg0: &mut Vault, arg1: 0x1::ascii::String) {
        0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.balance_storage, arg1, 0x2::balance::zero<T0>());
    }

    public fun initialize_tvl_calculation(arg0: &Vault) : TotalValueLockedCalculation {
        TotalValueLockedCalculation{
            remaining_coins : *0x2::vec_set::keys<0x1::ascii::String>(&arg0.swap_coins),
            value           : 0,
        }
    }

    public fun initiate_withdrawal(arg0: &mut Vault, arg1: &mut 0x2::tx_context::TxContext) : Withdrawal {
        assert!(!arg0.paused, 1);
        Withdrawal{
            vault_id   : 0x2::object::uid_to_inner(&arg0.id),
            owner      : 0x2::tx_context::sender(arg1),
            lp_balance : get_liquidity_provider_balance(arg0, 0x2::tx_context::sender(arg1)),
            coins      : *0x2::vec_set::keys<0x1::ascii::String>(&arg0.swap_coins),
        }
    }

    public fun is_paused(arg0: &Vault) : bool {
        arg0.paused
    }

    fun mint_lp(arg0: &mut Vault, arg1: address, arg2: u64) {
        arg0.lp_supply = arg0.lp_supply + arg2;
        if (0x2::table::contains<address, u64>(&arg0.lp_balance, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.lp_balance, arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.lp_balance, arg1, arg2);
        };
    }

    public fun new_vault(arg0: &mut 0x2::tx_context::TxContext) : ManagerCap {
        let v0 = Vault{
            id              : 0x2::object::new(arg0),
            lp_supply       : 0,
            balance_storage : 0x2::bag::new(arg0),
            lp_balance      : 0x2::table::new<address, u64>(arg0),
            required_votes  : 0,
            paused          : false,
            deposit_coins   : 0x2::vec_set::empty<0x1::ascii::String>(),
            swap_coins      : 0x2::vec_set::empty<0x1::ascii::String>(),
        };
        let v1 = ManagerCap{
            id       : 0x2::object::new(arg0),
            vault_id : 0x2::object::id<Vault>(&v0),
        };
        0x2::transfer::share_object<Vault>(v0);
        v1
    }

    fun process_add_deposit_coin<T0>(arg0: &mut Vault) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        0x2::vec_set::insert<0x1::ascii::String>(&mut arg0.deposit_coins, v0);
        if (!has_balance(arg0, v0)) {
            process_add_swap_coin<T0>(arg0, v0);
        };
    }

    fun process_add_swap_coin<T0>(arg0: &mut Vault, arg1: 0x1::ascii::String) {
        0x2::vec_set::insert<0x1::ascii::String>(&mut arg0.swap_coins, arg1);
        init_balance<T0>(arg0, arg1);
    }

    fun process_remove_deposit_coin(arg0: &mut Vault, arg1: &0x1::ascii::String) {
        0x2::vec_set::remove<0x1::ascii::String>(&mut arg0.deposit_coins, arg1);
    }

    fun process_remove_swap_coin<T0>(arg0: &mut Vault, arg1: 0x1::ascii::String) : 0x2::balance::Balance<T0> {
        0x2::vec_set::remove<0x1::ascii::String>(&mut arg0.swap_coins, &arg1);
        process_remove_deposit_coin(arg0, &arg1);
        remove_balance<T0>(arg0, arg1)
    }

    fun remove_balance<T0>(arg0: &mut Vault, arg1: 0x1::ascii::String) : 0x2::balance::Balance<T0> {
        0x2::bag::remove<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.balance_storage, arg1)
    }

    public fun remove_deposit_coin<T0>(arg0: &mut Vault, arg1: &ManagerCap) {
        assert!(arg1.vault_id == 0x2::object::id<Vault>(arg0), 5);
        let v0 = 0x1::type_name::get<T0>();
        process_remove_deposit_coin(arg0, 0x1::type_name::borrow_string(&v0));
    }

    public fun remove_swap_coin<T0>(arg0: &mut Vault, arg1: &ManagerCap) : 0x2::balance::Balance<T0> {
        assert!(arg1.vault_id == 0x2::object::id<Vault>(arg0), 5);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        process_remove_deposit_coin(arg0, &v0);
        process_remove_swap_coin<T0>(arg0, v0)
    }

    public fun return_flashloan_from_swap<T0>(arg0: &mut Vault, arg1: &0x3ba83cbc3e8ccdf3191cdc7cf5d113b30793a3b0cf61c8392ea404f706bb016b::coin_registry::CoinRegistry, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: FlashLoanForSwap, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let FlashLoanForSwap {
            vault_id              : v0,
            borrow_usd_value      : v1,
            borrow_coin_type_name : _,
        } = arg4;
        assert!(0x2::object::uid_to_inner(&arg0.id) == v0, 17);
        let v3 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v4 = 0x2::coin::value<T0>(&arg5) * 0x3ba83cbc3e8ccdf3191cdc7cf5d113b30793a3b0cf61c8392ea404f706bb016b::price::usd_price(0x3ba83cbc3e8ccdf3191cdc7cf5d113b30793a3b0cf61c8392ea404f706bb016b::coin_registry::get_price_feed_id(arg1, &v3), arg3, arg6) / 0x2::math::pow(10, 0x2::coin::get_decimals<T0>(arg2));
        assert!(v4 >= v1 * 99 / 100, 2);
        append_balance<T0>(arg0, 0x2::coin::into_balance<T0>(arg5));
        let v5 = Returned{
            vault          : 0x2::object::id<Vault>(arg0),
            returner       : 0x2::tx_context::sender(arg7),
            coin_type_name : v3,
            usd_value      : v4,
        };
        0x2::event::emit<Returned>(v5);
    }

    fun take_balance<T0>(arg0: &mut Vault, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.balance_storage, 0x1::type_name::into_string(0x1::type_name::get<T0>())), arg1)
    }

    public fun toggle_pause(arg0: &mut Vault, arg1: &PauserCap) {
        arg0.paused = !arg0.paused;
    }

    fun total_shares(arg0: &Vault) : u64 {
        arg0.lp_supply
    }

    fun usd_to_shares(arg0: &Vault, arg1: TotalValueLocked, arg2: u64) : u64 {
        (((arg2 as u128) * ((total_shares(arg0) + 1) as u128) / ((arg1.pos0 + 1) as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

