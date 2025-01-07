module 0xd1eb99a093889888b6d935cc7b7e08f965c8c715ba0a55a6150962c1c74f8c78::sui_name_service_presale {
    struct SuiNameServicePresaleNFT has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        title: 0x1::string::String,
    }

    public fun description(arg0: &SuiNameServicePresaleNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &SuiNameServicePresaleNFT) : &0x2::url::Url {
        &arg0.image_url
    }

    public entry fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SuiNameServicePresaleNFT{
            id          : 0x2::object::new(arg0),
            title       : 0x1::string::utf8(b"Sui Name Service Presale"),
            description : 0x1::string::utf8(b"This NFT represents your spot in the upcoming Sui Name Service Presale"),
            image_url   : 0x2::url::new_unsafe_from_bytes(b"https://example.com/sui-name-service-presale.gif"),
        };
        let v1 = 0x2::tx_context::sender(arg0);
        let v2 = NFTMinted{
            object_id : 0x2::object::uid_to_inner(&v0.id),
            creator   : v1,
            title     : v0.title,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::transfer<SuiNameServicePresaleNFT>(v0, v1);
    }

    public fun title(arg0: &SuiNameServicePresaleNFT) : &0x1::string::String {
        &arg0.title
    }

    // decompiled from Move bytecode v6
}

