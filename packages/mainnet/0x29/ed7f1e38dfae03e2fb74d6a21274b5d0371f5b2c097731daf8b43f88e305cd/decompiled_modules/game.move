module 0x29ed7f1e38dfae03e2fb74d6a21274b5d0371f5b2c097731daf8b43f88e305cd::game {
    struct GAME has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintVault<phantom T0> has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
    }

    struct GameState has key {
        id: 0x2::object::UID,
        total_network_pressure: u64,
        total_players: u64,
        total_minted: u64,
        total_burned: u64,
        total_bublz_burned: u64,
        game_start: u64,
        paused: bool,
        sui_treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        treasury_recipient: address,
        bublz_cost: u64,
        sui_costs: vector<u64>,
        cosmetic_types: 0x2::table::Table<u64, CosmeticType>,
        next_cosmetic_id: u64,
        player_tanks: 0x2::table::Table<address, PlayerTank>,
        staked_bubblers: 0x2::table::Table<u64, StakedBubblerInfo>,
        displayed_cosmetics: 0x2::table::Table<u64, DisplayedCosmeticInfo>,
        next_bubbler_id: u64,
        next_cosmetic_instance_id: u64,
    }

    struct PlayerTank has store {
        tier: u8,
        last_upgrade_time: u64,
        staked_bubbler_ids: vector<u64>,
        displayed_cosmetic_ids: vector<u64>,
        total_pressure: u64,
        total_tank_pressure: u64,
        upgrade_levels: vector<u8>,
        last_claim_time: u64,
        total_earned: u64,
        referrer: address,
        has_referrer: bool,
    }

    struct StakedBubblerInfo has drop, store {
        owner: address,
        tier: u8,
        bubble_pressure: u64,
        tank_pressure: u64,
    }

    struct DisplayedCosmeticInfo has drop, store {
        owner: address,
        cosmetic_type_id: u64,
        bubble_pressure: u64,
    }

    struct BubbleGenerator has store, key {
        id: 0x2::object::UID,
        bubbler_id: u64,
        tier: u8,
        name: vector<u8>,
        bubble_pressure: u64,
        tank_pressure: u64,
        image_url: vector<u8>,
    }

    struct BubbleCosmetic has store, key {
        id: 0x2::object::UID,
        cosmetic_instance_id: u64,
        cosmetic_type_id: u64,
        name: vector<u8>,
        bubble_pressure: u64,
        image_url: vector<u8>,
    }

    struct CosmeticType has store {
        name: vector<u8>,
        image_url: vector<u8>,
        bub_cost: u64,
        bublz_cost: u64,
        sui_cost: u64,
        bubble_pressure: u64,
        max_supply: u64,
        minted: u64,
        per_facility: u64,
        disabled: bool,
    }

    struct TankCreated has copy, drop {
        player: address,
    }

    struct TankUpgraded has copy, drop {
        player: address,
        new_tier: u8,
    }

    struct BubblerMinted has copy, drop {
        owner: address,
        bubbler_id: u64,
        tier: u8,
        bubble_pressure: u64,
    }

    struct BubblerStaked has copy, drop {
        owner: address,
        bubbler_id: u64,
        tier: u8,
    }

    struct BubblerUnstaked has copy, drop {
        owner: address,
        bubbler_id: u64,
        tier: u8,
    }

    struct RewardsClaimed has copy, drop {
        player: address,
        amount: u64,
        burned: u64,
        referrer_reward: u64,
    }

    struct StatUpgraded has copy, drop {
        player: address,
        upgrade_type: u8,
        new_level: u8,
    }

    struct CosmeticMinted has copy, drop {
        owner: address,
        cosmetic_type_id: u64,
        name: vector<u8>,
    }

    fun apply_cooling_bonus(arg0: &PlayerTank, arg1: u64) : u64 {
        let v0 = (((arg1 as u128) * (((*0x1::vector::borrow<u8>(&arg0.upgrade_levels, 1) as u64) * 200 + (*0x1::vector::borrow<u8>(&arg0.upgrade_levels, 4) as u64) * 100) as u128) / 10000) as u64);
        if (v0 >= arg1) {
            1
        } else {
            arg1 - v0
        }
    }

    fun apply_upgrade_bonus(arg0: &PlayerTank, arg1: u64) : u64 {
        (((arg1 as u128) * ((10000 + (*0x1::vector::borrow<u8>(&arg0.upgrade_levels, 0) as u64) * 200 + (*0x1::vector::borrow<u8>(&arg0.upgrade_levels, 2) as u64) * 100 + (*0x1::vector::borrow<u8>(&arg0.upgrade_levels, 3) as u64) * 300 + (*0x1::vector::borrow<u8>(&arg0.upgrade_levels, 4) as u64) * 100) as u128) / 10000) as u64)
    }

    fun burn_bub_payment<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut GameState, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = (((0x2::balance::value<T0>(&arg0) as u128) * (8500 as u128) / (10000 as u128)) as u64);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0, v0), arg2), @0x0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1.treasury_recipient);
        arg1.total_burned = arg1.total_burned + v0;
    }

    fun calculate_current_emission(arg0: &GameState, arg1: u64) : u64 {
        let v0 = 200000000000000;
        let v1 = 0;
        while (v1 < (arg1 - arg0.game_start) / 1800000 && v0 > 0) {
            v0 = v0 / 2;
            v1 = v1 + 1;
        };
        v0
    }

    fun calculate_pending_rewards(arg0: &GameState, arg1: &PlayerTank, arg2: u64) : u64 {
        if (arg1.total_pressure == 0 || arg0.total_network_pressure == 0) {
            return 0
        };
        let v0 = ((((((calculate_current_emission(arg0, arg2) as u128) * ((arg2 - arg1.last_claim_time) as u128) / (86400000 as u128)) as u64) as u128) * (arg1.total_pressure as u128) / (arg0.total_network_pressure as u128)) as u64);
        let v1 = 20000000000000000 - arg0.total_minted;
        if (v0 > v1) {
            v1
        } else {
            v0
        }
    }

    entry fun claim_rewards<T0>(arg0: &mut GameState, arg1: &mut MintVault<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, PlayerTank>(&arg0.player_tanks, v0), 10);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0x2::table::borrow<address, PlayerTank>(&arg0.player_tanks, v0);
        let v3 = calculate_pending_rewards(arg0, v2, v1);
        assert!(v3 > 0, 20);
        assert!(arg0.total_minted + v3 <= 20000000000000000, 21);
        let v4 = v2.has_referrer;
        let v5 = if (v4) {
            750
        } else {
            1000
        };
        let v6 = (((v3 as u128) * (v5 as u128) / (10000 as u128)) as u64);
        let v7 = 0;
        if (v4) {
            v7 = (((v3 as u128) * (250 as u128) / (10000 as u128)) as u64);
        };
        let v8 = v3 - v6 - v7;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut arg1.treasury_cap, v6, arg3), @0x0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut arg1.treasury_cap, v8, arg3), v0);
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut arg1.treasury_cap, v7, arg3), v2.referrer);
        };
        arg0.total_minted = arg0.total_minted + v3;
        arg0.total_burned = arg0.total_burned + v6;
        let v9 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v0);
        v9.last_claim_time = v1;
        v9.total_earned = v9.total_earned + v8;
        let v10 = RewardsClaimed{
            player          : v0,
            amount          : v8,
            burned          : v6,
            referrer_reward : v7,
        };
        0x2::event::emit<RewardsClaimed>(v10);
    }

    entry fun create_cosmetic_type(arg0: &mut GameState, arg1: &AdminCap, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = arg0.next_cosmetic_id;
        arg0.next_cosmetic_id = v0 + 1;
        let v1 = CosmeticType{
            name            : arg2,
            image_url       : arg3,
            bub_cost        : arg4,
            bublz_cost      : arg5,
            sui_cost        : arg6,
            bubble_pressure : arg7,
            max_supply      : arg8,
            minted          : 0,
            per_facility    : arg9,
            disabled        : false,
        };
        0x2::table::add<u64, CosmeticType>(&mut arg0.cosmetic_types, v0, v1);
    }

    entry fun create_game(arg0: &AdminCap, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, 1000000);
        0x1::vector::push_back<u64>(&mut v0, 1000000);
        0x1::vector::push_back<u64>(&mut v0, 1000000);
        0x1::vector::push_back<u64>(&mut v0, 1000000);
        0x1::vector::push_back<u64>(&mut v0, 1000000);
        0x1::vector::push_back<u64>(&mut v0, 1000000);
        0x1::vector::push_back<u64>(&mut v0, 1000000);
        0x1::vector::push_back<u64>(&mut v0, 1000000);
        0x1::vector::push_back<u64>(&mut v0, 1000000);
        0x1::vector::push_back<u64>(&mut v0, 1000000);
        0x1::vector::push_back<u64>(&mut v0, 1000000);
        0x1::vector::push_back<u64>(&mut v0, 1000000);
        0x1::vector::push_back<u64>(&mut v0, 1000000);
        let v1 = GameState{
            id                        : 0x2::object::new(arg4),
            total_network_pressure    : 0,
            total_players             : 0,
            total_minted              : 0,
            total_burned              : 0,
            total_bublz_burned        : 0,
            game_start                : 0x2::clock::timestamp_ms(arg3),
            paused                    : false,
            sui_treasury              : 0x2::balance::zero<0x2::sui::SUI>(),
            treasury_recipient        : arg2,
            bublz_cost                : arg1,
            sui_costs                 : v0,
            cosmetic_types            : 0x2::table::new<u64, CosmeticType>(arg4),
            next_cosmetic_id          : 0,
            player_tanks              : 0x2::table::new<address, PlayerTank>(arg4),
            staked_bubblers           : 0x2::table::new<u64, StakedBubblerInfo>(arg4),
            displayed_cosmetics       : 0x2::table::new<u64, DisplayedCosmeticInfo>(arg4),
            next_bubbler_id           : 0,
            next_cosmetic_instance_id : 0,
        };
        0x2::transfer::share_object<GameState>(v1);
    }

    entry fun create_tank(arg0: &mut GameState, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, PlayerTank>(&arg0.player_tanks, v0), 25);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 5) {
            0x1::vector::push_back<u8>(&mut v1, 0);
            v2 = v2 + 1;
        };
        let v3 = PlayerTank{
            tier                   : 0,
            last_upgrade_time      : 0,
            staked_bubbler_ids     : 0x1::vector::empty<u64>(),
            displayed_cosmetic_ids : 0x1::vector::empty<u64>(),
            total_pressure         : 0,
            total_tank_pressure    : 0,
            upgrade_levels         : v1,
            last_claim_time        : 0x2::clock::timestamp_ms(arg1),
            total_earned           : 0,
            referrer               : @0x0,
            has_referrer           : false,
        };
        0x2::table::add<address, PlayerTank>(&mut arg0.player_tanks, v0, v3);
        arg0.total_players = arg0.total_players + 1;
        let v4 = TankCreated{player: v0};
        0x2::event::emit<TankCreated>(v4);
    }

    entry fun deposit_treasury_cap<T0>(arg0: &AdminCap, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MintVault<T0>{
            id           : 0x2::object::new(arg2),
            treasury_cap : arg1,
        };
        0x2::transfer::share_object<MintVault<T0>>(v0);
    }

    entry fun disable_cosmetic(arg0: &mut GameState, arg1: &AdminCap, arg2: u64) {
        0x2::table::borrow_mut<u64, CosmeticType>(&mut arg0.cosmetic_types, arg2).disabled = true;
    }

    entry fun display_cosmetic(arg0: &mut GameState, arg1: &BubbleCosmetic, arg2: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, PlayerTank>(&arg0.player_tanks, v0), 10);
        let v1 = 0x2::table::borrow<address, PlayerTank>(&arg0.player_tanks, v0);
        assert!(0x1::vector::length<u64>(&v1.displayed_cosmetic_ids) < get_tank_cosmetic_slots(v1.tier), 16);
        let v2 = arg1.cosmetic_instance_id;
        assert!(!0x2::table::contains<u64, DisplayedCosmeticInfo>(&arg0.displayed_cosmetics, v2), 19);
        if (0x2::table::contains<u64, CosmeticType>(&arg0.cosmetic_types, arg1.cosmetic_type_id)) {
            let v3 = 0;
            let v4 = 0;
            while (v4 < 0x1::vector::length<u64>(&v1.displayed_cosmetic_ids)) {
                let v5 = *0x1::vector::borrow<u64>(&v1.displayed_cosmetic_ids, v4);
                if (0x2::table::contains<u64, DisplayedCosmeticInfo>(&arg0.displayed_cosmetics, v5)) {
                    if (0x2::table::borrow<u64, DisplayedCosmeticInfo>(&arg0.displayed_cosmetics, v5).cosmetic_type_id == arg1.cosmetic_type_id) {
                        v3 = v3 + 1;
                    };
                };
                v4 = v4 + 1;
            };
            assert!(v3 < 0x2::table::borrow<u64, CosmeticType>(&arg0.cosmetic_types, arg1.cosmetic_type_id).per_facility, 17);
        };
        let v6 = DisplayedCosmeticInfo{
            owner            : v0,
            cosmetic_type_id : arg1.cosmetic_type_id,
            bubble_pressure  : arg1.bubble_pressure,
        };
        0x2::table::add<u64, DisplayedCosmeticInfo>(&mut arg0.displayed_cosmetics, v2, v6);
        let v7 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v0);
        0x1::vector::push_back<u64>(&mut v7.displayed_cosmetic_ids, v2);
        v7.total_pressure = v7.total_pressure + arg1.bubble_pressure;
        arg0.total_network_pressure = arg0.total_network_pressure + arg1.bubble_pressure;
    }

    entry fun emergency_withdraw(arg0: &mut GameState, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.paused, 22);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_treasury);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_treasury, v0), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    fun get_bubbler_stats(arg0: u8) : (u64, u64, u64, vector<u8>, vector<u8>) {
        if (arg0 == 0) {
            (100, 1, 0, b"Droplet", b"https://bublz.fun/bubblers/droplet.png")
        } else if (arg0 == 1) {
            (180, 6, 1000000000, b"Fizzer", b"https://bublz.fun/bubblers/fizzer.png")
        } else if (arg0 == 2) {
            (420, 8, 1000000000, b"Trickler", b"https://bublz.fun/bubblers/trickler.png")
        } else if (arg0 == 3) {
            (1000, 10, 2000000000, b"Streamer", b"https://bublz.fun/bubblers/streamer.png")
        } else if (arg0 == 4) {
            (5000, 30, 2000000000, b"Pumper", b"https://bublz.fun/bubblers/pumper.png")
        } else if (arg0 == 5) {
            (15000, 50, 3000000000, b"Jet", b"https://bublz.fun/bubblers/jet.png")
        } else if (arg0 == 6) {
            (20000, 90, 3000000000, b"Blaster", b"https://bublz.fun/bubblers/blaster.png")
        } else if (arg0 == 7) {
            (60000, 200, 5000000000, b"Geyser", b"https://bublz.fun/bubblers/geyser.png")
        } else if (arg0 == 8) {
            (120000, 400, 5000000000, b"Eruption", b"https://bublz.fun/bubblers/eruption.png")
        } else if (arg0 == 9) {
            (200000, 600, 10000000000, b"Torrent", b"https://bublz.fun/bubblers/torrent.png")
        } else {
            let (v5, v6, v7, v8, v9) = if (arg0 == 10) {
                (b"https://bublz.fun/bubblers/tsunami.png", 800000, 2000, 10000000000, b"Tsunami")
            } else {
                let (v10, v11, v12, v13, v14) = if (arg0 == 11) {
                    (1336000, 3000, 15000000000, b"Cyclone", b"https://bublz.fun/bubblers/cyclone.png")
                } else {
                    (2508000, 5000, 20000000000, b"Rift", b"https://bublz.fun/bubblers/rift.png")
                };
                (v14, v10, v11, v12, v13)
            };
            (v6, v7, v8, v9, v5)
        }
    }

    fun get_bubbler_sui_cost(arg0: u8, arg1: &vector<u64>) : u64 {
        *0x1::vector::borrow<u64>(arg1, (arg0 as u64))
    }

    public fun get_game_start(arg0: &GameState) : u64 {
        arg0.game_start
    }

    fun get_tank_bub_cost(arg0: u8) : u64 {
        if (arg0 == 1) {
            1000000000
        } else if (arg0 == 2) {
            1000000000
        } else if (arg0 == 3) {
            1000000000
        } else if (arg0 == 4) {
            1000000000
        } else if (arg0 == 5) {
            1000000000
        } else if (arg0 == 6) {
            1000000000
        } else if (arg0 == 7) {
            1000000000
        } else {
            1000000000
        }
    }

    fun get_tank_cosmetic_slots(arg0: u8) : u64 {
        if (arg0 == 0) {
            1
        } else if (arg0 == 1) {
            2
        } else if (arg0 == 2) {
            3
        } else if (arg0 == 3) {
            4
        } else if (arg0 == 4) {
            5
        } else if (arg0 == 5) {
            6
        } else if (arg0 == 6) {
            8
        } else if (arg0 == 7) {
            10
        } else {
            12
        }
    }

    fun get_tank_max_bubblers(arg0: u8) : u64 {
        if (arg0 == 0) {
            4
        } else if (arg0 == 1) {
            8
        } else if (arg0 == 2) {
            12
        } else if (arg0 == 3) {
            16
        } else if (arg0 == 4) {
            20
        } else if (arg0 == 5) {
            20
        } else if (arg0 == 6) {
            24
        } else if (arg0 == 7) {
            42
        } else {
            42
        }
    }

    fun get_tank_pressure_capacity(arg0: u8) : u64 {
        if (arg0 == 0) {
            28
        } else if (arg0 == 1) {
            168
        } else if (arg0 == 2) {
            420
        } else if (arg0 == 3) {
            1120
        } else if (arg0 == 4) {
            7000
        } else if (arg0 == 5) {
            13125
        } else if (arg0 == 6) {
            20000
        } else if (arg0 == 7) {
            40000
        } else {
            65000
        }
    }

    fun get_tank_sui_cost(arg0: u8) : u64 {
        if (arg0 == 1) {
            1000000
        } else if (arg0 == 2) {
            1000000
        } else if (arg0 == 3) {
            1000000
        } else if (arg0 == 4) {
            1000000
        } else if (arg0 == 5) {
            1000000
        } else if (arg0 == 6) {
            1000000
        } else if (arg0 == 7) {
            1000000
        } else {
            1000000
        }
    }

    public fun get_total_bublz_burned(arg0: &GameState) : u64 {
        arg0.total_bublz_burned
    }

    public fun get_total_burned(arg0: &GameState) : u64 {
        arg0.total_burned
    }

    public fun get_total_minted(arg0: &GameState) : u64 {
        arg0.total_minted
    }

    public fun get_total_network_pressure(arg0: &GameState) : u64 {
        arg0.total_network_pressure
    }

    public fun get_total_players(arg0: &GameState) : u64 {
        arg0.total_players
    }

    fun get_upgrade_base_bub(arg0: u8) : u64 {
        if (arg0 == 0) {
            1000000000
        } else if (arg0 == 1) {
            1000000000
        } else if (arg0 == 2) {
            1000000000
        } else if (arg0 == 3) {
            1000000000
        } else {
            1000000000
        }
    }

    fun get_upgrade_bub_cost(arg0: u8, arg1: u8) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg1) {
            v0 = v0 * 2;
            v1 = v1 + 1;
        };
        get_upgrade_base_bub(arg0) * v0
    }

    fun init(arg0: GAME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<GAME>(arg0, arg1);
        let v1 = 0x2::display::new<BubbleGenerator>(&v0, arg1);
        0x2::display::add<BubbleGenerator>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<BubbleGenerator>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<BubbleGenerator>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(x"427562636f696e20427562626c657220e28094207b627562626c655f70726573737572657d204250204d696e696e6720506f776572"));
        0x2::display::add<BubbleGenerator>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://bublz.fun/bubcoin"));
        0x2::display::add<BubbleGenerator>(&mut v1, 0x1::string::utf8(b"collection"), 0x1::string::utf8(b"Bubcoin Bubblers"));
        0x2::display::add<BubbleGenerator>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"BUBLZ"));
        0x2::display::update_version<BubbleGenerator>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<BubbleGenerator>>(v1, 0x2::tx_context::sender(arg1));
        let v2 = 0x2::display::new<BubbleCosmetic>(&v0, arg1);
        0x2::display::add<BubbleCosmetic>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<BubbleCosmetic>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<BubbleCosmetic>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(x"427562636f696e20436f736d6574696320e28094202b7b627562626c655f70726573737572657d20425020426f6e7573"));
        0x2::display::add<BubbleCosmetic>(&mut v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://bublz.fun/bubcoin"));
        0x2::display::add<BubbleCosmetic>(&mut v2, 0x1::string::utf8(b"collection"), 0x1::string::utf8(b"Bubcoin Cosmetics"));
        0x2::display::add<BubbleCosmetic>(&mut v2, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"BUBLZ"));
        0x2::display::update_version<BubbleCosmetic>(&mut v2);
        0x2::transfer::public_transfer<0x2::display::Display<BubbleCosmetic>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
    }

    entry fun mint_bubbler<T0, T1>(arg0: &mut GameState, arg1: u8, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        assert!((arg1 as u64) < 13, 1);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, PlayerTank>(&arg0.player_tanks, v0), 10);
        let (v1, v2, v3, v4, v5) = get_bubbler_stats(arg1);
        if (v3 > 0) {
            let v6 = process_bub_payment<T0>(arg2, v3, arg5);
            burn_bub_payment<T0>(v6, arg0, arg5);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v0);
        };
        let v7 = if (arg1 == 0) {
            arg0.bublz_cost * 2
        } else {
            arg0.bublz_cost
        };
        process_bublz_payment<T1>(arg3, v7, arg0, arg5);
        let v8 = get_bubbler_sui_cost(arg1, &arg0.sui_costs);
        process_sui_payment(arg4, v8, arg0, arg5);
        let v9 = arg0.next_bubbler_id;
        arg0.next_bubbler_id = v9 + 1;
        let v10 = BubbleGenerator{
            id              : 0x2::object::new(arg5),
            bubbler_id      : v9,
            tier            : arg1,
            name            : v4,
            bubble_pressure : v1,
            tank_pressure   : v2,
            image_url       : v5,
        };
        0x2::transfer::public_transfer<BubbleGenerator>(v10, v0);
        let v11 = BubblerMinted{
            owner           : v0,
            bubbler_id      : v9,
            tier            : arg1,
            bubble_pressure : v1,
        };
        0x2::event::emit<BubblerMinted>(v11);
    }

    entry fun mint_cosmetic<T0, T1>(arg0: &mut GameState, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        assert!(0x2::table::contains<u64, CosmeticType>(&arg0.cosmetic_types, arg1), 1);
        let v0 = 0x2::table::borrow_mut<u64, CosmeticType>(&mut arg0.cosmetic_types, arg1);
        assert!(!v0.disabled, 14);
        assert!(v0.minted < v0.max_supply, 15);
        let v1 = v0.bub_cost;
        let v2 = v0.name;
        let v3 = v0.bubble_pressure;
        v0.minted = v0.minted + 1;
        if (v1 > 0) {
            let v4 = process_bub_payment<T0>(arg2, v1, arg5);
            burn_bub_payment<T0>(v4, arg0, arg5);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg5));
        };
        process_bublz_payment<T1>(arg3, v0.bublz_cost, arg0, arg5);
        process_sui_payment(arg4, v0.sui_cost, arg0, arg5);
        let v5 = arg0.next_cosmetic_instance_id;
        arg0.next_cosmetic_instance_id = v5 + 1;
        let v6 = BubbleCosmetic{
            id                   : 0x2::object::new(arg5),
            cosmetic_instance_id : v5,
            cosmetic_type_id     : arg1,
            name                 : v2,
            bubble_pressure      : v3,
            image_url            : v0.image_url,
        };
        0x2::transfer::public_transfer<BubbleCosmetic>(v6, 0x2::tx_context::sender(arg5));
        let v7 = CosmeticMinted{
            owner            : 0x2::tx_context::sender(arg5),
            cosmetic_type_id : arg1,
            name             : v2,
        };
        0x2::event::emit<CosmeticMinted>(v7);
    }

    fun process_bub_payment<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 >= arg1, 7);
        let v1 = 0x2::coin::into_balance<T0>(arg0);
        if (v0 > arg1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1, v0 - arg1), arg2), 0x2::tx_context::sender(arg2));
        };
        v1
    }

    fun process_bublz_payment<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut GameState, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 >= arg1, 7);
        if (v0 > arg1) {
            let v1 = 0x2::coin::into_balance<T0>(arg0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1, v0 - arg1), arg3), 0x2::tx_context::sender(arg3));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg3), @0x0);
            arg2.total_bublz_burned = arg2.total_bublz_burned + arg1;
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, @0x0);
            arg2.total_bublz_burned = arg2.total_bublz_burned + v0;
        };
    }

    fun process_sui_payment(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut GameState, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 >= arg1, 7);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg0);
        if (v0 > arg1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1, v0 - arg1), arg3), 0x2::tx_context::sender(arg3));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.sui_treasury, v1);
    }

    entry fun remove_cosmetic(arg0: &mut GameState, arg1: &BubbleCosmetic, arg2: &0x2::tx_context::TxContext) {
        let v0 = arg1.cosmetic_instance_id;
        assert!(0x2::table::contains<u64, DisplayedCosmeticInfo>(&arg0.displayed_cosmetics, v0), 18);
        let v1 = 0x2::table::remove<u64, DisplayedCosmeticInfo>(&mut arg0.displayed_cosmetics, v0);
        let v2 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v1.owner);
        let v3 = 0;
        let v4 = 0x1::vector::length<u64>(&v2.displayed_cosmetic_ids);
        while (v3 < v4) {
            if (*0x1::vector::borrow<u64>(&v2.displayed_cosmetic_ids, v3) == v0) {
                0x1::vector::swap_remove<u64>(&mut v2.displayed_cosmetic_ids, v3);
                v3 = v4;
            };
            v3 = v3 + 1;
        };
        v2.total_pressure = v2.total_pressure - v1.bubble_pressure;
        arg0.total_network_pressure = arg0.total_network_pressure - v1.bubble_pressure;
    }

    entry fun set_bublz_cost(arg0: &mut GameState, arg1: &AdminCap, arg2: u64) {
        arg0.bublz_cost = arg2;
    }

    entry fun set_paused(arg0: &mut GameState, arg1: &AdminCap, arg2: bool) {
        arg0.paused = arg2;
    }

    entry fun set_referral(arg0: &mut GameState, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 != arg1, 9);
        assert!(0x2::table::contains<address, PlayerTank>(&arg0.player_tanks, v0), 10);
        assert!(0x2::table::contains<address, PlayerTank>(&arg0.player_tanks, arg1), 24);
        let v1 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v0);
        assert!(!v1.has_referrer, 8);
        v1.referrer = arg1;
        v1.has_referrer = true;
    }

    entry fun set_sui_costs(arg0: &mut GameState, arg1: &AdminCap, arg2: vector<u64>) {
        arg0.sui_costs = arg2;
    }

    entry fun set_treasury_recipient(arg0: &mut GameState, arg1: &AdminCap, arg2: address) {
        arg0.treasury_recipient = arg2;
    }

    entry fun stake_bubbler(arg0: &mut GameState, arg1: &BubbleGenerator, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = arg1.bubbler_id;
        assert!(!0x2::table::contains<u64, StakedBubblerInfo>(&arg0.staked_bubblers, v1), 19);
        assert!(0x2::table::contains<address, PlayerTank>(&arg0.player_tanks, v0), 10);
        let v2 = 0x2::table::borrow<address, PlayerTank>(&arg0.player_tanks, v0);
        assert!(0x1::vector::length<u64>(&v2.staked_bubbler_ids) < get_tank_max_bubblers(v2.tier), 2);
        let v3 = apply_upgrade_bonus(v2, arg1.bubble_pressure);
        let v4 = apply_cooling_bonus(v2, arg1.tank_pressure);
        assert!(v2.total_tank_pressure + v4 <= get_tank_pressure_capacity(v2.tier), 3);
        let v5 = StakedBubblerInfo{
            owner           : v0,
            tier            : arg1.tier,
            bubble_pressure : v3,
            tank_pressure   : v4,
        };
        0x2::table::add<u64, StakedBubblerInfo>(&mut arg0.staked_bubblers, v1, v5);
        let v6 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v0);
        0x1::vector::push_back<u64>(&mut v6.staked_bubbler_ids, v1);
        v6.total_pressure = v6.total_pressure + v3;
        v6.total_tank_pressure = v6.total_tank_pressure + v4;
        arg0.total_network_pressure = arg0.total_network_pressure + v3;
        let v7 = BubblerStaked{
            owner      : v0,
            bubbler_id : v1,
            tier       : arg1.tier,
        };
        0x2::event::emit<BubblerStaked>(v7);
    }

    entry fun unstake_all_bubblers(arg0: &mut GameState, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, PlayerTank>(&arg0.player_tanks, v0), 10);
        let v1 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v0);
        let v2 = v1.staked_bubbler_ids;
        v1.staked_bubbler_ids = 0x1::vector::empty<u64>();
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&v2)) {
            let v6 = *0x1::vector::borrow<u64>(&v2, v5);
            if (0x2::table::contains<u64, StakedBubblerInfo>(&arg0.staked_bubblers, v6)) {
                let v7 = 0x2::table::remove<u64, StakedBubblerInfo>(&mut arg0.staked_bubblers, v6);
                v3 = v3 + v7.bubble_pressure;
                v4 = v4 + v7.tank_pressure;
            };
            v5 = v5 + 1;
        };
        let v8 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v0);
        v8.total_pressure = v8.total_pressure - v3;
        v8.total_tank_pressure = v8.total_tank_pressure - v4;
        arg0.total_network_pressure = arg0.total_network_pressure - v3;
    }

    entry fun unstake_bubbler(arg0: &mut GameState, arg1: &BubbleGenerator, arg2: &0x2::tx_context::TxContext) {
        let v0 = arg1.bubbler_id;
        assert!(0x2::table::contains<u64, StakedBubblerInfo>(&arg0.staked_bubblers, v0), 18);
        let v1 = 0x2::table::remove<u64, StakedBubblerInfo>(&mut arg0.staked_bubblers, v0);
        let v2 = v1.owner;
        let v3 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v2);
        let v4 = 0;
        let v5 = 0x1::vector::length<u64>(&v3.staked_bubbler_ids);
        while (v4 < v5) {
            if (*0x1::vector::borrow<u64>(&v3.staked_bubbler_ids, v4) == v0) {
                0x1::vector::swap_remove<u64>(&mut v3.staked_bubbler_ids, v4);
                v4 = v5;
            };
            v4 = v4 + 1;
        };
        v3.total_pressure = v3.total_pressure - v1.bubble_pressure;
        v3.total_tank_pressure = v3.total_tank_pressure - v1.tank_pressure;
        arg0.total_network_pressure = arg0.total_network_pressure - v1.bubble_pressure;
        let v6 = BubblerUnstaked{
            owner      : v2,
            bubbler_id : v0,
            tier       : v1.tier,
        };
        0x2::event::emit<BubblerUnstaked>(v6);
    }

    entry fun upgrade_stat<T0, T1>(arg0: &mut GameState, arg1: u8, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        assert!(arg1 < 5, 1);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, PlayerTank>(&arg0.player_tanks, v0), 10);
        let v1 = *0x1::vector::borrow<u8>(&0x2::table::borrow<address, PlayerTank>(&arg0.player_tanks, v0).upgrade_levels, (arg1 as u64));
        assert!(v1 < 5, 13);
        let v2 = process_bub_payment<T0>(arg2, get_upgrade_bub_cost(arg1, v1), arg5);
        burn_bub_payment<T0>(v2, arg0, arg5);
        process_bublz_payment<T1>(arg3, 1000000000, arg0, arg5);
        process_sui_payment(arg4, 1000000, arg0, arg5);
        let v3 = 0x1::vector::borrow_mut<u8>(&mut 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v0).upgrade_levels, (arg1 as u64));
        *v3 = *v3 + 1;
        let v4 = StatUpgraded{
            player       : v0,
            upgrade_type : arg1,
            new_level    : *v3,
        };
        0x2::event::emit<StatUpgraded>(v4);
    }

    entry fun upgrade_tank<T0, T1>(arg0: &mut GameState, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, PlayerTank>(&arg0.player_tanks, v0), 10);
        let v1 = 0x2::table::borrow<address, PlayerTank>(&arg0.player_tanks, v0);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        assert!(v1.tier < 8, 1);
        assert!(v2 >= v1.last_upgrade_time + 60000, 12);
        assert!(0x1::vector::length<u64>(&v1.staked_bubbler_ids) == 0, 23);
        assert!(0x1::vector::length<u64>(&v1.displayed_cosmetic_ids) == 0, 23);
        let v3 = v1.tier + 1;
        let v4 = process_bub_payment<T0>(arg1, get_tank_bub_cost(v3), arg5);
        burn_bub_payment<T0>(v4, arg0, arg5);
        let v5 = arg0.bublz_cost;
        process_bublz_payment<T1>(arg2, v5, arg0, arg5);
        process_sui_payment(arg3, get_tank_sui_cost(v3), arg0, arg5);
        let v6 = 0x2::table::borrow_mut<address, PlayerTank>(&mut arg0.player_tanks, v0);
        v6.tier = v3;
        v6.last_upgrade_time = v2;
        let v7 = TankUpgraded{
            player   : v0,
            new_tier : v3,
        };
        0x2::event::emit<TankUpgraded>(v7);
    }

    entry fun withdraw_sui_treasury(arg0: &mut GameState, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_treasury);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_treasury, v0), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    // decompiled from Move bytecode v6
}

