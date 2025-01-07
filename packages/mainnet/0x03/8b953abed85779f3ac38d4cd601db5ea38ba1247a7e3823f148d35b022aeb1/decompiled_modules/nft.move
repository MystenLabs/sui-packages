module 0x38b953abed85779f3ac38d4cd601db5ea38ba1247a7e3823f148d35b022aeb1::nft {
    struct ResurrectNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun transfer(arg0: ResurrectNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<ResurrectNFT>(arg0, arg1);
    }

    public fun url(arg0: &ResurrectNFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: ResurrectNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let ResurrectNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &ResurrectNFT) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"The first-ever NFT for early believers. Proof of loyalty and dedication. Unlocks access to exclusive perks and future benefits."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://resurrect.fun"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://resurrect.fun"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Resurrect"));
        let v5 = 0x2::display::new_with_fields<ResurrectNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<ResurrectNFT>(&mut v5);
        let v6 = MintCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<MintCap>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<ResurrectNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &MintCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : ResurrectNFT {
        let v0 = ResurrectNFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            url         : 0x2::url::new_unsafe_from_bytes(arg3),
        };
        let v1 = NFTMinted{
            object_id : 0x2::object::id<ResurrectNFT>(&v0),
            creator   : 0x2::tx_context::sender(arg4),
            name      : v0.name,
        };
        0x2::event::emit<NFTMinted>(v1);
        v0
    }

    public entry fun mint_to_sender(arg0: &MintCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<ResurrectNFT>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun name(arg0: &ResurrectNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut ResurrectNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

