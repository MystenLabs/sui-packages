module 0xeefdabea2776d6d9cfd7b2e65aeabafcc9de68c515972b8ad9e4e864c7c3c783::sui_nft {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        minted_by: address,
    }

    public entry fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg2);
        let v1 = NFTMinted{
            nft_id    : 0x2::object::uid_to_inner(&v0),
            minted_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<NFTMinted>(v1);
        let v2 = NFT{
            id   : v0,
            name : arg0,
            url  : arg1,
        };
        0x2::transfer::public_transfer<NFT>(v2, 0x2::tx_context::sender(arg2));
    }

    public fun name(arg0: &NFT) : 0x1::string::String {
        arg0.name
    }

    public entry fun transfer_nft(arg0: NFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<NFT>(arg0, arg1);
    }

    public fun url(arg0: &NFT) : 0x1::string::String {
        arg0.url
    }

    // decompiled from Move bytecode v6
}

