module 0xec46732fdaf2fdf21544dad677163ddc5eb2827213b55b4abb399eec2cb6f61::suipump {
    struct BondingCurveRegistry has key {
        id: 0x2::object::UID,
        curves: vector<BondingCurveInfo>,
        curves_symbol: 0x2::table::Table<0x2::object::ID, BondingCurveInfo>,
        counter: u128,
    }

    struct BondingCurveInfo has copy, drop, store {
        id: 0x2::object::ID,
        symbol: 0x1::ascii::String,
        creator: address,
        created_at_ms: u64,
    }

    struct BondingCurveState has copy, drop {
        sui_balance: u64,
        meme_balance: u64,
        is_active: bool,
        fee: u64,
    }

    public fun get_symbol(arg0: &BondingCurveInfo) : 0x1::ascii::String {
        arg0.symbol
    }

    public entry fun contains(arg0: &BondingCurveRegistry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, BondingCurveInfo>(&arg0.curves_symbol, arg1)
    }

    public entry fun curves(arg0: &BondingCurveRegistry) : vector<BondingCurveInfo> {
        arg0.curves
    }

    public entry fun buy<T0>(arg0: &mut 0xec46732fdaf2fdf21544dad677163ddc5eb2827213b55b4abb399eec2cb6f61::curves::BondingCurve<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0xec46732fdaf2fdf21544dad677163ddc5eb2827213b55b4abb399eec2cb6f61::curves::buy<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
        0x2::coin::value<T0>(&v0)
    }

    public entry fun sell<T0>(arg0: &mut 0xec46732fdaf2fdf21544dad677163ddc5eb2827213b55b4abb399eec2cb6f61::curves::BondingCurve<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0xec46732fdaf2fdf21544dad677163ddc5eb2827213b55b4abb399eec2cb6f61::curves::sell<T0>(arg0, arg1, 0, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg2));
        0x2::coin::value<0x2::sui::SUI>(&v0)
    }

    public entry fun bonding_curve_state<T0>(arg0: &0xec46732fdaf2fdf21544dad677163ddc5eb2827213b55b4abb399eec2cb6f61::curves::BondingCurve<T0>) : BondingCurveState {
        let (v0, v1, _, _, v4, v5) = 0xec46732fdaf2fdf21544dad677163ddc5eb2827213b55b4abb399eec2cb6f61::curves::get_curve_state<T0>(arg0);
        BondingCurveState{
            sui_balance  : v0,
            meme_balance : v1,
            is_active    : v4,
            fee          : v5,
        }
    }

    public fun borrow_curves_symbol(arg0: &BondingCurveRegistry) : &0x2::table::Table<0x2::object::ID, BondingCurveInfo> {
        &arg0.curves_symbol
    }

    public fun bytes_to_url(arg0: vector<u8>) : 0x2::url::Url {
        0x2::url::new_unsafe_from_bytes(arg0)
    }

    public entry fun create_and_first_buy<T0>(arg0: &mut BondingCurveRegistry, arg1: &mut 0xec46732fdaf2fdf21544dad677163ddc5eb2827213b55b4abb399eec2cb6f61::curves::Configurator, arg2: 0x2::coin::TreasuryCap<T0>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u8, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x2::tx_context::epoch_timestamp_ms(arg10) - 0x2::clock::timestamp_ms(arg9) < 60000, 2);
        let (_, _, v2) = 0xec46732fdaf2fdf21544dad677163ddc5eb2827213b55b4abb399eec2cb6f61::curves::get_config_info(arg1);
        assert!(v2 <= 0x2::coin::value<0x2::sui::SUI>(&arg4), 3);
        let v3 = 0xec46732fdaf2fdf21544dad677163ddc5eb2827213b55b4abb399eec2cb6f61::curves::list<T0>(arg1, arg2, arg3, 0x2::coin::split<0x2::sui::SUI>(&mut arg4, v2, arg10), arg5, bytes_to_url(arg6), bytes_to_url(arg7), bytes_to_url(arg8), arg10);
        registry_bonding(arg0, 0x2::object::id<0xec46732fdaf2fdf21544dad677163ddc5eb2827213b55b4abb399eec2cb6f61::curves::BondingCurve<T0>>(&v3), 0x2::coin::get_symbol<T0>(arg3), 0x2::tx_context::sender(arg10), 0x2::tx_context::epoch_timestamp_ms(arg10));
        let v4 = 0;
        if (!0xec46732fdaf2fdf21544dad677163ddc5eb2827213b55b4abb399eec2cb6f61::curves::is_empty<0x2::sui::SUI>(&arg4)) {
            let v5 = &mut v3;
            v4 = buy<T0>(v5, arg4, arg10);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg4);
        };
        0xec46732fdaf2fdf21544dad677163ddc5eb2827213b55b4abb399eec2cb6f61::curves::transfer<T0>(v3);
        v4
    }

    public entry fun create_and_first_buy_1<T0>(arg0: &mut BondingCurveRegistry, arg1: &mut 0xec46732fdaf2fdf21544dad677163ddc5eb2827213b55b4abb399eec2cb6f61::curves::Configurator, arg2: 0x2::coin::TreasuryCap<T0>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u8, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        let (_, _, v2) = 0xec46732fdaf2fdf21544dad677163ddc5eb2827213b55b4abb399eec2cb6f61::curves::get_config_info(arg1);
        assert!(v2 <= 0x2::coin::value<0x2::sui::SUI>(&arg4), 3);
        let v3 = 0xec46732fdaf2fdf21544dad677163ddc5eb2827213b55b4abb399eec2cb6f61::curves::list<T0>(arg1, arg2, arg3, 0x2::coin::split<0x2::sui::SUI>(&mut arg4, v2, arg9), arg5, bytes_to_url(arg6), bytes_to_url(arg7), bytes_to_url(arg8), arg9);
        registry_bonding(arg0, 0x2::object::id<0xec46732fdaf2fdf21544dad677163ddc5eb2827213b55b4abb399eec2cb6f61::curves::BondingCurve<T0>>(&v3), 0x2::coin::get_symbol<T0>(arg3), 0x2::tx_context::sender(arg9), 0x2::tx_context::epoch_timestamp_ms(arg9));
        let v4 = 0;
        if (!0xec46732fdaf2fdf21544dad677163ddc5eb2827213b55b4abb399eec2cb6f61::curves::is_empty<0x2::sui::SUI>(&arg4)) {
            let v5 = &mut v3;
            v4 = buy<T0>(v5, arg4, arg9);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg4);
        };
        0xec46732fdaf2fdf21544dad677163ddc5eb2827213b55b4abb399eec2cb6f61::curves::transfer<T0>(v3);
        v4
    }

    public entry fun curve_counter(arg0: &BondingCurveRegistry) : u128 {
        arg0.counter
    }

    public entry fun curves_length(arg0: &BondingCurveRegistry) : u64 {
        0x1::vector::length<BondingCurveInfo>(&arg0.curves)
    }

    public fun get_created_at_ms(arg0: &BondingCurveInfo) : u64 {
        arg0.created_at_ms
    }

    public fun get_creator(arg0: &BondingCurveInfo) : address {
        arg0.creator
    }

    public fun get_id(arg0: &BondingCurveInfo) : 0x2::object::ID {
        arg0.id
    }

    public fun get_is_active(arg0: &BondingCurveState) : bool {
        arg0.is_active
    }

    public fun get_meme_balance(arg0: &BondingCurveState) : u64 {
        arg0.meme_balance
    }

    public fun get_sui_balance(arg0: &BondingCurveState) : u64 {
        arg0.sui_balance
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BondingCurveRegistry{
            id            : 0x2::object::new(arg0),
            curves        : 0x1::vector::empty<BondingCurveInfo>(),
            curves_symbol : 0x2::table::new<0x2::object::ID, BondingCurveInfo>(arg0),
            counter       : 0,
        };
        0x2::transfer::share_object<BondingCurveRegistry>(v0);
    }

    public fun new_bonding_info(arg0: 0x2::object::ID, arg1: 0x1::ascii::String, arg2: address, arg3: u64) : BondingCurveInfo {
        BondingCurveInfo{
            id            : arg0,
            symbol        : arg1,
            creator       : arg2,
            created_at_ms : arg3,
        }
    }

    fun registry_bonding(arg0: &mut BondingCurveRegistry, arg1: 0x2::object::ID, arg2: 0x1::ascii::String, arg3: address, arg4: u64) {
        let v0 = new_bonding_info(arg1, arg2, arg3, arg4);
        0x2::table::add<0x2::object::ID, BondingCurveInfo>(&mut arg0.curves_symbol, arg1, v0);
        arg0.counter = arg0.counter + 1;
        0x1::vector::push_back<BondingCurveInfo>(&mut arg0.curves, v0);
    }

    // decompiled from Move bytecode v6
}

