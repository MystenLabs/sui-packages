module 0xa66ef08a48c3a5d7ef700e293b5ae3da33686b2c6c4a27b6190ab9ac5c8c8da7::game_assets {
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

    public fun mint_to_owner(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = GameAssetsNFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v1 = NFTMinted{
            object_id : 0x2::object::id<GameAssetsNFT>(&v0),
            creator   : arg3,
            name      : v0.name,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::public_transfer<GameAssetsNFT>(v0, arg3);
    }

    public fun name(arg0: &GameAssetsNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun update_description(arg0: &mut GameAssetsNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

