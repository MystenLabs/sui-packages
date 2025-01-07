module 0x77fc613f1455b52a3b8afa81da26156b3bb56d69e4b72b542ecc2f655cf93c62::nft {
    struct NFT has store, key {
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

    public fun description(arg0: &NFT) : &0x1::string::String {
        &arg0.description
    }

    public fun mint_to_sender<T0>(arg0: &mut vector<0x77fc613f1455b52a3b8afa81da26156b3bb56d69e4b72b542ecc2f655cf93c62::locker::Locker<T0>>) {
        let v0 = 2500;
        assert!(0x77fc613f1455b52a3b8afa81da26156b3bb56d69e4b72b542ecc2f655cf93c62::locker::get_scores<T0>(arg0) >= v0, 0);
        0x77fc613f1455b52a3b8afa81da26156b3bb56d69e4b72b542ecc2f655cf93c62::locker::consume_score<T0>(arg0, v0);
    }

    public fun name(arg0: &NFT) : &0x1::string::String {
        &arg0.name
    }

    public fun update_description(arg0: &mut NFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

