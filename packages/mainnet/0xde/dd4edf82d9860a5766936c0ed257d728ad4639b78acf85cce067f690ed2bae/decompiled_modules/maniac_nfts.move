module 0xdedd4edf82d9860a5766936c0ed257d728ad4639b78acf85cce067f690ed2bae::maniac_nfts {
    struct Admin has store {
        admin_address: address,
    }

    struct MintingControl has store, key {
        id: 0x2::object::UID,
        paused: bool,
        counter: u32,
        admin: Admin,
    }

    struct MANIAC_NFTS has drop {
        dummy_field: bool,
    }

    struct ManiacNftAttributes has store {
        background: 0x1::string::String,
        body: 0x1::string::String,
        hat: 0x1::string::String,
        beard: 0x1::string::String,
        eyes: 0x1::string::String,
    }

    struct ManiacNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x2::url::Url,
        attributes: ManiacNftAttributes,
    }

    fun init(arg0: MANIAC_NFTS, arg1: &mut 0x2::tx_context::TxContext) {
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
        let v4 = 0x2::package::claim<MANIAC_NFTS>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<ManiacNft>(&v4, v0, v2, arg1);
        0x2::display::update_version<ManiacNft>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<ManiacNft>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = Admin{admin_address: 0x2::tx_context::sender(arg1)};
        let v7 = MintingControl{
            id      : 0x2::object::new(arg1),
            paused  : false,
            counter : 0,
            admin   : v6,
        };
        0x2::transfer::share_object<MintingControl>(v7);
    }

    public fun mint_to_sender(arg0: &mut MintingControl, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"Fever Maniac #");
        let v1 = 0x1::u32::to_string(arg0.counter);
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&v1));
        let v2 = 0x2::object::new(arg4);
        let v3 = b"https://base-metadata-api-testnet.vercel.app/api/image-sui/?id=";
        let v4 = 0x2::address::to_string(0x2::object::uid_to_address(&v2));
        0x1::vector::append<u8>(&mut v3, *0x1::string::as_bytes(&v4));
        let v5 = ManiacNftAttributes{
            background : 0x1::string::utf8(b"None"),
            body       : 0x1::string::utf8(b"None"),
            hat        : 0x1::string::utf8(b"None"),
            beard      : 0x1::string::utf8(b"None"),
            eyes       : 0x1::string::utf8(b"None"),
        };
        let v6 = ManiacNft{
            id         : v2,
            name       : 0x1::string::utf8(v0),
            image_url  : 0x2::url::new_unsafe_from_bytes(v3),
            attributes : v5,
        };
        arg0.counter = arg0.counter + 1;
        let v7 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<ManiacNft>(v6, v7);
        0x2::transfer::public_transfer<0xdedd4edf82d9860a5766936c0ed257d728ad4639b78acf85cce067f690ed2bae::maniac_attribute::ManiacAttributeNft>(0xdedd4edf82d9860a5766936c0ed257d728ad4639b78acf85cce067f690ed2bae::maniac_attribute::create_attribute(b"background", arg1, arg4), v7);
        0x2::transfer::public_transfer<0xdedd4edf82d9860a5766936c0ed257d728ad4639b78acf85cce067f690ed2bae::maniac_attribute::ManiacAttributeNft>(0xdedd4edf82d9860a5766936c0ed257d728ad4639b78acf85cce067f690ed2bae::maniac_attribute::create_attribute(b"beard", arg2, arg4), v7);
        0x2::transfer::public_transfer<0xdedd4edf82d9860a5766936c0ed257d728ad4639b78acf85cce067f690ed2bae::maniac_attribute::ManiacAttributeNft>(0xdedd4edf82d9860a5766936c0ed257d728ad4639b78acf85cce067f690ed2bae::maniac_attribute::create_attribute(b"body", arg3, arg4), v7);
    }

    public fun set_attribute(arg0: &mut ManiacNft, arg1: vector<0xdedd4edf82d9860a5766936c0ed257d728ad4639b78acf85cce067f690ed2bae::maniac_attribute::ManiacAttributeNft>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0xdedd4edf82d9860a5766936c0ed257d728ad4639b78acf85cce067f690ed2bae::maniac_attribute::ManiacAttributeNft>(&arg1) >= 1 && 0x1::vector::length<0xdedd4edf82d9860a5766936c0ed257d728ad4639b78acf85cce067f690ed2bae::maniac_attribute::ManiacAttributeNft>(&arg1) <= 5, 1);
        while (!0x1::vector::is_empty<0xdedd4edf82d9860a5766936c0ed257d728ad4639b78acf85cce067f690ed2bae::maniac_attribute::ManiacAttributeNft>(&arg1)) {
            let v0 = 0x1::vector::pop_back<0xdedd4edf82d9860a5766936c0ed257d728ad4639b78acf85cce067f690ed2bae::maniac_attribute::ManiacAttributeNft>(&mut arg1);
            let v1 = 0x1::string::as_bytes(0xdedd4edf82d9860a5766936c0ed257d728ad4639b78acf85cce067f690ed2bae::maniac_attribute::field_type(&v0));
            let v2 = 0x1::string::as_bytes(0xdedd4edf82d9860a5766936c0ed257d728ad4639b78acf85cce067f690ed2bae::maniac_attribute::field_value(&v0));
            if (0x2::dynamic_object_field::exists_<vector<u8>>(&arg0.id, *v1)) {
                0x2::transfer::public_transfer<0xdedd4edf82d9860a5766936c0ed257d728ad4639b78acf85cce067f690ed2bae::maniac_attribute::ManiacAttributeNft>(0x2::dynamic_object_field::remove<vector<u8>, 0xdedd4edf82d9860a5766936c0ed257d728ad4639b78acf85cce067f690ed2bae::maniac_attribute::ManiacAttributeNft>(&mut arg0.id, *v1), 0x2::tx_context::sender(arg2));
            };
            let v3 = b"background";
            if (v1 == &v3) {
                arg0.attributes.background = 0x1::string::utf8(*v2);
            } else {
                let v4 = b"body";
                if (v1 == &v4) {
                    arg0.attributes.body = 0x1::string::utf8(*v2);
                } else {
                    let v5 = b"hat";
                    if (v1 == &v5) {
                        arg0.attributes.hat = 0x1::string::utf8(*v2);
                    } else {
                        let v6 = b"beard";
                        if (v1 == &v6) {
                            arg0.attributes.beard = 0x1::string::utf8(*v2);
                        } else {
                            let v7 = b"eyes";
                            if (v1 == &v7) {
                                arg0.attributes.eyes = 0x1::string::utf8(*v2);
                            };
                        };
                    };
                };
            };
            0x2::dynamic_object_field::add<vector<u8>, 0xdedd4edf82d9860a5766936c0ed257d728ad4639b78acf85cce067f690ed2bae::maniac_attribute::ManiacAttributeNft>(&mut arg0.id, *v1, v0);
        };
        0x1::vector::destroy_empty<0xdedd4edf82d9860a5766936c0ed257d728ad4639b78acf85cce067f690ed2bae::maniac_attribute::ManiacAttributeNft>(arg1);
    }

    // decompiled from Move bytecode v6
}

