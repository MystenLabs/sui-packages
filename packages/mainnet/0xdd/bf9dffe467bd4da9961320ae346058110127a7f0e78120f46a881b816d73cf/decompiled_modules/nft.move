module 0xddbf9dffe467bd4da9961320ae346058110127a7f0e78120f46a881b816d73cf::nft {
    struct Tako has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct Box has store, key {
        id: 0x2::object::UID,
        rarity: 0x1::string::String,
    }

    struct Configuration has key {
        id: 0x2::object::UID,
        admin: address,
        box_config: 0x2::table::Table<0x1::string::String, BoxConfig>,
        whitelist_config: WhitelistConfig,
        public_sale_start: u64,
        can_reveal: bool,
    }

    struct FundStorage has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct BoxConfig has copy, drop, store {
        max_supply: u64,
        supply: u64,
        price: u64,
        whitelist_allocation: u64,
        tier1_chance: u64,
        tier2_chance: u64,
        tier3_chance: u64,
        tier4_chance: u64,
    }

    struct WhitelistConfig has store {
        whitelist: 0x2::table::Table<address, u64>,
        whitelist_start: u64,
        whitelist_end: u64,
    }

    struct TakoAttributes has copy, drop, store {
        image_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct AttributesRegistry has store, key {
        id: 0x2::object::UID,
        available_attributes: 0x2::vec_map::VecMap<0x1::string::String, vector<TakoAttributes>>,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    public fun add_attributes(arg0: &mut Configuration, arg1: &mut AttributesRegistry, arg2: 0x1::string::String, arg3: TakoAttributes, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0);
        if (0x2::vec_map::contains<0x1::string::String, vector<TakoAttributes>>(&arg1.available_attributes, &arg2) == true) {
            let v0 = *0x2::vec_map::get_mut<0x1::string::String, vector<TakoAttributes>>(&mut arg1.available_attributes, &arg2);
            0x1::vector::push_back<TakoAttributes>(&mut v0, arg3);
            *0x2::vec_map::get_mut<0x1::string::String, vector<TakoAttributes>>(&mut arg1.available_attributes, &arg2) = v0;
        } else {
            0x2::vec_map::insert<0x1::string::String, vector<TakoAttributes>>(&mut arg1.available_attributes, arg2, 0x1::vector::singleton<TakoAttributes>(arg3));
        };
    }

    public fun batch_add_attributes(arg0: &mut Configuration, arg1: &mut AttributesRegistry, arg2: vector<0x1::string::String>, arg3: vector<TakoAttributes>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0);
        assert!(0x1::vector::length<0x1::string::String>(&arg2) == 0x1::vector::length<TakoAttributes>(&arg3), 5);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            add_attributes(arg0, arg1, *0x1::vector::borrow<0x1::string::String>(&arg2, v0), *0x1::vector::borrow<TakoAttributes>(&arg3, v0), arg4);
            v0 = v0 + 1;
        };
    }

    public fun batch_update_whitelist_allocation(arg0: &mut Configuration, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 5);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            update_whitelist_allocation(arg0, *0x1::vector::borrow<address>(&arg1, v0), *0x1::vector::borrow<u64>(&arg2, v0), arg3);
            v0 = v0 + 1;
        };
    }

    fun buy_boxes(arg0: &mut Configuration, arg1: &mut FundStorage, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<0x1::string::String, BoxConfig>(&mut arg0.box_config, arg2);
        let v1 = take_fee(arg1, arg3, v0, arg4);
        v0.supply = v0.supply - v1;
        if (arg4) {
            v0.whitelist_allocation = v0.whitelist_allocation - v1;
        };
        let v2 = 0;
        while (v2 < v1) {
            let v3 = Box{
                id     : 0x2::object::new(arg5),
                rarity : arg2,
            };
            0x2::transfer::public_transfer<Box>(v3, 0x2::tx_context::sender(arg5));
            v2 = v2 + 1;
        };
    }

    public fun change_admin(arg0: &mut Configuration, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.admin = arg1;
    }

    public fun claim_fee(arg0: &mut Configuration, arg1: &mut FundStorage, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, arg2, arg3)
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = WhitelistConfig{
            whitelist       : 0x2::table::new<address, u64>(arg1),
            whitelist_start : 0,
            whitelist_end   : 0,
        };
        let v1 = Configuration{
            id                : 0x2::object::new(arg1),
            admin             : 0x2::tx_context::sender(arg1),
            box_config        : 0x2::table::new<0x1::string::String, BoxConfig>(arg1),
            whitelist_config  : v0,
            public_sale_start : 0,
            can_reveal        : false,
        };
        let v2 = FundStorage{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v3 = AttributesRegistry{
            id                   : 0x2::object::new(arg1),
            available_attributes : 0x2::vec_map::empty<0x1::string::String, vector<TakoAttributes>>(),
        };
        0x2::table::add<0x1::string::String, BoxConfig>(&mut v1.box_config, 0x1::string::utf8(b"common"), new_box_config(2500, 1, 250, 70, 25, 5, 0));
        0x2::table::add<0x1::string::String, BoxConfig>(&mut v1.box_config, 0x1::string::utf8(b"rare"), new_box_config(4777, 2, 477, 35, 48, 15, 2));
        0x2::table::add<0x1::string::String, BoxConfig>(&mut v1.box_config, 0x1::string::utf8(b"legendary"), new_box_config(500, 3, 50, 0, 0, 70, 30));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"project_url"));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://placehold.co/600x400/"));
        let v8 = 0x2::package::claim<NFT>(arg0, arg1);
        let (v9, v10) = 0x2::transfer_policy::new<Tako>(&v8, arg1);
        let v11 = v10;
        let v12 = v9;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Tako>(&mut v12, &v11, 1000, 1000000000000000000);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Tako>(&mut v12, &v11);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Tako>>(v12);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Tako>>(v11, 0x2::tx_context::sender(arg1));
        let v13 = 0x2::display::new_with_fields<Tako>(&v8, v4, v6, arg1);
        0x2::display::update_version<Tako>(&mut v13);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v8, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Tako>>(v13, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Configuration>(v1);
        0x2::transfer::share_object<FundStorage>(v2);
        0x2::transfer::share_object<AttributesRegistry>(v3);
    }

    public fun new_box_config(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : BoxConfig {
        BoxConfig{
            max_supply           : arg0,
            supply               : arg0,
            price                : arg1,
            whitelist_allocation : arg2,
            tier1_chance         : arg3,
            tier2_chance         : arg4,
            tier3_chance         : arg5,
            tier4_chance         : arg6,
        }
    }

    public fun new_tako_attributes(arg0: 0x1::string::String, arg1: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) : TakoAttributes {
        TakoAttributes{
            image_url  : arg0,
            attributes : arg1,
        }
    }

    public fun public_buy_boxes(arg0: &mut Configuration, arg1: &mut FundStorage, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.public_sale_start != 0 && arg0.public_sale_start <= 0x2::clock::timestamp_ms(arg4), 2);
        buy_boxes(arg0, arg1, arg2, arg3, false, arg5);
    }

    public fun remove_box_config(arg0: &mut Configuration, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        if (0x2::table::contains<0x1::string::String, BoxConfig>(&arg0.box_config, arg1) == true) {
            0x2::table::remove<0x1::string::String, BoxConfig>(&mut arg0.box_config, arg1);
        };
    }

    entry fun reveal_box(arg0: &Configuration, arg1: &mut AttributesRegistry, arg2: Box, arg3: &0x2::random::Random, arg4: &mut 0x2::kiosk::Kiosk, arg5: &mut 0x2::kiosk::KioskOwnerCap, arg6: &mut 0x2::transfer_policy::TransferPolicy<Tako>, arg7: &mut 0x2::transfer_policy::TransferPolicyCap<Tako>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.can_reveal == true, 4);
        let Box {
            id     : v0,
            rarity : v1,
        } = arg2;
        let v2 = 0x2::random::new_generator(arg3, arg8);
        let v3 = &mut v2;
        0x2::object::delete(v0);
        0x2::kiosk::lock<Tako>(arg4, arg5, arg6, reveal_nft(arg1, v3, 0x2::table::borrow<0x1::string::String, BoxConfig>(&arg0.box_config, v1), arg8));
    }

    fun reveal_nft(arg0: &mut AttributesRegistry, arg1: &mut 0x2::random::RandomGenerator, arg2: &BoxConfig, arg3: &mut 0x2::tx_context::TxContext) : Tako {
        let v0 = (0x2::random::generate_u128_in_range(arg1, 0, 99) as u64);
        let v1 = if (v0 < arg2.tier1_chance) {
            0x1::string::utf8(b"Pirate")
        } else if (v0 < arg2.tier1_chance + arg2.tier2_chance) {
            0x1::string::utf8(b"Ninja")
        } else if (v0 < arg2.tier1_chance + arg2.tier2_chance + arg2.tier3_chance) {
            0x1::string::utf8(b"Tengu")
        } else {
            0x1::string::utf8(b"Samurai")
        };
        let v2 = *0x2::vec_map::get_mut<0x1::string::String, vector<TakoAttributes>>(&mut arg0.available_attributes, &v1);
        assert!(0x1::vector::length<TakoAttributes>(&v2) > 0, 6);
        let v3 = 0x1::vector::swap_remove<TakoAttributes>(&mut v2, 0x2::random::generate_u64_in_range(arg1, 0, 0x1::vector::length<TakoAttributes>(&v2) - 1));
        let v4 = Tako{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(b"Tako"),
            image_url   : v3.image_url,
            description : 0x1::string::utf8(b"Tako"),
            attributes  : v3.attributes,
        };
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v4.attributes, 0x1::string::utf8(b"tier"), v1);
        v4
    }

    public fun set_can_reveal(arg0: &mut Configuration, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.can_reveal = arg1;
    }

    fun take_fee(arg0: &mut FundStorage, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &BoxConfig, arg3: bool) : u64 {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1) / arg2.price;
        assert!(v0 > 0, 1);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
        if (arg3 == false) {
            let v2 = v0 + v0 / 10 * 3;
            let v3 = v2;
            if (v0 % 5 == 0) {
                v3 = v2 + 1;
            };
            v3
        } else {
            v0
        }
    }

    public fun update_box_config(arg0: &mut Configuration, arg1: 0x1::string::String, arg2: BoxConfig, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        if (0x2::table::contains<0x1::string::String, BoxConfig>(&arg0.box_config, arg1) == true) {
            *0x2::table::borrow_mut<0x1::string::String, BoxConfig>(&mut arg0.box_config, arg1) = arg2;
        } else {
            0x2::table::add<0x1::string::String, BoxConfig>(&mut arg0.box_config, arg1, arg2);
        };
    }

    public fun update_public_sale_start(arg0: &mut Configuration, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.public_sale_start = arg1;
    }

    public fun update_whitelist_allocation(arg0: &mut Configuration, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        if (0x2::table::contains<address, u64>(&arg0.whitelist_config.whitelist, arg1) == true) {
            if (arg2 == 0) {
                0x2::table::remove<address, u64>(&mut arg0.whitelist_config.whitelist, arg1);
            } else {
                *0x2::table::borrow_mut<address, u64>(&mut arg0.whitelist_config.whitelist, arg1) = arg2;
            };
        } else {
            if (arg2 == 0) {
                return
            };
            0x2::table::add<address, u64>(&mut arg0.whitelist_config.whitelist, arg1, arg2);
        };
    }

    public fun update_whitelist_dates(arg0: &mut Configuration, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        arg0.whitelist_config.whitelist_start = arg1;
        arg0.whitelist_config.whitelist_end = arg2;
    }

    public fun whitelist_buy_boxess(arg0: &mut Configuration, arg1: &mut FundStorage, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.whitelist_config.whitelist_start <= 0x2::clock::timestamp_ms(arg4), 2);
        assert!(arg0.whitelist_config.whitelist_end >= 0x2::clock::timestamp_ms(arg4), 3);
        buy_boxes(arg0, arg1, arg2, arg3, true, arg5);
    }

    // decompiled from Move bytecode v6
}

