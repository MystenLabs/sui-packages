module 0x41aec5278d2f735dbb27c9cbb828c4f5acb3a30bb266a81ecfb5853c0cd38d03::nft_with_display {
    struct MarketplaceNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        creator: address,
        attributes: vector<Attribute>,
    }

    struct Attribute has copy, drop, store {
        trait_type: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct NFT_WITH_DISPLAY has drop {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun attributes(arg0: &MarketplaceNFT) : &vector<Attribute> {
        &arg0.attributes
    }

    public fun burn(arg0: MarketplaceNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let MarketplaceNFT {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            creator     : _,
            attributes  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun create_attribute(arg0: vector<u8>, arg1: vector<u8>) : Attribute {
        Attribute{
            trait_type : 0x1::string::utf8(arg0),
            value      : 0x1::string::utf8(arg1),
        }
    }

    public fun creator(arg0: &MarketplaceNFT) : address {
        arg0.creator
    }

    public fun description(arg0: &MarketplaceNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &MarketplaceNFT) : &0x1::string::String {
        &arg0.image_url
    }

    fun init(arg0: NFT_WITH_DISPLAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://your-nft-marketplace.replit.app"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://your-nft-marketplace.replit.app/nft/{id}"));
        let v4 = 0x2::package::claim<NFT_WITH_DISPLAY>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<MarketplaceNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<MarketplaceNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MarketplaceNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint_nft(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<Attribute>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketplaceNFT{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x1::string::utf8(arg2),
            creator     : 0x2::tx_context::sender(arg5),
            attributes  : arg3,
        };
        let v1 = NFTMinted{
            object_id : 0x2::object::id<MarketplaceNFT>(&v0),
            creator   : 0x2::tx_context::sender(arg5),
            name      : v0.name,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::public_transfer<MarketplaceNFT>(v0, arg4);
    }

    public fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<Attribute>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        mint_nft(arg0, arg1, arg2, arg3, v0, arg4);
    }

    public fun name(arg0: &MarketplaceNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun transfer_nft(arg0: MarketplaceNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<MarketplaceNFT>(arg0, arg1);
    }

    public fun update_description(arg0: &mut MarketplaceNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

