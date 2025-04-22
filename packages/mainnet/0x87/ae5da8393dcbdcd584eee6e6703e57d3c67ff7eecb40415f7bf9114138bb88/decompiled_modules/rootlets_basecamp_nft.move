module 0x87ae5da8393dcbdcd584eee6e6703e57d3c67ff7eecb40415f7bf9114138bb88::rootlets_basecamp_nft {
    struct ROOTLETS_BASECAMP_NFT has drop {
        dummy_field: bool,
    }

    struct RootletsBasecampNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_uri: 0x1::string::String,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
    }

    public fun destroy(arg0: RootletsBasecampNft) {
        let RootletsBasecampNft {
            id          : v0,
            name        : _,
            description : _,
            image_uri   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_mint_cap(arg0: MintCap) {
        let MintCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: ROOTLETS_BASECAMP_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ROOTLETS_BASECAMP_NFT>(arg0, arg1);
        let v1 = 0x2::display::new<RootletsBasecampNft>(&v0, arg1);
        0x2::display::add<RootletsBasecampNft>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<RootletsBasecampNft>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<RootletsBasecampNft>(&mut v1, 0x1::string::utf8(b"image_uri"), 0x1::string::utf8(b"walrus://{image_uri}"));
        0x2::display::add<RootletsBasecampNft>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://wal.gg/{image_uri}?mimeType=image/gif"));
        0x2::display::update_version<RootletsBasecampNft>(&mut v1);
        let v2 = MintCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, @0x6191f9a47c411cc169ee4b0292f08531e4d442d4cb9ec61333016d2e9dee1205);
        0x2::transfer::public_transfer<0x2::display::Display<RootletsBasecampNft>>(v1, @0x6191f9a47c411cc169ee4b0292f08531e4d442d4cb9ec61333016d2e9dee1205);
        0x2::transfer::public_transfer<MintCap>(v2, @0xb41735cfcd301441913693bad5b62b901017effda15109f5ec08d21eeb270a48);
    }

    fun internal_new_and_transfer(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RootletsBasecampNft{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"Root Sauce: Basecamp 2025 Edition"),
            description : 0x1::string::utf8(b"Limited Edition Root Sauce designed for Sui Basecamp 2025 in Dubai!"),
            image_uri   : 0x1::string::utf8(b"1Clpmccz_Tc_iJcmI1bHpwn_JTBirVq7sGc4eTw8QzY"),
        };
        0x2::transfer::public_transfer<RootletsBasecampNft>(v0, arg0);
    }

    public fun new_and_transfer_bulk(arg0: &mut MintCap, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            internal_new_and_transfer(0x1::vector::pop_back<address>(&mut arg1), arg2);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg1);
    }

    // decompiled from Move bytecode v6
}

