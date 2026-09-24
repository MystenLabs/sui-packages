module 0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::landmark {
    struct Landmark has store, key {
        id: 0x2::object::UID,
        asset_id: 0x1::string::String,
        name: 0x1::string::String,
        category: 0x1::string::String,
        country_code: 0x1::string::String,
        prestige: u64,
        lat_e6_off: u32,
        lng_e6_off: u32,
        tier: u8,
        image_url: 0x1::string::String,
    }

    struct LANDMARK has drop {
        dummy_field: bool,
    }

    struct LandmarkMinted has copy, drop {
        object_id: 0x2::object::ID,
        asset_id: 0x1::string::String,
        name: 0x1::string::String,
        category: 0x1::string::String,
        country_code: 0x1::string::String,
        to: address,
        prestige: u64,
    }

    public fun id(arg0: &Landmark) : &0x2::object::UID {
        &arg0.id
    }

    public fun asset_id(arg0: &Landmark) : &0x1::string::String {
        &arg0.asset_id
    }

    public fun category(arg0: &Landmark) : &0x1::string::String {
        &arg0.category
    }

    public fun country_code(arg0: &Landmark) : &0x1::string::String {
        &arg0.country_code
    }

    public fun image_url(arg0: &Landmark) : &0x1::string::String {
        &arg0.image_url
    }

    fun init(arg0: LANDMARK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<LANDMARK>(arg0, arg1);
        let v1 = 0x2::display::new<Landmark>(&v0, arg1);
        0x2::display::add<Landmark>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Landmark>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Plan it Earth landmark ({category}) in {country_code}"));
        0x2::display::add<Landmark>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Landmark>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://planitearth.game"));
        0x2::display::update_version<Landmark>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Landmark>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun lat_e6_off(arg0: &Landmark) : u32 {
        arg0.lat_e6_off
    }

    public fun lng_e6_off(arg0: &Landmark) : u32 {
        arg0.lng_e6_off
    }

    public fun mint(arg0: &0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::admin::AdminCap, arg1: &mut 0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::admin::Config, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: u32, arg8: u32, arg9: u8, arg10: 0x1::string::String, arg11: address, arg12: &mut 0x2::tx_context::TxContext) : Landmark {
        0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::admin::assert_not_paused(arg1);
        assert!(arg9 >= 1 && arg9 <= 5, 20);
        assert!(0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::admin::landmarks_minted(arg1) < 0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::admin::max_landmarks_primary(), 21);
        let v0 = Landmark{
            id           : 0x2::object::new(arg12),
            asset_id     : arg2,
            name         : arg3,
            category     : arg4,
            country_code : arg5,
            prestige     : arg6,
            lat_e6_off   : arg7,
            lng_e6_off   : arg8,
            tier         : arg9,
            image_url    : arg10,
        };
        let v1 = LandmarkMinted{
            object_id    : 0x2::object::id<Landmark>(&v0),
            asset_id     : v0.asset_id,
            name         : v0.name,
            category     : v0.category,
            country_code : v0.country_code,
            to           : arg11,
            prestige     : v0.prestige,
        };
        0x2::event::emit<LandmarkMinted>(v1);
        0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::admin::bump_landmarks(arg1, 1);
        v0
    }

    public fun mint_to(arg0: &0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::admin::AdminCap, arg1: &mut 0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::admin::Config, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: u32, arg8: u32, arg9: u8, arg10: 0x1::string::String, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Landmark>(mint(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12), arg11);
    }

    public fun name(arg0: &Landmark) : &0x1::string::String {
        &arg0.name
    }

    public fun prestige(arg0: &Landmark) : u64 {
        arg0.prestige
    }

    public fun tier(arg0: &Landmark) : u8 {
        arg0.tier
    }

    // decompiled from Move bytecode v7
}

