module 0x2baad02bc18846d93a97ebb8aef28048089c77d7d8aedbcb0ebc61ce323af572::nobori {
    struct NOBORI has drop {
        dummy_field: bool,
    }

    struct Nobori has key {
        id: 0x2::object::UID,
        image: 0x1::option::Option<0x2baad02bc18846d93a97ebb8aef28048089c77d7d8aedbcb0ebc61ce323af572::image::Image>,
        image_url: 0x1::option::Option<0x1::string::String>,
        koi_collection: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct NoboriCreated has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        epoch: u64,
    }

    entry fun create_insert_and_transfer_koi(arg0: &0x2baad02bc18846d93a97ebb8aef28048089c77d7d8aedbcb0ebc61ce323af572::role::AdminCap, arg1: &mut Nobori, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: 0x1::string::String, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2baad02bc18846d93a97ebb8aef28048089c77d7d8aedbcb0ebc61ce323af572::role::verify_admin_cap(arg0, arg6);
        let v0 = 0x2baad02bc18846d93a97ebb8aef28048089c77d7d8aedbcb0ebc61ce323af572::koi::new(0x2::object::id<Nobori>(arg1), 0x2baad02bc18846d93a97ebb8aef28048089c77d7d8aedbcb0ebc61ce323af572::image::create_image(arg2, arg3, arg6), arg4, arg6);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.koi_collection, 0x2::object::id<0x2baad02bc18846d93a97ebb8aef28048089c77d7d8aedbcb0ebc61ce323af572::koi::Koi>(&v0));
        0x2::transfer::public_transfer<0x2baad02bc18846d93a97ebb8aef28048089c77d7d8aedbcb0ebc61ce323af572::koi::Koi>(v0, arg5);
    }

    fun init(arg0: NOBORI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NOBORI>(arg0, arg1);
        let v1 = 0x2::display::new<Nobori>(&v0, arg1);
        0x2::display::add<Nobori>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"koinobori - NoboriFT"));
        0x2::display::add<Nobori>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"A school of \"koi\" as a \"nobori\"."));
        0x2::display::add<Nobori>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Nobori>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://koinobori2024.junni.dev"));
        0x2::display::add<Nobori>(&mut v1, 0x1::string::utf8(b"koi_collection"), 0x1::string::utf8(b"{koi_collection}"));
        0x2::display::update_version<Nobori>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Nobori>>(v1, 0x2::tx_context::sender(arg1));
        let v2 = Nobori{
            id             : 0x2::object::new(arg1),
            image          : 0x1::option::none<0x2baad02bc18846d93a97ebb8aef28048089c77d7d8aedbcb0ebc61ce323af572::image::Image>(),
            image_url      : 0x1::option::none<0x1::string::String>(),
            koi_collection : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        let v3 = NoboriCreated{
            object_id : 0x2::object::id<Nobori>(&v2),
            creator   : 0x2::tx_context::sender(arg1),
            epoch     : 0x2::tx_context::epoch(arg1),
        };
        0x2::event::emit<NoboriCreated>(v3);
        0x2::transfer::share_object<Nobori>(v2);
    }

    entry fun set_image(arg0: &0x2baad02bc18846d93a97ebb8aef28048089c77d7d8aedbcb0ebc61ce323af572::role::AdminCap, arg1: &mut Nobori, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        0x2baad02bc18846d93a97ebb8aef28048089c77d7d8aedbcb0ebc61ce323af572::role::verify_admin_cap(arg0, arg4);
        assert!(0x1::option::is_none<0x2baad02bc18846d93a97ebb8aef28048089c77d7d8aedbcb0ebc61ce323af572::image::Image>(&arg1.image), 1);
        0x1::option::fill<0x2baad02bc18846d93a97ebb8aef28048089c77d7d8aedbcb0ebc61ce323af572::image::Image>(&mut arg1.image, 0x2baad02bc18846d93a97ebb8aef28048089c77d7d8aedbcb0ebc61ce323af572::image::create_image(arg2, arg3, arg4));
    }

    entry fun update_image_url(arg0: &0x2baad02bc18846d93a97ebb8aef28048089c77d7d8aedbcb0ebc61ce323af572::role::AdminCap, arg1: &mut Nobori, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        0x2baad02bc18846d93a97ebb8aef28048089c77d7d8aedbcb0ebc61ce323af572::role::verify_admin_cap(arg0, arg3);
        arg1.image_url = 0x1::option::some<0x1::string::String>(arg2);
    }

    // decompiled from Move bytecode v6
}

