module 0xc76e89c82342989841f46fafe134677aad54b7bf4aeb9817af5c498f4ae46fc1::nft {
    struct BETTA_NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        attributes_key: vector<0x1::string::String>,
        attributes_value: vector<0x1::string::String>,
        creator: address,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://bettasui.xyz/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<BETTA_NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<BETTA_NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<BETTA_NFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: 0x1::string::String, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= 50000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, @0x9aade983602d59bca76ec5a3f9f40f4a281ed20de3c163937af6d249514ac500);
        let v0 = BETTA_NFT{
            id               : 0x2::object::new(arg6),
            name             : arg0,
            description      : arg1,
            url              : 0x2::url::new_unsafe_from_bytes(*0x1::string::bytes(&arg4)),
            attributes_key   : arg2,
            attributes_value : arg3,
            creator          : 0x2::tx_context::sender(arg6),
        };
        0x2::transfer::public_transfer<BETTA_NFT>(v0, 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v6
}

