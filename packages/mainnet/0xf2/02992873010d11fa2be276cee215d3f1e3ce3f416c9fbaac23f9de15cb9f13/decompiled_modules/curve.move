module 0x3f2a0baf78f98087a04431f848008bad050cb5f4427059fa08eeefaa94d56cca::curve {
    struct BondingCurve<phantom T0> has key {
        id: 0x2::object::UID,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        token_balance: 0x2::balance::Balance<T0>,
        virtual_sui_amt: u64,
        target_supply_threshold: u64,
        swap_fee: u64,
        is_active: bool,
        creator: address,
        twitter: 0x1::option::Option<0x1::ascii::String>,
        telegram: 0x1::option::Option<0x1::ascii::String>,
        website: 0x1::option::Option<0x1::ascii::String>,
        migration_target: u64,
    }

    struct Configurator has key {
        id: 0x2::object::UID,
        virtual_sui_amt: u64,
        target_supply_threshold: u64,
        migration_fee: u64,
        listing_fee: u64,
        swap_fee: u64,
        fee: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct BondingCurveListedEvent has copy, drop {
        object_id: 0x2::object::ID,
        token_type: 0x1::ascii::String,
        sui_balance_val: u64,
        token_balance_val: u64,
        virtual_sui_amt: u64,
        target_supply_threshold: u64,
        creator: address,
        ticker: 0x1::ascii::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::option::Option<0x2::url::Url>,
        coin_metadata_id: 0x2::object::ID,
        twitter: 0x1::option::Option<0x1::ascii::String>,
        telegram: 0x1::option::Option<0x1::ascii::String>,
        website: 0x1::option::Option<0x1::ascii::String>,
        migration_target: u64,
    }

    struct Points has copy, drop {
        amount: u64,
        sender: address,
    }

    struct SwapEvent has copy, drop {
        bc_id: 0x2::object::ID,
        token_type: 0x1::ascii::String,
        is_buy: bool,
        input_amount: u64,
        output_amount: u64,
        sui_reserve_val: u64,
        token_reserve_val: u64,
        sender: address,
    }

    struct MigrationPendingEvent has copy, drop {
        bc_id: 0x2::object::ID,
        token_type: 0x1::ascii::String,
        sui_reserve_val: u64,
        token_reserve_val: u64,
    }

    struct MigrationCompletedEvent has copy, drop {
        adapter_id: u64,
        bc_id: 0x2::object::ID,
        token_type: 0x1::ascii::String,
        target_pool_id: 0x2::object::ID,
        sui_balance_val: u64,
        token_balance_val: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun transfer<T0>(arg0: BondingCurve<T0>) {
        0x2::transfer::share_object<BondingCurve<T0>>(arg0);
    }

    public fun buy<T0>(arg0: &mut BondingCurve<T0>, arg1: &mut Configurator, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.is_active, 4);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        let v2 = &mut v1;
        take_fee(arg1, arg0.swap_fee, v2, v0);
        let (v3, v4) = get_reserves<T0>(arg0);
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&v1);
        let v6 = get_output_amount(v5, v3 + arg0.virtual_sui_amt, v4);
        assert!(v6 >= arg3, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, v1);
        let (v7, v8) = get_reserves<T0>(arg0);
        assert!(v7 > 0 && v8 > 0, 5);
        if (v8 <= arg0.target_supply_threshold) {
            arg0.is_active = false;
            emit_migration_pending_event(0x2::object::id<BondingCurve<T0>>(arg0), 0x1::type_name::into_string(0x1::type_name::get<T0>()), v7, v8);
        };
        emit_swap_event(0x2::object::id<BondingCurve<T0>>(arg0), 0x1::type_name::into_string(0x1::type_name::get<T0>()), true, v5, v6, v7, v8, v0);
        0x2::coin::take<T0>(&mut arg0.token_balance, v6, arg4)
    }

    public fun confirm_migration(arg0: &AdminCap, arg1: u64, arg2: 0x2::object::ID, arg3: 0x1::ascii::String, arg4: 0x2::object::ID, arg5: u64, arg6: u64) {
        emit_migration_completed_event(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    fun emit_bonding_curve_event<T0>(arg0: &BondingCurve<T0>, arg1: 0x1::ascii::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::option::Option<0x2::url::Url>, arg5: 0x2::object::ID) {
        let v0 = BondingCurveListedEvent{
            object_id               : 0x2::object::id<BondingCurve<T0>>(arg0),
            token_type              : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            sui_balance_val         : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance),
            token_balance_val       : 0x2::balance::value<T0>(&arg0.token_balance),
            virtual_sui_amt         : arg0.virtual_sui_amt,
            target_supply_threshold : arg0.target_supply_threshold,
            creator                 : arg0.creator,
            ticker                  : arg1,
            name                    : arg2,
            description             : arg3,
            url                     : arg4,
            coin_metadata_id        : arg5,
            twitter                 : arg0.twitter,
            telegram                : arg0.telegram,
            website                 : arg0.website,
            migration_target        : arg0.migration_target,
        };
        0x2::event::emit<BondingCurveListedEvent>(v0);
    }

    fun emit_migration_completed_event(arg0: u64, arg1: 0x2::object::ID, arg2: 0x1::ascii::String, arg3: 0x2::object::ID, arg4: u64, arg5: u64) {
        let v0 = MigrationCompletedEvent{
            adapter_id        : arg0,
            bc_id             : arg1,
            token_type        : arg2,
            target_pool_id    : arg3,
            sui_balance_val   : arg4,
            token_balance_val : arg5,
        };
        0x2::event::emit<MigrationCompletedEvent>(v0);
    }

    fun emit_migration_pending_event(arg0: 0x2::object::ID, arg1: 0x1::ascii::String, arg2: u64, arg3: u64) {
        let v0 = MigrationPendingEvent{
            bc_id             : arg0,
            token_type        : arg1,
            sui_reserve_val   : arg2,
            token_reserve_val : arg3,
        };
        0x2::event::emit<MigrationPendingEvent>(v0);
    }

    fun emit_swap_event(arg0: 0x2::object::ID, arg1: 0x1::ascii::String, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: address) {
        let v0 = SwapEvent{
            bc_id             : arg0,
            token_type        : arg1,
            is_buy            : arg2,
            input_amount      : arg3,
            output_amount     : arg4,
            sui_reserve_val   : arg5,
            token_reserve_val : arg6,
            sender            : arg7,
        };
        0x2::event::emit<SwapEvent>(v0);
    }

    fun get_coin_metadata_info<T0>(arg0: &0x2::coin::CoinMetadata<T0>) : (0x1::ascii::String, 0x1::string::String, 0x1::string::String, 0x1::option::Option<0x2::url::Url>) {
        (0x2::coin::get_symbol<T0>(arg0), 0x2::coin::get_name<T0>(arg0), 0x2::coin::get_description<T0>(arg0), 0x2::coin::get_icon_url<T0>(arg0))
    }

    public fun get_info<T0>(arg0: &BondingCurve<T0>) : (u64, u64, u64, u64, bool) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), 0x2::balance::value<T0>(&arg0.token_balance), arg0.virtual_sui_amt, arg0.target_supply_threshold, arg0.is_active)
    }

    fun get_output_amount(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128);
        ((v0 * (arg2 as u128) / ((arg1 as u128) + v0)) as u64)
    }

    fun get_reserves<T0>(arg0: &BondingCurve<T0>) : (u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), 0x2::balance::value<T0>(&arg0.token_balance))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Configurator{
            id                      : 0x2::object::new(arg0),
            virtual_sui_amt         : 2000000000000,
            target_supply_threshold : 300000000000000000,
            migration_fee           : 200000000000,
            listing_fee             : 1000000000,
            swap_fee                : 10000,
            fee                     : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Configurator>(v1);
    }

    public fun list<T0>(arg0: &mut Configurator, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x1::option::Option<0x1::ascii::String>, arg5: 0x1::option::Option<0x1::ascii::String>, arg6: 0x1::option::Option<0x1::ascii::String>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : BondingCurve<T0> {
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 0);
        assert!(0x2::coin::get_decimals<T0>(arg2) == 9, 2);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v0) == arg0.listing_fee, 3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg1, @0x0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg0.listing_fee));
        let v1 = BondingCurve<T0>{
            id                      : 0x2::object::new(arg8),
            sui_balance             : v0,
            token_balance           : 0x2::coin::mint_balance<T0>(&mut arg1, 1000000000000000000),
            virtual_sui_amt         : arg0.virtual_sui_amt,
            target_supply_threshold : arg0.target_supply_threshold,
            swap_fee                : arg0.swap_fee,
            is_active               : true,
            creator                 : 0x2::tx_context::sender(arg8),
            twitter                 : arg4,
            telegram                : arg5,
            website                 : arg6,
            migration_target        : arg7,
        };
        let (v2, v3, v4, v5) = get_coin_metadata_info<T0>(arg2);
        emit_bonding_curve_event<T0>(&v1, v2, v3, v4, v5, 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg2));
        v1
    }

    public fun migrate<T0>(arg0: &AdminCap, arg1: &mut BondingCurve<T0>, arg2: &mut Configurator, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        assert!(!arg1.is_active, 6);
        if (arg2.migration_fee > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg2.fee, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_balance, arg2.migration_fee));
            let v0 = Points{
                amount : arg2.migration_fee,
                sender : 0x2::tx_context::sender(arg3),
            };
            0x2::event::emit<Points>(v0);
        };
        let (v1, v2) = get_reserves<T0>(arg1);
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_balance, v1), arg3), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.token_balance, v2), arg3))
    }

    public fun sell<T0>(arg0: &mut BondingCurve<T0>, arg1: &mut Configurator, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.is_active, 4);
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let (v1, v2) = get_reserves<T0>(arg0);
        let v3 = 0x2::balance::value<T0>(&v0);
        let v4 = get_output_amount(v3, v2, v1 + arg0.virtual_sui_amt);
        assert!(v4 >= arg3, 1);
        0x2::balance::join<T0>(&mut arg0.token_balance, v0);
        let v5 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, v4);
        let v6 = &mut v5;
        take_fee(arg1, arg0.swap_fee, v6, 0x2::tx_context::sender(arg4));
        let (v7, v8) = get_reserves<T0>(arg0);
        assert!(v7 > 0 && v8 > 0, 5);
        emit_swap_event(0x2::object::id<BondingCurve<T0>>(arg0), 0x1::type_name::into_string(0x1::type_name::get<T0>()), false, v3, 0x2::balance::value<0x2::sui::SUI>(&v5), v7, v8, 0x2::tx_context::sender(arg4));
        0x2::coin::from_balance<0x2::sui::SUI>(v5, arg4)
    }

    fun take_fee(arg0: &mut Configurator, arg1: u64, arg2: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg3: address) {
        let v0 = (((arg1 as u128) * (0x2::balance::value<0x2::sui::SUI>(arg2) as u128) / 1000000) as u64);
        let v1 = Points{
            amount : v0,
            sender : arg3,
        };
        0x2::event::emit<Points>(v1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee, 0x2::balance::split<0x2::sui::SUI>(arg2, v0));
    }

    public fun update_listing_fee(arg0: &AdminCap, arg1: &mut Configurator, arg2: u64) {
        arg1.listing_fee = arg2;
    }

    public fun update_migration_fee(arg0: &AdminCap, arg1: &mut Configurator, arg2: u64) {
        arg1.migration_fee = arg2;
    }

    public fun update_target_supply_threshold(arg0: &AdminCap, arg1: &mut Configurator, arg2: u64) {
        arg1.target_supply_threshold = arg2;
    }

    public fun update_virtual_sui_liq(arg0: &AdminCap, arg1: &mut Configurator, arg2: u64) {
        arg1.virtual_sui_amt = arg2;
    }

    public fun withdraw_fee(arg0: &AdminCap, arg1: &mut Configurator, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.fee, 0x2::balance::value<0x2::sui::SUI>(&arg1.fee)), arg2)
    }

    // decompiled from Move bytecode v6
}

