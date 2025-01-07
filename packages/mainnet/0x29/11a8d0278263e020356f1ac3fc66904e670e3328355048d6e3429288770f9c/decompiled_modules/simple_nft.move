module 0x2911a8d0278263e020356f1ac3fc66904e670e3328355048d6e3429288770f9c::simple_nft {
    struct SimpleNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct SIMPLE_NFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMPLE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://link-nft-sui.gifted.art/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://images-nft-sui.gifted.art/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A Demo NFT only for testing on gifted.art"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui-nft.gifted.art"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Gifted.art"));
        let v4 = 0x2::package::claim<SIMPLE_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SimpleNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<SimpleNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SimpleNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : SimpleNFT {
        let v0 = SimpleNFT{
            id   : 0x2::object::new(arg1),
            name : 0x1::string::utf8(arg0),
        };
        let v1 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v0.id),
            creator   : 0x2::tx_context::sender(arg1),
            name      : v0.name,
        };
        0x2::event::emit<MintNFTEvent>(v1);
        v0
    }

    public entry fun mint_to_sender(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1);
        0x2::transfer::public_transfer<SimpleNFT>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

