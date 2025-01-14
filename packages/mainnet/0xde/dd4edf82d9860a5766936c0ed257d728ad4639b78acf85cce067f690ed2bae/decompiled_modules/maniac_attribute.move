module 0xdedd4edf82d9860a5766936c0ed257d728ad4639b78acf85cce067f690ed2bae::maniac_attribute {
    struct Admin has store {
        admin_address: address,
    }

    struct MintingControl has store, key {
        id: 0x2::object::UID,
        admin: Admin,
    }

    struct MANIAC_ATTRIBUTE has drop {
        dummy_field: bool,
    }

    struct ManiacAttributeNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x2::url::Url,
        field_type: 0x1::string::String,
        field_value: 0x1::string::String,
    }

    public(friend) fun create_attribute(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : ManiacAttributeNft {
        0x1::vector::append<u8>(&mut arg1, b" Attribute");
        let v0 = b"https://base-metadata-api-testnet.vercel.app/layers/";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, b"/");
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, b".png");
        ManiacAttributeNft{
            id          : 0x2::object::new(arg2),
            name        : 0x1::string::utf8(arg1),
            image_url   : 0x2::url::new_unsafe_from_bytes(v0),
            field_type  : 0x1::string::utf8(arg0),
            field_value : 0x1::string::utf8(arg1),
        }
    }

    public fun field_type(arg0: &ManiacAttributeNft) : &0x1::string::String {
        &arg0.field_type
    }

    public fun field_value(arg0: &ManiacAttributeNft) : &0x1::string::String {
        &arg0.field_value
    }

    fun init(arg0: MANIAC_ATTRIBUTE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://coinfever.app"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"CoinFever"));
        let v4 = 0x2::package::claim<MANIAC_ATTRIBUTE>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<ManiacAttributeNft>(&v4, v0, v2, arg1);
        0x2::display::update_version<ManiacAttributeNft>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<ManiacAttributeNft>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = Admin{admin_address: 0x2::tx_context::sender(arg1)};
        let v7 = MintingControl{
            id    : 0x2::object::new(arg1),
            admin : v6,
        };
        0x2::transfer::share_object<MintingControl>(v7);
    }

    public fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = create_attribute(arg0, arg1, arg2);
        0x2::transfer::public_transfer<ManiacAttributeNft>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

