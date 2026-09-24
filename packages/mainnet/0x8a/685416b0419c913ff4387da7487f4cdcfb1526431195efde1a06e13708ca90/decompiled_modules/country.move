module 0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::country {
    struct Country has store, key {
        id: 0x2::object::UID,
        country_code: 0x1::string::String,
        name: 0x1::string::String,
        category: 0x1::string::String,
        gdp_basis: u64,
        lat_e6_off: u32,
        lng_e6_off: u32,
        tier: u8,
        image_url: 0x1::string::String,
    }

    struct COUNTRY has drop {
        dummy_field: bool,
    }

    struct CountryMinted has copy, drop {
        object_id: 0x2::object::ID,
        country_code: 0x1::string::String,
        name: 0x1::string::String,
        to: address,
        gdp_basis: u64,
    }

    public fun id(arg0: &Country) : &0x2::object::UID {
        &arg0.id
    }

    public fun category(arg0: &Country) : &0x1::string::String {
        &arg0.category
    }

    public fun country_code(arg0: &Country) : &0x1::string::String {
        &arg0.country_code
    }

    public fun encode_lat_e6(arg0: u32, arg1: bool) : u32 {
        if (arg1) {
            90000000 - arg0
        } else {
            90000000 + arg0
        }
    }

    public fun encode_lng_e6(arg0: u32, arg1: bool) : u32 {
        if (arg1) {
            180000000 - arg0
        } else {
            180000000 + arg0
        }
    }

    public fun gdp_basis(arg0: &Country) : u64 {
        arg0.gdp_basis
    }

    public fun image_url(arg0: &Country) : &0x1::string::String {
        &arg0.image_url
    }

    fun init(arg0: COUNTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<COUNTRY>(arg0, arg1);
        let v1 = 0x2::display::new<Country>(&v0, arg1);
        0x2::display::add<Country>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Country>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(x"506c616e20697420456172746820636f756e747279206465656420e28094207b636f756e7472795f636f64657d"));
        0x2::display::add<Country>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Country>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://planitearth.game"));
        0x2::display::update_version<Country>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Country>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun lat_e6_off(arg0: &Country) : u32 {
        arg0.lat_e6_off
    }

    public fun lng_e6_off(arg0: &Country) : u32 {
        arg0.lng_e6_off
    }

    public fun mint(arg0: &0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::admin::AdminCap, arg1: &mut 0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::admin::Config, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u32, arg7: u32, arg8: u8, arg9: 0x1::string::String, arg10: address, arg11: &mut 0x2::tx_context::TxContext) : Country {
        0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::admin::assert_not_paused(arg1);
        assert!(arg8 >= 1 && arg8 <= 5, 10);
        let v0 = Country{
            id           : 0x2::object::new(arg11),
            country_code : arg2,
            name         : arg3,
            category     : arg4,
            gdp_basis    : arg5,
            lat_e6_off   : arg6,
            lng_e6_off   : arg7,
            tier         : arg8,
            image_url    : arg9,
        };
        let v1 = CountryMinted{
            object_id    : 0x2::object::id<Country>(&v0),
            country_code : v0.country_code,
            name         : v0.name,
            to           : arg10,
            gdp_basis    : v0.gdp_basis,
        };
        0x2::event::emit<CountryMinted>(v1);
        0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::admin::bump_countries(arg1, 1);
        v0
    }

    public fun mint_to(arg0: &0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::admin::AdminCap, arg1: &mut 0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::admin::Config, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u32, arg7: u32, arg8: u8, arg9: 0x1::string::String, arg10: address, arg11: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Country>(mint(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11), arg10);
    }

    public fun name(arg0: &Country) : &0x1::string::String {
        &arg0.name
    }

    public fun tier(arg0: &Country) : u8 {
        arg0.tier
    }

    // decompiled from Move bytecode v7
}

