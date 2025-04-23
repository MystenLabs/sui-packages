module 0xc441dac0335300ee0c37280f5daad227cbe86b3ad59b428e486cb6a981f43c1a::suilend_basecamp_nft {
    struct SUILEND_BASECAMP_NFT has drop {
        dummy_field: bool,
    }

    struct SuilendBasecampNft has key {
        id: 0x2::object::UID,
        number: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_uri: 0x1::string::String,
    }

    public fun new(arg0: &mut 0xc441dac0335300ee0c37280f5daad227cbe86b3ad59b428e486cb6a981f43c1a::registry::Registry, arg1: &mut 0x2::tx_context::TxContext) {
        0xc441dac0335300ee0c37280f5daad227cbe86b3ad59b428e486cb6a981f43c1a::registry::assert_not_exists(arg0, arg1);
        let v0 = SuilendBasecampNft{
            id          : 0x2::object::new(arg1),
            number      : 0xc441dac0335300ee0c37280f5daad227cbe86b3ad59b428e486cb6a981f43c1a::registry::size(arg0) + 1,
            name        : 0x1::string::utf8(b"Suilend Basecamp 2025 NFT"),
            description : 0x1::string::utf8(b"A commemorative NFT for the Suilend community at Sui Basecamp 2025 in Dubai."),
            image_uri   : 0x1::string::utf8(b"5FFFkELPk97laX6YEGUuIWwQ6-HkzM_Zz4ldVS767mI"),
        };
        0xc441dac0335300ee0c37280f5daad227cbe86b3ad59b428e486cb6a981f43c1a::registry::add(arg0, 0x2::object::uid_to_inner(&v0.id), 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<SuilendBasecampNft>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun burn(arg0: SuilendBasecampNft, arg1: &mut 0xc441dac0335300ee0c37280f5daad227cbe86b3ad59b428e486cb6a981f43c1a::registry::Registry, arg2: &mut 0x2::tx_context::TxContext) {
        0xc441dac0335300ee0c37280f5daad227cbe86b3ad59b428e486cb6a981f43c1a::registry::remove(arg1, arg2);
        let SuilendBasecampNft {
            id          : v0,
            number      : _,
            name        : _,
            description : _,
            image_uri   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &SuilendBasecampNft) : 0x1::string::String {
        arg0.description
    }

    public fun image_uri(arg0: &SuilendBasecampNft) : 0x1::string::String {
        arg0.image_uri
    }

    fun init(arg0: SUILEND_BASECAMP_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SUILEND_BASECAMP_NFT>(arg0, arg1);
        let v1 = 0x2::display::new<SuilendBasecampNft>(&v0, arg1);
        0x2::display::add<SuilendBasecampNft>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<SuilendBasecampNft>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<SuilendBasecampNft>(&mut v1, 0x1::string::utf8(b"image_uri"), 0x1::string::utf8(b"walrus://{image_uri}"));
        0x2::display::add<SuilendBasecampNft>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://wal.gg/{image_uri}?mimeType=image/gif"));
        0x2::display::update_version<SuilendBasecampNft>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, @0x6191f9a47c411cc169ee4b0292f08531e4d442d4cb9ec61333016d2e9dee1205);
        0x2::transfer::public_transfer<0x2::display::Display<SuilendBasecampNft>>(v1, @0x6191f9a47c411cc169ee4b0292f08531e4d442d4cb9ec61333016d2e9dee1205);
    }

    public fun name(arg0: &SuilendBasecampNft) : 0x1::string::String {
        arg0.name
    }

    public fun number(arg0: &SuilendBasecampNft) : u64 {
        arg0.number
    }

    // decompiled from Move bytecode v6
}

