module 0x68017420bdf42db1bce929fcce2ff4554cff0d787e476ee32ffc68b733554d25::booster_pack {
    struct Rarity has copy, drop, store {
        tier: u8,
    }

    struct MushroomNFT has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        rarity: Rarity,
        level: u64,
        power: u64,
        created_at: u64,
    }

    struct PlayerFarmSlots has key {
        id: 0x2::object::UID,
        owner: address,
        slots: vector<0x1::option::Option<MushroomNFT>>,
        max_slots: u64,
        daily_pack_limit: u64,
        packs_opened_today: u64,
        last_reset_day: u64,
        total_packs_opened: u64,
    }

    struct BoosterPackSystem<phantom T0> has key {
        id: 0x2::object::UID,
        total_packs_opened: u64,
        total_shrooms_burned: u64,
        burn_balance: 0x2::balance::Balance<T0>,
    }

    struct PackOpened has copy, drop {
        player: address,
        rarity: u8,
        power: u64,
        name: vector<u8>,
    }

    struct MushroomPlanted has copy, drop {
        player: address,
        slot_index: u64,
        power: u64,
    }

    fun determine_rarity_and_stats(arg0: u8) : (Rarity, u64, vector<u8>) {
        let v0 = arg0 % 100 + 1;
        if (v0 <= 50) {
            let v4 = Rarity{tier: 0};
            (v4, 100, b"Common Shroom")
        } else if (v0 <= 50 + 30) {
            let v5 = Rarity{tier: 1};
            (v5, 250, b"Rare Shroom")
        } else if (v0 <= 50 + 30 + 15) {
            let v6 = Rarity{tier: 2};
            (v6, 500, b"Super Rare Shroom")
        } else if (v0 <= 50 + 30 + 15 + 4) {
            let v7 = Rarity{tier: 3};
            (v7, 1000, b"Ultra Rare Shroom")
        } else {
            let v8 = Rarity{tier: 4};
            (v8, 2500, b"Legendary Shroom")
        }
    }

    public fun get_mushroom_stats(arg0: &MushroomNFT) : (vector<u8>, u8, u64, u64) {
        (arg0.name, arg0.rarity.tier, arg0.level, arg0.power)
    }

    public fun get_player_stats(arg0: &PlayerFarmSlots) : (u64, u64, u64, u64) {
        (arg0.max_slots, arg0.daily_pack_limit, arg0.packs_opened_today, arg0.total_packs_opened)
    }

    public fun get_system_stats<T0>(arg0: &BoosterPackSystem<T0>) : (u64, u64) {
        (arg0.total_packs_opened, arg0.total_shrooms_burned)
    }

    public fun get_total_power(arg0: &PlayerFarmSlots) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::option::Option<MushroomNFT>>(&arg0.slots)) {
            let v2 = 0x1::vector::borrow<0x1::option::Option<MushroomNFT>>(&arg0.slots, v1);
            if (0x1::option::is_some<MushroomNFT>(v2)) {
                v0 = v0 + 0x1::option::borrow<MushroomNFT>(v2).power;
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun initialize_slots(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x1::vector::empty<0x1::option::Option<MushroomNFT>>();
        let v2 = 0;
        while (v2 < 6) {
            0x1::vector::push_back<0x1::option::Option<MushroomNFT>>(&mut v1, 0x1::option::none<MushroomNFT>());
            v2 = v2 + 1;
        };
        let v3 = PlayerFarmSlots{
            id                 : 0x2::object::new(arg0),
            owner              : v0,
            slots              : v1,
            max_slots          : 6,
            daily_pack_limit   : 10,
            packs_opened_today : 0,
            last_reset_day     : 0,
            total_packs_opened : 0,
        };
        0x2::transfer::transfer<PlayerFarmSlots>(v3, v0);
    }

    public entry fun open_pack<T0>(arg0: &mut BoosterPackSystem<T0>, arg1: &mut PlayerFarmSlots, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg1.owner == v0, 3);
        assert!(0x2::coin::value<T0>(&arg2) >= 300000000, 1);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        if (v1 - arg1.last_reset_day >= 86400000) {
            arg1.packs_opened_today = 0;
            arg1.last_reset_day = v1;
        };
        assert!(arg1.packs_opened_today < arg1.daily_pack_limit, 0);
        0x2::balance::join<T0>(&mut arg0.burn_balance, 0x2::coin::into_balance<T0>(arg2));
        arg0.total_shrooms_burned = arg0.total_shrooms_burned + 300000000;
        let v2 = 0x2::random::new_generator(arg3, arg5);
        let (v3, v4, v5) = determine_rarity_and_stats(0x2::random::generate_u8(&mut v2));
        let v6 = v3;
        let v7 = MushroomNFT{
            id         : 0x2::object::new(arg5),
            name       : v5,
            rarity     : v6,
            level      : (0x2::random::generate_u8_in_range(&mut v2, 1, 11) as u64),
            power      : v4,
            created_at : v1,
        };
        0x2::transfer::transfer<MushroomNFT>(v7, v0);
        arg1.packs_opened_today = arg1.packs_opened_today + 1;
        arg1.total_packs_opened = arg1.total_packs_opened + 1;
        arg0.total_packs_opened = arg0.total_packs_opened + 1;
        let v8 = PackOpened{
            player : v0,
            rarity : v6.tier,
            power  : v4,
            name   : v5,
        };
        0x2::event::emit<PackOpened>(v8);
    }

    public entry fun plant_mushroom(arg0: &mut PlayerFarmSlots, arg1: MushroomNFT, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.owner == v0, 3);
        assert!(arg2 < arg0.max_slots, 2);
        let v1 = 0x1::vector::borrow_mut<0x1::option::Option<MushroomNFT>>(&mut arg0.slots, arg2);
        if (0x1::option::is_some<MushroomNFT>(v1)) {
            0x2::transfer::transfer<MushroomNFT>(0x1::option::extract<MushroomNFT>(v1), v0);
        };
        0x1::option::fill<MushroomNFT>(v1, arg1);
        let v2 = MushroomPlanted{
            player     : v0,
            slot_index : arg2,
            power      : arg1.power,
        };
        0x2::event::emit<MushroomPlanted>(v2);
    }

    public entry fun remove_mushroom(arg0: &mut PlayerFarmSlots, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.owner == v0, 3);
        let v1 = 0x1::vector::borrow_mut<0x1::option::Option<MushroomNFT>>(&mut arg0.slots, arg1);
        assert!(0x1::option::is_some<MushroomNFT>(v1), 2);
        0x2::transfer::transfer<MushroomNFT>(0x1::option::extract<MushroomNFT>(v1), v0);
    }

    public entry fun upgrade_daily_limit<T0>(arg0: &mut BoosterPackSystem<T0>, arg1: &mut PlayerFarmSlots, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 3);
        assert!(0x2::coin::value<T0>(&arg2) >= 1000000000, 1);
        0x2::balance::join<T0>(&mut arg0.burn_balance, 0x2::coin::into_balance<T0>(arg2));
        arg0.total_shrooms_burned = arg0.total_shrooms_burned + 1000000000;
        arg1.daily_pack_limit = arg1.daily_pack_limit + 5;
    }

    public entry fun upgrade_slots<T0>(arg0: &mut BoosterPackSystem<T0>, arg1: &mut PlayerFarmSlots, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 3);
        assert!(0x2::coin::value<T0>(&arg2) >= 500000000, 1);
        0x2::balance::join<T0>(&mut arg0.burn_balance, 0x2::coin::into_balance<T0>(arg2));
        arg0.total_shrooms_burned = arg0.total_shrooms_burned + 500000000;
        0x1::vector::push_back<0x1::option::Option<MushroomNFT>>(&mut arg1.slots, 0x1::option::none<MushroomNFT>());
        0x1::vector::push_back<0x1::option::Option<MushroomNFT>>(&mut arg1.slots, 0x1::option::none<MushroomNFT>());
        arg1.max_slots = arg1.max_slots + 2;
    }

    // decompiled from Move bytecode v6
}

