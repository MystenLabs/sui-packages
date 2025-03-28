module 0x92a48cefde66e3fb54f020b7d4802030a4f3361b1d95ba77e26c883e041014ce::my_nft {
    struct MyNFT has store, key {
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

    public fun transfer(arg0: MyNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<MyNFT>(arg0, arg1);
    }

    public fun url(arg0: &MyNFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun burn(arg0: MyNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let MyNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &MyNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = MyNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(b"muet NFT"),
            description : 0x1::string::utf8(b"This my first NFT!"),
            url         : 0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/195670331?v=4"),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<MyNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<MyNFT>(v1, v0);
    }

    public fun name(arg0: &MyNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun update_description(arg0: &mut MyNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

