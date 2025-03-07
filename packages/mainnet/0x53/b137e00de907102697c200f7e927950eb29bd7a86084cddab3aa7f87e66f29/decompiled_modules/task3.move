module 0x53b137e00de907102697c200f7e927950eb29bd7a86084cddab3aa7f87e66f29::task3 {
    struct GitAvatarNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun url(arg0: &GitAvatarNFT) : &0x2::url::Url {
        &arg0.image_url
    }

    public fun burn(arg0: GitAvatarNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let GitAvatarNFT {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &GitAvatarNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = GitAvatarNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<GitAvatarNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<GitAvatarNFT>(v1, v0);
    }

    public fun name(arg0: &GitAvatarNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun transfer_nft(arg0: GitAvatarNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<GitAvatarNFT>(arg0, arg1);
    }

    public fun update_description(arg0: &mut GitAvatarNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

