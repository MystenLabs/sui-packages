module 0xe996b1450b5be066af7f35fa07c210e34dcfc7ac80f2b94b67721f60a18db8f2::nft {
    struct Attribute has copy, drop, store {
        trait_type: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        attributes: vector<Attribute>,
        kiosk_id: 0x2::object::ID,
        kiosk_owner_cap_id: 0x2::object::ID,
    }

    public fun create_attribute(arg0: 0x1::string::String, arg1: 0x1::string::String) : Attribute {
        Attribute{
            trait_type : arg0,
            value      : arg1,
        }
    }

    public fun create_nft_with_ipfs(arg0: 0x1::string::String, arg1: u64, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) : Nft {
        0x1::string::append(&mut arg0, num_str(arg1));
        0x1::string::append(&mut arg0, 0x1::string::utf8(b".json"));
        0x1::string::append(&mut arg0, num_str(arg1));
        0x1::string::append(&mut arg0, 0x1::string::utf8(b".png"));
        let v0 = 0x1::string::utf8(b"My NFT #");
        0x1::string::append(&mut v0, num_str(arg1));
        Nft{
            id                 : 0x2::object::new(arg4),
            name               : v0,
            description        : 0x1::string::utf8(b"A unique NFT from my collection"),
            image_url          : 0x2::url::new_unsafe_from_bytes(*0x1::string::as_bytes(&arg0)),
            attributes         : 0x1::vector::empty<Attribute>(),
            kiosk_id           : arg2,
            kiosk_owner_cap_id : arg3,
        }
    }

    fun num_str(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = arg0;
        while (v1 / 10 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((v1 % 10 + 48) as u8));
            v1 = v1 / 10;
        };
        0x1::vector::push_back<u8>(&mut v0, ((v1 + 48) as u8));
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

