module 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::orchestrator {
    struct ORCHESTRATOR has drop {
        dummy_field: bool,
    }

    struct WhitelistTicket has key {
        id: 0x2::object::UID,
        waterCoolerId: 0x2::object::ID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        phase: u8,
    }

    struct OriginalGangsterTicket has key {
        id: 0x2::object::UID,
        waterCoolerId: 0x2::object::ID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        phase: u8,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        minter: address,
    }

    struct OrchAdminCap has key {
        id: 0x2::object::UID,
        for_settings: 0x2::object::ID,
        for_warehouse: 0x2::object::ID,
    }

    struct OrchCap has key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    public(friend) fun create_mint_distributer(arg0: &mut 0x2::tx_context::TxContext) : (0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::settings::Settings, 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::warehouse::Warehouse) {
        let v0 = 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::settings::new(arg0);
        let v1 = 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::warehouse::new(arg0);
        let v2 = OrchAdminCap{
            id            : 0x2::object::new(arg0),
            for_settings  : 0x2::object::id<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::settings::Settings>(&v0),
            for_warehouse : 0x2::object::id<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::warehouse::Warehouse>(&v1),
        };
        0x2::transfer::transfer<OrchAdminCap>(v2, 0x2::tx_context::sender(arg0));
        (v0, v1)
    }

    public fun create_og_ticket(arg0: &OrchAdminCap, arg1: &0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::WaterCooler, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = OriginalGangsterTicket{
            id            : 0x2::object::new(arg3),
            waterCoolerId : 0x2::object::id<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::WaterCooler>(arg1),
            name          : 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::name(arg1),
            image_url     : 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::placeholder_image(arg1),
            phase         : 1,
        };
        0x2::transfer::transfer<OriginalGangsterTicket>(v0, arg2);
    }

    public fun create_og_ticket_bulk(arg0: &OrchAdminCap, arg1: &0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::WaterCooler, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg2) > 0) {
            let v0 = OriginalGangsterTicket{
                id            : 0x2::object::new(arg3),
                waterCoolerId : 0x2::object::id<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::WaterCooler>(arg1),
                name          : 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::name(arg1),
                image_url     : 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::placeholder_image(arg1),
                phase         : 1,
            };
            0x2::transfer::transfer<OriginalGangsterTicket>(v0, 0x1::vector::pop_back<address>(&mut arg2));
        };
    }

    public fun create_wl_ticket(arg0: &OrchAdminCap, arg1: &0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::WaterCooler, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = WhitelistTicket{
            id            : 0x2::object::new(arg3),
            waterCoolerId : 0x2::object::id<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::WaterCooler>(arg1),
            name          : 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::name(arg1),
            image_url     : 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::placeholder_image(arg1),
            phase         : 2,
        };
        0x2::transfer::transfer<WhitelistTicket>(v0, arg2);
    }

    public fun create_wl_ticket_bulk(arg0: &OrchAdminCap, arg1: &0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::WaterCooler, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg2) > 0) {
            let v0 = WhitelistTicket{
                id            : 0x2::object::new(arg3),
                waterCoolerId : 0x2::object::id<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::WaterCooler>(arg1),
                name          : 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::name(arg1),
                image_url     : 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::placeholder_image(arg1),
                phase         : 2,
            };
            0x2::transfer::transfer<WhitelistTicket>(v0, 0x1::vector::pop_back<address>(&mut arg2));
        };
    }

    public fun destroy_mint_warehouse(arg0: &OrchAdminCap, arg1: 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::warehouse::Warehouse) {
        assert!(0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::warehouse::is_empty(&arg1), 8);
        assert!(0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::warehouse::is_initialized(&arg1) == true, 9);
        assert!(0x2::object::id<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::warehouse::Warehouse>(&arg1) == arg0.for_warehouse, 0);
        0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::warehouse::delete(arg1);
    }

    public fun get_mintwarehouse_length(arg0: &0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::warehouse::Warehouse) : u64 {
        0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::warehouse::count(arg0)
    }

    fun init(arg0: ORCHESTRATOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ORCHESTRATOR>(arg0, arg1);
        let v1 = 0x2::display::new<WhitelistTicket>(&v0, arg1);
        0x2::display::add<WhitelistTicket>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name} WL Ticket"));
        0x2::display::add<WhitelistTicket>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<WhitelistTicket>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::update_version<WhitelistTicket>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<WhitelistTicket>>(v1, 0x2::tx_context::sender(arg1));
        let v2 = 0x2::display::new<OriginalGangsterTicket>(&v0, arg1);
        0x2::display::add<OriginalGangsterTicket>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name} OG Ticket"));
        0x2::display::add<OriginalGangsterTicket>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<OriginalGangsterTicket>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::update_version<OriginalGangsterTicket>(&mut v2);
        0x2::transfer::public_transfer<0x2::display::Display<OriginalGangsterTicket>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_capsule(arg0: &0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::factory_settings::FactorySetings, arg1: &mut 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::WaterCooler, arg2: &mut 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::warehouse::Warehouse, arg3: &0x2::transfer_policy::TransferPolicy<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::rinoco::Rinoco>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::warehouse::pop_nft(arg2);
        let (v1, v2) = 0x2::kiosk::new(arg5);
        let v3 = v2;
        let v4 = v1;
        let v5 = NFTMinted{
            nft_id   : 0x2::object::id<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::rinoco::Rinoco>(&v0),
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(&v4),
            minter   : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<NFTMinted>(v5);
        0x2::kiosk::place<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::rinoco::Rinoco>(&mut v4, &v3, v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
        0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::factory_settings::send_fees(arg0, 0x2::coin::take<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg4), 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::factory_settings::get_mint_fee(arg0), arg5));
        0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::send_fees(arg1, arg4);
        0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::inc_minted(arg1);
    }

    public fun og_mint(arg0: OriginalGangsterTicket, arg1: &0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::factory_settings::FactorySetings, arg2: &mut 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::WaterCooler, arg3: &mut 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::warehouse::Warehouse, arg4: &0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::settings::Settings, arg5: &0x2::transfer_policy::TransferPolicy<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::rinoco::Rinoco>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::get_warehouse_id(arg2) == 0x2::object::id<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::warehouse::Warehouse>(arg3), 15);
        assert!(0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::get_settings_id(arg2) == 0x2::object::id<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::settings::Settings>(arg4), 14);
        let OriginalGangsterTicket {
            id            : v0,
            waterCoolerId : v1,
            name          : _,
            image_url     : _,
            phase         : v4,
        } = arg0;
        assert!(0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::settings::status(arg4) == 1, 6);
        assert!(v4 == 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::settings::phase(arg4), 5);
        assert!(v1 == 0x2::object::id<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::WaterCooler>(arg2), 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) == 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::settings::price(arg4), 1);
        mint_capsule(arg1, arg2, arg3, arg5, arg6, arg7);
        0x2::object::delete(v0);
    }

    public entry fun public_mint(arg0: &mut 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::WaterCooler, arg1: &0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::factory_settings::FactorySetings, arg2: &mut 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::warehouse::Warehouse, arg3: &0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::settings::Settings, arg4: &0x2::transfer_policy::TransferPolicy<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::rinoco::Rinoco>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::get_warehouse_id(arg0) == 0x2::object::id<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::warehouse::Warehouse>(arg2), 15);
        assert!(0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::get_settings_id(arg0) == 0x2::object::id<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::settings::Settings>(arg3), 14);
        assert!(0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::warehouse::count(arg2) > 0, 11);
        assert!(0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::settings::phase(arg3) == 3, 12);
        assert!(0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::settings::status(arg3) == 1, 6);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) == 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::settings::price(arg3), 1);
        mint_capsule(arg1, arg0, arg2, arg4, arg5, arg6);
    }

    public fun set_mint_phase(arg0: &OrchAdminCap, arg1: &mut 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::settings::Settings, arg2: u8) {
        assert!(0x2::object::id<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::settings::Settings>(arg1) == arg0.for_settings, 0);
        assert!(arg2 >= 1 && arg2 <= 3, 2);
        0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::settings::set_phase(arg1, arg2);
    }

    public fun set_mint_price(arg0: &OrchAdminCap, arg1: &mut 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::settings::Settings, arg2: u64) {
        assert!(0x2::object::id<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::settings::Settings>(arg1) == arg0.for_settings, 0);
        assert!(arg2 >= 0, 3);
        0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::settings::set_price(arg1, arg2);
    }

    public fun set_mint_status(arg0: &OrchAdminCap, arg1: &mut 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::settings::Settings, arg2: u8) {
        assert!(0x2::object::id<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::settings::Settings>(arg1) == arg0.for_settings, 0);
        assert!(arg2 == 0 || arg2 == 1, 4);
        0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::settings::set_status(arg1, arg2);
    }

    public fun stock_warehouse(arg0: &OrchAdminCap, arg1: &0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::WaterCooler, arg2: vector<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::rinoco::Rinoco>, arg3: &mut 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::warehouse::Warehouse) {
        assert!(0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::get_is_initialized(arg1), 16);
        assert!(0x2::object::id<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::warehouse::Warehouse>(arg3) == arg0.for_warehouse, 0);
        0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::warehouse::stock(arg3, 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::supply(arg1), arg2);
    }

    public fun whitelist_mint(arg0: WhitelistTicket, arg1: &0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::factory_settings::FactorySetings, arg2: &mut 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::WaterCooler, arg3: &mut 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::warehouse::Warehouse, arg4: &0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::settings::Settings, arg5: &0x2::transfer_policy::TransferPolicy<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::rinoco::Rinoco>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::get_warehouse_id(arg2) == 0x2::object::id<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::warehouse::Warehouse>(arg3), 15);
        assert!(0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::get_settings_id(arg2) == 0x2::object::id<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::settings::Settings>(arg4), 14);
        let WhitelistTicket {
            id            : v0,
            waterCoolerId : v1,
            name          : _,
            image_url     : _,
            phase         : v4,
        } = arg0;
        assert!(0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::settings::status(arg4) == 1, 6);
        assert!(v4 == 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::settings::phase(arg4), 5);
        assert!(v1 == 0x2::object::id<0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::water_cooler::WaterCooler>(arg2), 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) == 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::settings::price(arg4), 1);
        mint_capsule(arg1, arg2, arg3, arg5, arg6, arg7);
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

