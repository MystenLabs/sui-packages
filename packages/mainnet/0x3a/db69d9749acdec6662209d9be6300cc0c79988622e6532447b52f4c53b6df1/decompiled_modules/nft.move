module 0x3adb69d9749acdec6662209d9be6300cc0c79988622e6532447b52f4c53b6df1::nft {
    struct NFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x2::url::Url,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id   : 0x2::object::new(arg0),
            name : 0x1::string::utf8(b"sahab NFT"),
            url  : 0x2::url::new_unsafe(0x1::ascii::string(b"https://avatars.githubusercontent.com/u/162699534")),
        };
        0x2::transfer::transfer<NFT>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint_to(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id   : 0x2::object::new(arg1),
            name : 0x1::string::utf8(b"sahab NFT"),
            url  : 0x2::url::new_unsafe(0x1::ascii::string(b"https://avatars.githubusercontent.com/u/162699534")),
        };
        0x2::transfer::transfer<NFT>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

