module 0x7f45a0cdfc2f82569e0fee267aef22370a6f7ebd316331108d7c427b2cdd6bc::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct NFTObject has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x1::string::String,
        external_url: 0x1::string::String,
    }

    struct MintCap has key {
        id: 0x2::object::UID,
        allowed_minter: address,
        minted: 0x2::table::Table<address, bool>,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        recipient: address,
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MintCap{
            id             : 0x2::object::new(arg1),
            allowed_minter : 0x2::tx_context::sender(arg1),
            minted         : 0x2::table::new<address, bool>(arg1),
        };
        let v1 = 0x2::package::claim<NFT>(arg0, arg1);
        let v2 = 0x2::display::new<NFTObject>(&v1, arg1);
        0x2::display::add<NFTObject>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<NFTObject>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<NFTObject>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{img_url}"));
        0x2::display::add<NFTObject>(&mut v2, 0x1::string::utf8(b"thumbnail_url"), 0x1::string::utf8(b"{img_url}"));
        0x2::display::add<NFTObject>(&mut v2, 0x1::string::utf8(b"image"), 0x1::string::utf8(b"{img_url}"));
        0x2::display::add<NFTObject>(&mut v2, 0x1::string::utf8(b"url"), 0x1::string::utf8(b"{img_url}"));
        0x2::display::add<NFTObject>(&mut v2, 0x1::string::utf8(b"external_url"), 0x1::string::utf8(b"{external_url}"));
        0x2::display::add<NFTObject>(&mut v2, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"{external_url}"));
        0x2::display::add<NFTObject>(&mut v2, 0x1::string::utf8(b"collection_name"), 0x1::string::from_ascii(0x1::ascii::string(b"Gatchaman Commemorative NFT")));
        0x2::display::add<NFTObject>(&mut v2, 0x1::string::utf8(b"creator"), 0x1::string::from_ascii(0x1::ascii::string(b"Project J")));
        0x2::display::add<NFTObject>(&mut v2, 0x1::string::utf8(b"project_url"), 0x1::string::from_ascii(0x1::ascii::string(b"https://lp.projectj-tcg.com")));
        0x2::display::update_version<NFTObject>(&mut v2);
        0x2::transfer::share_object<MintCap>(v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFTObject>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut MintCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.allowed_minter == 0x2::tx_context::sender(arg2), 0);
        assert!(!0x2::table::contains<address, bool>(&arg0.minted, arg1), 1);
        let v0 = NFTObject{
            id           : 0x2::object::new(arg2),
            name         : 0x1::string::from_ascii(0x1::ascii::string(b"Gatchaman Commemorative NFT")),
            description  : 0x1::string::from_ascii(0x1::ascii::string(b"A unique NFT that can only be minted once per address")),
            img_url      : 0x1::string::from_ascii(0x1::ascii::string(b"https://lp.projectj-tcg.com/card.png")),
            external_url : 0x1::string::from_ascii(0x1::ascii::string(b"https://lp.projectj-tcg.com")),
        };
        0x2::table::add<address, bool>(&mut arg0.minted, arg1, true);
        let v1 = NFTMinted{
            object_id : 0x2::object::id<NFTObject>(&v0),
            creator   : 0x2::tx_context::sender(arg2),
            recipient : arg1,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::public_transfer<NFTObject>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

