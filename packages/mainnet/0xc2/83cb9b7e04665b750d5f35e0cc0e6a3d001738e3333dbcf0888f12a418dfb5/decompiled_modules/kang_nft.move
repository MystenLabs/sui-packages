module 0xc283cb9b7e04665b750d5f35e0cc0e6a3d001738e3333dbcf0888f12a418dfb5::kang_nft {
    struct KANG_NFT has drop {
        dummy_field: bool,
    }

    struct KangNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    struct ENFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct ENFTTransferred has copy, drop {
        object_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    public fun transfer(arg0: KangNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ENFTTransferred{
            object_id : 0x2::object::id<KangNFT>(&arg0),
            from      : 0x2::tx_context::sender(arg2),
            to        : arg1,
        };
        0x2::event::emit<ENFTTransferred>(v0);
        0x2::transfer::public_transfer<KangNFT>(arg0, arg1);
    }

    fun init(arg0: KANG_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"kangNFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/92361529?s=96&v=4"));
        let v4 = 0x2::package::claim<KANG_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<KangNFT>(&v4, v0, v2, arg1);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::display::update_version<KangNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v6);
        0x2::transfer::public_transfer<0x2::display::Display<KangNFT>>(v5, v6);
    }

    public fun mint(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = KangNFT{
            id   : 0x2::object::new(arg1),
            name : 0x1::string::utf8(arg0),
        };
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = ENFTMinted{
            object_id : 0x2::object::id<KangNFT>(&v0),
            creator   : v1,
            name      : v0.name,
        };
        0x2::event::emit<ENFTMinted>(v2);
        0x2::transfer::public_transfer<KangNFT>(v0, v1);
    }

    public fun name(arg0: &KangNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun name_mut(arg0: &mut KangNFT, arg1: vector<u8>) {
        arg0.name = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

