module 0x727d9fe5194261aa6429f577d0df3f12cfdb3bb0512bf9500a197d7b2d40e29e::OccultPass {
    struct Mint has store, key {
        id: 0x2::object::UID,
        minted: u64,
        total: u64,
        name: 0x1::string::String,
        url: 0x1::string::String,
        burn: u64,
    }

    struct OCCULTPASS has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct OccultPass has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x2::url::Url,
        level: u64,
    }

    public entry fun burn(arg0: OccultPass, arg1: &mut 0x2::tx_context::TxContext) {
        let OccultPass {
            id        : v0,
            name      : _,
            image_url : _,
            level     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: OCCULTPASS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::create_with_mint_cap<OCCULTPASS, OccultPass>(&arg0, 0x1::option::some<u64>(2222), arg1);
        let v3 = v1;
        let v4 = 0x2::package::claim<OCCULTPASS>(arg0, arg1);
        let v5 = 0x2::display::new<OccultPass>(&v4, arg1);
        0x2::display::add<OccultPass>(&mut v5, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<OccultPass>(&mut v5, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"This MultiPass is redeemable for 1 Occult NFT and 1 Ordinal WL."));
        0x2::display::add<OccultPass>(&mut v5, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::update_version<OccultPass>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<OccultPass>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = Witness{dummy_field: false};
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::add_domain<OccultPass, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::DisplayInfo>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_witness<OccultPass, Witness>(v6), &mut v3, 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::display_info::new(0x1::string::utf8(b"Occult Multi-pass"), 0x1::string::utf8(b"This MultiPass is redeemable for 1 Occult NFT and 1 Ordinal WL.")));
        0x2::transfer::public_transfer<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<OccultPass>>(v2, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
        0x2::transfer::public_share_object<0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<OccultPass>>(v3);
        let v7 = Mint{
            id     : 0x2::object::new(arg1),
            minted : 0,
            total  : 2000,
            name   : 0x1::string::utf8(b"Occult Multi-pass"),
            url    : 0x1::string::utf8(b"ipfs://QmPCVTBqPnC5Jm4J1DYvwZguwnU4rTm3dnMJwCjzs37vxR"),
            burn   : 0,
        };
        0x2::transfer::public_share_object<Mint>(v7);
    }

    public fun mint(arg0: &mut Mint, arg1: &mut 0x2::tx_context::TxContext) : OccultPass {
        assert!(arg0.minted < arg0.total, 2);
        let v0 = arg0.name;
        let v1 = arg0.url;
        arg0.minted = arg0.minted + 1;
        0x1::string::append(&mut v0, 0x1::string::utf8(b" #"));
        0x1::string::append(&mut v0, num_str(arg0.minted));
        OccultPass{
            id        : 0x2::object::new(arg1),
            name      : v0,
            image_url : 0x2::url::new_unsafe_from_bytes(*0x1::string::bytes(&v1)),
            level     : 1,
        }
    }

    public entry fun mint_and_transfer(arg0: &mut Mint, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<OccultPass>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x2::transfer::public_transfer<OccultPass>(mint(arg0, arg3), 0x1::vector::pop_back<address>(&mut arg2));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg2);
    }

    public entry fun mint_with(arg0: &mut Mint, arg1: &0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::mint_cap::MintCap<OccultPass>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg2) {
            let v1 = mint(arg0, arg3);
            0x2::transfer::public_transfer<OccultPass>(v1, 0x2::tx_context::sender(arg3));
            v0 = v0 + 1;
        };
    }

    public fun num_str(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 / 10 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::push_back<u8>(&mut v0, ((arg0 + 48) as u8));
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

