module 0xd0277f0b6c7ae118599ebe404563b7663845b5ade9a1d1bbfd5cd4930253ffba::krilltube_pfp {
    struct KRILLTUBE_PFP has drop {
        dummy_field: bool,
    }

    struct KrillTubePFP has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        style: 0x1::string::String,
        creator: address,
    }

    struct PFPMinted has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        style: 0x1::string::String,
    }

    fun init(arg0: KRILLTUBE_PFP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<KRILLTUBE_PFP>(arg0, arg1);
        let v1 = 0x2::display::new<KrillTubePFP>(&v0, arg1);
        0x2::display::add<KrillTubePFP>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<KrillTubePFP>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<KrillTubePFP>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<KrillTubePFP>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"{creator}"));
        0x2::display::add<KrillTubePFP>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://krilltube.xyz"));
        0x2::display::update_version<KrillTubePFP>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<KrillTubePFP>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = KrillTubePFP{
            id          : 0x2::object::new(arg4),
            name        : arg0,
            description : arg1,
            image_url   : 0x2::url::new_unsafe_from_bytes(arg2),
            style       : arg3,
            creator     : v0,
        };
        let v2 = PFPMinted{
            nft_id : 0x2::object::id<KrillTubePFP>(&v1),
            owner  : v0,
            style  : arg3,
        };
        0x2::event::emit<PFPMinted>(v2);
        0x2::transfer::transfer<KrillTubePFP>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

