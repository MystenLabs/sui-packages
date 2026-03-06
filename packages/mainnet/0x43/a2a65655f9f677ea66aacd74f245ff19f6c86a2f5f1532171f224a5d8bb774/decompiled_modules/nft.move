module 0x43a2a65655f9f677ea66aacd74f245ff19f6c86a2f5f1532171f224a5d8bb774::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct NftToken has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_uri: 0x2::url::Url,
        metadata_uri: 0x2::url::Url,
        project_url: 0x2::url::Url,
        creator: address,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct AdminConfig has key {
        id: 0x2::object::UID,
        admins: vector<address>,
    }

    public fun add_admin(arg0: &mut AdminConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(contains(&arg0.admins, 0x2::tx_context::sender(arg2)), 1);
        assert!(!contains(&arg0.admins, arg1), 2);
        0x1::vector::push_back<address>(&mut arg0.admins, arg1);
    }

    public fun burn(arg0: NftToken, arg1: &mut 0x2::tx_context::TxContext) {
        let NftToken {
            id           : v0,
            name         : _,
            description  : _,
            image_uri    : _,
            metadata_uri : _,
            project_url  : _,
            creator      : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun contains(arg0: &vector<address>, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun creator(arg0: &NftToken) : address {
        arg0.creator
    }

    public fun description(arg0: &NftToken) : &0x1::string::String {
        &arg0.description
    }

    public fun image_uri(arg0: &NftToken) : &0x2::url::Url {
        &arg0.image_uri
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"metadata_uri"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_uri}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{project_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{metadata_uri}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator}"));
        0x2::transfer::public_transfer<0x2::display::Display<NftToken>>(0x2::display::new_with_fields<NftToken>(&v0, v1, v3, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v5 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v5, 0x2::tx_context::sender(arg1));
        let v6 = AdminConfig{
            id     : 0x2::object::new(arg1),
            admins : v5,
        };
        0x2::transfer::share_object<AdminConfig>(v6);
    }

    public fun metadata_uri(arg0: &NftToken) : &0x2::url::Url {
        &arg0.metadata_uri
    }

    public fun mint_to(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: &AdminConfig, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(contains(&arg6.admins, v0), 1);
        let v1 = NftToken{
            id           : 0x2::object::new(arg7),
            name         : 0x1::string::utf8(arg0),
            description  : 0x1::string::utf8(arg1),
            image_uri    : 0x2::url::new_unsafe_from_bytes(arg2),
            metadata_uri : 0x2::url::new_unsafe_from_bytes(arg3),
            project_url  : 0x2::url::new_unsafe_from_bytes(arg4),
            creator      : v0,
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<NftToken>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::transfer<NftToken>(v1, arg5);
    }

    public fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = NftToken{
            id           : 0x2::object::new(arg5),
            name         : 0x1::string::utf8(arg0),
            description  : 0x1::string::utf8(arg1),
            image_uri    : 0x2::url::new_unsafe_from_bytes(arg2),
            metadata_uri : 0x2::url::new_unsafe_from_bytes(arg3),
            project_url  : 0x2::url::new_unsafe_from_bytes(arg4),
            creator      : v0,
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<NftToken>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::transfer<NftToken>(v1, v0);
    }

    public fun name(arg0: &NftToken) : &0x1::string::String {
        &arg0.name
    }

    public fun project_url(arg0: &NftToken) : &0x2::url::Url {
        &arg0.project_url
    }

    public fun update_description(arg0: &mut NftToken, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    public fun update_image_uri(arg0: &mut NftToken, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.image_uri = 0x2::url::new_unsafe_from_bytes(arg1);
    }

    public fun update_metadata_uri(arg0: &mut NftToken, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.metadata_uri = 0x2::url::new_unsafe_from_bytes(arg1);
    }

    // decompiled from Move bytecode v6
}

