module 0x93e51eda6559fdb221d16254b868065bb21a4a6a068787cf142e28da0631230d::Anonymous_nft {
    struct AnonymousNFT has store, key {
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

    struct ANONYMOUS_NFT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: AnonymousNFT) {
        let AnonymousNFT {
            id          : v0,
            name        : _,
            description : _,
            img_url     : _,
            creator     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &AnonymousNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun img_url(arg0: &AnonymousNFT) : &0x2::url::Url {
        &arg0.img_url
    }

    fun init(arg0: ANONYMOUS_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"version"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://Anonymous.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Beta"));
        let v4 = 0x2::package::claim<ANONYMOUS_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<AnonymousNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<AnonymousNFT>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v6);
        0x2::transfer::public_transfer<0x2::display::Display<AnonymousNFT>>(v5, v6);
    }

    public fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : AnonymousNFT {
        let v0 = AnonymousNFT{
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
        v0
    }

    public entry fun mint_n_to(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg5) {
            mint_to(arg0, arg1, arg2, arg3, arg4, arg6);
            v0 = v0 + 1;
        };
    }

    public entry fun mint_to(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<AnonymousNFT>(mint(arg0, arg1, arg2, arg3, arg5), arg4);
    }

    public fun name(arg0: &AnonymousNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut AnonymousNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 0);
        arg0.description = 0x1::string::utf8(arg1);
    }

    public entry fun update_name(arg0: &mut AnonymousNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 0);
        arg0.name = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

