module 0x7b3c21b45ea400b10253bf3678862aa94a927c37f069d312fdf7a4b804179b5e::partners {
    struct PartnersGalleryControl has store, key {
        id: 0x2::object::UID,
        paused: bool,
        allowed_items: 0x2::table::Table<0x1::string::String, 0x1::string::String>,
        mints: 0x2::table::Table<0x1::string::String, bool>,
    }

    struct PartnersColorArtefact has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        artefact_type: 0x1::string::String,
    }

    struct PartnersColorArtefactMint has store, key {
        id: 0x2::object::UID,
        artefact_type: 0x1::string::String,
    }

    struct ColorArtefactMinted has copy, drop {
        id: 0x2::object::ID,
        artefact_type: 0x1::string::String,
        minted_by: address,
    }

    public fun add_gallery_item(arg0: &mut PartnersGalleryControl, arg1: &0x7b3c21b45ea400b10253bf3678862aa94a927c37f069d312fdf7a4b804179b5e::colors::AdminCap, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        assert!(0x2::table::contains<0x1::string::String, 0x1::string::String>(&arg0.allowed_items, arg2) == false, 1);
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut arg0.allowed_items, arg2, arg3);
    }

    public fun manual_init(arg0: &0x7b3c21b45ea400b10253bf3678862aa94a927c37f069d312fdf7a4b804179b5e::colors::AdminCap, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suicolors.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"SuiColors"));
        let v4 = 0x2::display::new_with_fields<PartnersColorArtefact>(arg1, v0, v2, arg2);
        0x2::display::update_version<PartnersColorArtefact>(&mut v4);
        let v5 = PartnersGalleryControl{
            id            : 0x2::object::new(arg2),
            paused        : false,
            allowed_items : 0x2::table::new<0x1::string::String, 0x1::string::String>(arg2),
            mints         : 0x2::table::new<0x1::string::String, bool>(arg2),
        };
        0x2::transfer::public_transfer<0x2::display::Display<PartnersColorArtefact>>(v4, 0x2::tx_context::sender(arg2));
        0x2::transfer::share_object<PartnersGalleryControl>(v5);
    }

    public fun mint(arg0: &mut PartnersGalleryControl, arg1: PartnersColorArtefactMint, arg2: &mut 0x2::tx_context::TxContext) : PartnersColorArtefact {
        assert!(arg0.paused == false, 3);
        let v0 = arg1.artefact_type;
        0x1::string::append(&mut v0, 0x2::address::to_string(0x2::tx_context::sender(arg2)));
        assert!(!0x2::table::contains<0x1::string::String, bool>(&arg0.mints, v0), 4);
        0x2::table::add<0x1::string::String, bool>(&mut arg0.mints, v0, true);
        let v1 = 0x1::string::utf8(b"https://suicolors.com/api/image/custom?hex=000000&resize=false&type=");
        0x1::string::append(&mut v1, arg1.artefact_type);
        let v2 = 0x2::object::new(arg2);
        let v3 = ColorArtefactMinted{
            id            : 0x2::object::uid_to_inner(&v2),
            artefact_type : arg1.artefact_type,
            minted_by     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ColorArtefactMinted>(v3);
        let v4 = PartnersColorArtefact{
            id            : v2,
            name          : *0x2::table::borrow<0x1::string::String, 0x1::string::String>(&arg0.allowed_items, arg1.artefact_type),
            image_url     : v1,
            artefact_type : arg1.artefact_type,
        };
        let PartnersColorArtefactMint {
            id            : v5,
            artefact_type : _,
        } = arg1;
        0x2::object::delete(v5);
        v4
    }

    public fun mint_color(arg0: &0x7b3c21b45ea400b10253bf3678862aa94a927c37f069d312fdf7a4b804179b5e::colors::Color, arg1: &mut PartnersGalleryControl, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : PartnersColorArtefact {
        assert!(arg1.paused == false, 3);
        0x1::string::append(&mut arg2, 0x2::address::to_string(0x2::tx_context::sender(arg3)));
        assert!(!0x2::table::contains<0x1::string::String, bool>(&arg1.mints, arg2), 4);
        0x2::table::add<0x1::string::String, bool>(&mut arg1.mints, arg2, true);
        let v0 = 0x1::string::utf8(b"https://suicolors.com/api/image/custom?hex=000000&resize=false&type=");
        0x1::string::append(&mut v0, arg2);
        let v1 = 0x2::object::new(arg3);
        let v2 = ColorArtefactMinted{
            id            : 0x2::object::uid_to_inner(&v1),
            artefact_type : arg2,
            minted_by     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ColorArtefactMinted>(v2);
        PartnersColorArtefact{
            id            : v1,
            name          : *0x2::table::borrow<0x1::string::String, 0x1::string::String>(&arg1.allowed_items, arg2),
            image_url     : v0,
            artefact_type : arg2,
        }
    }

    public fun pause(arg0: &mut PartnersGalleryControl, arg1: &0x7b3c21b45ea400b10253bf3678862aa94a927c37f069d312fdf7a4b804179b5e::colors::AdminCap) {
        arg0.paused = true;
    }

    public fun remove_gallery_item(arg0: &mut PartnersGalleryControl, arg1: &0x7b3c21b45ea400b10253bf3678862aa94a927c37f069d312fdf7a4b804179b5e::colors::AdminCap, arg2: 0x1::string::String) {
        assert!(0x2::table::contains<0x1::string::String, 0x1::string::String>(&arg0.allowed_items, arg2), 2);
        0x2::table::remove<0x1::string::String, 0x1::string::String>(&mut arg0.allowed_items, arg2);
    }

    public fun send_mint(arg0: &0x7b3c21b45ea400b10253bf3678862aa94a927c37f069d312fdf7a4b804179b5e::colors::AdminCap, arg1: &PartnersGalleryControl, arg2: address, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::string::String, 0x1::string::String>(&arg1.allowed_items, arg3), 2);
        let v0 = PartnersColorArtefactMint{
            id            : 0x2::object::new(arg4),
            artefact_type : arg3,
        };
        0x2::transfer::public_transfer<PartnersColorArtefactMint>(v0, arg2);
    }

    public fun unpause(arg0: &mut PartnersGalleryControl, arg1: &0x7b3c21b45ea400b10253bf3678862aa94a927c37f069d312fdf7a4b804179b5e::colors::AdminCap) {
        arg0.paused = false;
    }

    // decompiled from Move bytecode v6
}

