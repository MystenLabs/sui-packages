module 0xe1376b7c41bbad0085da8fba6778a5d5dadd98fae88570dc21d5bcc63536d8bc::dao_vault {
    struct ManagerCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct Guardian has store, key {
        id: 0x2::object::UID,
    }

    struct TotalValueLocked has drop {
        pos0: u64,
    }

    struct TotalValueLockedCalculation {
        remaining_coins: vector<0x1::ascii::String>,
        value: u64,
    }

    struct LPPosition has store, key {
        id: 0x2::object::UID,
        owner: address,
        amount: u64,
        entry_price: u64,
        vault_id: 0x2::object::ID,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        lp_supply: u64,
        balance_storage: 0x2::bag::Bag,
        positions: 0x2::table::Table<0x2::object::ID, LPPosition>,
        positions_by_owner: 0x2::table::Table<address, vector<0x2::object::ID>>,
        paused: bool,
        deposit_coins: 0x2::vec_set::VecSet<0x1::ascii::String>,
        swap_coins: 0x2::vec_set::VecSet<0x1::ascii::String>,
        performance_fee_bps: u64,
        emergency_fee_pause: bool,
        manager_commission_balance: u64,
    }

    struct Created has copy, drop {
        vault: 0x2::object::ID,
        manager: address,
    }

    struct Withdrawal has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        lp_value: u64,
        coins: vector<0x1::ascii::String>,
        unlock_time: u64,
    }

    struct PositionCreated has copy, drop {
        vault: 0x2::object::ID,
        position: 0x2::object::ID,
        owner: address,
        amount: u64,
        entry_price: u64,
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

    struct PerformanceFeeCollected has copy, drop {
        vault: 0x2::object::ID,
        amount: u64,
        current_price: u64,
        entry_price: u64,
    }

    struct ProtocolFeeCollected has copy, drop {
        vault: 0x2::object::ID,
        amount: u64,
        coin_type: 0x1::ascii::String,
    }

    struct ProtocolFeesWithdrawn has copy, drop {
        vault: 0x2::object::ID,
        amount: u64,
        coin_type: 0x1::ascii::String,
    }

    struct FeeCollectionPaused has copy, drop {
        vault: 0x2::object::ID,
        paused_by: address,
    }

    struct FeeCollectionResumed has copy, drop {
        vault: 0x2::object::ID,
        resumed_by: address,
    }

    struct ManagerCommissionClaimed has copy, drop {
        vault: 0x2::object::ID,
        amount: u64,
        manager: address,
    }

    struct FlashLoanForSwap {
        vault_id: 0x2::object::ID,
        borrow_usd_value: u64,
        borrow_coin_type_name: 0x1::ascii::String,
    }

    fun balance<T0>(arg0: &Vault) : &0x2::balance::Balance<T0> {
        0x2::bag::borrow<0x1::ascii::String, 0x2::balance::Balance<T0>>(&arg0.balance_storage, 0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    public fun add_deposit_coin<T0>(arg0: &mut Vault, arg1: &ManagerCap, arg2: &0xe1376b7c41bbad0085da8fba6778a5d5dadd98fae88570dc21d5bcc63536d8bc::protocol_config::ProtocolConfig) {
        assert!(arg1.vault_id == 0x2::object::id<Vault>(arg0), 5);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0xe1376b7c41bbad0085da8fba6778a5d5dadd98fae88570dc21d5bcc63536d8bc::protocol_config::is_token_allowed(arg2, &v0), 22);
        process_add_deposit_coin<T0>(arg0);
    }

    public fun add_swap_coin<T0>(arg0: &mut Vault, arg1: &ManagerCap, arg2: &0xe1376b7c41bbad0085da8fba6778a5d5dadd98fae88570dc21d5bcc63536d8bc::protocol_config::ProtocolConfig) {
        assert!(arg1.vault_id == 0x2::object::id<Vault>(arg0), 5);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0xe1376b7c41bbad0085da8fba6778a5d5dadd98fae88570dc21d5bcc63536d8bc::protocol_config::is_token_allowed(arg2, &v0), 22);
        process_add_swap_coin<T0>(arg0, v0);
    }

    fun append_balance<T0>(arg0: &mut Vault, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.balance_storage, 0x1::type_name::into_string(0x1::type_name::get<T0>())), arg1);
    }

    fun burn_lp(arg0: &mut Vault, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, LPPosition>(&mut arg0.positions, arg1);
        assert!(v0.amount >= arg2, 3);
        assert!(v0.owner == 0x2::tx_context::sender(arg3), 34);
        arg0.lp_supply = arg0.lp_supply - arg2;
        v0.amount = v0.amount - arg2;
        if (v0.amount == 0) {
            let LPPosition {
                id          : v1,
                owner       : v2,
                amount      : _,
                entry_price : _,
                vault_id    : _,
            } = 0x2::table::remove<0x2::object::ID, LPPosition>(&mut arg0.positions, arg1);
            let v6 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.positions_by_owner, v2);
            let v7 = 0;
            while (v7 < 0x1::vector::length<0x2::object::ID>(v6)) {
                if (0x1::vector::borrow<0x2::object::ID>(v6, v7) == &arg1) {
                    0x1::vector::swap_remove<0x2::object::ID>(v6, v7);
                    break
                };
                v7 = v7 + 1;
            };
            0x2::object::delete(v1);
        };
    }

    fun calculate_and_collect_performance_fee(arg0: &mut Vault, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = calculate_performance_fee(arg0, arg1, arg2, arg3);
        if (v0 > 0) {
            arg0.manager_commission_balance = arg0.manager_commission_balance + v0;
            let v1 = PerformanceFeeCollected{
                vault         : 0x2::object::id<Vault>(arg0),
                amount        : v0,
                current_price : arg1,
                entry_price   : arg2,
            };
            0x2::event::emit<PerformanceFeeCollected>(v1);
        };
        v0
    }

    fun calculate_lp_token_price(arg0: &Vault, arg1: &TotalValueLocked) : u64 {
        let v0 = arg1.pos0;
        if (v0 == 0) {
            return 0
        };
        let v1 = total_shares(arg0);
        if (v1 == 0) {
            return 0
        };
        (((v0 as u128) / (v1 as u128)) as u64)
    }

    fun calculate_performance_fee(arg0: &Vault, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg1 <= arg2) {
            return 0
        };
        ((((arg1 as u128) - (arg2 as u128)) * (arg3 as u128) * (arg0.performance_fee_bps as u128) * 10000000000000000000000 / (arg1 as u128) * 10000 * 10000000000000000000000) as u64)
    }

    fun calculate_protocol_fee(arg0: &0xe1376b7c41bbad0085da8fba6778a5d5dadd98fae88570dc21d5bcc63536d8bc::protocol_config::ProtocolConfig, arg1: u64) : u64 {
        arg1 * 0xe1376b7c41bbad0085da8fba6778a5d5dadd98fae88570dc21d5bcc63536d8bc::protocol_config::get_protocol_fee(arg0) / 10000
    }

    public fun calculate_total_value_locked_in_usd<T0>(arg0: &Vault, arg1: &0xe1376b7c41bbad0085da8fba6778a5d5dadd98fae88570dc21d5bcc63536d8bc::protocol_config::ProtocolConfig, arg2: &mut TotalValueLockedCalculation, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock) {
        let v0 = 0x1::vector::pop_back<0x1::ascii::String>(&mut arg2.remaining_coins);
        arg2.value = arg2.value + 0x2::balance::value<T0>(0x2::bag::borrow<0x1::ascii::String, 0x2::balance::Balance<T0>>(&arg0.balance_storage, v0)) * 0xe1376b7c41bbad0085da8fba6778a5d5dadd98fae88570dc21d5bcc63536d8bc::price::usd_price(0xe1376b7c41bbad0085da8fba6778a5d5dadd98fae88570dc21d5bcc63536d8bc::protocol_config::get_price_feed_id(arg1, &v0), arg4, arg5) / 0x1::u64::pow(10, 0x2::coin::get_decimals<T0>(arg3));
    }

    public fun claim_manager_commission<T0>(arg0: &mut Vault, arg1: &ManagerCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.vault_id == 0x2::object::id<Vault>(arg0), 5);
        assert!(arg0.manager_commission_balance > 0, 3);
        let v0 = arg0.manager_commission_balance;
        arg0.manager_commission_balance = 0;
        let v1 = take_balance<T0>(arg0, v0);
        let v2 = ManagerCommissionClaimed{
            vault   : 0x2::object::id<Vault>(arg0),
            amount  : v0,
            manager : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ManagerCommissionClaimed>(v2);
        0x2::coin::from_balance<T0>(v1, arg2)
    }

    public fun deposit_coin<T0>(arg0: &mut Vault, arg1: &0xe1376b7c41bbad0085da8fba6778a5d5dadd98fae88570dc21d5bcc63536d8bc::protocol_config::ProtocolConfig, arg2: TotalValueLocked, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        let v0 = 0x2::coin::value<T0>(&arg6);
        assert!(v0 > 0, 2);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0xe1376b7c41bbad0085da8fba6778a5d5dadd98fae88570dc21d5bcc63536d8bc::protocol_config::is_token_allowed(arg1, &v1), 22);
        let v2 = calculate_lp_token_price(arg0, &arg2);
        let v3 = usd_to_shares(arg0, arg2, v0 * 0xe1376b7c41bbad0085da8fba6778a5d5dadd98fae88570dc21d5bcc63536d8bc::price::usd_price(0xe1376b7c41bbad0085da8fba6778a5d5dadd98fae88570dc21d5bcc63536d8bc::protocol_config::get_price_feed_id(arg1, &v1), arg4, arg5) / 0x1::u64::pow(10, 0x2::coin::get_decimals<T0>(arg3)));
        assert!(v3 > 0, 2);
        if (!arg0.emergency_fee_pause) {
            let v4 = calculate_protocol_fee(arg1, v0);
            if (v4 > 0) {
                append_balance<T0>(arg0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg6, v4, arg7)));
                let v5 = ProtocolFeeCollected{
                    vault     : 0x2::object::id<Vault>(arg0),
                    amount    : v4,
                    coin_type : v1,
                };
                0x2::event::emit<ProtocolFeeCollected>(v5);
            };
        };
        if (!0x2::vec_set::contains<0x1::ascii::String>(&arg0.swap_coins, &v1)) {
            0x2::vec_set::insert<0x1::ascii::String>(&mut arg0.swap_coins, v1);
        };
        append_balance<T0>(arg0, 0x2::coin::into_balance<T0>(arg6));
        let v6 = LPPosition{
            id          : 0x2::object::new(arg7),
            owner       : 0x2::tx_context::sender(arg7),
            amount      : v3,
            entry_price : v2,
            vault_id    : 0x2::object::id<Vault>(arg0),
        };
        let v7 = 0x2::object::id<LPPosition>(&v6);
        0x2::table::add<0x2::object::ID, LPPosition>(&mut arg0.positions, v7, v6);
        arg0.lp_supply = arg0.lp_supply + v3;
        let v8 = if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.positions_by_owner, 0x2::tx_context::sender(arg7))) {
            0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.positions_by_owner, 0x2::tx_context::sender(arg7))
        } else {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.positions_by_owner, 0x2::tx_context::sender(arg7), 0x1::vector::empty<0x2::object::ID>());
            0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.positions_by_owner, 0x2::tx_context::sender(arg7))
        };
        0x1::vector::push_back<0x2::object::ID>(v8, v7);
        let v9 = PositionCreated{
            vault            : 0x2::object::id<Vault>(arg0),
            position         : v7,
            owner            : 0x2::tx_context::sender(arg7),
            amount           : v0,
            entry_price      : v2,
            lp_tokens_minted : v3,
        };
        0x2::event::emit<PositionCreated>(v9);
    }

    public fun emergency_stop_fee_collection(arg0: &mut Vault, arg1: &Guardian, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.emergency_fee_pause = true;
        let v0 = FeeCollectionPaused{
            vault     : 0x2::object::id<Vault>(arg0),
            paused_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<FeeCollectionPaused>(v0);
    }

    public fun execute_withdrawal<T0>(arg0: &mut Vault, arg1: &mut Withdrawal, arg2: &0xe1376b7c41bbad0085da8fba6778a5d5dadd98fae88570dc21d5bcc63536d8bc::protocol_config::ProtocolConfig, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.vault_id, 17);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.coins) > 0, 2);
        assert!(0x2::clock::timestamp_ms(arg4) >= arg1.unlock_time, 23);
        assert!(0x1::vector::pop_back<0x1::ascii::String>(&mut arg1.coins) == 0x1::type_name::into_string(0x1::type_name::get<T0>()), 2);
        let v0 = arg1.lp_value;
        let v1 = get_position(arg0, arg1.position_id).entry_price;
        let v2 = total_shares(arg0);
        let v3 = if (v2 == 0) {
            v1
        } else {
            (((0x2::balance::value<T0>(balance<T0>(arg0)) as u128) / (v2 as u128)) as u64)
        };
        let v4 = calculate_and_collect_performance_fee(arg0, v3, v1, v0, arg5);
        let v5 = total_shares(arg0);
        let v6 = if (v5 == 0) {
            0
        } else {
            (((0x2::balance::value<T0>(balance<T0>(arg0)) as u128) * (v0 as u128) / (v5 as u128)) as u64)
        };
        let v7 = if (v6 > v4) {
            v6 - v4
        } else {
            0
        };
        0x2::coin::from_balance<T0>(take_balance<T0>(arg0, v7), arg5)
    }

    public fun finalize_tvl_calculation(arg0: TotalValueLockedCalculation) : TotalValueLocked {
        let TotalValueLockedCalculation {
            remaining_coins : v0,
            value           : v1,
        } = arg0;
        0x1::vector::destroy_empty<0x1::ascii::String>(v0);
        TotalValueLocked{pos0: v1}
    }

    public fun finalize_withdrawal(arg0: &mut Vault, arg1: Withdrawal, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let Withdrawal {
            id          : v0,
            vault_id    : v1,
            position_id : v2,
            lp_value    : v3,
            coins       : v4,
            unlock_time : _,
        } = arg1;
        assert!(0x2::object::uid_to_inner(&arg0.id) == v1, 17);
        let v6 = Withdrawn{
            vault      : 0x2::object::id<Vault>(arg0),
            withdrawer : 0x2::tx_context::sender(arg4),
            amount     : v3,
        };
        0x2::event::emit<Withdrawn>(v6);
        burn_lp(arg0, v2, v3, arg4);
        0x1::vector::destroy_empty<0x1::ascii::String>(v4);
        0x2::object::delete(v0);
    }

    public fun flashloan_for_swap<T0>(arg0: &mut Vault, arg1: &0xe1376b7c41bbad0085da8fba6778a5d5dadd98fae88570dc21d5bcc63536d8bc::protocol_config::ProtocolConfig, arg2: &ManagerCap, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoanForSwap) {
        assert!(arg5 > 0, 2);
        assert!(arg2.vault_id == 0x2::object::id<Vault>(arg0), 5);
        assert!(!arg0.paused, 1);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = arg5 * 0xe1376b7c41bbad0085da8fba6778a5d5dadd98fae88570dc21d5bcc63536d8bc::price::usd_price(0xe1376b7c41bbad0085da8fba6778a5d5dadd98fae88570dc21d5bcc63536d8bc::protocol_config::get_price_feed_id(arg1, &v0), arg4, arg6) / 0x1::u64::pow(10, 0x2::coin::get_decimals<T0>(arg3));
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

    public fun get_liquidity_provider_balance(arg0: &Vault, arg1: 0x2::object::ID) : (u64, u64) {
        let v0 = 0x2::table::borrow<0x2::object::ID, LPPosition>(&arg0.positions, arg1);
        (v0.amount, v0.entry_price)
    }

    public fun get_manager_commission_balance(arg0: &Vault) : u64 {
        arg0.manager_commission_balance
    }

    fun get_position(arg0: &Vault, arg1: 0x2::object::ID) : &LPPosition {
        let v0 = 0x2::table::borrow<0x2::object::ID, LPPosition>(&arg0.positions, arg1);
        assert!(v0.vault_id == 0x2::object::id<Vault>(arg0), 17);
        v0
    }

    public fun get_position_info(arg0: &Vault, arg1: 0x2::object::ID) : (u64, u64) {
        let v0 = 0x2::table::borrow<0x2::object::ID, LPPosition>(&arg0.positions, arg1);
        (v0.amount, v0.entry_price)
    }

    public fun get_positions_by_owner(arg0: &Vault, arg1: address) : &vector<0x2::object::ID> {
        0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.positions_by_owner, arg1)
    }

    public fun get_total_shares(arg0: &Vault) : u64 {
        total_shares(arg0)
    }

    fun has_balance(arg0: &Vault, arg1: 0x1::ascii::String) : bool {
        0x2::bag::contains<0x1::ascii::String>(&arg0.balance_storage, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Guardian{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Guardian>(v0, 0x2::tx_context::sender(arg0));
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

    public fun initiate_withdrawal(arg0: &mut Vault, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : Withdrawal {
        assert!(!arg0.paused, 1);
        let v0 = get_position(arg0, arg1);
        assert!(v0.owner == 0x2::tx_context::sender(arg3), 34);
        Withdrawal{
            id          : 0x2::object::new(arg3),
            vault_id    : 0x2::object::uid_to_inner(&arg0.id),
            position_id : arg1,
            lp_value    : v0.amount,
            coins       : 0x1::vector::empty<0x1::ascii::String>(),
            unlock_time : 0x2::clock::timestamp_ms(arg2) + 7200000,
        }
    }

    public fun is_fee_collection_paused(arg0: &Vault) : bool {
        arg0.emergency_fee_pause
    }

    public fun is_paused(arg0: &Vault) : bool {
        arg0.paused
    }

    public fun new_tvl(arg0: u64) : TotalValueLocked {
        TotalValueLocked{pos0: arg0}
    }

    public fun new_vault(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : ManagerCap {
        assert!(arg0 <= 6000, 32);
        let v0 = Vault{
            id                         : 0x2::object::new(arg1),
            lp_supply                  : 0,
            balance_storage            : 0x2::bag::new(arg1),
            positions                  : 0x2::table::new<0x2::object::ID, LPPosition>(arg1),
            positions_by_owner         : 0x2::table::new<address, vector<0x2::object::ID>>(arg1),
            paused                     : false,
            deposit_coins              : 0x2::vec_set::empty<0x1::ascii::String>(),
            swap_coins                 : 0x2::vec_set::empty<0x1::ascii::String>(),
            performance_fee_bps        : arg0,
            emergency_fee_pause        : false,
            manager_commission_balance : 0,
        };
        let v1 = ManagerCap{
            id       : 0x2::object::new(arg1),
            vault_id : 0x2::object::id<Vault>(&v0),
        };
        let v2 = Created{
            vault   : 0x2::object::id<Vault>(&v0),
            manager : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<Created>(v2);
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
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        process_remove_deposit_coin(arg0, &v0);
    }

    public fun remove_swap_coin<T0>(arg0: &mut Vault, arg1: &ManagerCap) : 0x2::balance::Balance<T0> {
        assert!(arg1.vault_id == 0x2::object::id<Vault>(arg0), 5);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        process_remove_deposit_coin(arg0, &v0);
        process_remove_swap_coin<T0>(arg0, v0)
    }

    public fun resume_fee_collection(arg0: &mut Vault, arg1: &Guardian, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.emergency_fee_pause = false;
        let v0 = FeeCollectionResumed{
            vault      : 0x2::object::id<Vault>(arg0),
            resumed_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<FeeCollectionResumed>(v0);
    }

    public fun return_flashloan_from_swap<T0>(arg0: &mut Vault, arg1: &0xe1376b7c41bbad0085da8fba6778a5d5dadd98fae88570dc21d5bcc63536d8bc::protocol_config::ProtocolConfig, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: FlashLoanForSwap, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let FlashLoanForSwap {
            vault_id              : v0,
            borrow_usd_value      : v1,
            borrow_coin_type_name : _,
        } = arg4;
        assert!(0x2::object::uid_to_inner(&arg0.id) == v0, 17);
        let v3 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v4 = 0x2::coin::value<T0>(&arg5) * 0xe1376b7c41bbad0085da8fba6778a5d5dadd98fae88570dc21d5bcc63536d8bc::price::usd_price(0xe1376b7c41bbad0085da8fba6778a5d5dadd98fae88570dc21d5bcc63536d8bc::protocol_config::get_price_feed_id(arg1, &v3), arg3, arg6) / 0x1::u64::pow(10, 0x2::coin::get_decimals<T0>(arg2));
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

    public fun toggle_pause(arg0: &mut Vault, arg1: &Guardian) {
        arg0.paused = !arg0.paused;
    }

    fun total_shares(arg0: &Vault) : u64 {
        arg0.lp_supply + arg0.manager_commission_balance
    }

    fun usd_to_shares(arg0: &Vault, arg1: TotalValueLocked, arg2: u64) : u64 {
        let v0 = arg1.pos0;
        if (v0 == 0) {
            return arg2
        };
        let v1 = total_shares(arg0);
        if (v1 == 0) {
            return arg2
        };
        (((arg2 as u128) * (v1 as u128) / (v0 as u128)) as u64)
    }

    public fun withdraw_protocol_fees<T0>(arg0: &mut Vault, arg1: &0xe1376b7c41bbad0085da8fba6778a5d5dadd98fae88570dc21d5bcc63536d8bc::protocol_config::ProtocolConfig, arg2: &Guardian, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.emergency_fee_pause, 1);
        let v0 = calculate_protocol_fee(arg1, arg3);
        assert!(v0 > 0, 2);
        let v1 = take_balance<T0>(arg0, v0);
        let v2 = ProtocolFeesWithdrawn{
            vault     : 0x2::object::id<Vault>(arg0),
            amount    : v0,
            coin_type : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
        };
        0x2::event::emit<ProtocolFeesWithdrawn>(v2);
        0x2::coin::from_balance<T0>(v1, arg4)
    }

    // decompiled from Move bytecode v6
}

