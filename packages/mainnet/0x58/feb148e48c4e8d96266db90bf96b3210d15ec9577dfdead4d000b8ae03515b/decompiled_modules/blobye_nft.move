module 0x58feb148e48c4e8d96266db90bf96b3210d15ec9577dfdead4d000b8ae03515b::blobye_nft {
    struct BLOBYE_NFT has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BlobyeNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        collection_name: 0x1::string::String,
        creator: address,
        platform_id: 0x1::string::String,
    }

    struct NFTMinted has copy, drop {
        nft_id: address,
        name: 0x1::string::String,
        collection_name: 0x1::string::String,
        creator: address,
        buyer: address,
        platform_id: 0x1::string::String,
    }

    fun init(arg0: BLOBYE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<BLOBYE_NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"collection"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{collection_name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://blobye.com"));
        let v5 = 0x2::display::new_with_fields<BlobyeNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<BlobyeNFT>(&mut v5);
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<BlobyeNFT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun mint_and_transfer(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: address, arg6: 0x1::string::String, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = BlobyeNFT{
            id              : 0x2::object::new(arg8),
            name            : arg1,
            description     : arg2,
            image_url       : arg3,
            collection_name : arg4,
            creator         : arg5,
            platform_id     : arg6,
        };
        let v1 = NFTMinted{
            nft_id          : 0x2::object::uid_to_address(&v0.id),
            name            : v0.name,
            collection_name : v0.collection_name,
            creator         : v0.creator,
            buyer           : arg7,
            platform_id     : v0.platform_id,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::public_transfer<BlobyeNFT>(v0, arg7);
    }

    // decompiled from Move bytecode v6
}

