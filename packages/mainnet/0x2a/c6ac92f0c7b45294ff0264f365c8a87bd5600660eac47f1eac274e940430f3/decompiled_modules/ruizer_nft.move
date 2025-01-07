module 0x2ac6ac92f0c7b45294ff0264f365c8a87bd5600660eac47f1eac274e940430f3::ruizer_nft {
    struct RuizerNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        avatar_url: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun transfer(arg0: RuizerNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<RuizerNFT>(arg0, arg1);
    }

    public fun url(arg0: &RuizerNFT) : &0x2::url::Url {
        &arg0.avatar_url
    }

    public fun burn(arg0: RuizerNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let RuizerNFT {
            id          : v0,
            name        : _,
            description : _,
            avatar_url  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &RuizerNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = RuizerNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            avatar_url  : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<RuizerNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<RuizerNFT>(v1, v0);
    }

    public fun name(arg0: &RuizerNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun update_description(arg0: &mut RuizerNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

