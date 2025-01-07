module 0x2baad02bc18846d93a97ebb8aef28048089c77d7d8aedbcb0ebc61ce323af572::koi {
    struct KOI has drop {
        dummy_field: bool,
    }

    struct Koi has store, key {
        id: 0x2::object::UID,
        image: 0x1::option::Option<0x2baad02bc18846d93a97ebb8aef28048089c77d7d8aedbcb0ebc61ce323af572::image::Image>,
        image_url: 0x1::string::String,
        nobori_id: 0x2::object::ID,
    }

    struct KoiCreated has copy, drop {
        object_id: 0x2::object::ID,
        nobori_id: 0x2::object::ID,
        creator: address,
        epoch: u64,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: 0x2baad02bc18846d93a97ebb8aef28048089c77d7d8aedbcb0ebc61ce323af572::image::Image, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : Koi {
        let v0 = Koi{
            id        : 0x2::object::new(arg3),
            image     : 0x1::option::some<0x2baad02bc18846d93a97ebb8aef28048089c77d7d8aedbcb0ebc61ce323af572::image::Image>(arg1),
            image_url : arg2,
            nobori_id : arg0,
        };
        let v1 = KoiCreated{
            object_id : 0x2::object::id<Koi>(&v0),
            nobori_id : arg0,
            creator   : 0x2::tx_context::sender(arg3),
            epoch     : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<KoiCreated>(v1);
        v0
    }

    fun init(arg0: KOI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<KOI>(arg0, arg1);
        let v1 = 0x2::display::new<Koi>(&v0, arg1);
        0x2::display::add<Koi>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"koi - NoboriFT"));
        0x2::display::add<Koi>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"A \"koi\" for \"koinobori\"."));
        0x2::display::add<Koi>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Koi>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://koinobori2024.junni.dev"));
        0x2::display::add<Koi>(&mut v1, 0x1::string::utf8(b"nobori_id"), 0x1::string::utf8(b"{nobori_id}"));
        0x2::display::update_version<Koi>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Koi>>(v1, 0x2::tx_context::sender(arg1));
    }

    entry fun update_image_url(arg0: &0x2baad02bc18846d93a97ebb8aef28048089c77d7d8aedbcb0ebc61ce323af572::role::AdminCap, arg1: &mut Koi, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        0x2baad02bc18846d93a97ebb8aef28048089c77d7d8aedbcb0ebc61ce323af572::role::verify_admin_cap(arg0, arg3);
        arg1.image_url = arg2;
    }

    // decompiled from Move bytecode v6
}

