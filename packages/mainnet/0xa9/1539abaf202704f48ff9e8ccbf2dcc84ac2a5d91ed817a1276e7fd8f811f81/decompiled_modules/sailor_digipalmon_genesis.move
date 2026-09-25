module 0xa91539abaf202704f48ff9e8ccbf2dcc84ac2a5d91ed817a1276e7fd8f811f81::sailor_digipalmon_genesis {
    struct SAILOR_DIGIPALMON_GENESIS has drop {
        dummy_field: bool,
    }

    struct SailorNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        metadata_url: 0x2::url::Url,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public fun description(arg0: &SailorNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &SailorNFT) : &0x2::url::Url {
        &arg0.image_url
    }

    fun init(arg0: SAILOR_DIGIPALMON_GENESIS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SAILOR_DIGIPALMON_GENESIS>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        let v5 = 0x2::display::new_with_fields<SailorNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<SailorNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<SailorNFT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun metadata_url(arg0: &SailorNFT) : &0x2::url::Url {
        &arg0.metadata_url
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Character"), 0x1::string::utf8(arg4));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Rarity"), 0x1::string::utf8(arg5));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Collection"), 0x1::string::utf8(arg6));
        let v1 = SailorNFT{
            id           : 0x2::object::new(arg8),
            name         : 0x1::string::utf8(arg0),
            description  : 0x1::string::utf8(arg1),
            image_url    : 0x2::url::new_unsafe_from_bytes(arg2),
            metadata_url : 0x2::url::new_unsafe_from_bytes(arg3),
            attributes   : v0,
        };
        0x2::transfer::public_transfer<SailorNFT>(v1, arg7);
    }

    public fun name(arg0: &SailorNFT) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v7
}

