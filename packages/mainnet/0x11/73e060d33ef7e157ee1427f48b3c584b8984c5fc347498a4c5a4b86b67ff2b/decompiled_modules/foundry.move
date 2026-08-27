module 0x1173e060d33ef7e157ee1427f48b3c584b8984c5fc347498a4c5a4b86b67ff2b::foundry {
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
        minted: u64,
    }

    struct CommanderMinted has copy, drop {
        buyer: address,
        commander_id: 0x2::object::ID,
        doctrine: u8,
        command: u8,
        cunning: u8,
        logistics: u8,
        serial: u64,
        currency: 0x1::type_name::TypeName,
        price: u64,
    }

    entry fun mint<T0>(arg0: &mut Config, arg1: &0x2::random::Random, arg2: u8, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        assert!(arg2 < 4, 8);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.prices, &v1), 2);
        let v2 = *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.prices, &v1);
        assert!(0x2::coin::value<T0>(&arg3) >= v2, 3);
        let v3 = 0x2::coin::split<T0>(&mut arg3, v2, arg4);
        if (0x2::coin::value<T0>(&arg3) == 0) {
            0x2::coin::destroy_zero<T0>(arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0);
        };
        let v4 = v2 * arg0.burn_bps / 10000;
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v3, v4, arg4), @0x0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, arg0.treasury);
        let v5 = 0x2::random::new_generator(arg1, arg4);
        let v6 = (0x2::random::generate_u64_in_range(&mut v5, 4, 9) as u8);
        let v7 = (0x2::random::generate_u64_in_range(&mut v5, 4, 9) as u8);
        let v8 = (0x2::random::generate_u64_in_range(&mut v5, 4, 9) as u8);
        arg0.minted = arg0.minted + 1;
        let v9 = arg0.minted;
        let v10 = build(arg0, arg2, v6, v7, v8, v9, arg4);
        0x2::transfer::public_transfer<0x1173e060d33ef7e157ee1427f48b3c584b8984c5fc347498a4c5a4b86b67ff2b::commander::Commander>(v10, v0);
        let v11 = CommanderMinted{
            buyer        : v0,
            commander_id : 0x2::object::id<0x1173e060d33ef7e157ee1427f48b3c584b8984c5fc347498a4c5a4b86b67ff2b::commander::Commander>(&v10),
            doctrine     : arg2,
            command      : v6,
            cunning      : v7,
            logistics    : v8,
            serial       : v9,
            currency     : v1,
            price        : v2,
        };
        0x2::event::emit<CommanderMinted>(v11);
    }

    public fun admin_mint(arg0: &AdminCap, arg1: &mut Config, arg2: u8, arg3: u8, arg4: u8, arg5: u8, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 < 4, 8);
        let v0 = if (arg3 >= (4 as u8)) {
            if (arg3 <= (9 as u8)) {
                if (arg4 >= (4 as u8)) {
                    if (arg4 <= (9 as u8)) {
                        if (arg5 >= (4 as u8)) {
                            arg5 <= (9 as u8)
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 4);
        arg1.minted = arg1.minted + 1;
        0x2::transfer::public_transfer<0x1173e060d33ef7e157ee1427f48b3c584b8984c5fc347498a4c5a4b86b67ff2b::commander::Commander>(build(arg1, arg2, arg3, arg4, arg5, arg1.minted, arg7), arg6);
    }

    fun build(arg0: &Config, arg1: u8, arg2: u8, arg3: u8, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x1173e060d33ef7e157ee1427f48b3c584b8984c5fc347498a4c5a4b86b67ff2b::commander::Commander {
        let v0 = 0x1::string::utf8(doctrine_name(arg1));
        0x1::string::append(&mut v0, 0x1::string::utf8(b" #"));
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg5));
        let v1 = arg0.media_base;
        0x1::string::append(&mut v1, 0x1::string::utf8(b"commander-"));
        0x1::string::append(&mut v1, 0x1::string::utf8(doctrine_slug(arg1)));
        0x1::string::append(&mut v1, 0x1::string::utf8(b".png"));
        let v2 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"DOCTRINE"), 0x1::string::utf8(doctrine_name(arg1)));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"COMMAND"), 0x1::u64::to_string((arg2 as u64)));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"CUNNING"), 0x1::u64::to_string((arg3 as u64)));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"LOGISTICS"), 0x1::u64::to_string((arg4 as u64)));
        0x1173e060d33ef7e157ee1427f48b3c584b8984c5fc347498a4c5a4b86b67ff2b::commander::mint(arg1, arg2, arg3, arg4, arg5, v0, 0x1::string::utf8(doctrine_blurb(arg1)), v1, v2, arg6)
    }

    public fun burn_bps(arg0: &Config) : u64 {
        arg0.burn_bps
    }

    fun doctrine_blurb(arg0: u8) : vector<u8> {
        if (arg0 == 0) {
            b"Runs the squad like a supply line: caches found, couriers escorted, vault fed."
        } else if (arg0 == 1) {
            b"Holds the wall. Extra guards on the ring, long rallies, raiders punished on home ground."
        } else if (arg0 == 2) {
            b"Hunts. Bigger war parties, richer targets, other people's bases on fire."
        } else {
            b"Reads the map. Finds the rich ground, moves the base, arrives before the rush."
        }
    }

    fun doctrine_name(arg0: u8) : vector<u8> {
        if (arg0 == 0) {
            b"Quartermaster"
        } else if (arg0 == 1) {
            b"Warden"
        } else if (arg0 == 2) {
            b"Warlord"
        } else {
            b"Pathfinder"
        }
    }

    fun doctrine_slug(arg0: u8) : vector<u8> {
        if (arg0 == 0) {
            b"quartermaster"
        } else if (arg0 == 1) {
            b"warden"
        } else if (arg0 == 2) {
            b"warlord"
        } else {
            b"pathfinder"
        }
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
            minted     : 0,
        };
        0x2::transfer::share_object<Config>(v2);
    }

    public fun is_paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun minted(arg0: &Config) : u64 {
        arg0.minted
    }

    public fun price_for<T0>(arg0: &Config) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.prices, &v0), 2);
        *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.prices, &v0)
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

    public fun set_treasury(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        arg1.treasury = arg2;
    }

    // decompiled from Move bytecode v7
}

