module 0x1c706a00bafd9184d851216839d9efee9cba25debeb6bda7e2130b1e63867957::OccultPass {
    struct Mint has store, key {
        id: 0x2::object::UID,
        minted: u64,
        total: u64,
        name: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct OCCULTPASS has drop {
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
        let v0 = 0x2::package::claim<OCCULTPASS>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<OccultPass>(&v0, arg1);
        let v3 = v2;
        let v4 = v1;
        0x1c706a00bafd9184d851216839d9efee9cba25debeb6bda7e2130b1e63867957::rule::add<OccultPass>(&mut v4, &v3, 500, 10000000);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<OccultPass>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<OccultPass>>(v4);
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"creator"));
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"This Multi-pass will be redeemable for 1X Occult NFT"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"Occult"));
        let v9 = 0x2::display::new_with_fields<OccultPass>(&v0, v5, v7, arg1);
        0x2::display::update_version<OccultPass>(&mut v9);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<OccultPass>>(v9, 0x2::tx_context::sender(arg1));
        let v10 = Mint{
            id     : 0x2::object::new(arg1),
            minted : 0,
            total  : 1200,
            name   : 0x1::string::utf8(b"Occult Multi-pass"),
            url    : 0x1::string::utf8(b"https://cloudflare-ipfs.com/ipfs/QmPCVTBqPnC5Jm4J1DYvwZguwnU4rTm3dnMJwCjzs37vxR"),
        };
        0x2::transfer::public_share_object<Mint>(v10);
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

    public entry fun mint_with(arg0: &mut Mint, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg1) {
            let v1 = mint(arg0, arg2);
            0x2::transfer::public_transfer<OccultPass>(v1, 0x2::tx_context::sender(arg2));
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

