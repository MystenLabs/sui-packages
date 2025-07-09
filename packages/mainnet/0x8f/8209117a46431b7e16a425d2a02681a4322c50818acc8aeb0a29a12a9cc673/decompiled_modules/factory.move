module 0x8f8209117a46431b7e16a425d2a02681a4322c50818acc8aeb0a29a12a9cc673::factory {
    struct FactoryRegistry has key {
        id: 0x2::object::UID,
        factories: 0x2::table::Table<0x2::object::ID, FactoryInfo>,
    }

    struct FactoryInfo has store {
        factory_id: 0x2::object::ID,
        factory_cap_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
    }

    struct RedemptionQueue has key {
        id: 0x2::object::UID,
        redemptions: 0x2::table::Table<address, vector<RedemptionTicket>>,
        locked_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        redemption_delay: u64,
        min_redemption: u64,
    }

    struct RedemptionTicket has drop, store {
        id: 0x2::object::ID,
        user: address,
        sui_amount: u64,
        repusd_burned: u64,
        created_epoch: u64,
        redeemable_epoch: u64,
    }

    struct Factory<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        total_supply: u64,
        supply_limit: u64,
        exchange_rate: u64,
        admin: address,
        is_active: bool,
        unstaking_fee_bps: u64,
        accumulated_fees: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct FactoryCap has store, key {
        id: 0x2::object::UID,
        factory_id: 0x2::object::ID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        protocol_fee_bps: u64,
        min_mint_amount: u64,
        max_mint_amount: u64,
    }

    struct FactoryCreated has copy, drop {
        factory_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        creator: address,
    }

    struct Minted has copy, drop {
        user: address,
        sui_amount: u64,
        repusd_amount: u64,
        exchange_rate: u64,
    }

    struct Burned has copy, drop {
        user: address,
        repusd_amount: u64,
        sui_amount: u64,
        fee_amount: u64,
        exchange_rate: u64,
    }

    struct RedemptionQueued has copy, drop {
        user: address,
        ticket_id: 0x2::object::ID,
        repusd_amount: u64,
        sui_amount: u64,
        redeemable_epoch: u64,
    }

    struct RedemptionClaimed has copy, drop {
        user: address,
        ticket_id: 0x2::object::ID,
        sui_amount: u64,
    }

    public fun mint<T0>(arg0: &mut Factory<T0>, arg1: &Config, arg2: &FactoryRegistry, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.is_active, 4);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        assert!(v0 >= arg1.min_mint_amount, 1);
        assert!(v0 <= arg1.max_mint_amount, 1);
        let v1 = calculate_mint_amount(v0, arg0.exchange_rate);
        assert!(arg0.total_supply + v1 <= arg0.supply_limit, 6);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.accumulated_fees, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v0 * arg1.protocol_fee_bps / 10000, arg5)));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg4));
        arg0.total_supply = arg0.total_supply + v1;
        let v2 = Minted{
            user          : 0x2::tx_context::sender(arg5),
            sui_amount    : v0,
            repusd_amount : v1,
            exchange_rate : arg0.exchange_rate,
        };
        0x2::event::emit<Minted>(v2);
        0x2::coin::mint<T0>(&mut arg0.treasury_cap, v1, arg5)
    }

    public fun new<T0>(arg0: &mut FactoryRegistry, arg1: &Config, arg2: 0x2::coin::TreasuryCap<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (Factory<T0>, FactoryCap) {
        let v0 = 0x2::object::new(arg4);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = Factory<T0>{
            id                : v0,
            treasury_cap      : arg2,
            sui_reserve       : 0x2::balance::zero<0x2::sui::SUI>(),
            total_supply      : 0,
            supply_limit      : arg3,
            exchange_rate     : 1000000000,
            admin             : 0x2::tx_context::sender(arg4),
            is_active         : true,
            unstaking_fee_bps : 200,
            accumulated_fees  : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v3 = FactoryCap{
            id         : 0x2::object::new(arg4),
            factory_id : v1,
        };
        let v4 = FactoryInfo{
            factory_id     : v1,
            factory_cap_id : 0x2::object::uid_to_inner(&v3.id),
            coin_type      : 0x1::string::utf8(b"REP_USD"),
        };
        0x2::table::add<0x2::object::ID, FactoryInfo>(&mut arg0.factories, v1, v4);
        let v5 = FactoryCreated{
            factory_id : v1,
            coin_type  : 0x1::string::utf8(b"REP_USD"),
            creator    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<FactoryCreated>(v5);
        (v2, v3)
    }

    public fun accumulated_fees<T0>(arg0: &Factory<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.accumulated_fees)
    }

    public fun burn_and_redeem<T0>(arg0: &mut Factory<T0>, arg1: &Config, arg2: &mut RedemptionQueue, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 4);
        let v0 = 0x2::coin::value<T0>(&arg4);
        assert!(v0 > 0, 1);
        assert!(arg5 >= arg2.min_redemption, 1);
        assert!(arg5 <= v0, 1);
        let arg4 = if (arg5 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg4, v0 - arg5, arg7), 0x2::tx_context::sender(arg7));
            arg4
        } else {
            arg4
        };
        let v1 = calculate_burn_amount(arg5, arg0.exchange_rate);
        let v2 = v1 * arg0.unstaking_fee_bps / 10000;
        let v3 = v1 - v2;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) >= v1, 2);
        0x2::coin::burn<T0>(&mut arg0.treasury_cap, arg4);
        arg0.total_supply = arg0.total_supply - arg5;
        let v4 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.accumulated_fees, 0x2::balance::split<0x2::sui::SUI>(&mut v4, v2));
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.locked_sui, v4);
        let v5 = 0x2::tx_context::epoch(arg7);
        let v6 = 0x2::object::new(arg7);
        let v7 = 0x2::object::uid_to_inner(&v6);
        0x2::object::delete(v6);
        let v8 = RedemptionTicket{
            id               : v7,
            user             : arg6,
            sui_amount       : v3,
            repusd_burned    : arg5,
            created_epoch    : v5,
            redeemable_epoch : v5 + arg2.redemption_delay,
        };
        if (!0x2::table::contains<address, vector<RedemptionTicket>>(&arg2.redemptions, arg6)) {
            0x2::table::add<address, vector<RedemptionTicket>>(&mut arg2.redemptions, arg6, 0x1::vector::empty<RedemptionTicket>());
        };
        0x1::vector::push_back<RedemptionTicket>(0x2::table::borrow_mut<address, vector<RedemptionTicket>>(&mut arg2.redemptions, arg6), v8);
        let v9 = RedemptionQueued{
            user             : arg6,
            ticket_id        : v7,
            repusd_amount    : arg5,
            sui_amount       : v3,
            redeemable_epoch : v5 + arg2.redemption_delay,
        };
        0x2::event::emit<RedemptionQueued>(v9);
    }

    entry fun burn_and_redeem_<T0>(arg0: &mut Factory<T0>, arg1: &Config, arg2: &mut RedemptionQueue, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        burn_and_redeem<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun calculate_burn_amount(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (1000000000 as u128)) as u64)
    }

    fun calculate_mint_amount(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (1000000000 as u128) / (arg1 as u128)) as u64)
    }

    public fun claim_redemption(arg0: &mut RedemptionQueue, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, vector<RedemptionTicket>>(&arg0.redemptions, v0), 1);
        let v1 = 0x2::table::borrow_mut<address, vector<RedemptionTicket>>(&mut arg0.redemptions, v0);
        assert!(arg1 < 0x1::vector::length<RedemptionTicket>(v1), 8);
        assert!(0x2::tx_context::epoch(arg2) >= 0x1::vector::borrow<RedemptionTicket>(v1, arg1).redeemable_epoch, 7);
        let v2 = 0x1::vector::remove<RedemptionTicket>(v1, arg1);
        let v3 = v2.sui_amount;
        let v4 = RedemptionClaimed{
            user       : v0,
            ticket_id  : v2.id,
            sui_amount : v3,
        };
        0x2::event::emit<RedemptionClaimed>(v4);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.locked_sui, v3), arg2)
    }

    entry fun claim_redemption_(arg0: &mut RedemptionQueue, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = claim_redemption(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun exchange_rate<T0>(arg0: &Factory<T0>) : u64 {
        arg0.exchange_rate
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FactoryRegistry{
            id        : 0x2::object::new(arg0),
            factories : 0x2::table::new<0x2::object::ID, FactoryInfo>(arg0),
        };
        0x2::transfer::share_object<FactoryRegistry>(v0);
        let v1 = Config{
            id               : 0x2::object::new(arg0),
            protocol_fee_bps : 50,
            min_mint_amount  : 1000000000,
            max_mint_amount  : 1000000000000000,
        };
        0x2::transfer::share_object<Config>(v1);
        let v2 = RedemptionQueue{
            id               : 0x2::object::new(arg0),
            redemptions      : 0x2::table::new<address, vector<RedemptionTicket>>(arg0),
            locked_sui       : 0x2::balance::zero<0x2::sui::SUI>(),
            redemption_delay : 720,
            min_redemption   : 100000000,
        };
        0x2::transfer::share_object<RedemptionQueue>(v2);
    }

    public fun is_active<T0>(arg0: &Factory<T0>) : bool {
        arg0.is_active
    }

    public fun locked_sui(arg0: &RedemptionQueue) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.locked_sui)
    }

    entry fun mint_<T0>(arg0: &mut Factory<T0>, arg1: &Config, arg2: &FactoryRegistry, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = mint<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun redemption_delay(arg0: &RedemptionQueue) : u64 {
        arg0.redemption_delay
    }

    public fun set_active<T0>(arg0: &FactoryCap, arg1: &mut Factory<T0>, arg2: bool) {
        arg1.is_active = arg2;
    }

    public fun set_supply_limit<T0>(arg0: &FactoryCap, arg1: &mut Factory<T0>, arg2: u64) {
        arg1.supply_limit = arg2;
    }

    public fun sui_reserve<T0>(arg0: &Factory<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve)
    }

    public fun supply_limit<T0>(arg0: &Factory<T0>) : u64 {
        arg0.supply_limit
    }

    public fun total_supply<T0>(arg0: &Factory<T0>) : u64 {
        arg0.total_supply
    }

    public fun update_exchange_rate<T0>(arg0: &FactoryCap, arg1: &mut Factory<T0>, arg2: u64) {
        arg1.exchange_rate = arg2;
    }

    public fun update_unstaking_fee<T0>(arg0: &FactoryCap, arg1: &mut Factory<T0>, arg2: u64) {
        arg1.unstaking_fee_bps = arg2;
    }

    public fun user_redemptions(arg0: &RedemptionQueue, arg1: address) : &vector<RedemptionTicket> {
        assert!(0x2::table::contains<address, vector<RedemptionTicket>>(&arg0.redemptions, arg1), 1);
        0x2::table::borrow<address, vector<RedemptionTicket>>(&arg0.redemptions, arg1)
    }

    public fun withdraw_fees<T0>(arg0: &FactoryCap, arg1: &mut Factory<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.accumulated_fees) >= arg2, 2);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.accumulated_fees, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

