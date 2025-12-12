module 0x723ea839c19c5b7634b60156821be7a871a1018d4af6dcc3aae78b0e7a1c2aa0::walrus_nft {
    struct WalrusNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
    }

    struct WALRUS_NFT has drop {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        name: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
        minter: address,
    }

    public entry fun burn(arg0: WalrusNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let WalrusNFT {
            id             : v0,
            name           : _,
            description    : _,
            walrus_blob_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &WalrusNFT) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: WALRUS_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"walrus_blob_id"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://aggregator.walrus.space/v1/{walrus_blob_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{walrus_blob_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://easynftnow.xyz"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Easy NFT Now"));
        let v4 = 0x2::package::claim<WALRUS_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<WalrusNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<WalrusNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<WalrusNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = WalrusNFT{
            id             : 0x2::object::new(arg3),
            name           : arg0,
            description    : arg1,
            walrus_blob_id : arg2,
        };
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = NFTMinted{
            nft_id         : 0x2::object::id<WalrusNFT>(&v0),
            name           : v0.name,
            walrus_blob_id : v0.walrus_blob_id,
            minter         : v1,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<WalrusNFT>(v0, v1);
    }

    public fun name(arg0: &WalrusNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update(arg0: &mut WalrusNFT, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        arg0.name = arg1;
        arg0.description = arg2;
        arg0.walrus_blob_id = arg3;
    }

    public fun walrus_blob_id(arg0: &WalrusNFT) : &0x1::string::String {
        &arg0.walrus_blob_id
    }

    // decompiled from Move bytecode v6
}

