module 0xec46732fdaf2fdf21544dad677163ddc5eb2827213b55b4abb399eec2cb6f61::curves {
    struct BondingCurve<phantom T0> has key {
        id: 0x2::object::UID,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        meme_balance: 0x2::balance::Balance<T0>,
        fee: 0x2::balance::Balance<0x2::sui::SUI>,
        virtual_sui_amt: u64,
        target_supply_threshold: u64,
        swap_fee_rate: u64,
        is_active: bool,
        migration_fee: u64,
        creator: address,
    }

    struct Configurator has key {
        id: 0x2::object::UID,
        virtual_sui_amt: u64,
        target_supply_threshold: u64,
        migration_fee: u64,
        listing_fee: u64,
        swap_fee_rate: u64,
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
        decimals: u8,
        website: 0x2::url::Url,
        description: 0x1::string::String,
        url: 0x1::option::Option<0x2::url::Url>,
        twitter: 0x2::url::Url,
        telegram: 0x2::url::Url,
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

    public fun transfer<T0>(arg0: BondingCurve<T0>) {
        0x2::transfer::share_object<BondingCurve<T0>>(arg0);
    }

    public fun buy<T0>(arg0: &mut BondingCurve<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!is_empty<0x2::sui::SUI>(&arg1), 3);
        assert!(arg0.is_active, 4);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        let v2 = &mut v1;
        take_fee<T0>(arg0, v2, v0);
        let (v3, v4) = get_reserves<T0>(arg0);
        let v5 = 6000000000 - v3;
        let v6 = if (0x2::balance::value<0x2::sui::SUI>(&v1) > v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg2), v0);
            0x2::balance::split<0x2::sui::SUI>(&mut v1, v5)
        } else {
            v1
        };
        let v7 = v6;
        let v8 = 0x2::balance::value<0x2::sui::SUI>(&v7);
        let v9 = get_output_amount(v8, v3 + arg0.virtual_sui_amt, v4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, v7);
        let (v10, v11) = get_reserves<T0>(arg0);
        assert!(v10 > 0 && v11 > 0, 5);
        if (v10 >= 6000000000) {
            arg0.is_active = false;
            0x1::debug::print<bool>(&arg0.is_active);
            migrating<T0>(arg0, arg2);
        };
        let v12 = SwapEvent{
            bc_id            : 0x2::object::id<BondingCurve<T0>>(arg0),
            meme_type        : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            is_buy           : true,
            input_amount     : v8,
            output_amount    : v9,
            sui_reserve_val  : v10,
            meme_reserve_val : v11 - v9,
            sender           : v0,
        };
        0x2::event::emit<SwapEvent>(v12);
        0x2::coin::take<T0>(&mut arg0.meme_balance, v9, arg2)
    }

    fun emit_bonding_curve_event<T0>(arg0: &BondingCurve<T0>, arg1: 0x1::ascii::String, arg2: 0x1::string::String, arg3: u8, arg4: 0x2::url::Url, arg5: 0x1::string::String, arg6: 0x1::option::Option<0x2::url::Url>, arg7: 0x2::url::Url, arg8: 0x2::url::Url) {
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
            decimals                : arg3,
            website                 : arg4,
            description             : arg5,
            url                     : arg6,
            twitter                 : arg7,
            telegram                : arg8,
        };
        0x2::event::emit<BondingCurveListedEvent>(v0);
    }

    fun get_coin_metadata_info<T0>(arg0: &0x2::coin::CoinMetadata<T0>) : (0x1::ascii::String, 0x1::string::String, 0x1::string::String, 0x1::option::Option<0x2::url::Url>) {
        (0x2::coin::get_symbol<T0>(arg0), 0x2::coin::get_name<T0>(arg0), 0x2::coin::get_description<T0>(arg0), 0x2::coin::get_icon_url<T0>(arg0))
    }

    public fun get_config_info(arg0: &Configurator) : (u64, u64, u64) {
        (arg0.virtual_sui_amt, arg0.target_supply_threshold, arg0.listing_fee)
    }

    public fun get_curve_state<T0>(arg0: &BondingCurve<T0>) : (u64, u64, u64, u64, bool, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), 0x2::balance::value<T0>(&arg0.meme_balance), arg0.virtual_sui_amt, arg0.target_supply_threshold, arg0.is_active, 0x2::balance::value<0x2::sui::SUI>(&arg0.fee))
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
            virtual_sui_amt         : 2000000000,
            target_supply_threshold : 1073000191000000000,
            migration_fee           : 100000000,
            listing_fee             : 1000000000,
            swap_fee_rate           : 100,
        };
        0x2::transfer::share_object<Configurator>(v0);
    }

    public fun is_empty<T0>(arg0: &0x2::coin::Coin<T0>) : bool {
        0x2::coin::value<T0>(arg0) == 0
    }

    public fun list<T0>(arg0: &mut Configurator, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u8, arg5: 0x2::url::Url, arg6: 0x2::url::Url, arg7: 0x2::url::Url, arg8: &mut 0x2::tx_context::TxContext) : BondingCurve<T0> {
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 0);
        assert!(0x2::coin::get_decimals<T0>(arg2) == 9, 2);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v0) == arg0.listing_fee, 3);
        let v1 = BondingCurve<T0>{
            id                      : 0x2::object::new(arg8),
            sui_balance             : v0,
            meme_balance            : 0x2::coin::mint_balance<T0>(&mut arg1, 1073000191000000000),
            fee                     : 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg0.listing_fee),
            virtual_sui_amt         : arg0.virtual_sui_amt,
            target_supply_threshold : arg0.target_supply_threshold,
            swap_fee_rate           : arg0.swap_fee_rate,
            is_active               : true,
            migration_fee           : arg0.migration_fee,
            creator                 : 0x2::tx_context::sender(arg8),
        };
        let (v2, v3, v4, v5) = get_coin_metadata_info<T0>(arg2);
        emit_bonding_curve_event<T0>(&v1, v2, v3, arg4, arg5, v4, v5, arg6, arg7);
        0xec46732fdaf2fdf21544dad677163ddc5eb2827213b55b4abb399eec2cb6f61::freezer::freeze_object<0x2::coin::TreasuryCap<T0>>(arg1, arg8);
        v1
    }

    fun migrating<T0>(arg0: &mut BondingCurve<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_active, 6);
        let (v0, v1) = get_reserves<T0>(arg0);
        assert!(v0 >= 5000000000, 3);
        assert!(v1 >= 178214564000000000, 7);
        let v2 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, 5000000000);
        let v3 = 0x2::balance::split<T0>(&mut arg0.meme_balance, 178214564000000000);
        let v4 = MigrationPendingEvent{
            bc_id            : 0x2::object::id<BondingCurve<T0>>(arg0),
            meme_type        : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            sui_reserve_val  : 0x2::balance::value<0x2::sui::SUI>(&v2),
            meme_reserve_val : 0x2::balance::value<T0>(&v3),
        };
        transfer_fee_and_income_to_platform<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.fee), 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.sui_balance), @0x8c3f4f0f466f57fee42ccb9a9a84ff1f7004a5067db7c50ce5ef9d6845b75de5, arg1);
        transfer_dex_initial_platform<T0>(v2, v3, @0x29f6154704ff236ad9cc4c42923a2308e2e26cacbbe732c1900379ccc8947d3, arg1);
        0x2::event::emit<MigrationPendingEvent>(v4);
    }

    public fun sell<T0>(arg0: &mut BondingCurve<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(!is_empty<T0>(&arg1), 7);
        assert!(arg0.is_active, 4);
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let (v1, v2) = get_reserves<T0>(arg0);
        let v3 = 0x2::balance::value<T0>(&v0);
        let v4 = get_output_amount(v3, v2, v1 + arg0.virtual_sui_amt);
        assert!(v4 >= arg2, 1);
        0x2::balance::join<T0>(&mut arg0.meme_balance, v0);
        let v5 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, v4);
        let (v6, v7) = get_reserves<T0>(arg0);
        assert!(v6 > 0 && v7 > 0, 5);
        let v8 = SwapEvent{
            bc_id            : 0x2::object::id<BondingCurve<T0>>(arg0),
            meme_type        : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            is_buy           : false,
            input_amount     : v3,
            output_amount    : 0x2::balance::value<0x2::sui::SUI>(&v5),
            sui_reserve_val  : v6,
            meme_reserve_val : v7,
            sender           : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SwapEvent>(v8);
        0x2::coin::from_balance<0x2::sui::SUI>(v5, arg3)
    }

    fun take_fee<T0>(arg0: &mut BondingCurve<T0>, arg1: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg2: address) {
        let v0 = (((arg0.swap_fee_rate as u128) * (0x2::balance::value<0x2::sui::SUI>(arg1) as u128) / (10000 as u128)) as u64);
        let v1 = Points{
            amount : v0,
            sender : arg2,
        };
        0x2::event::emit<Points>(v1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee, 0x2::balance::split<0x2::sui::SUI>(arg1, v0));
    }

    fun transfer_dex_initial_platform<T0>(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: 0x2::balance::Balance<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(arg0, arg3), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg1, arg3), arg2);
    }

    fun transfer_fee_and_income_to_platform<T0>(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: 0x2::balance::Balance<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(arg0, arg3), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg1, arg3), arg2);
    }

    public fun update_listing_fee(arg0: &0xec46732fdaf2fdf21544dad677163ddc5eb2827213b55b4abb399eec2cb6f61::admin::AdminCap, arg1: &mut Configurator, arg2: u64) {
        arg1.listing_fee = arg2;
    }

    public fun update_migration_fee(arg0: &0xec46732fdaf2fdf21544dad677163ddc5eb2827213b55b4abb399eec2cb6f61::admin::AdminCap, arg1: &mut Configurator, arg2: u64) {
        arg1.migration_fee = arg2;
    }

    public fun update_target_supply_threshold(arg0: &0xec46732fdaf2fdf21544dad677163ddc5eb2827213b55b4abb399eec2cb6f61::admin::AdminCap, arg1: &mut Configurator, arg2: u64) {
        arg1.target_supply_threshold = arg2;
    }

    public fun update_virtual_sui_liquidity(arg0: &0xec46732fdaf2fdf21544dad677163ddc5eb2827213b55b4abb399eec2cb6f61::admin::AdminCap, arg1: &mut Configurator, arg2: u64) {
        arg1.virtual_sui_amt = arg2;
    }

    // decompiled from Move bytecode v6
}

