module 0xbb5f60c838c5bc7c8e1147b3b0f683df9c757f4709b09003827e90a6e4b2115c::nfts {
    struct NFTS has drop {
        dummy_field: bool,
    }

    struct Owner has key {
        id: 0x2::object::UID,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x1::string::String,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    fun init(arg0: NFTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Owner{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<Owner>(v0, 0x2::tx_context::sender(arg1));
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"img_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"this is name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"this is description"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://nftstorage.link/ipfs/bafybeigql36shsqudxrvxf7yhnqoypkrczpabng6b7gmlqipsger2jg4uu/8k4mw58zng8.png"));
        let v5 = 0x2::package::claim<NFTS>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<NFT>(&v5, v1, v3, arg1);
        0x2::display::update_version<NFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v6, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &Owner, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            img_url     : 0x1::string::utf8(arg3),
        };
        let v1 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v0.id),
            creator   : 0x2::tx_context::sender(arg5),
            name      : v0.name,
        };
        0x2::event::emit<MintNFTEvent>(v1);
        0x2::transfer::public_transfer<NFT>(v0, arg4);
    }

    // decompiled from Move bytecode v6
}

