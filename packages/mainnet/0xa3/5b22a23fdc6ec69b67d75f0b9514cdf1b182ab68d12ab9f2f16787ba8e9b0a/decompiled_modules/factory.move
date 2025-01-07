module 0xa35b22a23fdc6ec69b67d75f0b9514cdf1b182ab68d12ab9f2f16787ba8e9b0a::factory {
    struct FACTORY has drop {
        dummy_field: bool,
    }

    struct Chakra has store, key {
        id: 0x2::object::UID,
        number: u16,
        image: 0x1::option::Option<0xa35b22a23fdc6ec69b67d75f0b9514cdf1b182ab68d12ab9f2f16787ba8e9b0a::image::Image>,
        minted_by: 0x1::option::Option<address>,
        kiosk_id: 0x2::object::ID,
        kiosk_owner_cap_id: 0x2::object::ID,
    }

    struct Factory has key {
        id: 0x2::object::UID,
        pfps: 0x2::object_table::ObjectTable<u16, Chakra>,
        is_initialized: bool,
    }

    public(friend) fun id(arg0: &Chakra) : 0x2::object::ID {
        0x2::object::id<Chakra>(arg0)
    }

    public fun admin_destroy_factory(arg0: &0xa35b22a23fdc6ec69b67d75f0b9514cdf1b182ab68d12ab9f2f16787ba8e9b0a::admin::AdminCap, arg1: Factory, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.is_initialized == true, 4);
        assert!(0x2::object_table::is_empty<u16, Chakra>(&arg1.pfps), 3);
        let Factory {
            id             : v0,
            pfps           : v1,
            is_initialized : _,
        } = arg1;
        0x2::object_table::destroy_empty<u16, Chakra>(v1);
        0x2::object::delete(v0);
    }

    public fun admin_initialize_factory(arg0: &0xa35b22a23fdc6ec69b67d75f0b9514cdf1b182ab68d12ab9f2f16787ba8e9b0a::admin::AdminCap, arg1: &mut Factory, arg2: &mut 0xa35b22a23fdc6ec69b67d75f0b9514cdf1b182ab68d12ab9f2f16787ba8e9b0a::registry::Registry, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_initialized == false, 2);
        let v0 = (0x2::object_table::length<u16, Chakra>(&arg1.pfps) as u16) + 1;
        while (v0 <= (0x2::math::min(((v0 + 332) as u64), (0xa35b22a23fdc6ec69b67d75f0b9514cdf1b182ab68d12ab9f2f16787ba8e9b0a::collection::size() as u64)) as u16)) {
            let (v1, v2) = 0x2::kiosk::new(arg3);
            let v3 = v2;
            let v4 = v1;
            let v5 = Chakra{
                id                 : 0x2::object::new(arg3),
                number             : v0,
                image              : 0x1::option::none<0xa35b22a23fdc6ec69b67d75f0b9514cdf1b182ab68d12ab9f2f16787ba8e9b0a::image::Image>(),
                minted_by          : 0x1::option::none<address>(),
                kiosk_id           : 0x2::object::id<0x2::kiosk::Kiosk>(&v4),
                kiosk_owner_cap_id : 0x2::object::id<0x2::kiosk::KioskOwnerCap>(&v3),
            };
            0x2::kiosk::set_owner_custom(&mut v4, &v3, 0x2::object::id_address<Chakra>(&v5));
            let v6 = 0x2::object::id<Chakra>(&v5);
            0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, 0x2::object::id_to_address(&v6));
            0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
            0xa35b22a23fdc6ec69b67d75f0b9514cdf1b182ab68d12ab9f2f16787ba8e9b0a::registry::add(v0, 0x2::object::id<Chakra>(&v5), arg2);
            0x2::object_table::add<u16, Chakra>(&mut arg1.pfps, v0, v5);
            v0 = v0 + 1;
        };
        if ((0x2::object_table::length<u16, Chakra>(&arg1.pfps) as u16) == 0xa35b22a23fdc6ec69b67d75f0b9514cdf1b182ab68d12ab9f2f16787ba8e9b0a::collection::size()) {
            arg1.is_initialized = true;
        };
    }

    public fun admin_remove_from_factory(arg0: &0xa35b22a23fdc6ec69b67d75f0b9514cdf1b182ab68d12ab9f2f16787ba8e9b0a::admin::AdminCap, arg1: vector<u16>, arg2: &mut Factory, arg3: &0x2::tx_context::TxContext) : vector<Chakra> {
        assert!(arg2.is_initialized == true, 4);
        let v0 = 0x1::vector::empty<Chakra>();
        while (!0x1::vector::is_empty<u16>(&arg1)) {
            0x1::vector::push_back<Chakra>(&mut v0, 0x2::object_table::remove<u16, Chakra>(&mut arg2.pfps, 0x1::vector::pop_back<u16>(&mut arg1)));
        };
        v0
    }

    public(friend) fun image(arg0: &Chakra) : &0xa35b22a23fdc6ec69b67d75f0b9514cdf1b182ab68d12ab9f2f16787ba8e9b0a::image::Image {
        0x1::option::borrow<0xa35b22a23fdc6ec69b67d75f0b9514cdf1b182ab68d12ab9f2f16787ba8e9b0a::image::Image>(&arg0.image)
    }

    fun init(arg0: FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<FACTORY>(arg0, arg1);
        let v1 = Factory{
            id             : 0x2::object::new(arg1),
            pfps           : 0x2::object_table::new<u16, Chakra>(arg1),
            is_initialized : false,
        };
        let v2 = 0x2::display::new<Chakra>(&v0, arg1);
        0x2::display::add<Chakra>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Chakra #{number}"));
        0x2::display::add<Chakra>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Chakra #{number}"));
        0x2::display::add<Chakra>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://source.boomplaymusic.com/buzzgroup1/M00/18/E5/rBEevF_cRkmALJL2AADixAQNp4M606.jpg"));
        0x2::display::add<Chakra>(&mut v2, 0x1::string::utf8(b"minted_by"), 0x1::string::utf8(b"{minted_by}"));
        0x2::display::add<Chakra>(&mut v2, 0x1::string::utf8(b"kiosk_id"), 0x1::string::utf8(b"{kiosk_id}"));
        0x2::display::add<Chakra>(&mut v2, 0x1::string::utf8(b"kiosk_owner_cap_id"), 0x1::string::utf8(b"{kiosk_owner_cap_id}"));
        0x2::display::update_version<Chakra>(&mut v2);
        let (v3, v4) = 0x2::transfer_policy::new<Chakra>(&v0, arg1);
        0x2::transfer::transfer<Factory>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Chakra>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Chakra>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Chakra>>(v3);
    }

    public(friend) fun kiosk_id(arg0: &Chakra) : 0x2::object::ID {
        arg0.kiosk_id
    }

    public(friend) fun kiosk_owner_cap_id(arg0: &Chakra) : 0x2::object::ID {
        arg0.kiosk_owner_cap_id
    }

    public(friend) fun number(arg0: &Chakra) : u16 {
        arg0.number
    }

    public(friend) fun set_image(arg0: &mut Chakra, arg1: 0xa35b22a23fdc6ec69b67d75f0b9514cdf1b182ab68d12ab9f2f16787ba8e9b0a::image::Image) {
        assert!(0x1::option::is_none<0xa35b22a23fdc6ec69b67d75f0b9514cdf1b182ab68d12ab9f2f16787ba8e9b0a::image::Image>(&arg0.image), 5);
        0x1::option::fill<0xa35b22a23fdc6ec69b67d75f0b9514cdf1b182ab68d12ab9f2f16787ba8e9b0a::image::Image>(&mut arg0.image, arg1);
    }

    public(friend) fun set_minted_by_address(arg0: &mut Chakra, arg1: address) {
        0x1::option::fill<address>(&mut arg0.minted_by, arg1);
    }

    public(friend) fun swap_image(arg0: &mut Chakra, arg1: 0xa35b22a23fdc6ec69b67d75f0b9514cdf1b182ab68d12ab9f2f16787ba8e9b0a::image::Image) : (0xa35b22a23fdc6ec69b67d75f0b9514cdf1b182ab68d12ab9f2f16787ba8e9b0a::image::Image, 0xa35b22a23fdc6ec69b67d75f0b9514cdf1b182ab68d12ab9f2f16787ba8e9b0a::image::DeleteImagePromise) {
        assert!(arg0.number == 0xa35b22a23fdc6ec69b67d75f0b9514cdf1b182ab68d12ab9f2f16787ba8e9b0a::image::number(&arg1), 7);
        let v0 = 0x1::option::swap<0xa35b22a23fdc6ec69b67d75f0b9514cdf1b182ab68d12ab9f2f16787ba8e9b0a::image::Image>(&mut arg0.image, arg1);
        (v0, 0xa35b22a23fdc6ec69b67d75f0b9514cdf1b182ab68d12ab9f2f16787ba8e9b0a::image::issue_delete_image_promise(&v0))
    }

    public(friend) fun uid_mut(arg0: &mut Chakra) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun unset_image(arg0: &mut Chakra) : 0xa35b22a23fdc6ec69b67d75f0b9514cdf1b182ab68d12ab9f2f16787ba8e9b0a::image::Image {
        assert!(0x1::option::is_some<0xa35b22a23fdc6ec69b67d75f0b9514cdf1b182ab68d12ab9f2f16787ba8e9b0a::image::Image>(&arg0.image), 6);
        0x1::option::extract<0xa35b22a23fdc6ec69b67d75f0b9514cdf1b182ab68d12ab9f2f16787ba8e9b0a::image::Image>(&mut arg0.image)
    }

    // decompiled from Move bytecode v6
}

