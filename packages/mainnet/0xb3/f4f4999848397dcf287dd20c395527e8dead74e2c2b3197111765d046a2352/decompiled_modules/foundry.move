module 0xb3f4f4999848397dcf287dd20c395527e8dead74e2c2b3197111765d046a2352::foundry {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        paused: bool,
        price_scrap: u64,
        price_alloy: u64,
        media_base: 0x1::string::String,
        minted: u64,
        minted_by: 0x2::table::Table<address, u64>,
    }

    struct WallBuilderMinted has copy, drop {
        buyer: address,
        builder_id: 0x2::object::ID,
        build: u8,
        stock: u8,
        armour: u8,
        serial: u64,
        scrap: u64,
        alloy: u64,
    }

    public fun admin_mint(arg0: &AdminCap, arg1: &mut Config, arg2: u8, arg3: u8, arg4: u8, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg2 >= (4 as u8)) {
            if (arg2 <= (9 as u8)) {
                if (arg3 >= (4 as u8)) {
                    if (arg3 <= (9 as u8)) {
                        if (arg4 >= (6 as u8)) {
                            arg4 <= (10 as u8)
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
        assert!(arg1.minted < 200, 8);
        arg1.minted = arg1.minted + 1;
        0x2::transfer::public_transfer<0xb3f4f4999848397dcf287dd20c395527e8dead74e2c2b3197111765d046a2352::wall_builder::WallBuilder>(build_unit(arg1, arg2, arg3, arg4, arg1.minted, arg6), arg5);
    }

    fun build_unit(arg0: &Config, arg1: u8, arg2: u8, arg3: u8, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0xb3f4f4999848397dcf287dd20c395527e8dead74e2c2b3197111765d046a2352::wall_builder::WallBuilder {
        let v0 = 0x1::string::utf8(b"Wall Builder #");
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg4));
        let v1 = arg0.media_base;
        0x1::string::append(&mut v1, 0x1::string::utf8(b"wall-builder.png"));
        let v2 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"BUILD RATE"), 0x1::u64::to_string((arg1 as u64)));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"SANDBAG STOCK"), 0x1::u64::to_string((arg2 as u64)));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v2, 0x1::string::utf8(b"ARMOUR"), 0x1::u64::to_string((arg3 as u64)));
        0xb3f4f4999848397dcf287dd20c395527e8dead74e2c2b3197111765d046a2352::wall_builder::mint(arg1, arg2, arg3, arg4, v0, 0x1::string::utf8(b"Builds the walls that hold the line. Unarmed, patient, and the reason a raid takes all night."), v1, v2, arg5)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Config{
            id          : 0x2::object::new(arg0),
            paused      : true,
            price_scrap : 12000000,
            price_alloy : 3600000,
            media_base  : 0x1::string::utf8(b""),
            minted      : 0,
            minted_by   : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<Config>(v1);
    }

    public fun is_paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun max_supply() : u64 {
        200
    }

    entry fun mint(arg0: &mut Config, arg1: &0x2::random::Random, arg2: &mut 0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::mint::Mint, arg3: 0x2::coin::Coin<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::scrap::SCRAP>, arg4: 0x2::coin::Coin<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::alloy::ALLOY>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        assert!(arg0.minted < 200, 8);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = if (0x2::table::contains<address, u64>(&arg0.minted_by, v0)) {
            *0x2::table::borrow<address, u64>(&arg0.minted_by, v0)
        } else {
            0
        };
        assert!(v1 < 5, 7);
        assert!(0x2::coin::value<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::scrap::SCRAP>(&arg3) >= arg0.price_scrap, 3);
        assert!(0x2::coin::value<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::alloy::ALLOY>(&arg4) >= arg0.price_alloy, 3);
        if (0x2::coin::value<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::scrap::SCRAP>(&arg3) == 0) {
            0x2::coin::destroy_zero<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::scrap::SCRAP>(arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::scrap::SCRAP>>(arg3, v0);
        };
        if (0x2::coin::value<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::alloy::ALLOY>(&arg4) == 0) {
            0x2::coin::destroy_zero<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::alloy::ALLOY>(arg4);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::alloy::ALLOY>>(arg4, v0);
        };
        let v2 = 0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::mint::burn_scrap(arg2, 0x2::coin::split<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::scrap::SCRAP>(&mut arg3, arg0.price_scrap, arg5));
        let v3 = 0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::mint::burn_alloy(arg2, 0x2::coin::split<0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::alloy::ALLOY>(&mut arg4, arg0.price_alloy, arg5));
        let v4 = 0x2::random::new_generator(arg1, arg5);
        let v5 = (0x2::random::generate_u64_in_range(&mut v4, 4, 9) as u8);
        let v6 = (0x2::random::generate_u64_in_range(&mut v4, 4, 9) as u8);
        let v7 = (0x2::random::generate_u64_in_range(&mut v4, 6, 10) as u8);
        if (0x2::table::contains<address, u64>(&arg0.minted_by, v0)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.minted_by, v0) = v1 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.minted_by, v0, 1);
        };
        arg0.minted = arg0.minted + 1;
        let v8 = arg0.minted;
        let v9 = build_unit(arg0, v5, v6, v7, v8, arg5);
        0x2::transfer::public_transfer<0xb3f4f4999848397dcf287dd20c395527e8dead74e2c2b3197111765d046a2352::wall_builder::WallBuilder>(v9, v0);
        let v10 = WallBuilderMinted{
            buyer      : v0,
            builder_id : 0x2::object::id<0xb3f4f4999848397dcf287dd20c395527e8dead74e2c2b3197111765d046a2352::wall_builder::WallBuilder>(&v9),
            build      : v5,
            stock      : v6,
            armour     : v7,
            serial     : v8,
            scrap      : v2,
            alloy      : v3,
        };
        0x2::event::emit<WallBuilderMinted>(v10);
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

    public fun prices(arg0: &Config) : (u64, u64) {
        (arg0.price_scrap, arg0.price_alloy)
    }

    public fun set_media_base(arg0: &AdminCap, arg1: &mut Config, arg2: 0x1::string::String) {
        arg1.media_base = arg2;
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.paused = arg2;
    }

    public fun set_prices(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64) {
        arg1.price_scrap = arg2;
        arg1.price_alloy = arg3;
    }

    public fun wallet_cap() : u64 {
        5
    }

    // decompiled from Move bytecode v7
}

