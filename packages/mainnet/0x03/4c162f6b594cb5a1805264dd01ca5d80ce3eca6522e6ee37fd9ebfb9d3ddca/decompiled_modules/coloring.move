module 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::coloring {
    struct COLORING has drop {
        dummy_field: bool,
    }

    struct ColoringReceipt has key {
        id: 0x2::object::UID,
        number: u16,
        pfp_id: 0x2::object::ID,
        studio_id: 0x2::object::ID,
        level: u8,
    }

    struct ColoringSettings has key {
        id: 0x2::object::UID,
        lvl1_price_koto: u64,
        lvl1_price_sui: u64,
        lvl2_price_koto: u64,
        lvl2_price_sui: u64,
    }

    struct ColoringStudioRegistry has key {
        id: 0x2::object::UID,
        studios: 0x2::table::Table<u16, 0x2::object::ID>,
    }

    struct ColoringStudio has key {
        id: 0x2::object::UID,
        number: u16,
        level: u8,
        image: 0x1::option::Option<0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::image::Image>,
        is_fulfilled: bool,
    }

    struct ColoringTicket has store, key {
        id: 0x2::object::UID,
        level: u8,
    }

    struct FulfillColoringCap has key {
        id: 0x2::object::UID,
        number: u16,
        level: u8,
        studio_id: 0x2::object::ID,
        create_image_cap_id: 0x2::object::ID,
    }

    public fun admin_fulfill_coloring(arg0: FulfillColoringCap, arg1: 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::image::Image, arg2: &mut ColoringStudio) {
        0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::image::verify_image_chunks_registered(&arg1);
        assert!(arg0.studio_id == 0x2::object::id<ColoringStudio>(arg2), 6);
        assert!(arg0.number == 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::image::number(&arg1), 4);
        assert!(arg0.level == 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::image::level(&arg1), 3);
        0x1::option::fill<0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::image::Image>(&mut arg2.image, arg1);
        arg2.is_fulfilled = true;
        let FulfillColoringCap {
            id                  : v0,
            number              : _,
            level               : _,
            studio_id           : _,
            create_image_cap_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun admin_issue_coloring_ticket(arg0: &0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::admin::AdminCap, arg1: u8, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::admin::verify_admin_cap(arg0, arg3);
        0x2::transfer::transfer<ColoringTicket>(create_coloring_ticket_internal(arg1, arg3), arg2);
    }

    public fun admin_set_coloring_prices(arg0: &0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::admin::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut ColoringSettings, arg6: &mut 0x2::tx_context::TxContext) {
        0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::admin::verify_admin_cap(arg0, arg6);
        arg5.lvl1_price_koto = arg1;
        arg5.lvl1_price_sui = arg2;
        arg5.lvl2_price_koto = arg3;
        arg5.lvl2_price_sui = arg4;
    }

    public fun buy_coloring_ticket(arg0: u8, arg1: 0x2::coin::Coin<0xa99166e802527eeb5439cbda12b0a02851bf2305d3c96a592b1440014fcb8975::koto::KOTO>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &ColoringSettings, arg4: &mut 0x2::tx_context::TxContext) : ColoringTicket {
        assert!(arg0 == 1 || arg0 == 2, 7);
        if (arg0 == 1) {
            assert!(0x2::coin::value<0xa99166e802527eeb5439cbda12b0a02851bf2305d3c96a592b1440014fcb8975::koto::KOTO>(&arg1) == arg3.lvl1_price_koto, 8);
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg3.lvl1_price_sui, 11);
        } else if (arg0 == 2) {
            assert!(0x2::coin::value<0xa99166e802527eeb5439cbda12b0a02851bf2305d3c96a592b1440014fcb8975::koto::KOTO>(&arg1) == arg3.lvl2_price_koto, 8);
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg3.lvl2_price_sui, 11);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa99166e802527eeb5439cbda12b0a02851bf2305d3c96a592b1440014fcb8975::koto::KOTO>>(arg1, @0xde0053243f3226649701a7fe2c3988be11941bf3ff3535f3c8c5bf32fc600220);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, @0xde0053243f3226649701a7fe2c3988be11941bf3ff3535f3c8c5bf32fc600220);
        create_coloring_ticket_internal(arg0, arg4)
    }

    public fun claim_coloring(arg0: &mut 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::factory::PrimeMachin, arg1: 0x2::transfer::Receiving<ColoringReceipt>, arg2: ColoringStudio, arg3: &mut ColoringStudioRegistry, arg4: &mut 0x2::tx_context::TxContext) : (0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::image::Image, 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::image::DeleteImagePromise) {
        let v0 = 0x2::transfer::receive<ColoringReceipt>(0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::factory::uid_mut(arg0), arg1);
        assert!(v0.number == 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::factory::number(arg0), 9);
        assert!(arg2.is_fulfilled == true, 5);
        assert!(0x2::object::id<ColoringStudio>(&arg2) == v0.studio_id, 10);
        let v1 = 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::factory::unset_image(arg0);
        0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::factory::set_image(arg0, 0x1::option::extract<0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::image::Image>(&mut arg2.image));
        if (arg2.level == 1) {
            0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::factory::set_lvl1_colored_by_address(arg0, 0x2::tx_context::sender(arg4));
        } else if (arg2.level == 2) {
            0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::factory::set_lvl2_colored_by_address(arg0, 0x2::tx_context::sender(arg4));
        };
        0x2::table::remove<u16, 0x2::object::ID>(&mut arg3.studios, v0.number);
        let ColoringReceipt {
            id        : v2,
            number    : _,
            pfp_id    : _,
            studio_id : _,
            level     : _,
        } = v0;
        0x2::object::delete(v2);
        let ColoringStudio {
            id           : v7,
            number       : _,
            level        : _,
            image        : v10,
            is_fulfilled : _,
        } = arg2;
        0x1::option::destroy_none<0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::image::Image>(v10);
        0x2::object::delete(v7);
        (v1, 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::image::issue_delete_image_promise(&v1))
    }

    fun create_coloring_ticket_internal(arg0: u8, arg1: &mut 0x2::tx_context::TxContext) : ColoringTicket {
        ColoringTicket{
            id    : 0x2::object::new(arg1),
            level : arg0,
        }
    }

    public fun destroy_coloring_ticket(arg0: ColoringTicket) {
        let ColoringTicket {
            id    : v0,
            level : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: COLORING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<COLORING>(arg0, arg1);
        let v1 = 0x2::display::new<ColoringReceipt>(&v0, arg1);
        0x2::display::add<ColoringReceipt>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Prime Machin #{number} Coloring Receipt"));
        0x2::display::add<ColoringReceipt>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"A receipt to claim a Level {level} coloring for Prime Machin #{number}."));
        0x2::display::add<ColoringReceipt>(&mut v1, 0x1::string::utf8(b"number"), 0x1::string::utf8(b"{number}"));
        0x2::display::add<ColoringReceipt>(&mut v1, 0x1::string::utf8(b"studio_id"), 0x1::string::utf8(b"{studio_id}"));
        0x2::display::add<ColoringReceipt>(&mut v1, 0x1::string::utf8(b"level"), 0x1::string::utf8(b"{level}"));
        0x2::display::add<ColoringReceipt>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://prime.nozomi.world/images/coloring-receipt.webp"));
        0x2::display::update_version<ColoringReceipt>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<ColoringReceipt>>(v1, 0x2::tx_context::sender(arg1));
        let v2 = 0x2::display::new<ColoringTicket>(&v0, arg1);
        0x2::display::add<ColoringTicket>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Prime Machin Coloring Ticket (Level {level})"));
        0x2::display::add<ColoringTicket>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"A ticket that can be used to Level {level} color a Prime Machin."));
        0x2::display::add<ColoringTicket>(&mut v2, 0x1::string::utf8(b"level"), 0x1::string::utf8(b"{level}"));
        0x2::display::add<ColoringTicket>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://prime.nozomi.world/images/coloring-ticket-level-{level}.webp"));
        0x2::display::update_version<ColoringTicket>(&mut v2);
        let v3 = ColoringStudioRegistry{
            id      : 0x2::object::new(arg1),
            studios : 0x2::table::new<u16, 0x2::object::ID>(arg1),
        };
        let v4 = ColoringSettings{
            id              : 0x2::object::new(arg1),
            lvl1_price_koto : 2000,
            lvl1_price_sui  : 5000000000,
            lvl2_price_koto : 10000,
            lvl2_price_sui  : 150000000000,
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, @0xde0053243f3226649701a7fe2c3988be11941bf3ff3535f3c8c5bf32fc600220);
        0x2::transfer::public_transfer<0x2::display::Display<ColoringTicket>>(v2, @0xde0053243f3226649701a7fe2c3988be11941bf3ff3535f3c8c5bf32fc600220);
        0x2::transfer::share_object<ColoringStudioRegistry>(v3);
        0x2::transfer::share_object<ColoringSettings>(v4);
    }

    public fun request_coloring(arg0: &0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::factory::PrimeMachin, arg1: ColoringTicket, arg2: &mut ColoringStudioRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<u16, 0x2::object::ID>(&arg2.studios, 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::factory::number(arg0)), 1);
        if (arg1.level == 1) {
            let v0 = 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::factory::lvl1_colored_by(arg0);
            assert!(0x1::option::is_none<address>(&v0), 1);
        } else if (arg1.level == 2) {
            let v1 = 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::factory::lvl1_colored_by(arg0);
            assert!(0x1::option::is_some<address>(&v1), 12);
            let v2 = 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::factory::lvl2_colored_by(arg0);
            assert!(0x1::option::is_none<address>(&v2), 2);
        };
        let v3 = ColoringStudio{
            id           : 0x2::object::new(arg3),
            number       : 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::factory::number(arg0),
            level        : arg1.level,
            image        : 0x1::option::none<0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::image::Image>(),
            is_fulfilled : false,
        };
        let v4 = ColoringReceipt{
            id        : 0x2::object::new(arg3),
            number    : 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::factory::number(arg0),
            pfp_id    : 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::factory::id(arg0),
            studio_id : 0x2::object::id<ColoringStudio>(&v3),
            level     : 1,
        };
        let v5 = 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::image::issue_create_image_cap(0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::factory::number(arg0), arg1.level, 0x2::object::id<ColoringStudio>(&v3), arg3);
        let v6 = FulfillColoringCap{
            id                  : 0x2::object::new(arg3),
            number              : 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::factory::number(arg0),
            level               : arg1.level,
            studio_id           : 0x2::object::id<ColoringStudio>(&v3),
            create_image_cap_id : 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::image::create_image_cap_id(&v5),
        };
        let v7 = 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::factory::id(arg0);
        0x2::transfer::transfer<ColoringReceipt>(v4, 0x2::object::id_to_address(&v7));
        0x2::transfer::public_transfer<0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::image::CreateImageCap>(v5, @0x597996d64570b1ba7ec02376995fe126d4430d385a62970f33266d7eb711172f);
        0x2::transfer::transfer<FulfillColoringCap>(v6, @0x597996d64570b1ba7ec02376995fe126d4430d385a62970f33266d7eb711172f);
        0x2::table::add<u16, 0x2::object::ID>(&mut arg2.studios, 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::factory::number(arg0), 0x2::object::id<ColoringStudio>(&v3));
        0x2::transfer::share_object<ColoringStudio>(v3);
        let ColoringTicket {
            id    : v8,
            level : _,
        } = arg1;
        0x2::object::delete(v8);
    }

    // decompiled from Move bytecode v6
}

