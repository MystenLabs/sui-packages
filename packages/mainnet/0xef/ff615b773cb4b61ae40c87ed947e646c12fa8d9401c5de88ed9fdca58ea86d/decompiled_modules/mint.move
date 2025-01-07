module 0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::mint {
    struct BlubWhitelistTicket has store, key {
        id: 0x2::object::UID,
    }

    struct CollectionData has store, key {
        id: 0x2::object::UID,
        nfts: 0x2::table_vec::TableVec<0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::BlubberData>,
        registry: 0x2::table::Table<address, u64>,
        mint_wl_date: u64,
        mint_buy_date: u64,
        mint_end_date: u64,
        mint_buy_price: u64,
    }

    struct MINT has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: BlubWhitelistTicket, arg1: &mut CollectionData, arg2: &0x2::transfer_policy::TransferPolicy<0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::Blubber>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) >= arg1.mint_wl_date, 9223372423401832447);
        assert!(0x2::clock::timestamp_ms(arg3) <= arg1.mint_end_date, 9223372427696799743);
        let BlubWhitelistTicket { id: v0 } = arg0;
        0x2::object::delete(v0);
        let v1 = if (0x2::table_vec::length<0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::BlubberData>(&arg1.nfts) == 1) {
            0
        } else {
            0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::pseuso_random::rng(0, 0x2::table_vec::length<0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::BlubberData>(&arg1.nfts) - 1, arg3, arg6)
        };
        let v2 = if (0x2::table_vec::length<0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::BlubberData>(&arg1.nfts) == 1) {
            0x2::table_vec::pop_back<0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::BlubberData>(&mut arg1.nfts)
        } else {
            0x2::table_vec::swap_remove<0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::BlubberData>(&mut arg1.nfts, v1)
        };
        0x2::kiosk::lock<0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::Blubber>(arg4, arg5, arg2, 0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::mint(v2, arg6));
    }

    public fun admin_mint(arg0: &0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::cap::MintCap, arg1: u64, arg2: &mut CollectionData, arg3: &0x2::transfer_policy::TransferPolicy<0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::Blubber>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &mut 0x2::tx_context::TxContext) {
        while (arg1 > 0) {
            let v0 = if (0x2::table_vec::length<0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::BlubberData>(&arg2.nfts) == 1) {
                0
            } else {
                0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::pseuso_random::rng(0, 0x2::table_vec::length<0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::BlubberData>(&arg2.nfts) - 1, arg4, arg7)
            };
            let v1 = if (0x2::table_vec::length<0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::BlubberData>(&arg2.nfts) == 1) {
                0x2::table_vec::pop_back<0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::BlubberData>(&mut arg2.nfts)
            } else {
                0x2::table_vec::swap_remove<0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::BlubberData>(&mut arg2.nfts, v0)
            };
            0x2::kiosk::lock<0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::Blubber>(arg5, arg6, arg3, 0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::mint(v1, arg7));
            arg1 = arg1 - 1;
        };
    }

    public fun create_data(arg0: &0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::cap::MintCap, arg1: &mut CollectionData, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut vector<0x1::string::String>, arg5: &mut vector<0x1::string::String>, arg6: 0x2::coin::Coin<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB>) {
        0x2::table_vec::push_back<0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::BlubberData>(&mut arg1.nfts, 0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::create(arg2, arg3, arg4, arg5, arg6));
    }

    public fun direct_mint(arg0: &0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::cap::MintCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut vector<0x1::string::String>, arg4: &mut vector<0x1::string::String>, arg5: 0x2::coin::Coin<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB>, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: &0x2::transfer_policy::TransferPolicy<0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::Blubber>, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk::lock<0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::Blubber>(arg6, arg7, arg8, 0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::mint(0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::create(arg1, arg2, arg3, arg4, arg5), arg9));
    }

    public fun distribute_wl(arg0: &0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::cap::MintCap, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg1) > 0) {
            let v0 = BlubWhitelistTicket{id: 0x2::object::new(arg2)};
            0x2::transfer::public_transfer<BlubWhitelistTicket>(v0, 0x1::vector::pop_back<address>(&mut arg1));
        };
    }

    fun init(arg0: MINT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CollectionData{
            id             : 0x2::object::new(arg1),
            nfts           : 0x2::table_vec::empty<0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::BlubberData>(arg1),
            registry       : 0x2::table::new<address, u64>(arg1),
            mint_wl_date   : 1727377200000,
            mint_buy_date  : 1727463600000,
            mint_end_date  : 1727722800000,
            mint_buy_price : 10000000000,
        };
        0x2::transfer::public_share_object<CollectionData>(v0);
        let v1 = 0x2::package::claim<MINT>(arg0, arg1);
        let v2 = 0x2::display::new<BlubWhitelistTicket>(&v1, arg1);
        0x2::display::add<BlubWhitelistTicket>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Blubbers Whitelist Ticket"));
        0x2::display::add<BlubWhitelistTicket>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Blubbers Whitelist Ticket! Burn this ticket to mint a Blubber for free!"));
        0x2::display::add<BlubWhitelistTicket>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://blubbersnft.com/ticket.jpg"));
        0x2::display::update_version<BlubWhitelistTicket>(&mut v2);
        0x2::transfer::public_transfer<0x2::display::Display<BlubWhitelistTicket>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_buy(arg0: 0x2::coin::Coin<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB>, arg1: &mut CollectionData, arg2: &0x2::transfer_policy::TransferPolicy<0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::Blubber>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) >= arg1.mint_buy_date, 9223372552250851327);
        assert!(0x2::clock::timestamp_ms(arg3) <= arg1.mint_end_date, 9223372556545818623);
        assert!(arg1.mint_buy_price <= 0x2::coin::value<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB>(&arg0), 9223372565135753215);
        if (0x2::table::contains<address, u64>(&arg1.registry, 0x2::tx_context::sender(arg6))) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg1.registry, 0x2::tx_context::sender(arg6));
            assert!(*v0 < 2, 0);
            *v0 = *v0 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg1.registry, 0x2::tx_context::sender(arg6), 1);
        };
        let v1 = if (0x2::table_vec::length<0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::BlubberData>(&arg1.nfts) == 1) {
            0
        } else {
            0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::pseuso_random::rng(0, 0x2::table_vec::length<0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::BlubberData>(&arg1.nfts) - 1, arg3, arg6)
        };
        let v2 = if (0x2::table_vec::length<0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::BlubberData>(&arg1.nfts) == 1) {
            0x2::table_vec::pop_back<0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::BlubberData>(&mut arg1.nfts)
        } else {
            0x2::table_vec::swap_remove<0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::BlubberData>(&mut arg1.nfts, v1)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB>>(arg0, @0x8e9a48fcdcd04180517aaf118e58d0b2bec3484f97b200aa6cda0d8028b038be);
        0x2::kiosk::lock<0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::Blubber>(arg4, arg5, arg2, 0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::mint(v2, arg6));
    }

    public fun mint_rest(arg0: &0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::cap::MintCap, arg1: &mut CollectionData, arg2: &0x2::transfer_policy::TransferPolicy<0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::Blubber>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table_vec::length<0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::BlubberData>(&arg1.nfts) > 0, 9223373084826796031);
        assert!(arg1.mint_end_date < 0x2::clock::timestamp_ms(arg5), 9223373089121763327);
        while (0x2::table_vec::length<0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::BlubberData>(&arg1.nfts) > 0) {
            0x2::kiosk::lock<0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::Blubber>(arg3, arg4, arg2, 0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::mint(0x2::table_vec::pop_back<0xefff615b773cb4b61ae40c87ed947e646c12fa8d9401c5de88ed9fdca58ea86d::collection::BlubberData>(&mut arg1.nfts), arg6));
        };
    }

    // decompiled from Move bytecode v6
}

