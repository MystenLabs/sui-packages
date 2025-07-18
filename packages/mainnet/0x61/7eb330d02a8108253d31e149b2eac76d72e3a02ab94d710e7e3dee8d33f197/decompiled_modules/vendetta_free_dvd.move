module 0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::vendetta_free_dvd {
    struct VENDETTA_FRE_DVD has drop {
        dummy_field: bool,
    }

    struct FreeVendettaDVD has key {
        id: 0x2::object::UID,
        tier: u8,
        name: 0x1::string::String,
        description: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        image_url: 0x1::string::String,
        model_url: 0x1::string::String,
        number: u64,
    }

    struct FreeDVDRegistry has key {
        id: 0x2::object::UID,
        current_supply: u64,
        dvd_holders: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct FreeMintDvdEvent has copy, drop {
        nft_id: 0x2::object::ID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        price_paid: u64,
        receiver: address,
        edition: 0x1::string::String,
        texture: 0x1::string::String,
        cover_art: 0x1::string::String,
        tier: u8,
    }

    public fun add_player(arg0: &mut FreeVendettaDVD, arg1: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::dvd_version::Version, arg2: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::dvd_authority::DVDCap, arg3: 0x2::object::ID) {
        0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::dvd_version::validate_version(arg1, 2);
        assert!(!0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"player")), 0);
        0x2::dynamic_field::add<0x1::string::String, 0x2::object::ID>(&mut arg0.id, 0x1::string::utf8(b"player"), arg3);
    }

    public fun free_mint(arg0: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::dvd_version::Version, arg1: &mut FreeDVDRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::dvd_version::validate_version(arg0, 2);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg1.dvd_holders, 0x2::tx_context::sender(arg2)), 2);
        arg1.current_supply = arg1.current_supply + 1;
        let v0 = FreeVendettaDVD{
            id          : 0x2::object::new(arg2),
            tier        : 0,
            name        : 0x1::string::utf8(b"Vendetta DVD"),
            description : 0x1::string::utf8(b"This is a free dvd"),
            attributes  : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            image_url   : 0x1::string::utf8(b"https://vendetta-assets.s3.eu-west-1.amazonaws.com/dvds/freeMint/mintDVD.webp"),
            model_url   : 0x1::string::utf8(b"https://vendetta-assets.s3.eu-west-1.amazonaws.com/dvds/freeMint/mintDVD.glb"),
            number      : arg1.current_supply,
        };
        0x2::table::add<address, 0x2::object::ID>(&mut arg1.dvd_holders, 0x2::tx_context::sender(arg2), 0x2::object::id<FreeVendettaDVD>(&v0));
        let v1 = FreeMintDvdEvent{
            nft_id     : 0x2::object::id<FreeVendettaDVD>(&v0),
            name       : v0.name,
            image_url  : v0.image_url,
            price_paid : 0,
            receiver   : 0x2::tx_context::sender(arg2),
            edition    : 0x1::string::utf8(b""),
            texture    : 0x1::string::utf8(b""),
            cover_art  : 0x1::string::utf8(b""),
            tier       : v0.tier,
        };
        0x2::event::emit<FreeMintDvdEvent>(v1);
        0x2::transfer::transfer<FreeVendettaDVD>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun init_free_dvd(arg0: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::dvd_authority::GovernorCap, arg1: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::dvd_version::Version, arg2: &0x2::package::Publisher, arg3: &mut 0x2::tx_context::TxContext) {
        0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::dvd_version::validate_version(arg1, 2);
        let v0 = 0x2::display::new<FreeVendettaDVD>(arg2, arg3);
        let v1 = FreeDVDRegistry{
            id             : 0x2::object::new(arg3),
            current_supply : 0,
            dvd_holders    : 0x2::table::new<address, 0x2::object::ID>(arg3),
        };
        0x2::display::add<FreeVendettaDVD>(&mut v0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Vendetta DVD #{number}"));
        0x2::display::add<FreeVendettaDVD>(&mut v0, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"The Vendetta DVD stores your game state, including your progress, actions, and history. It is required to access and play the game"));
        0x2::display::add<FreeVendettaDVD>(&mut v0, 0x1::string::utf8(b"number"), 0x1::string::utf8(b"{number}"));
        0x2::display::add<FreeVendettaDVD>(&mut v0, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://vendetta-assets.s3.eu-west-1.amazonaws.com/dvds/freeMint/mintDVD.webp"));
        0x2::display::update_version<FreeVendettaDVD>(&mut v0);
        0x2::transfer::public_transfer<0x2::display::Display<FreeVendettaDVD>>(v0, 0x2::tx_context::sender(arg3));
        0x2::transfer::share_object<FreeDVDRegistry>(v1);
    }

    public fun is_valid_player(arg0: &FreeVendettaDVD, arg1: &0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::dvd_version::Version, arg2: 0x2::object::ID) {
        0x5add2a1cf7289de270b32ccb66cd4616c4974ac27aa2562a3400447bc7aa5395::dvd_version::validate_version(arg1, 2);
        assert!(arg2 == *0x2::dynamic_field::borrow<0x1::string::String, 0x2::object::ID>(&arg0.id, 0x1::string::utf8(b"player")), 1);
    }

    // decompiled from Move bytecode v6
}

