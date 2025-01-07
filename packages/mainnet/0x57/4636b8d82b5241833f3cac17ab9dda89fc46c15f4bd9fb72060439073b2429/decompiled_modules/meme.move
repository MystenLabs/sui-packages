module 0x574636b8d82b5241833f3cac17ab9dda89fc46c15f4bd9fb72060439073b2429::meme {
    struct BondingCurve<phantom T0> has key {
        id: 0x2::object::UID,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        meme_balance: 0x2::balance::Balance<T0>,
        fee: 0x2::balance::Balance<0x2::sui::SUI>,
        virtual_sui_amt: u64,
        target_supply_threshold: u64,
        swap_fee: u64,
        is_active: bool,
        creator: address,
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
        meme_type: 0x1::ascii::String,
        sui_balance_val: u64,
        meme_balance_val: u64,
        virtual_sui_amt: u64,
        target_supply_threshold: u64,
        creator: address,
        ticker: 0x1::ascii::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::option::Option<0x2::url::Url>,
        coin_metadata_id: 0x2::object::ID,
    }

    struct Points has copy, drop {
        amount: u64,
        sender: address,
    }

    struct SwapEvent has copy, drop {
        bc_id: 0x2::object::ID,
        meme_type: 0x1::ascii::String,
        is_buy: bool,
        input_amount: u64,
        output_amount: u64,
        sui_reserve_val: u64,
        meme_reserve_val: u64,
        sender: address,
    }

    struct MigrationPendingEvent has copy, drop {
        bc_id: 0x2::object::ID,
        meme_type: 0x1::ascii::String,
        sui_reserve_val: u64,
        meme_reserve_val: u64,
    }

    struct MigrationCompletedEvent has copy, drop {
        adapter_id: u64,
        bc_id: 0x2::object::ID,
        meme_type: 0x1::ascii::String,
        target_pool_id: 0x2::object::ID,
        sui_balance_val: u64,
        meme_balance_val: u64,
    }

    public fun transfer<T0>(arg0: BondingCurve<T0>) {
        0x2::transfer::share_object<BondingCurve<T0>>(arg0);
    }

    public fun buy<T0>(arg0: &mut BondingCurve<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.is_active, 4);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        let v2 = &mut v1;
        take_fee<T0>(arg0, v2, v0);
        let (v3, v4) = get_reserves<T0>(arg0);
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&v1);
        let v6 = get_output_amount(v5, v3 + arg0.virtual_sui_amt, v4);
        assert!(v6 >= arg2, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, v1);
        let (v7, v8) = get_reserves<T0>(arg0);
        assert!(v7 > 0 && v8 > 0, 5);
        if (v8 <= arg0.target_supply_threshold) {
            arg0.is_active = false;
            let v9 = MigrationPendingEvent{
                bc_id            : 0x2::object::id<BondingCurve<T0>>(arg0),
                meme_type        : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
                sui_reserve_val  : v7,
                meme_reserve_val : v8,
            };
            0x2::event::emit<MigrationPendingEvent>(v9);
        };
        let v10 = SwapEvent{
            bc_id            : 0x2::object::id<BondingCurve<T0>>(arg0),
            meme_type        : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            is_buy           : true,
            input_amount     : v5,
            output_amount    : v6,
            sui_reserve_val  : v7,
            meme_reserve_val : v8,
            sender           : v0,
        };
        0x2::event::emit<SwapEvent>(v10);
        0x2::coin::take<T0>(&mut arg0.meme_balance, v6, arg3)
    }

    fun emit_bonding_curve_event<T0>(arg0: &BondingCurve<T0>, arg1: 0x1::ascii::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::option::Option<0x2::url::Url>, arg5: 0x2::object::ID) {
        let v0 = BondingCurveListedEvent{
            object_id               : 0x2::object::id<BondingCurve<T0>>(arg0),
            meme_type               : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            sui_balance_val         : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance),
            meme_balance_val        : 0x2::balance::value<T0>(&arg0.meme_balance),
            virtual_sui_amt         : arg0.virtual_sui_amt,
            target_supply_threshold : arg0.target_supply_threshold,
            creator                 : arg0.creator,
            ticker                  : arg1,
            name                    : arg2,
            description             : arg3,
            url                     : arg4,
            coin_metadata_id        : arg5,
        };
        0x2::event::emit<BondingCurveListedEvent>(v0);
    }

    fun extract_all_fee<T0>(arg0: &mut BondingCurve<T0>) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.fee, 0x2::balance::value<0x2::sui::SUI>(&arg0.fee))
    }

    fun get_coin_metadata_info<T0>(arg0: &0x2::coin::CoinMetadata<T0>) : (0x1::ascii::String, 0x1::string::String, 0x1::string::String, 0x1::option::Option<0x2::url::Url>) {
        (0x2::coin::get_symbol<T0>(arg0), 0x2::coin::get_name<T0>(arg0), 0x2::coin::get_description<T0>(arg0), 0x2::coin::get_icon_url<T0>(arg0))
    }

    public fun get_info<T0>(arg0: &BondingCurve<T0>) : (u64, u64, u64, u64, bool) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), 0x2::balance::value<T0>(&arg0.meme_balance), arg0.virtual_sui_amt, arg0.target_supply_threshold, arg0.is_active)
    }

    fun get_output_amount(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128);
        ((v0 * (arg2 as u128) / ((arg1 as u128) + v0)) as u64)
    }

    fun get_reserves<T0>(arg0: &BondingCurve<T0>) : (u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), 0x2::balance::value<T0>(&arg0.meme_balance))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Configurator{
            id                      : 0x2::object::new(arg0),
            virtual_sui_amt         : 5000000000000,
            target_supply_threshold : 200000000000000000,
            migration_fee           : 800000000000,
            listing_fee             : 1000000000,
            swap_fee                : 100000,
            fee                     : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Configurator>(v0);
    }

    public fun list<T0>(arg0: &mut Configurator, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : BondingCurve<T0> {
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 0);
        assert!(0x2::coin::get_decimals<T0>(arg2) == 9, 2);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v0) == arg0.listing_fee, 3);
        0x574636b8d82b5241833f3cac17ab9dda89fc46c15f4bd9fb72060439073b2429::freezer::freeze_object<0x2::coin::TreasuryCap<T0>>(arg1, arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg0.listing_fee));
        let v1 = BondingCurve<T0>{
            id                      : 0x2::object::new(arg4),
            sui_balance             : v0,
            meme_balance            : 0x2::coin::mint_balance<T0>(&mut arg1, 1000000000000000000),
            fee                     : 0x2::balance::zero<0x2::sui::SUI>(),
            virtual_sui_amt         : arg0.virtual_sui_amt,
            target_supply_threshold : arg0.target_supply_threshold,
            swap_fee                : arg0.swap_fee,
            is_active               : true,
            creator                 : 0x2::tx_context::sender(arg4),
        };
        let (v2, v3, v4, v5) = get_coin_metadata_info<T0>(arg2);
        emit_bonding_curve_event<T0>(&v1, v2, v3, v4, v5, 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg2));
        v1
    }

    public fun make_safu<T0>(arg0: &mut BondingCurve<T0>, arg1: &mut Configurator, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x574636b8d82b5241833f3cac17ab9dda89fc46c15f4bd9fb72060439073b2429::safu_receipt::SafuReceipt<T0> {
        assert!(!arg0.is_active, 6);
        if (arg1.migration_fee > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.fee, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, arg1.migration_fee));
        };
        transfer_fee_to_configurator<T0>(arg0, arg1, arg3);
        let (v0, v1) = get_reserves<T0>(arg0);
        0x574636b8d82b5241833f3cac17ab9dda89fc46c15f4bd9fb72060439073b2429::safu_receipt::mint<T0>(arg2, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, v0), 0x2::balance::split<T0>(&mut arg0.meme_balance, v1), 0x2::object::id<BondingCurve<T0>>(arg0))
    }

    public fun sell<T0>(arg0: &mut BondingCurve<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.is_active, 4);
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let (v1, v2) = get_reserves<T0>(arg0);
        let v3 = 0x2::balance::value<T0>(&v0);
        let v4 = get_output_amount(v3, v2, v1 + arg0.virtual_sui_amt);
        assert!(v4 >= arg2, 1);
        0x2::balance::join<T0>(&mut arg0.meme_balance, v0);
        let v5 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, v4);
        let v6 = &mut v5;
        take_fee<T0>(arg0, v6, 0x2::tx_context::sender(arg3));
        let (v7, v8) = get_reserves<T0>(arg0);
        assert!(v7 > 0 && v8 > 0, 5);
        let v9 = SwapEvent{
            bc_id            : 0x2::object::id<BondingCurve<T0>>(arg0),
            meme_type        : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            is_buy           : false,
            input_amount     : v3,
            output_amount    : 0x2::balance::value<0x2::sui::SUI>(&v5),
            sui_reserve_val  : v7,
            meme_reserve_val : v8,
            sender           : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SwapEvent>(v9);
        0x2::coin::from_balance<0x2::sui::SUI>(v5, arg3)
    }

    fun take_fee<T0>(arg0: &mut BondingCurve<T0>, arg1: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg2: address) {
        let v0 = (((arg0.swap_fee as u128) * (0x2::balance::value<0x2::sui::SUI>(arg1) as u128) / 1000000) as u64);
        let v1 = Points{
            amount : v0,
            sender : arg2,
        };
        0x2::event::emit<Points>(v1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::balance::split<0x2::sui::SUI>(arg1, v0));
    }

    public fun transfer_fee_to_configurator<T0>(arg0: &mut BondingCurve<T0>, arg1: &mut Configurator, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.fee, extract_all_fee<T0>(arg0));
    }

    public fun update_listing_fee(arg0: &0x574636b8d82b5241833f3cac17ab9dda89fc46c15f4bd9fb72060439073b2429::admin::AdminCap, arg1: &mut Configurator, arg2: u64) {
        arg1.listing_fee = arg2;
    }

    public fun update_migration_fee(arg0: &0x574636b8d82b5241833f3cac17ab9dda89fc46c15f4bd9fb72060439073b2429::admin::AdminCap, arg1: &mut Configurator, arg2: u64) {
        arg1.migration_fee = arg2;
    }

    public fun update_target_supply_threshold(arg0: &0x574636b8d82b5241833f3cac17ab9dda89fc46c15f4bd9fb72060439073b2429::admin::AdminCap, arg1: &mut Configurator, arg2: u64) {
        arg1.target_supply_threshold = arg2;
    }

    public fun update_virtual_sui_liq(arg0: &0x574636b8d82b5241833f3cac17ab9dda89fc46c15f4bd9fb72060439073b2429::admin::AdminCap, arg1: &mut Configurator, arg2: u64) {
        arg1.virtual_sui_amt = arg2;
    }

    public fun verify_if_safu<T0>(arg0: 0x574636b8d82b5241833f3cac17ab9dda89fc46c15f4bd9fb72060439073b2429::safu_receipt::SafuReceipt<T0>) {
        let (v0, v1, v2, v3, v4) = 0x574636b8d82b5241833f3cac17ab9dda89fc46c15f4bd9fb72060439073b2429::safu_receipt::burn<T0>(arg0);
        assert!(v2 > 0 && v3 > 0, 0);
        assert!(v4 != 0x2::object::id_from_address(@0x0), 0);
        let v5 = MigrationCompletedEvent{
            adapter_id       : v1,
            bc_id            : v0,
            meme_type        : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            target_pool_id   : v4,
            sui_balance_val  : v2,
            meme_balance_val : v3,
        };
        0x2::event::emit<MigrationCompletedEvent>(v5);
    }

    public fun withdraw_fee(arg0: &0x574636b8d82b5241833f3cac17ab9dda89fc46c15f4bd9fb72060439073b2429::admin::AdminCap, arg1: &0x574636b8d82b5241833f3cac17ab9dda89fc46c15f4bd9fb72060439073b2429::admin::AdminAccess, arg2: &mut Configurator, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg3 / 2;
        let (v1, v2) = 0x574636b8d82b5241833f3cac17ab9dda89fc46c15f4bd9fb72060439073b2429::admin::get_addresses(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2.fee, v0), arg4), v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2.fee, v0), arg4), v2);
    }

    // decompiled from Move bytecode v6
}

