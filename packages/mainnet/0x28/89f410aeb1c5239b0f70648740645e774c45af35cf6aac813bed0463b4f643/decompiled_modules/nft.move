module 0x2889f410aeb1c5239b0f70648740645e774c45af35cf6aac813bed0463b4f643::nft {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct PixelArtNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        width: u8,
        height: u8,
        pixel_data: vector<u8>,
        traits: 0x1::string::String,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct PixelArtNFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        width: u8,
        height: u8,
        traits: 0x1::string::String,
    }

    public fun transfer(arg0: NFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<NFT>(arg0, arg1);
    }

    public fun url(arg0: &NFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun burn(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let NFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun burn_pixel_art(arg0: PixelArtNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let PixelArtNFT {
            id          : v0,
            name        : _,
            description : _,
            width       : _,
            height      : _,
            pixel_data  : _,
            traits      : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &NFT) : &0x1::string::String {
        &arg0.description
    }

    public fun mint_pixel_art(arg0: vector<u8>, arg1: vector<u8>, arg2: u8, arg3: u8, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = PixelArtNFT{
            id          : 0x2::object::new(arg6),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            width       : arg2,
            height      : arg3,
            pixel_data  : arg4,
            traits      : 0x1::string::utf8(arg5),
        };
        let v2 = PixelArtNFTMinted{
            object_id : 0x2::object::id<PixelArtNFT>(&v1),
            creator   : v0,
            name      : v1.name,
            width     : arg2,
            height    : arg3,
            traits    : v1.traits,
        };
        0x2::event::emit<PixelArtNFTMinted>(v2);
        0x2::transfer::public_transfer<PixelArtNFT>(v1, v0);
    }

    public fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = NFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<NFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<NFT>(v1, v0);
    }

    public fun name(arg0: &NFT) : &0x1::string::String {
        &arg0.name
    }

    public fun pixel_art_data(arg0: &PixelArtNFT) : &vector<u8> {
        &arg0.pixel_data
    }

    public fun pixel_art_description(arg0: &PixelArtNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun pixel_art_height(arg0: &PixelArtNFT) : u8 {
        arg0.height
    }

    public fun pixel_art_name(arg0: &PixelArtNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun pixel_art_traits(arg0: &PixelArtNFT) : &0x1::string::String {
        &arg0.traits
    }

    public fun pixel_art_width(arg0: &PixelArtNFT) : u8 {
        arg0.width
    }

    public fun transfer_pixel_art(arg0: PixelArtNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<PixelArtNFT>(arg0, arg1);
    }

    public fun update_description(arg0: &mut NFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    public fun update_pixel_art_description(arg0: &mut PixelArtNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

