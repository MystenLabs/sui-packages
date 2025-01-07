module 0xdf486f32d62ef9c06343a10f97f6ad4f26ffc988884de282ee04179bc8967c2e::chakra {
    struct CHAKRA has drop {
        dummy_field: bool,
    }

    struct Chakra has store, key {
        id: 0x2::object::UID,
        number: u16,
        image: 0x1::option::Option<0xdf486f32d62ef9c06343a10f97f6ad4f26ffc988884de282ee04179bc8967c2e::image::Image>,
        points: u64,
        minted_by: 0x1::option::Option<address>,
        kiosk_id: 0x2::object::ID,
        kiosk_owner_cap_id: 0x2::object::ID,
    }

    public(friend) fun id(arg0: &Chakra) : 0x2::object::ID {
        0x2::object::id<Chakra>(arg0)
    }

    public fun create(arg0: &mut 0xdf486f32d62ef9c06343a10f97f6ad4f26ffc988884de282ee04179bc8967c2e::registry::Registry, arg1: &mut 0x2::tx_context::TxContext) : Chakra {
        let v0 = 0xdf486f32d62ef9c06343a10f97f6ad4f26ffc988884de282ee04179bc8967c2e::registry::count(arg0) + 1;
        let (v1, v2) = 0x2::kiosk::new(arg1);
        let v3 = v2;
        let v4 = v1;
        let v5 = Chakra{
            id                 : 0x2::object::new(arg1),
            number             : v0,
            image              : 0x1::option::none<0xdf486f32d62ef9c06343a10f97f6ad4f26ffc988884de282ee04179bc8967c2e::image::Image>(),
            points             : 0,
            minted_by          : 0x1::option::none<address>(),
            kiosk_id           : 0x2::object::id<0x2::kiosk::Kiosk>(&v4),
            kiosk_owner_cap_id : 0x2::object::id<0x2::kiosk::KioskOwnerCap>(&v3),
        };
        0x2::kiosk::set_owner_custom(&mut v4, &v3, 0x2::object::id_address<Chakra>(&v5));
        let v6 = 0x2::object::id<Chakra>(&v5);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, 0x2::object::id_to_address(&v6));
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
        0xdf486f32d62ef9c06343a10f97f6ad4f26ffc988884de282ee04179bc8967c2e::registry::add(v0, 0x2::object::id<Chakra>(&v5), arg0);
        v5
    }

    public(friend) fun image(arg0: &Chakra) : &0xdf486f32d62ef9c06343a10f97f6ad4f26ffc988884de282ee04179bc8967c2e::image::Image {
        0x1::option::borrow<0xdf486f32d62ef9c06343a10f97f6ad4f26ffc988884de282ee04179bc8967c2e::image::Image>(&arg0.image)
    }

    fun init(arg0: CHAKRA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CHAKRA>(arg0, arg1);
        let v1 = 0x2::display::new<Chakra>(&v0, arg1);
        0x2::display::add<Chakra>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Chakra #{number}"));
        0x2::display::add<Chakra>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Chakra #{number}"));
        0x2::display::add<Chakra>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://img.sm.xyz/{points}/"));
        0x2::display::add<Chakra>(&mut v1, 0x1::string::utf8(b"minted_by"), 0x1::string::utf8(b"{minted_by}"));
        0x2::display::add<Chakra>(&mut v1, 0x1::string::utf8(b"kiosk_id"), 0x1::string::utf8(b"{kiosk_id}"));
        0x2::display::add<Chakra>(&mut v1, 0x1::string::utf8(b"kiosk_owner_cap_id"), 0x1::string::utf8(b"{kiosk_owner_cap_id}"));
        0x2::display::update_version<Chakra>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<Chakra>(&v0, arg1);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Chakra>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Chakra>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Chakra>>(v2);
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

    public(friend) fun points(arg0: &Chakra) : u64 {
        arg0.points
    }

    public(friend) fun set_image(arg0: &mut Chakra, arg1: 0xdf486f32d62ef9c06343a10f97f6ad4f26ffc988884de282ee04179bc8967c2e::image::Image) {
        assert!(0x1::option::is_none<0xdf486f32d62ef9c06343a10f97f6ad4f26ffc988884de282ee04179bc8967c2e::image::Image>(&arg0.image), 5);
        0x1::option::fill<0xdf486f32d62ef9c06343a10f97f6ad4f26ffc988884de282ee04179bc8967c2e::image::Image>(&mut arg0.image, arg1);
    }

    public(friend) fun set_minted_by_address(arg0: &mut Chakra, arg1: address) {
        0x1::option::fill<address>(&mut arg0.minted_by, arg1);
    }

    public(friend) fun set_points(arg0: &mut Chakra, arg1: u64) {
        arg0.points = arg1;
    }

    public(friend) fun swap_image(arg0: &mut Chakra, arg1: 0xdf486f32d62ef9c06343a10f97f6ad4f26ffc988884de282ee04179bc8967c2e::image::Image) : (0xdf486f32d62ef9c06343a10f97f6ad4f26ffc988884de282ee04179bc8967c2e::image::Image, 0xdf486f32d62ef9c06343a10f97f6ad4f26ffc988884de282ee04179bc8967c2e::image::DeleteImagePromise) {
        assert!(arg0.number == 0xdf486f32d62ef9c06343a10f97f6ad4f26ffc988884de282ee04179bc8967c2e::image::number(&arg1), 7);
        let v0 = 0x1::option::swap<0xdf486f32d62ef9c06343a10f97f6ad4f26ffc988884de282ee04179bc8967c2e::image::Image>(&mut arg0.image, arg1);
        (v0, 0xdf486f32d62ef9c06343a10f97f6ad4f26ffc988884de282ee04179bc8967c2e::image::issue_delete_image_promise(&v0))
    }

    public(friend) fun uid_mut(arg0: &mut Chakra) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun unset_image(arg0: &mut Chakra) : 0xdf486f32d62ef9c06343a10f97f6ad4f26ffc988884de282ee04179bc8967c2e::image::Image {
        assert!(0x1::option::is_some<0xdf486f32d62ef9c06343a10f97f6ad4f26ffc988884de282ee04179bc8967c2e::image::Image>(&arg0.image), 6);
        0x1::option::extract<0xdf486f32d62ef9c06343a10f97f6ad4f26ffc988884de282ee04179bc8967c2e::image::Image>(&mut arg0.image)
    }

    // decompiled from Move bytecode v6
}

