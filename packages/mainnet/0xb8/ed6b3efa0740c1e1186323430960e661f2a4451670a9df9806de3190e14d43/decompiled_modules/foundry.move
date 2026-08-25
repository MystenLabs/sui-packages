module 0xb8ed6b3efa0740c1e1186323430960e661f2a4451670a9df9806de3190e14d43::foundry {
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
        minted_by: 0x2::table::Table<address, u64>,
    }

    struct HarvesterMinted has copy, drop {
        buyer: address,
        harvester_id: 0x2::object::ID,
        armour: u8,
        speed: u8,
        serial: u64,
        currency: 0x1::type_name::TypeName,
        price: u64,
    }

    public fun admin_mint(arg0: &AdminCap, arg1: &mut Config, arg2: u8, arg3: u8, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.minted < 200, 6);
        let v0 = if (arg2 >= (8 as u8)) {
            if (arg2 <= (12 as u8)) {
                if (arg3 >= (1 as u8)) {
                    arg3 <= (4 as u8)
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
        0x2::transfer::public_transfer<0xb8ed6b3efa0740c1e1186323430960e661f2a4451670a9df9806de3190e14d43::harvester::Harvester>(build(arg1, arg2, arg3, arg1.minted, arg5), arg4);
    }

    fun build(arg0: &Config, arg1: u8, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0xb8ed6b3efa0740c1e1186323430960e661f2a4451670a9df9806de3190e14d43::harvester::Harvester {
        let v0 = 0x1::string::utf8(b"Harvester #");
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg3));
        let v1 = arg0.media_base;
        0x1::string::append(&mut v1, 0x1::string::utf8(b"harvester.png"));
        let v2 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"ARMOUR"), 0x1::u64::to_string((arg1 as u64)));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"SPEED"), 0x1::u64::to_string((arg2 as u64)));
        0xb8ed6b3efa0740c1e1186323430960e661f2a4451670a9df9806de3190e14d43::harvester::mint(arg1, arg2, arg3, v0, 0x1::string::utf8(b"An unarmed forager of the Wastes. Picks a patron base, gathers what the war leaves behind, and hauls it home for a cut."), v1, v2, arg4)
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
            minted     : 0,
            minted_by  : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<Config>(v2);
    }

    public fun is_paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun max_supply() : u64 {
        200
    }

    entry fun mint<T0>(arg0: &mut Config, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        assert!(arg0.minted < 200, 6);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = if (0x2::table::contains<address, u64>(&arg0.minted_by, v0)) {
            *0x2::table::borrow<address, u64>(&arg0.minted_by, v0)
        } else {
            0
        };
        assert!(v1 < 5, 7);
        let v2 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.prices, &v2), 2);
        let v3 = *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.prices, &v2);
        assert!(0x2::coin::value<T0>(&arg2) >= v3, 3);
        let v4 = 0x2::coin::split<T0>(&mut arg2, v3, arg3);
        if (0x2::coin::value<T0>(&arg2) == 0) {
            0x2::coin::destroy_zero<T0>(arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v0);
        };
        let v5 = v3 * arg0.burn_bps / 10000;
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v4, v5, arg3), @0x0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, arg0.treasury);
        let v6 = 0x2::random::new_generator(arg1, arg3);
        let v7 = (0x2::random::generate_u64_in_range(&mut v6, 8, 12) as u8);
        let v8 = (0x2::random::generate_u64_in_range(&mut v6, 1, 4) as u8);
        if (0x2::table::contains<address, u64>(&arg0.minted_by, v0)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.minted_by, v0) = v1 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.minted_by, v0, 1);
        };
        arg0.minted = arg0.minted + 1;
        let v9 = arg0.minted;
        let v10 = build(arg0, v7, v8, v9, arg3);
        0x2::transfer::public_transfer<0xb8ed6b3efa0740c1e1186323430960e661f2a4451670a9df9806de3190e14d43::harvester::Harvester>(v10, v0);
        let v11 = HarvesterMinted{
            buyer        : v0,
            harvester_id : 0x2::object::id<0xb8ed6b3efa0740c1e1186323430960e661f2a4451670a9df9806de3190e14d43::harvester::Harvester>(&v10),
            armour       : v7,
            speed        : v8,
            serial       : v9,
            currency     : v2,
            price        : v3,
        };
        0x2::event::emit<HarvesterMinted>(v11);
    }

    public fun minted(arg0: &Config) : u64 {
        arg0.minted
    }

    public fun minted_by(arg0: &Config, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.minted_by, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.minted_by, arg1)
        } else {
            0
        }
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

    public fun wallet_cap() : u64 {
        5
    }

    // decompiled from Move bytecode v7
}

