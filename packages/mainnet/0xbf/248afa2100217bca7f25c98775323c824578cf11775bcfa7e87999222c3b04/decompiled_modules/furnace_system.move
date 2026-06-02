module 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::furnace_system {
    struct FURNACE_SYSTEM has drop {
        dummy_field: bool,
    }

    struct FurnaceConfig has key {
        id: 0x2::object::UID,
        version: u64,
        crystal_r: u64,
        crystal_sr: u64,
        crystal_ssr: u64,
        alb_tax_r: u64,
        alb_tax_sr: u64,
        alb_tax_ssr: u64,
        wildcard_price_r: u64,
        wildcard_price_sr: u64,
        wildcard_price_ssr: u64,
        wildcard_limit_r: u64,
        wildcard_limit_sr: u64,
        wildcard_limit_ssr: u64,
        wildcard_image_r: 0x2::url::Url,
        wildcard_image_sr: 0x2::url::Url,
        wildcard_image_ssr: 0x2::url::Url,
        exclusive_game_id: u64,
        exclusive_price: u64,
        exclusive_founders_price: u64,
        founders_end_timestamp: u64,
        founders_max_redemptions: u64,
        batch_limit: u64,
        is_paused: bool,
    }

    struct FurnaceStats has key {
        id: 0x2::object::UID,
        version: u64,
        total_cards_smelted: u64,
        total_crystals_issued: u64,
        total_alb_burned: u64,
        current_exclusive_redeemed: u64,
        total_wildcards_minted: u64,
    }

    struct CrystalBalance has key {
        id: 0x2::object::UID,
        user: address,
        balance: u64,
        total_earned: u64,
        total_spent: u64,
        exclusives_purchased: 0x2::vec_map::VecMap<u64, bool>,
        wildcard_r_month: u64,
        wildcard_sr_month: u64,
        wildcard_ssr_month: u64,
        current_month: u64,
    }

    struct SmeltEvent has copy, drop {
        owner: address,
        character_game_id: u64,
        rarity: u8,
        crystals_earned: u64,
        alb_burned: u64,
    }

    struct BatchSmeltEvent has copy, drop {
        owner: address,
        count: u64,
        total_crystals: u64,
        total_alb_burned: u64,
    }

    struct WildcardPurchaseEvent has copy, drop {
        owner: address,
        rarity: u8,
        crystal_cost: u64,
        wildcard_id: 0x2::object::ID,
    }

    struct ExclusivePurchaseEvent has copy, drop {
        owner: address,
        game_id: u64,
        crystal_cost: u64,
        character_id: 0x2::object::ID,
        is_founders_price: bool,
    }

    struct CrystalBalanceCreated has copy, drop {
        owner: address,
        balance_id: 0x2::object::ID,
    }

    struct BatchWildcardPurchaseEvent has copy, drop {
        owner: address,
        qty_r: u64,
        qty_sr: u64,
        qty_ssr: u64,
        total_crystal_cost: u64,
    }

    struct AcceleratorPurchased has copy, drop {
        wallet: address,
        count: u64,
        crystal_cost: u64,
        timestamp_ms: u64,
    }

    fun assert_config_version(arg0: &FurnaceConfig) {
        assert!(arg0.version == 1, 11);
    }

    public fun create_crystal_balance(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = CrystalBalance{
            id                   : 0x2::object::new(arg0),
            user                 : v0,
            balance              : 0,
            total_earned         : 0,
            total_spent          : 0,
            exclusives_purchased : 0x2::vec_map::empty<u64, bool>(),
            wildcard_r_month     : 0,
            wildcard_sr_month    : 0,
            wildcard_ssr_month   : 0,
            current_month        : 0,
        };
        0x2::transfer::transfer<CrystalBalance>(v1, v0);
        let v2 = CrystalBalanceCreated{
            owner      : v0,
            balance_id : 0x2::object::id<CrystalBalance>(&v1),
        };
        0x2::event::emit<CrystalBalanceCreated>(v2);
    }

    public(friend) fun crystal_balance_owner(arg0: &CrystalBalance) : address {
        arg0.user
    }

    public fun furnace_config_version(arg0: &FurnaceConfig) : u64 {
        arg0.version
    }

    public fun furnace_stats_version(arg0: &FurnaceStats) : u64 {
        arg0.version
    }

    fun get_alb_tax(arg0: &FurnaceConfig, arg1: u8) : u64 {
        if (arg1 == 1) {
            arg0.alb_tax_r
        } else if (arg1 == 2) {
            arg0.alb_tax_sr
        } else {
            assert!(arg1 == 3, 9);
            arg0.alb_tax_ssr
        }
    }

    fun get_crystal_yield(arg0: &FurnaceConfig, arg1: u8) : u64 {
        if (arg1 == 1) {
            arg0.crystal_r
        } else if (arg1 == 2) {
            arg0.crystal_sr
        } else {
            assert!(arg1 == 3, 9);
            arg0.crystal_ssr
        }
    }

    fun get_monthly_count(arg0: &CrystalBalance, arg1: u8) : u64 {
        if (arg1 == 1) {
            arg0.wildcard_r_month
        } else if (arg1 == 2) {
            arg0.wildcard_sr_month
        } else {
            arg0.wildcard_ssr_month
        }
    }

    fun get_wildcard_image(arg0: &FurnaceConfig, arg1: u8) : 0x2::url::Url {
        if (arg1 == 1) {
            arg0.wildcard_image_r
        } else if (arg1 == 2) {
            arg0.wildcard_image_sr
        } else {
            assert!(arg1 == 3, 9);
            arg0.wildcard_image_ssr
        }
    }

    fun get_wildcard_limit(arg0: &FurnaceConfig, arg1: u8) : u64 {
        if (arg1 == 1) {
            arg0.wildcard_limit_r
        } else if (arg1 == 2) {
            arg0.wildcard_limit_sr
        } else {
            assert!(arg1 == 3, 9);
            arg0.wildcard_limit_ssr
        }
    }

    fun get_wildcard_price(arg0: &FurnaceConfig, arg1: u8) : u64 {
        if (arg1 == 1) {
            arg0.wildcard_price_r
        } else if (arg1 == 2) {
            arg0.wildcard_price_sr
        } else {
            assert!(arg1 == 3, 9);
            arg0.wildcard_price_ssr
        }
    }

    fun increment_monthly_count(arg0: &mut CrystalBalance, arg1: u8) {
        if (arg1 == 1) {
            arg0.wildcard_r_month = arg0.wildcard_r_month + 1;
        } else if (arg1 == 2) {
            arg0.wildcard_sr_month = arg0.wildcard_sr_month + 1;
        } else {
            arg0.wildcard_ssr_month = arg0.wildcard_ssr_month + 1;
        };
    }

    fun init(arg0: FURNACE_SYSTEM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::url::new_unsafe_from_bytes(b"https://img.albuspaths.com/wildcards/placeholder.png");
        let v1 = FurnaceConfig{
            id                       : 0x2::object::new(arg1),
            version                  : 1,
            crystal_r                : 3,
            crystal_sr               : 20,
            crystal_ssr              : 100,
            alb_tax_r                : 2000000000,
            alb_tax_sr               : 10000000000,
            alb_tax_ssr              : 50000000000,
            wildcard_price_r         : 15,
            wildcard_price_sr        : 150,
            wildcard_price_ssr       : 800,
            wildcard_limit_r         : 5,
            wildcard_limit_sr        : 2,
            wildcard_limit_ssr       : 1,
            wildcard_image_r         : v0,
            wildcard_image_sr        : v0,
            wildcard_image_ssr       : v0,
            exclusive_game_id        : 0,
            exclusive_price          : 1500,
            exclusive_founders_price : 1200,
            founders_end_timestamp   : 0,
            founders_max_redemptions : 100,
            batch_limit              : 20,
            is_paused                : true,
        };
        0x2::transfer::share_object<FurnaceConfig>(v1);
        let v2 = FurnaceStats{
            id                         : 0x2::object::new(arg1),
            version                    : 1,
            total_cards_smelted        : 0,
            total_crystals_issued      : 0,
            total_alb_burned           : 0,
            current_exclusive_redeemed : 0,
            total_wildcards_minted     : 0,
        };
        0x2::transfer::share_object<FurnaceStats>(v2);
    }

    fun maybe_reset_monthly(arg0: &mut CrystalBalance, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000 / 86400;
        let v1 = (1970 + v0 / 365) * 100 + v0 % 365 / 30 + 1;
        if (v1 != arg0.current_month) {
            arg0.wildcard_r_month = 0;
            arg0.wildcard_sr_month = 0;
            arg0.wildcard_ssr_month = 0;
            arg0.current_month = v1;
        };
    }

    public fun migrate_furnace_config(arg0: &0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::CharacterAdminCap, arg1: &mut FurnaceConfig) {
        assert!(arg1.version < 1, 12);
        arg1.version = 1;
    }

    public fun migrate_furnace_stats(arg0: &0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::CharacterAdminCap, arg1: &mut FurnaceStats) {
        assert!(arg1.version < 1, 12);
        arg1.version = 1;
    }

    public fun pause_furnace(arg0: &0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::CharacterAdminCap, arg1: &mut FurnaceConfig) {
        assert_config_version(arg1);
        arg1.is_paused = true;
    }

    public fun purchase_exclusive(arg0: &mut CrystalBalance, arg1: &FurnaceConfig, arg2: &mut FurnaceStats, arg3: &0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::TemplateRegistry, arg4: &mut 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::GlobalGameState, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.user == 0x2::tx_context::sender(arg6), 1);
        assert_config_version(arg1);
        assert!(!arg1.is_paused, 2);
        assert!(arg1.exclusive_game_id > 0, 2);
        assert!(!0x2::vec_map::contains<u64, bool>(&arg0.exclusives_purchased, &arg1.exclusive_game_id), 8);
        let v0 = 0x2::clock::timestamp_ms(arg5) < arg1.founders_end_timestamp && arg2.current_exclusive_redeemed < arg1.founders_max_redemptions;
        let v1 = if (v0) {
            arg1.exclusive_founders_price
        } else {
            arg1.exclusive_price
        };
        assert!(arg0.balance >= v1, 6);
        arg0.balance = arg0.balance - v1;
        arg0.total_spent = arg0.total_spent + v1;
        0x2::vec_map::insert<u64, bool>(&mut arg0.exclusives_purchased, arg1.exclusive_game_id, true);
        let v2 = 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::create_character_from_template(arg4, 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::get_template_by_id(arg3, arg1.exclusive_game_id), 3, arg6);
        0x2::transfer::public_transfer<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::Character>(v2, 0x2::tx_context::sender(arg6));
        arg2.current_exclusive_redeemed = arg2.current_exclusive_redeemed + 1;
        let v3 = ExclusivePurchaseEvent{
            owner             : 0x2::tx_context::sender(arg6),
            game_id           : arg1.exclusive_game_id,
            crystal_cost      : v1,
            character_id      : 0x2::object::id<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::Character>(&v2),
            is_founders_price : v0,
        };
        0x2::event::emit<ExclusivePurchaseEvent>(v3);
    }

    public fun purchase_purification_accelerator(arg0: &mut CrystalBalance, arg1: &FurnaceConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.user == 0x2::tx_context::sender(arg3), 1);
        assert_config_version(arg1);
        assert!(!arg1.is_paused, 2);
        assert!(arg0.balance >= 15, 6);
        arg0.balance = arg0.balance - 15;
        arg0.total_spent = arg0.total_spent + 15;
        let v0 = AcceleratorPurchased{
            wallet       : 0x2::tx_context::sender(arg3),
            count        : 1,
            crystal_cost : 15,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<AcceleratorPurchased>(v0);
    }

    public fun purchase_wildcard(arg0: &mut CrystalBalance, arg1: &FurnaceConfig, arg2: &mut FurnaceStats, arg3: &mut 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::fragment_system::GlobalFragmentState, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.user == 0x2::tx_context::sender(arg6), 1);
        assert_config_version(arg1);
        assert!(!arg1.is_paused, 2);
        assert!(arg4 >= 1 && arg4 <= 3, 9);
        maybe_reset_monthly(arg0, arg5);
        assert!(get_monthly_count(arg0, arg4) < get_wildcard_limit(arg1, arg4), 7);
        let v0 = get_wildcard_price(arg1, arg4);
        assert!(arg0.balance >= v0, 6);
        arg0.balance = arg0.balance - v0;
        arg0.total_spent = arg0.total_spent + v0;
        increment_monthly_count(arg0, arg4);
        let v1 = 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::fragment_system::mint_wildcard(arg4, get_wildcard_image(arg1, arg4), arg3, arg5, arg6);
        0x2::transfer::public_transfer<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::fragment_system::UniversalWildcard>(v1, 0x2::tx_context::sender(arg6));
        arg2.total_wildcards_minted = arg2.total_wildcards_minted + 1;
        let v2 = WildcardPurchaseEvent{
            owner        : 0x2::tx_context::sender(arg6),
            rarity       : arg4,
            crystal_cost : v0,
            wildcard_id  : 0x2::object::id<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::fragment_system::UniversalWildcard>(&v1),
        };
        0x2::event::emit<WildcardPurchaseEvent>(v2);
    }

    public fun purchase_wildcard_batch(arg0: &mut CrystalBalance, arg1: &FurnaceConfig, arg2: &mut FurnaceStats, arg3: &mut 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::fragment_system::GlobalFragmentState, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.user == 0x2::tx_context::sender(arg8), 1);
        assert_config_version(arg1);
        assert!(!arg1.is_paused, 2);
        assert!(arg4 + arg5 + arg6 > 0, 10);
        maybe_reset_monthly(arg0, arg7);
        assert!(get_monthly_count(arg0, 1) + arg4 <= get_wildcard_limit(arg1, 1), 7);
        assert!(get_monthly_count(arg0, 2) + arg5 <= get_wildcard_limit(arg1, 2), 7);
        assert!(get_monthly_count(arg0, 3) + arg6 <= get_wildcard_limit(arg1, 3), 7);
        let v0 = arg4 * get_wildcard_price(arg1, 1) + arg5 * get_wildcard_price(arg1, 2) + arg6 * get_wildcard_price(arg1, 3);
        assert!(arg0.balance >= v0, 6);
        arg0.balance = arg0.balance - v0;
        arg0.total_spent = arg0.total_spent + v0;
        let v1 = 0;
        while (v1 < arg4) {
            let v2 = 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::fragment_system::mint_wildcard(1, get_wildcard_image(arg1, 1), arg3, arg7, arg8);
            0x2::transfer::public_transfer<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::fragment_system::UniversalWildcard>(v2, 0x2::tx_context::sender(arg8));
            increment_monthly_count(arg0, 1);
            arg2.total_wildcards_minted = arg2.total_wildcards_minted + 1;
            let v3 = WildcardPurchaseEvent{
                owner        : 0x2::tx_context::sender(arg8),
                rarity       : 1,
                crystal_cost : get_wildcard_price(arg1, 1),
                wildcard_id  : 0x2::object::id<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::fragment_system::UniversalWildcard>(&v2),
            };
            0x2::event::emit<WildcardPurchaseEvent>(v3);
            v1 = v1 + 1;
        };
        v1 = 0;
        while (v1 < arg5) {
            let v4 = 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::fragment_system::mint_wildcard(2, get_wildcard_image(arg1, 2), arg3, arg7, arg8);
            0x2::transfer::public_transfer<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::fragment_system::UniversalWildcard>(v4, 0x2::tx_context::sender(arg8));
            increment_monthly_count(arg0, 2);
            arg2.total_wildcards_minted = arg2.total_wildcards_minted + 1;
            let v5 = WildcardPurchaseEvent{
                owner        : 0x2::tx_context::sender(arg8),
                rarity       : 2,
                crystal_cost : get_wildcard_price(arg1, 2),
                wildcard_id  : 0x2::object::id<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::fragment_system::UniversalWildcard>(&v4),
            };
            0x2::event::emit<WildcardPurchaseEvent>(v5);
            v1 = v1 + 1;
        };
        v1 = 0;
        while (v1 < arg6) {
            let v6 = 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::fragment_system::mint_wildcard(3, get_wildcard_image(arg1, 3), arg3, arg7, arg8);
            0x2::transfer::public_transfer<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::fragment_system::UniversalWildcard>(v6, 0x2::tx_context::sender(arg8));
            increment_monthly_count(arg0, 3);
            arg2.total_wildcards_minted = arg2.total_wildcards_minted + 1;
            let v7 = WildcardPurchaseEvent{
                owner        : 0x2::tx_context::sender(arg8),
                rarity       : 3,
                crystal_cost : get_wildcard_price(arg1, 3),
                wildcard_id  : 0x2::object::id<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::fragment_system::UniversalWildcard>(&v6),
            };
            0x2::event::emit<WildcardPurchaseEvent>(v7);
            v1 = v1 + 1;
        };
        let v8 = BatchWildcardPurchaseEvent{
            owner              : 0x2::tx_context::sender(arg8),
            qty_r              : arg4,
            qty_sr             : arg5,
            qty_ssr            : arg6,
            total_crystal_cost : v0,
        };
        0x2::event::emit<BatchWildcardPurchaseEvent>(v8);
    }

    public fun set_exclusive_character(arg0: &0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::CharacterAdminCap, arg1: &mut FurnaceConfig, arg2: &mut FurnaceStats, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        assert_config_version(arg1);
        arg1.exclusive_game_id = arg3;
        arg1.exclusive_price = arg4;
        arg1.exclusive_founders_price = arg5;
        arg1.founders_end_timestamp = arg6;
        arg1.founders_max_redemptions = arg7;
        arg2.current_exclusive_redeemed = 0;
    }

    public fun smelt_and_purchase_exclusive(arg0: &mut CrystalBalance, arg1: &FurnaceConfig, arg2: &mut FurnaceStats, arg3: &mut 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::TokenTreasury, arg4: &0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::TemplateRegistry, arg5: &mut 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::GlobalGameState, arg6: vector<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::Character>, arg7: 0x2::coin::Coin<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::ALB_TOKEN>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.user == 0x2::tx_context::sender(arg9), 1);
        assert_config_version(arg1);
        assert!(!arg1.is_paused, 2);
        assert!(arg1.exclusive_game_id > 0, 2);
        let v0 = 0x1::vector::length<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::Character>(&arg6);
        assert!(v0 > 0, 10);
        assert!(v0 <= arg1.batch_limit, 5);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0x1::vector::borrow<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::Character>(&arg6, v2);
            assert!(!0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::get_is_awakened(v3), 3);
            v1 = v1 + get_alb_tax(arg1, 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::get_rarity(v3));
            v2 = v2 + 1;
        };
        assert!(0x2::coin::value<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::ALB_TOKEN>(&arg7) >= v1, 4);
        let v4 = 0;
        while (!0x1::vector::is_empty<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::Character>(&arg6)) {
            let (v5, v6) = 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::burn_character(0x1::vector::pop_back<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::Character>(&mut arg6), arg9);
            let v7 = get_crystal_yield(arg1, v6);
            v4 = v4 + v7;
            let v8 = SmeltEvent{
                owner             : 0x2::tx_context::sender(arg9),
                character_game_id : v5,
                rarity            : v6,
                crystals_earned   : v7,
                alb_burned        : get_alb_tax(arg1, v6),
            };
            0x2::event::emit<SmeltEvent>(v8);
        };
        0x1::vector::destroy_empty<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::Character>(arg6);
        0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::route_alb_tax(arg3, arg7, arg9);
        arg0.balance = arg0.balance + v4;
        arg0.total_earned = arg0.total_earned + v4;
        arg2.total_cards_smelted = arg2.total_cards_smelted + v0;
        arg2.total_crystals_issued = arg2.total_crystals_issued + v4;
        arg2.total_alb_burned = arg2.total_alb_burned + v1;
        let v9 = BatchSmeltEvent{
            owner            : 0x2::tx_context::sender(arg9),
            count            : v0,
            total_crystals   : v4,
            total_alb_burned : v1,
        };
        0x2::event::emit<BatchSmeltEvent>(v9);
        assert!(!0x2::vec_map::contains<u64, bool>(&arg0.exclusives_purchased, &arg1.exclusive_game_id), 8);
        let v10 = 0x2::clock::timestamp_ms(arg8) < arg1.founders_end_timestamp && arg2.current_exclusive_redeemed < arg1.founders_max_redemptions;
        let v11 = if (v10) {
            arg1.exclusive_founders_price
        } else {
            arg1.exclusive_price
        };
        assert!(arg0.balance >= v11, 6);
        arg0.balance = arg0.balance - v11;
        arg0.total_spent = arg0.total_spent + v11;
        0x2::vec_map::insert<u64, bool>(&mut arg0.exclusives_purchased, arg1.exclusive_game_id, true);
        let v12 = 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::create_character_from_template(arg5, 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::get_template_by_id(arg4, arg1.exclusive_game_id), 3, arg9);
        0x2::transfer::public_transfer<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::Character>(v12, 0x2::tx_context::sender(arg9));
        arg2.current_exclusive_redeemed = arg2.current_exclusive_redeemed + 1;
        let v13 = ExclusivePurchaseEvent{
            owner             : 0x2::tx_context::sender(arg9),
            game_id           : arg1.exclusive_game_id,
            crystal_cost      : v11,
            character_id      : 0x2::object::id<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::Character>(&v12),
            is_founders_price : v10,
        };
        0x2::event::emit<ExclusivePurchaseEvent>(v13);
    }

    public fun smelt_and_purchase_wildcard(arg0: &mut CrystalBalance, arg1: &FurnaceConfig, arg2: &mut FurnaceStats, arg3: &mut 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::TokenTreasury, arg4: &mut 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::fragment_system::GlobalFragmentState, arg5: vector<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::Character>, arg6: 0x2::coin::Coin<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::ALB_TOKEN>, arg7: u8, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.user == 0x2::tx_context::sender(arg10), 1);
        assert_config_version(arg1);
        assert!(!arg1.is_paused, 2);
        assert!(arg7 >= 1 && arg7 <= 3, 9);
        assert!(arg8 > 0, 10);
        let v0 = 0x1::vector::length<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::Character>(&arg5);
        assert!(v0 > 0, 10);
        assert!(v0 <= arg1.batch_limit, 5);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0x1::vector::borrow<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::Character>(&arg5, v2);
            assert!(!0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::get_is_awakened(v3), 3);
            v1 = v1 + get_alb_tax(arg1, 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::get_rarity(v3));
            v2 = v2 + 1;
        };
        assert!(0x2::coin::value<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::ALB_TOKEN>(&arg6) >= v1, 4);
        let v4 = 0;
        while (!0x1::vector::is_empty<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::Character>(&arg5)) {
            let (v5, v6) = 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::burn_character(0x1::vector::pop_back<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::Character>(&mut arg5), arg10);
            let v7 = get_crystal_yield(arg1, v6);
            v4 = v4 + v7;
            let v8 = SmeltEvent{
                owner             : 0x2::tx_context::sender(arg10),
                character_game_id : v5,
                rarity            : v6,
                crystals_earned   : v7,
                alb_burned        : get_alb_tax(arg1, v6),
            };
            0x2::event::emit<SmeltEvent>(v8);
        };
        0x1::vector::destroy_empty<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::Character>(arg5);
        0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::route_alb_tax(arg3, arg6, arg10);
        arg0.balance = arg0.balance + v4;
        arg0.total_earned = arg0.total_earned + v4;
        arg2.total_cards_smelted = arg2.total_cards_smelted + v0;
        arg2.total_crystals_issued = arg2.total_crystals_issued + v4;
        arg2.total_alb_burned = arg2.total_alb_burned + v1;
        let v9 = BatchSmeltEvent{
            owner            : 0x2::tx_context::sender(arg10),
            count            : v0,
            total_crystals   : v4,
            total_alb_burned : v1,
        };
        0x2::event::emit<BatchSmeltEvent>(v9);
        maybe_reset_monthly(arg0, arg9);
        assert!(get_monthly_count(arg0, arg7) + arg8 <= get_wildcard_limit(arg1, arg7), 7);
        let v10 = arg8 * get_wildcard_price(arg1, arg7);
        assert!(arg0.balance >= v10, 6);
        arg0.balance = arg0.balance - v10;
        arg0.total_spent = arg0.total_spent + v10;
        v2 = 0;
        while (v2 < arg8) {
            let v11 = 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::fragment_system::mint_wildcard(arg7, get_wildcard_image(arg1, arg7), arg4, arg9, arg10);
            0x2::transfer::public_transfer<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::fragment_system::UniversalWildcard>(v11, 0x2::tx_context::sender(arg10));
            increment_monthly_count(arg0, arg7);
            arg2.total_wildcards_minted = arg2.total_wildcards_minted + 1;
            let v12 = WildcardPurchaseEvent{
                owner        : 0x2::tx_context::sender(arg10),
                rarity       : arg7,
                crystal_cost : get_wildcard_price(arg1, arg7),
                wildcard_id  : 0x2::object::id<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::fragment_system::UniversalWildcard>(&v11),
            };
            0x2::event::emit<WildcardPurchaseEvent>(v12);
            v2 = v2 + 1;
        };
    }

    public fun smelt_batch(arg0: &mut CrystalBalance, arg1: &FurnaceConfig, arg2: &mut FurnaceStats, arg3: &mut 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::TokenTreasury, arg4: vector<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::Character>, arg5: 0x2::coin::Coin<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::ALB_TOKEN>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::Character>(&arg4);
        assert!(v0 > 0, 10);
        assert!(v0 <= arg1.batch_limit, 5);
        assert!(arg0.user == 0x2::tx_context::sender(arg6), 1);
        assert_config_version(arg1);
        assert!(!arg1.is_paused, 2);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0x1::vector::borrow<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::Character>(&arg4, v2);
            assert!(!0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::get_is_awakened(v3), 3);
            v1 = v1 + get_alb_tax(arg1, 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::get_rarity(v3));
            v2 = v2 + 1;
        };
        assert!(0x2::coin::value<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::ALB_TOKEN>(&arg5) >= v1, 4);
        let v4 = 0;
        while (!0x1::vector::is_empty<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::Character>(&arg4)) {
            let (v5, v6) = 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::burn_character(0x1::vector::pop_back<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::Character>(&mut arg4), arg6);
            let v7 = get_crystal_yield(arg1, v6);
            v4 = v4 + v7;
            let v8 = SmeltEvent{
                owner             : 0x2::tx_context::sender(arg6),
                character_game_id : v5,
                rarity            : v6,
                crystals_earned   : v7,
                alb_burned        : get_alb_tax(arg1, v6),
            };
            0x2::event::emit<SmeltEvent>(v8);
        };
        0x1::vector::destroy_empty<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::Character>(arg4);
        0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::route_alb_tax(arg3, arg5, arg6);
        arg0.balance = arg0.balance + v4;
        arg0.total_earned = arg0.total_earned + v4;
        arg2.total_cards_smelted = arg2.total_cards_smelted + v0;
        arg2.total_crystals_issued = arg2.total_crystals_issued + v4;
        arg2.total_alb_burned = arg2.total_alb_burned + v1;
        let v9 = BatchSmeltEvent{
            owner            : 0x2::tx_context::sender(arg6),
            count            : v0,
            total_crystals   : v4,
            total_alb_burned : v1,
        };
        0x2::event::emit<BatchSmeltEvent>(v9);
    }

    public fun smelt_single(arg0: &mut CrystalBalance, arg1: &FurnaceConfig, arg2: &mut FurnaceStats, arg3: &mut 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::TokenTreasury, arg4: 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::Character, arg5: 0x2::coin::Coin<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::ALB_TOKEN>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.user == 0x2::tx_context::sender(arg6), 1);
        assert_config_version(arg1);
        assert!(!arg1.is_paused, 2);
        let v0 = get_alb_tax(arg1, 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::get_rarity(&arg4));
        assert!(0x2::coin::value<0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::ALB_TOKEN>(&arg5) >= v0, 4);
        let (v1, v2) = 0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::character_system::burn_character(arg4, arg6);
        0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::alb_token::route_alb_tax(arg3, arg5, arg6);
        let v3 = get_crystal_yield(arg1, v2);
        arg0.balance = arg0.balance + v3;
        arg0.total_earned = arg0.total_earned + v3;
        arg2.total_cards_smelted = arg2.total_cards_smelted + 1;
        arg2.total_crystals_issued = arg2.total_crystals_issued + v3;
        arg2.total_alb_burned = arg2.total_alb_burned + v0;
        let v4 = SmeltEvent{
            owner             : 0x2::tx_context::sender(arg6),
            character_game_id : v1,
            rarity            : v2,
            crystals_earned   : v3,
            alb_burned        : v0,
        };
        0x2::event::emit<SmeltEvent>(v4);
    }

    public(friend) fun spend_crystals(arg0: &mut CrystalBalance, arg1: u64) {
        assert!(arg0.balance >= arg1, 6);
        arg0.balance = arg0.balance - arg1;
        arg0.total_spent = arg0.total_spent + arg1;
    }

    public fun unpause_furnace(arg0: &0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::CharacterAdminCap, arg1: &mut FurnaceConfig) {
        assert_config_version(arg1);
        arg1.is_paused = false;
    }

    public fun update_batch_limit(arg0: &0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::CharacterAdminCap, arg1: &mut FurnaceConfig, arg2: u64) {
        assert_config_version(arg1);
        arg1.batch_limit = arg2;
    }

    public fun update_smelt_config(arg0: &0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::CharacterAdminCap, arg1: &mut FurnaceConfig, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        assert_config_version(arg1);
        arg1.crystal_r = arg2;
        arg1.crystal_sr = arg3;
        arg1.crystal_ssr = arg4;
        arg1.alb_tax_r = arg5;
        arg1.alb_tax_sr = arg6;
        arg1.alb_tax_ssr = arg7;
    }

    public fun update_wildcard_config(arg0: &0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::CharacterAdminCap, arg1: &mut FurnaceConfig, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        assert_config_version(arg1);
        arg1.wildcard_price_r = arg2;
        arg1.wildcard_price_sr = arg3;
        arg1.wildcard_price_ssr = arg4;
        arg1.wildcard_limit_r = arg5;
        arg1.wildcard_limit_sr = arg6;
        arg1.wildcard_limit_ssr = arg7;
    }

    public fun update_wildcard_images(arg0: &0xbf248afa2100217bca7f25c98775323c824578cf11775bcfa7e87999222c3b04::game_core::CharacterAdminCap, arg1: &mut FurnaceConfig, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) {
        assert_config_version(arg1);
        arg1.wildcard_image_r = 0x2::url::new_unsafe_from_bytes(arg2);
        arg1.wildcard_image_sr = 0x2::url::new_unsafe_from_bytes(arg3);
        arg1.wildcard_image_ssr = 0x2::url::new_unsafe_from_bytes(arg4);
    }

    // decompiled from Move bytecode v6
}

