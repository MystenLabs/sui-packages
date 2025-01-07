module 0xbdc7b62f56a651fb7801798e6b3746097bb7dac84db7b20e5015d95579b2b7e9::curves {
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
        decimals: u8,
        website: 0x1::option::Option<0x2::url::Url>,
        twitter: 0x1::option::Option<0x2::url::Url>,
        telegram: 0x1::option::Option<0x2::url::Url>,
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

    struct MigrationEvent has copy, drop {
        bc_id: 0x2::object::ID,
        meme_type: 0x1::ascii::String,
        sui_to_dex: u64,
        sui_fee: u64,
        meme_to_dex: u64,
        manager_address: address,
        dex_address: address,
    }

    public fun transfer<T0>(arg0: BondingCurve<T0>) {
        0x2::transfer::share_object<BondingCurve<T0>>(arg0);
    }

    public fun buy<T0>(arg0: &mut BondingCurve<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!is_empty<0x2::sui::SUI>(&arg1), 3);
        assert!(arg0.is_active, 4);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        let (v2, v3) = get_reserves<T0>(arg0);
        let v4 = 2000000000 - v2;
        let v5 = v4 / 100;
        let v6 = if (0x2::balance::value<0x2::sui::SUI>(&v1) > v4 + v5) {
            take_fee<T0>(arg0, 0x2::balance::split<0x2::sui::SUI>(&mut v1, v5), v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg2), v0);
            0x2::balance::split<0x2::sui::SUI>(&mut v1, v4)
        } else {
            take_fee<T0>(arg0, 0x2::balance::split<0x2::sui::SUI>(&mut v1, 0x2::balance::value<0x2::sui::SUI>(&v1) / 101), v0);
            v1
        };
        let v7 = v6;
        let v8 = 0x2::balance::value<0x2::sui::SUI>(&v7);
        let v9 = b"+++++++";
        0x1::debug::print<vector<u8>>(&v9);
        0x1::debug::print<u64>(&v8);
        let v10 = b"+++++++";
        0x1::debug::print<vector<u8>>(&v10);
        let v11 = get_output_amount(v8, v2 + arg0.virtual_sui_amt, v3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, v7);
        let (v12, v13) = get_reserves<T0>(arg0);
        assert!(v12 > 0 && v13 > 0, 5);
        if (v12 >= 2000000000) {
            arg0.is_active = false;
            let v14 = MigrationPendingEvent{
                bc_id            : 0x2::object::id<BondingCurve<T0>>(arg0),
                meme_type        : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
                sui_reserve_val  : v12,
                meme_reserve_val : v13 - v11,
            };
            0x1::debug::print<MigrationPendingEvent>(&v14);
            0x2::event::emit<MigrationPendingEvent>(v14);
        };
        let v15 = SwapEvent{
            bc_id            : 0x2::object::id<BondingCurve<T0>>(arg0),
            meme_type        : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            is_buy           : true,
            input_amount     : v8,
            output_amount    : v11,
            sui_reserve_val  : v12,
            meme_reserve_val : v13 - v11,
            sender           : v0,
        };
        0x1::debug::print<SwapEvent>(&v15);
        0x2::event::emit<SwapEvent>(v15);
        0x2::coin::take<T0>(&mut arg0.meme_balance, v11, arg2)
    }

    fun emit_bonding_curve_event<T0>(arg0: &BondingCurve<T0>, arg1: 0x1::ascii::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::option::Option<0x2::url::Url>, arg5: u8, arg6: 0x1::option::Option<0x2::url::Url>, arg7: 0x1::option::Option<0x2::url::Url>, arg8: 0x1::option::Option<0x2::url::Url>) {
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
            decimals                : arg5,
            website                 : arg8,
            twitter                 : arg6,
            telegram                : arg7,
        };
        0x2::event::emit<BondingCurveListedEvent>(v0);
    }

    fun extract_all_fee<T0>(arg0: &mut BondingCurve<T0>) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.fee, 0x2::balance::value<0x2::sui::SUI>(&arg0.fee))
    }

    fun extract_all_sui_balance<T0>(arg0: &mut BondingCurve<T0>) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance))
    }

    fun get_coin_metadata_info<T0>(arg0: &0x2::coin::CoinMetadata<T0>) : (0x1::ascii::String, 0x1::string::String, 0x1::string::String, 0x1::option::Option<0x2::url::Url>) {
        (0x2::coin::get_symbol<T0>(arg0), 0x2::coin::get_name<T0>(arg0), 0x2::coin::get_description<T0>(arg0), 0x2::coin::get_icon_url<T0>(arg0))
    }

    public fun get_config_info(arg0: &Configurator) : (u64, u64, u64, u64) {
        (arg0.virtual_sui_amt, arg0.target_supply_threshold, arg0.listing_fee, 0x2::balance::value<0x2::sui::SUI>(&arg0.fee))
    }

    public fun get_curve_state<T0>(arg0: &BondingCurve<T0>) : (u64, u64, u64, u64, bool) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), 0x2::balance::value<T0>(&arg0.meme_balance), arg0.virtual_sui_amt, arg0.target_supply_threshold, arg0.is_active)
    }

    fun get_fee<T0>(arg0: &BondingCurve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.fee)
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
            migration_fee           : 1000000000,
            listing_fee             : 1000000000,
            swap_fee                : 10000,
            fee                     : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Configurator>(v0);
    }

    public fun is_empty<T0>(arg0: &0x2::coin::Coin<T0>) : bool {
        0x2::coin::value<T0>(arg0) == 0
    }

    public fun list<T0>(arg0: &mut Configurator, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &0xbdc7b62f56a651fb7801798e6b3746097bb7dac84db7b20e5015d95579b2b7e9::admin::AdminAccess, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u8, arg6: 0x1::option::Option<0x2::url::Url>, arg7: 0x1::option::Option<0x2::url::Url>, arg8: 0x1::option::Option<0x2::url::Url>, arg9: &mut 0x2::tx_context::TxContext) : BondingCurve<T0> {
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 0);
        assert!(0x2::coin::get_decimals<T0>(arg2) == 9, 2);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg4);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v0) == arg0.listing_fee, 3);
        0xbdc7b62f56a651fb7801798e6b3746097bb7dac84db7b20e5015d95579b2b7e9::freezer::freeze_object<0x2::coin::TreasuryCap<T0>>(arg1, arg9);
        let (_, _, v3) = 0xbdc7b62f56a651fb7801798e6b3746097bb7dac84db7b20e5015d95579b2b7e9::admin::get_addresses(arg3);
        let v4 = v3;
        let v5 = b"+++++++++++++++++++++++++++++";
        0x1::debug::print<vector<u8>>(&v5);
        0x1::debug::print<address>(&v4);
        let v6 = b"+++++++++++++++++++++++++++++";
        0x1::debug::print<vector<u8>>(&v6);
        let v7 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v0, arg0.listing_fee), arg9);
        0x1::debug::print<0x2::coin::Coin<0x2::sui::SUI>>(&v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v7, v4);
        let v8 = BondingCurve<T0>{
            id                      : 0x2::object::new(arg9),
            sui_balance             : v0,
            meme_balance            : 0x2::coin::mint_balance<T0>(&mut arg1, 1073000191000000000),
            fee                     : 0x2::balance::zero<0x2::sui::SUI>(),
            virtual_sui_amt         : arg0.virtual_sui_amt,
            target_supply_threshold : arg0.target_supply_threshold,
            swap_fee                : arg0.swap_fee,
            is_active               : true,
            creator                 : 0x2::tx_context::sender(arg9),
        };
        let (v9, v10, v11, v12) = get_coin_metadata_info<T0>(arg2);
        emit_bonding_curve_event<T0>(&v8, v9, v10, v11, v12, arg5, arg6, arg7, arg8);
        v8
    }

    public fun migrating<T0>(arg0: &mut BondingCurve<T0>, arg1: &mut Configurator, arg2: &0xbdc7b62f56a651fb7801798e6b3746097bb7dac84db7b20e5015d95579b2b7e9::admin::AdminAccess, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_active, 6);
        let (v0, v1) = get_reserves<T0>(arg0);
        let v2 = v1;
        0x1::debug::print<u64>(&v2);
        let v3 = 536500095500000000;
        0x1::debug::print<u64>(&v3);
        assert!(v0 >= 1000000000, 3);
        assert!(v2 >= 536500095500000000, 7);
        if (arg1.migration_fee > 0) {
            let v4 = arg1.migration_fee + 500000000;
            let v5 = b"====================";
            0x1::debug::print<vector<u8>>(&v5);
            0x1::debug::print<0x2::balance::Balance<0x2::sui::SUI>>(&arg0.sui_balance);
            0x1::debug::print<u64>(&v4);
            let v6 = b"====================";
            0x1::debug::print<vector<u8>>(&v6);
            let v7 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, v4);
            let v8 = 0x2::balance::value<0x2::sui::SUI>(&v7);
            0x1::debug::print<u64>(&v8);
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.fee, v7);
            0x1::debug::print<0x2::balance::Balance<0x2::sui::SUI>>(&arg1.fee);
        };
        let v9 = 0x2::balance::value<0x2::sui::SUI>(&arg1.fee);
        let (v10, v11, v12) = 0xbdc7b62f56a651fb7801798e6b3746097bb7dac84db7b20e5015d95579b2b7e9::admin::get_addresses(arg2);
        let v13 = v11;
        let v14 = b"====================";
        0x1::debug::print<vector<u8>>(&v14);
        0x1::debug::print<address>(&v13);
        0x1::debug::print<Configurator>(arg1);
        0x1::debug::print<BondingCurve<T0>>(arg0);
        let v15 = b"====================";
        0x1::debug::print<vector<u8>>(&v15);
        let v16 = take_config_fee(arg1);
        let v17 = 0x2::coin::from_balance<0x2::sui::SUI>(v16, arg3);
        0x1::debug::print<0x2::coin::Coin<0x2::sui::SUI>>(&v17);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v17, v13);
        let v18 = 0x2::balance::value<0x2::sui::SUI>(&arg0.fee);
        transfer_fee_to_configurator<T0>(arg0, arg1, arg3);
        0x1::debug::print<Configurator>(arg1);
        let v19 = take_config_fee(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v19, arg3), v12);
        0x1::debug::print<Configurator>(arg1);
        let v20 = b"====================";
        0x1::debug::print<vector<u8>>(&v20);
        0x1::debug::print<0x2::balance::Balance<0x2::sui::SUI>>(&arg1.fee);
        let v21 = 0x2::balance::value<T0>(&arg0.meme_balance);
        let v22 = take_meme_balance<T0>(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v22, arg3), v13);
        let v23 = MigrationEvent{
            bc_id           : 0x2::object::id<BondingCurve<T0>>(arg0),
            meme_type       : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            sui_to_dex      : v9,
            sui_fee         : v18,
            meme_to_dex     : v21,
            manager_address : v10,
            dex_address     : v13,
        };
        0x1::debug::print<MigrationEvent>(&v23);
        0x2::event::emit<MigrationEvent>(v23);
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
        0x1::debug::print<SwapEvent>(&v8);
        0x2::event::emit<SwapEvent>(v8);
        0x2::coin::from_balance<0x2::sui::SUI>(v5, arg3)
    }

    fun subtract_abs(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    public(friend) fun take_config_fee(arg0: &mut Configurator) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.fee, 0x2::balance::value<0x2::sui::SUI>(&arg0.fee))
    }

    fun take_fee<T0>(arg0: &mut BondingCurve<T0>, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: address) {
        let v0 = Points{
            amount : 0x2::balance::value<0x2::sui::SUI>(&arg1),
            sender : arg2,
        };
        0x2::event::emit<Points>(v0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee, arg1);
    }

    public fun take_meme_balance<T0>(arg0: &mut BondingCurve<T0>) : 0x2::balance::Balance<T0> {
        0x1::debug::print<0x2::balance::Balance<T0>>(&arg0.meme_balance);
        0x2::balance::split<T0>(&mut arg0.meme_balance, 0x2::balance::value<T0>(&arg0.meme_balance))
    }

    public fun transfer_fee_to_configurator<T0>(arg0: &mut BondingCurve<T0>, arg1: &mut Configurator, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = extract_all_fee<T0>(arg0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.fee, v0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.fee, extract_all_sui_balance<T0>(arg0));
    }

    public fun update_listing_fee(arg0: &0xbdc7b62f56a651fb7801798e6b3746097bb7dac84db7b20e5015d95579b2b7e9::admin::AdminCap, arg1: &mut Configurator, arg2: u64) {
        arg1.listing_fee = arg2;
    }

    public fun update_migration_fee(arg0: &0xbdc7b62f56a651fb7801798e6b3746097bb7dac84db7b20e5015d95579b2b7e9::admin::AdminCap, arg1: &mut Configurator, arg2: u64) {
        arg1.migration_fee = arg2;
    }

    public fun update_target_supply_threshold(arg0: &0xbdc7b62f56a651fb7801798e6b3746097bb7dac84db7b20e5015d95579b2b7e9::admin::AdminCap, arg1: &mut Configurator, arg2: u64) {
        arg1.target_supply_threshold = arg2;
    }

    public fun update_virtual_sui_liq(arg0: &0xbdc7b62f56a651fb7801798e6b3746097bb7dac84db7b20e5015d95579b2b7e9::admin::AdminCap, arg1: &mut Configurator, arg2: u64) {
        arg1.virtual_sui_amt = arg2;
    }

    public fun withdraw_fee(arg0: &0xbdc7b62f56a651fb7801798e6b3746097bb7dac84db7b20e5015d95579b2b7e9::admin::AdminCap, arg1: &0xbdc7b62f56a651fb7801798e6b3746097bb7dac84db7b20e5015d95579b2b7e9::admin::AdminAccess, arg2: &mut Configurator, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (_, _, v2) = 0xbdc7b62f56a651fb7801798e6b3746097bb7dac84db7b20e5015d95579b2b7e9::admin::get_addresses(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2.fee, arg3), arg4), v2);
    }

    // decompiled from Move bytecode v6
}

