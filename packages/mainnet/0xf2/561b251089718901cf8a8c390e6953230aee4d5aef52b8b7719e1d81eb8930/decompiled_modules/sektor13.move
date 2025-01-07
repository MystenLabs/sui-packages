module 0xf2561b251089718901cf8a8c390e6953230aee4d5aef52b8b7719e1d81eb8930::sektor13 {
    struct NFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        collection_id: 0x2::object::ID,
        collection_name: 0x1::string::String,
        collection_description: 0x1::string::String,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct NFTCollection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        nft_ids: 0x2::table_vec::TableVec<0x2::object::ID>,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        creator: address,
        collection_id: 0x2::object::ID,
    }

    struct CollectionCreated has copy, drop {
        collection_id: 0x2::object::ID,
        owner: address,
    }

    struct SEKTOR13 has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: NFT) {
        let NFT {
            id                     : v0,
            name                   : _,
            description            : _,
            image_url              : _,
            collection_id          : _,
            collection_name        : _,
            collection_description : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun create_collection(arg0: &AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = NFTCollection{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            nft_ids     : 0x2::table_vec::empty<0x2::object::ID>(arg3),
        };
        0x2::transfer::public_transfer<NFTCollection>(v1, v0);
        let v2 = CollectionCreated{
            collection_id : 0x2::object::id<NFTCollection>(&v1),
            owner         : v0,
        };
        0x2::event::emit<CollectionCreated>(v2);
    }

    public fun getNFTDescription(arg0: &NFT) : &0x1::string::String {
        &arg0.description
    }

    public fun getNFTName(arg0: &NFT) : &0x1::string::String {
        &arg0.name
    }

    public fun getNFTUrl(arg0: &NFT) : &0x2::url::Url {
        &arg0.image_url
    }

    fun init(arg0: SEKTOR13, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"collection_id"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://explorer.sui.io/object/{id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{collection_id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://sektor13.xyz"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Sektor13"));
        let v5 = 0x2::package::claim<SEKTOR13>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<NFT>(&v5, v1, v3, arg1);
        0x2::display::update_version<NFT>(&mut v6);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun mintNFT(arg0: &AdminCap, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: vector<u8>, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id                     : 0x2::object::new(arg8),
            name                   : 0x1::string::utf8(arg2),
            description            : 0x1::string::utf8(arg3),
            image_url              : 0x2::url::new_unsafe_from_bytes(arg4),
            collection_id          : arg1,
            collection_name        : 0x1::string::utf8(arg6),
            collection_description : 0x1::string::utf8(arg7),
        };
        0x2::transfer::transfer<NFT>(v0, arg5);
        let v1 = NFTMinted{
            nft_id        : 0x2::object::id<NFT>(&v0),
            creator       : arg5,
            collection_id : arg1,
        };
        0x2::event::emit<NFTMinted>(v1);
    }

    public fun mintNFTToCollection(arg0: &AdminCap, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: vector<u8>, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id                     : 0x2::object::new(arg8),
            name                   : 0x1::string::utf8(arg2),
            description            : 0x1::string::utf8(arg3),
            image_url              : 0x2::url::new_unsafe_from_bytes(arg4),
            collection_id          : arg1,
            collection_name        : 0x1::string::utf8(arg6),
            collection_description : 0x1::string::utf8(arg7),
        };
        0x2::transfer::transfer<NFT>(v0, arg5);
        let v1 = NFTMinted{
            nft_id        : 0x2::object::id<NFT>(&v0),
            creator       : arg5,
            collection_id : arg1,
        };
        0x2::event::emit<NFTMinted>(v1);
    }

    // decompiled from Move bytecode v6
}

