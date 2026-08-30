module 0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::lootbox {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        paused: bool,
        prices: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        burn_bps: u64,
        treasury: address,
        media_base: 0x1::string::String,
        kinds: vector<u8>,
        rarities: vector<u8>,
        weights: vector<u64>,
        opens: u64,
    }

    struct BoxOpened has copy, drop {
        buyer: address,
        weapon_id: 0x2::object::ID,
        kind: u8,
        rarity: u8,
        serial: u64,
        currency: 0x1::type_name::TypeName,
        price: u64,
    }

    public fun admin_mint(arg0: &AdminCap, arg1: &mut Config, arg2: u8, arg3: u8, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        arg1.opens = arg1.opens + 1;
        0x2::transfer::public_transfer<0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::Weapon>(build(arg1, arg2, arg3, arg1.opens, arg5), arg4);
    }

    fun build(arg0: &Config, arg1: u8, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::Weapon {
        let (v0, v1, v2, v3, v4, v5) = spec(arg1);
        let v6 = 0x1::string::utf8(v0);
        0x1::string::append(&mut v6, 0x1::string::utf8(b" #"));
        0x1::string::append(&mut v6, 0x1::u64::to_string(arg3));
        let v7 = arg0.media_base;
        0x1::string::append(&mut v7, 0x1::string::utf8(v1));
        0x1::string::append(&mut v7, 0x1::string::utf8(b".png"));
        let v8 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v8, 0x1::string::utf8(b"RARITY"), 0x1::string::utf8(rarity_label(arg2)));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v8, 0x1::string::utf8(b"WEAPON"), 0x1::string::utf8(v0));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v8, 0x1::string::utf8(b"DMG"), 0x1::string::utf8(v3));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v8, 0x1::string::utf8(b"RATE"), 0x1::string::utf8(v4));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v8, 0x1::string::utf8(b"RNG"), 0x1::string::utf8(v5));
        0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::mint(arg1, arg2, arg3, v6, 0x1::string::utf8(v2), v7, v8, arg4)
    }

    public fun burn_bps(arg0: &Config) : u64 {
        arg0.burn_bps
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, v0);
        let v2 = Config{
            id         : 0x2::object::new(arg0),
            paused     : true,
            prices     : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            burn_bps   : 2000,
            treasury   : v0,
            media_base : 0x1::string::utf8(b""),
            kinds      : x"010203040506",
            rarities   : x"000001020203",
            weights    : vector[3200, 3000, 2400, 600, 500, 300],
            opens      : 0,
        };
        0x2::transfer::share_object<Config>(v2);
    }

    public fun is_paused(arg0: &Config) : bool {
        arg0.paused
    }

    entry fun open_box<T0>(arg0: &mut Config, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.prices, &v0), 2);
        let v1 = *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.prices, &v0);
        assert!(0x2::coin::value<T0>(&arg2) >= v1, 3);
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = 0x2::coin::split<T0>(&mut arg2, v1, arg3);
        if (0x2::coin::value<T0>(&arg2) == 0) {
            0x2::coin::destroy_zero<T0>(arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v2);
        };
        let v4 = v1 * arg0.burn_bps / 10000;
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v3, v4, arg3), @0x0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, arg0.treasury);
        let v5 = 0x2::random::new_generator(arg1, arg3);
        let v6 = pick(&arg0.weights, 0x2::random::generate_u64_in_range(&mut v5, 1, 10000));
        arg0.opens = arg0.opens + 1;
        let v7 = arg0.opens;
        let v8 = *0x1::vector::borrow<u8>(&arg0.kinds, v6);
        let v9 = *0x1::vector::borrow<u8>(&arg0.rarities, v6);
        let v10 = build(arg0, v8, v9, v7, arg3);
        0x2::transfer::public_transfer<0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::Weapon>(v10, v2);
        let v11 = BoxOpened{
            buyer     : v2,
            weapon_id : 0x2::object::id<0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::Weapon>(&v10),
            kind      : v8,
            rarity    : v9,
            serial    : v7,
            currency  : v0,
            price     : v1,
        };
        0x2::event::emit<BoxOpened>(v11);
    }

    public fun opens(arg0: &Config) : u64 {
        arg0.opens
    }

    fun pick(arg0: &vector<u64>, arg1: u64) : u64 {
        let v0 = 0x1::vector::length<u64>(arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = v1 + *0x1::vector::borrow<u64>(arg0, v2);
            v1 = v3;
            if (arg1 <= v3) {
                return v2
            };
            v2 = v2 + 1;
        };
        v0 - 1
    }

    public fun price_for<T0>(arg0: &Config) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.prices, &v0), 2);
        *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.prices, &v0)
    }

    fun rarity_label(arg0: u8) : vector<u8> {
        if (arg0 == 0) {
            b"Common"
        } else if (arg0 == 1) {
            b"Uncommon"
        } else if (arg0 == 2) {
            b"Rare"
        } else {
            b"Legendary"
        }
    }

    public fun remove_price<T0>(arg0: &AdminCap, arg1: &mut Config) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg1.prices, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg1.prices, &v0);
        };
    }

    public fun set_burn_bps(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg2 <= 10000, 4);
        arg1.burn_bps = arg2;
    }

    public fun set_media_base(arg0: &AdminCap, arg1: &mut Config, arg2: 0x1::string::String) {
        arg1.media_base = arg2;
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.paused = arg2;
    }

    public fun set_price<T0>(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg1.prices, &v0)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg1.prices, &v0) = arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg1.prices, v0, arg2);
        };
    }

    public fun set_table(arg0: &AdminCap, arg1: &mut Config, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u64>) {
        let v0 = 0x1::vector::length<u8>(&arg2);
        let v1 = if (v0 > 0) {
            if (0x1::vector::length<u8>(&arg3) == v0) {
                0x1::vector::length<u64>(&arg4) == v0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 4);
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            v2 = v2 + *0x1::vector::borrow<u64>(&arg4, v3);
            v3 = v3 + 1;
        };
        assert!(v2 == 10000, 4);
        arg1.kinds = arg2;
        arg1.rarities = arg3;
        arg1.weights = arg4;
    }

    public fun set_treasury(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        arg1.treasury = arg2;
    }

    fun spec(arg0: u8) : (vector<u8>, vector<u8>, vector<u8>, vector<u8>, vector<u8>, vector<u8>) {
        if (arg0 == 1) {
            (b"Scattergun", b"scattergun", b"Three barrels, one trigger. Short range, wide spread.", b"4", b"4", b"3")
        } else if (arg0 == 2) {
            (b"Minigun", b"minigun", b"Spins up and does not stop. Low damage, absurd rate.", b"2", b"9", b"4")
        } else if (arg0 == 3) {
            (b"Heavy Cannon", b"heavy-cannon", b"One enormous shell at a time. Hits like a truck.", b"9", b"2", b"5")
        } else {
            let (v6, v7, v8, v9, v10, v11) = if (arg0 == 4) {
                (b"8", b"3", b"10", b"Railgun", b"railgun", b"Hypersonic slug across the whole arena. Nowhere is safe.")
            } else {
                let (v12, v13, v14, v15, v16, v17) = if (arg0 == 5) {
                    (b"Missile Pod", b"missile-pod", b"Homing warheads with a splash radius. Tracks the nearest target.", b"7", b"3", b"7")
                } else {
                    assert!(arg0 == 6, 5);
                    (b"Plasma Storm", b"plasma-storm", b"Five superheated bolts per volley. Legendary ordnance.", b"8", b"4", b"4")
                };
                (v15, v16, v17, v12, v13, v14)
            };
            (v9, v10, v11, v6, v7, v8)
        }
    }

    public fun table(arg0: &Config) : (&vector<u8>, &vector<u8>, &vector<u64>) {
        (&arg0.kinds, &arg0.rarities, &arg0.weights)
    }

    // decompiled from Move bytecode v7
}

