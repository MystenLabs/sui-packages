module 0xb05f6e968458f746456a389cc7a8b0815829723c0890a9dc6bce7f6fcc3e53ae::nft_factory {
    struct BlockusNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        link: 0x2::url::Url,
        thumbnail_url: 0x1::string::String,
        project_url: 0x1::string::String,
        creator: 0x1::string::String,
        custom_attributes: 0x1::string::String,
        external_id: 0x1::string::String,
    }

    struct NFT_FACTORY has drop {
        dummy_field: bool,
    }

    struct MintCap has key {
        id: 0x2::object::UID,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun burn(arg0: &MintCap, arg1: BlockusNft) {
        let BlockusNft {
            id                : v0,
            name              : _,
            description       : _,
            image_url         : _,
            link              : _,
            thumbnail_url     : _,
            project_url       : _,
            creator           : _,
            custom_attributes : _,
            external_id       : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public entry fun create_minter(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MintCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<MintCap>(v0, arg1);
    }

    fun init(arg0: NFT_FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"id"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"custom_attributes"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{link}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{project_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{thumbnail_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{custom_attributes}"));
        let v4 = 0x2::package::claim<NFT_FACTORY>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<BlockusNft>(&v4, v0, v2, arg1);
        let v6 = MintCap{id: 0x2::object::new(arg1)};
        let v7 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::display::update_version<BlockusNft>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<BlockusNft>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<MintCap>(v6, @0x513aee5f129c1084c9d19569579b4be978c034033fc44960c7f7e377161edc2c);
        0x2::transfer::transfer<AdminCap>(v7, @0x513aee5f129c1084c9d19569579b4be978c034033fc44960c7f7e377161edc2c);
    }

    public entry fun mint(arg0: &MintCap, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = BlockusNft{
            id                : 0x2::object::new(arg11),
            name              : 0x1::string::utf8(arg2),
            description       : 0x1::string::utf8(arg3),
            image_url         : 0x1::string::utf8(arg4),
            link              : 0x2::url::new_unsafe_from_bytes(arg5),
            thumbnail_url     : 0x1::string::utf8(arg6),
            project_url       : 0x1::string::utf8(arg7),
            creator           : 0x1::string::utf8(arg8),
            custom_attributes : 0x1::string::utf8(arg9),
            external_id       : 0x1::string::utf8(arg10),
        };
        0x2::transfer::public_transfer<BlockusNft>(v0, arg1);
    }

    public entry fun set_creator(arg0: &MintCap, arg1: &mut BlockusNft, arg2: 0x1::string::String) {
        arg1.creator = arg2;
    }

    public entry fun set_custom_attributes(arg0: &MintCap, arg1: &mut BlockusNft, arg2: 0x1::string::String) {
        arg1.custom_attributes = arg2;
    }

    public entry fun set_description(arg0: &MintCap, arg1: &mut BlockusNft, arg2: 0x1::string::String) {
        arg1.description = arg2;
    }

    public entry fun set_external_id(arg0: &MintCap, arg1: &mut BlockusNft, arg2: 0x1::string::String) {
        arg1.external_id = arg2;
    }

    public entry fun set_image_url(arg0: &MintCap, arg1: &mut BlockusNft, arg2: 0x1::string::String) {
        arg1.image_url = arg2;
    }

    public entry fun set_link(arg0: &MintCap, arg1: &mut BlockusNft, arg2: vector<u8>) {
        arg1.link = 0x2::url::new_unsafe_from_bytes(arg2);
    }

    public entry fun set_name(arg0: &MintCap, arg1: &mut BlockusNft, arg2: 0x1::string::String) {
        arg1.name = arg2;
    }

    public entry fun set_project_url(arg0: &MintCap, arg1: &mut BlockusNft, arg2: 0x1::string::String) {
        arg1.project_url = arg2;
    }

    public entry fun set_thumbnail_url(arg0: &MintCap, arg1: &mut BlockusNft, arg2: 0x1::string::String) {
        arg1.thumbnail_url = arg2;
    }

    // decompiled from Move bytecode v6
}

