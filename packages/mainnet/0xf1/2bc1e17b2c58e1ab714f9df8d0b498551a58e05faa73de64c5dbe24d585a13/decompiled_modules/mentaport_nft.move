module 0xf12bc1e17b2c58e1ab714f9df8d0b498551a58e05faa73de64c5dbe24d585a13::mentaport_nft {
    struct MENTAPORT_NFT has drop {
        dummy_field: bool,
    }

    struct LocationNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x2::url::Url,
        metadata_url: 0x2::url::Url,
        project_url: 0x2::url::Url,
        city: 0x1::string::String,
        country: 0x1::string::String,
    }

    struct MintNFTEvent has copy, drop {
        id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        city: 0x1::string::String,
        country: 0x1::string::String,
    }

    public entry fun burn(arg0: LocationNft) {
        let LocationNft {
            id           : v0,
            name         : _,
            image_url    : _,
            metadata_url : _,
            project_url  : _,
            city         : _,
            country      : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun city(arg0: &LocationNft) : &0x1::string::String {
        &arg0.city
    }

    public fun country(arg0: &LocationNft) : &0x1::string::String {
        &arg0.country
    }

    public fun image_url(arg0: &LocationNft) : &0x2::url::Url {
        &arg0.image_url
    }

    fun init(arg0: MENTAPORT_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Stamps"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://stamps.mentaport.xyz/stamp/sui/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Many things make each of us unique, and one of these is our spatial context. We want to imprint digital assets with what is relevant and meaningful to people: Our cities, culture, and communities. Show off the cities you are at!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.mentaport.xyz"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Mentaport Inc."));
        let v4 = 0x2::package::claim<MENTAPORT_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<LocationNft>(&v4, v0, v2, arg1);
        0x2::display::update_version<LocationNft>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<LocationNft>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun metadata_url(arg0: &LocationNft) : &0x2::url::Url {
        &arg0.metadata_url
    }

    public entry fun mint(arg0: &mut 0xf12bc1e17b2c58e1ab714f9df8d0b498551a58e05faa73de64c5dbe24d585a13::signer_verify::MintRules, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0xf12bc1e17b2c58e1ab714f9df8d0b498551a58e05faa73de64c5dbe24d585a13::signer_verify::mint_with_cap(arg0, v0, arg1, arg2, arg3), 1);
        let v1 = LocationNft{
            id           : 0x2::object::new(arg8),
            name         : 0x1::string::utf8(b"Stamps"),
            image_url    : 0x2::url::new_unsafe_from_bytes(arg6),
            metadata_url : 0x2::url::new_unsafe_from_bytes(arg7),
            project_url  : 0x2::url::new_unsafe_from_bytes(b"https://www.mentaport.xyz"),
            city         : 0x1::string::utf8(arg4),
            country      : 0x1::string::utf8(arg5),
        };
        let v2 = MintNFTEvent{
            id      : 0x2::object::uid_to_inner(&v1.id),
            creator : v0,
            name    : 0x1::string::utf8(b"Stamps"),
            city    : v1.city,
            country : v1.country,
        };
        0x2::event::emit<MintNFTEvent>(v2);
        0x2::transfer::public_transfer<LocationNft>(v1, v0);
    }

    public fun name(arg0: &LocationNft) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v6
}

