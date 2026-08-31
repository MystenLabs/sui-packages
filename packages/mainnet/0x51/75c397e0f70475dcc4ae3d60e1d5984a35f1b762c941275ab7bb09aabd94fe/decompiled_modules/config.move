module 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct StoredQuote<phantom T0> has store {
        inner: 0x2::balance::Balance<T0>,
    }

    struct OfficialPitKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct InstantVirtualQuoteKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Config has key {
        id: 0x2::object::UID,
        launch_fee_sui: u64,
        swap_fee_bps: u64,
        std_creator_bps: u64,
        std_platform_bps: u64,
        std_pit_bps: u64,
        refl_reflection_bps: u64,
        refl_creator_bps: u64,
        refl_pit_bps: u64,
        refl_platform_bps: u64,
        graduation_sui: u64,
        graduation_xaum: u64,
        virtual_quote_sui: u64,
        virtual_quote_xaum: u64,
        virtual_token: u64,
        round_ms: u64,
        lp_lock_ms: u64,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        platform: 0x2::bag::Bag,
        paused: bool,
    }

    public fun assert_not_paused(arg0: &Config) {
        assert!(!arg0.paused, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::paused());
    }

    public fun assert_official_pit<T0>(arg0: &Config, arg1: &0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pit::Pit<T0>) {
        assert!(0x2::object::id<0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pit::Pit<T0>>(arg1) == official_pit_id<T0>(arg0), 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::wrong_pit());
    }

    public fun fee_split(arg0: &Config, arg1: bool, arg2: u64) : (u64, u64, u64, u64) {
        let v0 = 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::math::mul_div(arg2, arg0.swap_fee_bps, 10000);
        if (arg1) {
            (0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::math::mul_div(v0, arg0.refl_creator_bps, 10000), 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::math::mul_div(v0, arg0.refl_platform_bps, 10000), 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::math::mul_div(v0, arg0.refl_pit_bps, 10000), 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::math::mul_div(v0, arg0.refl_reflection_bps, 10000))
        } else {
            (0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::math::mul_div(v0, arg0.std_creator_bps, 10000), 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::math::mul_div(v0, arg0.std_platform_bps, 10000), 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::math::mul_div(v0, arg0.std_pit_bps, 10000), 0)
        }
    }

    public fun graduation_sui(arg0: &Config) : u64 {
        arg0.graduation_sui
    }

    public fun graduation_xaum(arg0: &Config) : u64 {
        arg0.graduation_xaum
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, @0x92a32ac7fd525f8bd37ed359423b8d7d858cad26224854dfbff1914b75ee658b);
        let v1 = Config{
            id                  : 0x2::object::new(arg0),
            launch_fee_sui      : 1000000000,
            swap_fee_bps        : 100,
            std_creator_bps     : 6000,
            std_platform_bps    : 1000,
            std_pit_bps         : 3000,
            refl_reflection_bps : 5000,
            refl_creator_bps    : 2000,
            refl_pit_bps        : 2000,
            refl_platform_bps   : 1000,
            graduation_sui      : 2000000000000,
            graduation_xaum     : 1000000000,
            virtual_quote_sui   : 30000000000,
            virtual_quote_xaum  : 100000000,
            virtual_token       : 800000000000000000,
            round_ms            : 86400000,
            lp_lock_ms          : 15552000000,
            treasury            : 0x2::balance::zero<0x2::sui::SUI>(),
            platform            : 0x2::bag::new(arg0),
            paused              : false,
        };
        0x2::transfer::share_object<Config>(v1);
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pit::create_and_share<0x2::sui::SUI>(arg0);
    }

    public fun instant_virtual_quote<T0>(arg0: &Config) : u64 {
        let v0 = InstantVirtualQuoteKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists<InstantVirtualQuoteKey<T0>>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<InstantVirtualQuoteKey<T0>, u64>(&arg0.id, v0)
        } else if (0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
            1000000000
        } else {
            10000000
        }
    }

    public fun launch_fee_sui(arg0: &Config) : u64 {
        arg0.launch_fee_sui
    }

    public fun lp_lock_ms(arg0: &Config) : u64 {
        arg0.lp_lock_ms
    }

    public fun official_pit_id<T0>(arg0: &Config) : 0x2::object::ID {
        let v0 = OfficialPitKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists<OfficialPitKey<T0>>(&arg0.id, v0), 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::pit_not_registered());
        *0x2::dynamic_field::borrow<OfficialPitKey<T0>, 0x2::object::ID>(&arg0.id, v0)
    }

    public fun paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun platform_value<T0>(arg0: &Config) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.platform, v0)) {
            0
        } else {
            0x2::balance::value<T0>(&0x2::bag::borrow<0x1::type_name::TypeName, StoredQuote<T0>>(&arg0.platform, v0).inner)
        }
    }

    public fun platform_wallet() : address {
        @0x92a32ac7fd525f8bd37ed359423b8d7d858cad26224854dfbff1914b75ee658b
    }

    public fun quote_params<T0>(arg0: &Config) : (u64, u64) {
        if (0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
            (arg0.virtual_quote_sui, arg0.graduation_sui)
        } else {
            (arg0.virtual_quote_xaum, arg0.graduation_xaum)
        }
    }

    public fun refl_creator_bps(arg0: &Config) : u64 {
        arg0.refl_creator_bps
    }

    public fun refl_pit_bps(arg0: &Config) : u64 {
        arg0.refl_pit_bps
    }

    public fun refl_platform_bps(arg0: &Config) : u64 {
        arg0.refl_platform_bps
    }

    public fun refl_reflection_bps(arg0: &Config) : u64 {
        arg0.refl_reflection_bps
    }

    public fun register_pit<T0>(arg0: &mut Config, arg1: &AdminCap, arg2: &0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pit::Pit<T0>) {
        set_official_pit<T0>(arg0, 0x2::object::id<0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pit::Pit<T0>>(arg2));
    }

    public fun round_ms(arg0: &Config) : u64 {
        arg0.round_ms
    }

    public fun set_graduation_sui(arg0: &mut Config, arg1: &AdminCap, arg2: u64) {
        arg0.graduation_sui = arg2;
    }

    public fun set_graduation_xaum(arg0: &mut Config, arg1: &AdminCap, arg2: u64) {
        arg0.graduation_xaum = arg2;
    }

    public fun set_instant_virtual_quote<T0>(arg0: &mut Config, arg1: &AdminCap, arg2: u64) {
        assert!(arg2 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::zero_amount());
        let v0 = InstantVirtualQuoteKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists<InstantVirtualQuoteKey<T0>>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<InstantVirtualQuoteKey<T0>, u64>(&mut arg0.id, v0) = arg2;
        } else {
            0x2::dynamic_field::add<InstantVirtualQuoteKey<T0>, u64>(&mut arg0.id, v0, arg2);
        };
    }

    public fun set_launch_fee_sui(arg0: &mut Config, arg1: &AdminCap, arg2: u64) {
        arg0.launch_fee_sui = arg2;
    }

    public fun set_lp_lock_ms(arg0: &mut Config, arg1: &AdminCap, arg2: u64) {
        arg0.lp_lock_ms = arg2;
    }

    fun set_official_pit<T0>(arg0: &mut Config, arg1: 0x2::object::ID) {
        let v0 = OfficialPitKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists<OfficialPitKey<T0>>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<OfficialPitKey<T0>, 0x2::object::ID>(&mut arg0.id, v0) = arg1;
        } else {
            0x2::dynamic_field::add<OfficialPitKey<T0>, 0x2::object::ID>(&mut arg0.id, v0, arg1);
        };
    }

    public fun set_paused(arg0: &mut Config, arg1: &AdminCap, arg2: bool) {
        arg0.paused = arg2;
    }

    public fun set_refl_split(arg0: &mut Config, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        assert!(arg2 + arg3 + arg4 + arg5 == 10000, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::invalid_fee());
        arg0.refl_reflection_bps = arg2;
        arg0.refl_creator_bps = arg3;
        arg0.refl_pit_bps = arg4;
        arg0.refl_platform_bps = arg5;
    }

    public fun set_round_ms(arg0: &mut Config, arg1: &AdminCap, arg2: u64) {
        arg0.round_ms = arg2;
    }

    public fun set_std_split(arg0: &mut Config, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg2 + arg3 + arg4 == 10000, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::invalid_fee());
        arg0.std_creator_bps = arg2;
        arg0.std_platform_bps = arg3;
        arg0.std_pit_bps = arg4;
    }

    public fun set_swap_fee_bps(arg0: &mut Config, arg1: &AdminCap, arg2: u64) {
        assert!(arg2 <= 10000, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::invalid_fee());
        arg0.swap_fee_bps = arg2;
    }

    public fun set_virtual_quote_sui(arg0: &mut Config, arg1: &AdminCap, arg2: u64) {
        arg0.virtual_quote_sui = arg2;
    }

    public fun set_virtual_quote_xaum(arg0: &mut Config, arg1: &AdminCap, arg2: u64) {
        arg0.virtual_quote_xaum = arg2;
    }

    public fun set_virtual_token(arg0: &mut Config, arg1: &AdminCap, arg2: u64) {
        arg0.virtual_token = arg2;
    }

    public fun std_creator_bps(arg0: &Config) : u64 {
        arg0.std_creator_bps
    }

    public fun std_pit_bps(arg0: &Config) : u64 {
        arg0.std_pit_bps
    }

    public fun std_platform_bps(arg0: &Config) : u64 {
        arg0.std_platform_bps
    }

    public fun swap_fee_bps(arg0: &Config) : u64 {
        arg0.swap_fee_bps
    }

    public fun take_launch_fee(arg0: &mut Config, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(!arg0.paused, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::paused());
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.launch_fee_sui, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::invalid_fee());
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun take_platform<T0>(arg0: &mut Config, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.platform, v0)) {
            0x2::balance::join<T0>(&mut 0x2::bag::borrow_mut<0x1::type_name::TypeName, StoredQuote<T0>>(&mut arg0.platform, v0).inner, arg1);
        } else {
            let v1 = StoredQuote<T0>{inner: arg1};
            0x2::bag::add<0x1::type_name::TypeName, StoredQuote<T0>>(&mut arg0.platform, v0, v1);
        };
    }

    public fun treasury_value(arg0: &Config) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
    }

    public fun virtual_quote_sui(arg0: &Config) : u64 {
        arg0.virtual_quote_sui
    }

    public fun virtual_quote_xaum(arg0: &Config) : u64 {
        arg0.virtual_quote_xaum
    }

    public fun virtual_token(arg0: &Config) : u64 {
        arg0.virtual_token
    }

    public fun withdraw_platform<T0>(arg0: &mut Config, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut 0x2::bag::borrow_mut<0x1::type_name::TypeName, StoredQuote<T0>>(&mut arg0.platform, 0x1::type_name::with_defining_ids<T0>()).inner, arg2), arg3)
    }

    public fun withdraw_treasury(arg0: &mut Config, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

