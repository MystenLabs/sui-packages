module 0xaf1659401f3abe67cdcfed6131949a73cc76509656b8be6f25d002127c9f24a1::pixsui_kiosk {
    struct TileListedInKiosk has copy, drop {
        tile_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        owner: address,
        price: u64,
    }

    struct TilePurchasedFromKiosk has copy, drop {
        tile_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        buyer: address,
        seller: address,
        price: u64,
    }

    public fun buy_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>) : (0xaf1659401f3abe67cdcfed6131949a73cc76509656b8be6f25d002127c9f24a1::pixsui::Tile, 0x2::transfer_policy::TransferRequest<0xaf1659401f3abe67cdcfed6131949a73cc76509656b8be6f25d002127c9f24a1::pixsui::Tile>) {
        assert!(0x2::kiosk::has_item(arg0, arg1), 2);
        assert!(0x2::kiosk::is_listed(arg0, arg1), 4);
        0x2::kiosk::purchase<0xaf1659401f3abe67cdcfed6131949a73cc76509656b8be6f25d002127c9f24a1::pixsui::Tile>(arg0, arg1, arg2)
    }

    public entry fun buy_tile_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::transfer_policy::TransferPolicy<0xaf1659401f3abe67cdcfed6131949a73cc76509656b8be6f25d002127c9f24a1::pixsui::Tile>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_item(arg0, arg1), 2);
        assert!(0x2::kiosk::is_listed(arg0, arg1), 4);
        let v0 = 0x2::kiosk::owner(arg0);
        assert!(0x2::tx_context::sender(arg4) != v0, 1);
        let (v1, v2) = 0x2::kiosk::purchase<0xaf1659401f3abe67cdcfed6131949a73cc76509656b8be6f25d002127c9f24a1::pixsui::Tile>(arg0, arg1, arg2);
        let v3 = v2;
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xaf1659401f3abe67cdcfed6131949a73cc76509656b8be6f25d002127c9f24a1::pixsui::Tile>(arg3, v3);
        let v7 = TilePurchasedFromKiosk{
            tile_id  : arg1,
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            buyer    : 0x2::tx_context::sender(arg4),
            seller   : v0,
            price    : 0x2::transfer_policy::paid<0xaf1659401f3abe67cdcfed6131949a73cc76509656b8be6f25d002127c9f24a1::pixsui::Tile>(&v3),
        };
        0x2::event::emit<TilePurchasedFromKiosk>(v7);
        0x2::transfer::public_transfer<0xaf1659401f3abe67cdcfed6131949a73cc76509656b8be6f25d002127c9f24a1::pixsui::Tile>(v1, 0x2::tx_context::sender(arg4));
    }

    public entry fun create_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
    }

    public entry fun delist_tile(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::owner(arg0) == 0x2::tx_context::sender(arg3), 1);
        assert!(0x2::kiosk::has_access(arg0, arg1), 1);
        assert!(0x2::kiosk::has_item(arg0, arg2), 2);
        assert!(0x2::kiosk::is_listed(arg0, arg2), 4);
        0x2::kiosk::delist<0xaf1659401f3abe67cdcfed6131949a73cc76509656b8be6f25d002127c9f24a1::pixsui::Tile>(arg0, arg1, arg2);
    }

    public entry fun list_tile_in_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::owner(arg0) == 0x2::tx_context::sender(arg4), 1);
        assert!(0x2::kiosk::has_access(arg0, arg1), 1);
        assert!(0x2::kiosk::has_item(arg0, arg2), 2);
        assert!(!0x2::kiosk::is_listed(arg0, arg2), 3);
        assert!(arg3 > 0, 5);
        0x2::kiosk::list<0xaf1659401f3abe67cdcfed6131949a73cc76509656b8be6f25d002127c9f24a1::pixsui::Tile>(arg0, arg1, arg2, arg3);
        let v0 = TileListedInKiosk{
            tile_id  : arg2,
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            owner    : 0x2::tx_context::sender(arg4),
            price    : arg3,
        };
        0x2::event::emit<TileListedInKiosk>(v0);
    }

    public entry fun place_tile_in_kiosk(arg0: 0xaf1659401f3abe67cdcfed6131949a73cc76509656b8be6f25d002127c9f24a1::pixsui::Tile, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::owner(arg1) == 0x2::tx_context::sender(arg3), 1);
        assert!(0x2::kiosk::has_access(arg1, arg2), 1);
        0x2::kiosk::place<0xaf1659401f3abe67cdcfed6131949a73cc76509656b8be6f25d002127c9f24a1::pixsui::Tile>(arg1, arg2, arg0);
    }

    public entry fun take_tile(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::owner(arg0) == 0x2::tx_context::sender(arg3), 1);
        assert!(0x2::kiosk::has_access(arg0, arg1), 1);
        assert!(0x2::kiosk::has_item(arg0, arg2), 2);
        assert!(!0x2::kiosk::is_listed(arg0, arg2), 3);
        0x2::transfer::public_transfer<0xaf1659401f3abe67cdcfed6131949a73cc76509656b8be6f25d002127c9f24a1::pixsui::Tile>(0x2::kiosk::take<0xaf1659401f3abe67cdcfed6131949a73cc76509656b8be6f25d002127c9f24a1::pixsui::Tile>(arg0, arg1, arg2), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_profits(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::owner(arg0) == 0x2::tx_context::sender(arg2), 1);
        assert!(0x2::kiosk::has_access(arg0, arg1), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::kiosk::withdraw(arg0, arg1, 0x1::option::none<u64>(), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

