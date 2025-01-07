module 0x38392f79127691172486d0a9d66b61745a0aedf03eab9088e78171f7735852bb::arcade_champion {
    struct Hero has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        tier: 0x1::string::String,
        star_rating: u8,
        level: u8,
        image_url: 0x1::string::String,
        edition: 0x1::string::String,
        exported: bool,
    }

    struct ImportTicket has store, key {
        id: 0x2::object::UID,
        hero_id: 0x2::object::ID,
        custodial_wallet: address,
    }

    public fun create_display<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"tier"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"star_rating"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"level"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"edition"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{tier}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{star_rating}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{level}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{edition}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Arcade Champion is a best in class mobile arcade game with a crypto play to own element and Hero based NFTs."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.bluejaygames.com/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"BlueJay Games"));
        let v4 = 0x2::display::new_with_fields<Hero>(arg0, v0, v2, arg1);
        0x2::display::update_version<Hero>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<Hero>>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun delete_hero(arg0: Hero) {
        assert!(hero_can_be_updated(&arg0), 2);
        let Hero {
            id          : v0,
            name        : _,
            tier        : _,
            star_rating : _,
            level       : _,
            image_url   : _,
            edition     : _,
            exported    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun hero_can_be_updated(arg0: &Hero) : bool {
        !arg0.exported
    }

    public fun hero_edition(arg0: &Hero) : 0x1::string::String {
        arg0.edition
    }

    public fun hero_exported(arg0: &Hero) : bool {
        arg0.exported
    }

    public fun hero_image_url(arg0: &Hero) : 0x1::string::String {
        arg0.image_url
    }

    public fun hero_level(arg0: &Hero) : u8 {
        arg0.level
    }

    public fun hero_name(arg0: &Hero) : 0x1::string::String {
        arg0.name
    }

    public fun hero_star_rating(arg0: &Hero) : u8 {
        arg0.star_rating
    }

    public fun hero_tier(arg0: &Hero) : 0x1::string::String {
        arg0.tier
    }

    public fun hero_uid_mut(arg0: &mut Hero) : &mut 0x2::object::UID {
        assert!(hero_can_be_updated(arg0), 0);
        &mut arg0.id
    }

    public fun lock_hero(arg0: &mut Hero, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.exported = true;
    }

    public fun mint_hero(arg0: &mut 0x38392f79127691172486d0a9d66b61745a0aedf03eab9088e78171f7735852bb::genesis::AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8, arg4: u8, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) : Hero {
        Hero{
            id          : 0x2::object::new(arg7),
            name        : arg1,
            tier        : arg2,
            star_rating : arg3,
            level       : arg4,
            image_url   : arg5,
            edition     : arg6,
            exported    : false,
        }
    }

    public fun mint_import_ticket(arg0: &mut 0x38392f79127691172486d0a9d66b61745a0aedf03eab9088e78171f7735852bb::genesis::AdminCap, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : ImportTicket {
        ImportTicket{
            id               : 0x2::object::new(arg3),
            hero_id          : arg1,
            custodial_wallet : arg2,
        }
    }

    public fun unlock_and_import_hero(arg0: ImportTicket, arg1: Hero, arg2: &mut 0x2::tx_context::TxContext) {
        let ImportTicket {
            id               : v0,
            hero_id          : v1,
            custodial_wallet : v2,
        } = arg0;
        let v3 = v1;
        assert!(0x2::object::id_to_bytes(&v3) == 0x2::object::uid_to_bytes(&arg1.id), 1);
        arg1.exported = false;
        0x2::transfer::public_transfer<Hero>(arg1, v2);
        0x2::object::delete(v0);
    }

    public fun update_hero(arg0: &mut Hero, arg1: u8, arg2: u8, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(hero_can_be_updated(arg0), 0);
        arg0.star_rating = arg1;
        arg0.level = arg2;
        arg0.image_url = arg3;
    }

    public fun update_image_url(arg0: &mut Hero, arg1: 0x1::string::String) {
        assert!(hero_can_be_updated(arg0), 0);
        arg0.image_url = arg1;
    }

    public fun update_level(arg0: &mut Hero, arg1: u8) {
        assert!(hero_can_be_updated(arg0), 0);
        arg0.level = arg1;
    }

    public fun update_stars(arg0: &mut Hero, arg1: u8) {
        assert!(hero_can_be_updated(arg0), 0);
        arg0.star_rating = arg1;
    }

    // decompiled from Move bytecode v6
}

