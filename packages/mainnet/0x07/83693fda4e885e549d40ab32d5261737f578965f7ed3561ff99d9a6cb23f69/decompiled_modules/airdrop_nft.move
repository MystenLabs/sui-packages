module 0x783693fda4e885e549d40ab32d5261737f578965f7ed3561ff99d9a6cb23f69::airdrop_nft {
    struct AirdropNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct AIRDROP_NFT has drop {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun transfer(arg0: AirdropNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<AirdropNFT>(arg0, arg1);
    }

    public fun url(arg0: &AirdropNFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: AirdropNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let AirdropNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &AirdropNFT) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: AIRDROP_NFT, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ethos-example-app.onrender.com/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Ethos"));
        let v4 = 0x2::package::claim<AIRDROP_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<AirdropNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<AirdropNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<AirdropNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : AirdropNFT {
        let v0 = AirdropNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v1 = NFTMinted{
            object_id : 0x2::object::id<AirdropNFT>(&v0),
            creator   : 0x2::tx_context::sender(arg3),
            name      : v0.name,
        };
        0x2::event::emit<NFTMinted>(v1);
        v0
    }

    public entry fun mint_to_airdrop(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<AirdropNFT>(mint(arg0, arg1, arg2, arg4), arg3);
    }

    public fun name(arg0: &AirdropNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut AirdropNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

