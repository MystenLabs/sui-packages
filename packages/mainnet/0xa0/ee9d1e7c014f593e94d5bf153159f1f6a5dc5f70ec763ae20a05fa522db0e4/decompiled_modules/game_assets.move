module 0xa0ee9d1e7c014f593e94d5bf153159f1f6a5dc5f70ec763ae20a05fa522db0e4::game_assets {
    struct GameAssetsNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun transfer(arg0: GameAssetsNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<GameAssetsNFT>(arg0, arg1);
    }

    public fun url(arg0: &GameAssetsNFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun burn(arg0: GameAssetsNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let GameAssetsNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &GameAssetsNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = GameAssetsNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<GameAssetsNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<GameAssetsNFT>(v1, v0);
    }

    public fun name(arg0: &GameAssetsNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun update_description(arg0: &mut GameAssetsNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

