module 0xca69eacbdd83eb4a56cd2239cf9c46735b94f0b3eeaa390be4aca223dee83493::nft {
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

    public fun mint_to_sender<T0>(arg0: &mut vector<0xca69eacbdd83eb4a56cd2239cf9c46735b94f0b3eeaa390be4aca223dee83493::locker::Locker<T0>>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg1);
        let v0 = 2500;
        assert!(0xca69eacbdd83eb4a56cd2239cf9c46735b94f0b3eeaa390be4aca223dee83493::locker::get_scores<T0>(arg0) >= v0, 0);
        0xca69eacbdd83eb4a56cd2239cf9c46735b94f0b3eeaa390be4aca223dee83493::locker::consume_score<T0>(arg0, v0);
    }

    public fun name(arg0: &NFT) : &0x1::string::String {
        &arg0.name
    }

    public fun update_description(arg0: &mut NFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

