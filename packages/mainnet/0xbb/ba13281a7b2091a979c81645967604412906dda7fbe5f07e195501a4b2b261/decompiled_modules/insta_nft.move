module 0xbbba13281a7b2091a979c81645967604412906dda7fbe5f07e195501a4b2b261::insta_nft {
    struct InstaNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x2::url::Url,
        creator: address,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct INSTA_NFT has drop {
        dummy_field: bool,
    }

    public(friend) fun burn(arg0: InstaNFT) {
        let InstaNFT {
            id          : v0,
            name        : _,
            description : _,
            img_url     : _,
            creator     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &InstaNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun img_url(arg0: &InstaNFT) : &0x2::url::Url {
        &arg0.img_url
    }

    fun init(arg0: INSTA_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://t.me/InstaSuiBot"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"@InstaSuiBot"));
        let v4 = 0x2::package::claim<INSTA_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<InstaNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<InstaNFT>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v6);
        0x2::transfer::public_transfer<0x2::display::Display<InstaNFT>>(v5, v6);
    }

    public(friend) fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = InstaNFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            img_url     : 0x2::url::new_unsafe_from_bytes(arg2),
            creator     : arg3,
        };
        let v1 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v0.id),
            creator   : arg3,
            name      : v0.name,
        };
        0x2::event::emit<MintNFTEvent>(v1);
        0x2::transfer::public_transfer<InstaNFT>(v0, arg3);
    }

    public fun name(arg0: &InstaNFT) : &0x1::string::String {
        &arg0.name
    }

    public(friend) fun update_description(arg0: &mut InstaNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 0);
        arg0.description = 0x1::string::utf8(arg1);
    }

    public(friend) fun update_name(arg0: &mut InstaNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 0);
        arg0.name = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

