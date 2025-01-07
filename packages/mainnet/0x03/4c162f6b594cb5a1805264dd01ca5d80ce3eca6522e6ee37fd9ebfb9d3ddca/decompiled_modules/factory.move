module 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::factory {
    struct FACTORY has drop {
        dummy_field: bool,
    }

    struct PrimeMachin has store, key {
        id: 0x2::object::UID,
        number: u16,
        attributes: 0x1::option::Option<0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::attributes::Attributes>,
        image: 0x1::option::Option<0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::image::Image>,
        rarity: 0x1::option::Option<0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::rarity::Rarity>,
        lvl1_colored_by: 0x1::option::Option<address>,
        lvl2_colored_by: 0x1::option::Option<address>,
        minted_by: 0x1::option::Option<address>,
        kiosk_id: 0x2::object::ID,
        kiosk_owner_cap_id: 0x2::object::ID,
    }

    struct Factory has key {
        id: 0x2::object::UID,
        pfps: 0x2::object_table::ObjectTable<u16, PrimeMachin>,
        is_initialized: bool,
    }

    public(friend) fun id(arg0: &PrimeMachin) : 0x2::object::ID {
        0x2::object::id<PrimeMachin>(arg0)
    }

    public fun admin_destroy_factory(arg0: &0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::admin::AdminCap, arg1: Factory, arg2: &0x2::tx_context::TxContext) {
        0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::admin::verify_admin_cap(arg0, arg2);
        assert!(arg1.is_initialized == true, 4);
        assert!(0x2::object_table::is_empty<u16, PrimeMachin>(&arg1.pfps), 3);
        let Factory {
            id             : v0,
            pfps           : v1,
            is_initialized : _,
        } = arg1;
        0x2::object_table::destroy_empty<u16, PrimeMachin>(v1);
        0x2::object::delete(v0);
    }

    public fun admin_initialize_factory(arg0: &0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::admin::AdminCap, arg1: &mut Factory, arg2: &mut 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::registry::Registry, arg3: &mut 0x2::tx_context::TxContext) {
        0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::admin::verify_admin_cap(arg0, arg3);
        assert!(arg1.is_initialized == false, 2);
        let v0 = (0x2::object_table::length<u16, PrimeMachin>(&arg1.pfps) as u16) + 1;
        while (v0 <= (0x2::math::min(((v0 + 332) as u64), (0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::collection::size() as u64)) as u16)) {
            let (v1, v2) = 0x2::kiosk::new(arg3);
            let v3 = v2;
            let v4 = v1;
            let v5 = PrimeMachin{
                id                 : 0x2::object::new(arg3),
                number             : v0,
                attributes         : 0x1::option::none<0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::attributes::Attributes>(),
                image              : 0x1::option::none<0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::image::Image>(),
                rarity             : 0x1::option::none<0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::rarity::Rarity>(),
                lvl1_colored_by    : 0x1::option::none<address>(),
                lvl2_colored_by    : 0x1::option::none<address>(),
                minted_by          : 0x1::option::none<address>(),
                kiosk_id           : 0x2::object::id<0x2::kiosk::Kiosk>(&v4),
                kiosk_owner_cap_id : 0x2::object::id<0x2::kiosk::KioskOwnerCap>(&v3),
            };
            0x2::kiosk::set_owner_custom(&mut v4, &v3, 0x2::object::id_address<PrimeMachin>(&v5));
            let v6 = 0x2::object::id<PrimeMachin>(&v5);
            0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, 0x2::object::id_to_address(&v6));
            0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
            0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::registry::add(v0, 0x2::object::id<PrimeMachin>(&v5), arg2);
            0x2::object_table::add<u16, PrimeMachin>(&mut arg1.pfps, v0, v5);
            v0 = v0 + 1;
        };
        if ((0x2::object_table::length<u16, PrimeMachin>(&arg1.pfps) as u16) == 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::collection::size()) {
            arg1.is_initialized = true;
        };
    }

    public fun admin_remove_from_factory(arg0: &0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::admin::AdminCap, arg1: vector<u16>, arg2: &mut Factory, arg3: &0x2::tx_context::TxContext) : vector<PrimeMachin> {
        0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::admin::verify_admin_cap(arg0, arg3);
        assert!(arg2.is_initialized == true, 4);
        let v0 = 0x1::vector::empty<PrimeMachin>();
        while (!0x1::vector::is_empty<u16>(&arg1)) {
            0x1::vector::push_back<PrimeMachin>(&mut v0, 0x2::object_table::remove<u16, PrimeMachin>(&mut arg2.pfps, 0x1::vector::pop_back<u16>(&mut arg1)));
        };
        v0
    }

    public(friend) fun image(arg0: &PrimeMachin) : &0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::image::Image {
        0x1::option::borrow<0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::image::Image>(&arg0.image)
    }

    fun init(arg0: FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<FACTORY>(arg0, arg1);
        let v1 = Factory{
            id             : 0x2::object::new(arg1),
            pfps           : 0x2::object_table::new<u16, PrimeMachin>(arg1),
            is_initialized : false,
        };
        let v2 = 0x2::display::new<PrimeMachin>(&v0, arg1);
        0x2::display::add<PrimeMachin>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Prime Machin #{number}"));
        0x2::display::add<PrimeMachin>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Prime Machin #{number} manufactured by the Triangle Company."));
        0x2::display::add<PrimeMachin>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://img.sm.xyz/{id}/"));
        0x2::display::add<PrimeMachin>(&mut v2, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<PrimeMachin>(&mut v2, 0x1::string::utf8(b"rarity"), 0x1::string::utf8(b"{rarity}"));
        0x2::display::add<PrimeMachin>(&mut v2, 0x1::string::utf8(b"lvl1_colored_by"), 0x1::string::utf8(b"{lvl1_colored_by}"));
        0x2::display::add<PrimeMachin>(&mut v2, 0x1::string::utf8(b"lvl2_colored_by"), 0x1::string::utf8(b"{lvl2_colored_by}"));
        0x2::display::add<PrimeMachin>(&mut v2, 0x1::string::utf8(b"minted_by"), 0x1::string::utf8(b"{minted_by}"));
        0x2::display::add<PrimeMachin>(&mut v2, 0x1::string::utf8(b"kiosk_id"), 0x1::string::utf8(b"{kiosk_id}"));
        0x2::display::add<PrimeMachin>(&mut v2, 0x1::string::utf8(b"kiosk_owner_cap_id"), 0x1::string::utf8(b"{kiosk_owner_cap_id}"));
        0x2::display::update_version<PrimeMachin>(&mut v2);
        let (v3, v4) = 0x2::transfer_policy::new<PrimeMachin>(&v0, arg1);
        0x2::transfer::transfer<Factory>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<PrimeMachin>>(v4, @0xde0053243f3226649701a7fe2c3988be11941bf3ff3535f3c8c5bf32fc600220);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, @0xde0053243f3226649701a7fe2c3988be11941bf3ff3535f3c8c5bf32fc600220);
        0x2::transfer::public_transfer<0x2::display::Display<PrimeMachin>>(v2, @0xde0053243f3226649701a7fe2c3988be11941bf3ff3535f3c8c5bf32fc600220);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<PrimeMachin>>(v3);
    }

    public(friend) fun kiosk_id(arg0: &PrimeMachin) : 0x2::object::ID {
        arg0.kiosk_id
    }

    public(friend) fun kiosk_owner_cap_id(arg0: &PrimeMachin) : 0x2::object::ID {
        arg0.kiosk_owner_cap_id
    }

    public(friend) fun lvl1_colored_by(arg0: &PrimeMachin) : 0x1::option::Option<address> {
        arg0.lvl1_colored_by
    }

    public(friend) fun lvl2_colored_by(arg0: &PrimeMachin) : 0x1::option::Option<address> {
        arg0.lvl2_colored_by
    }

    public(friend) fun number(arg0: &PrimeMachin) : u16 {
        arg0.number
    }

    public(friend) fun set_attributes(arg0: &mut PrimeMachin, arg1: 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::attributes::Attributes) {
        assert!(0x1::option::is_none<0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::attributes::Attributes>(&arg0.attributes), 1);
        0x1::option::fill<0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::attributes::Attributes>(&mut arg0.attributes, arg1);
    }

    public(friend) fun set_image(arg0: &mut PrimeMachin, arg1: 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::image::Image) {
        assert!(0x1::option::is_none<0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::image::Image>(&arg0.image), 5);
        0x1::option::fill<0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::image::Image>(&mut arg0.image, arg1);
    }

    public(friend) fun set_lvl1_colored_by_address(arg0: &mut PrimeMachin, arg1: address) {
        0x1::option::fill<address>(&mut arg0.lvl1_colored_by, arg1);
    }

    public(friend) fun set_lvl2_colored_by_address(arg0: &mut PrimeMachin, arg1: address) {
        0x1::option::fill<address>(&mut arg0.lvl2_colored_by, arg1);
    }

    public(friend) fun set_minted_by_address(arg0: &mut PrimeMachin, arg1: address) {
        0x1::option::fill<address>(&mut arg0.minted_by, arg1);
    }

    public(friend) fun set_rarity(arg0: &mut PrimeMachin, arg1: 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::rarity::Rarity) {
        assert!(0x1::option::is_none<0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::rarity::Rarity>(&arg0.rarity), 8);
        0x1::option::fill<0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::rarity::Rarity>(&mut arg0.rarity, arg1);
    }

    public(friend) fun swap_image(arg0: &mut PrimeMachin, arg1: 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::image::Image) : (0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::image::Image, 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::image::DeleteImagePromise) {
        assert!(arg0.number == 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::image::number(&arg1), 7);
        let v0 = 0x1::option::swap<0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::image::Image>(&mut arg0.image, arg1);
        (v0, 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::image::issue_delete_image_promise(&v0))
    }

    public(friend) fun uid_mut(arg0: &mut PrimeMachin) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun unset_image(arg0: &mut PrimeMachin) : 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::image::Image {
        assert!(0x1::option::is_some<0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::image::Image>(&arg0.image), 6);
        0x1::option::extract<0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::image::Image>(&mut arg0.image)
    }

    // decompiled from Move bytecode v6
}

