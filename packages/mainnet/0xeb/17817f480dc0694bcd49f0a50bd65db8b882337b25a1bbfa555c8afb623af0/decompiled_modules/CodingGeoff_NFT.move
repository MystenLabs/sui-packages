module 0xeb17817f480dc0694bcd49f0a50bd65db8b882337b25a1bbfa555c8afb623af0::CodingGeoff_NFT {
    struct CODINGGEOFF_NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct Mint_NFT has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun mint_NFT(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CODINGGEOFF_NFT{
            id          : 0x2::object::new(arg0),
            name        : 0x1::string::utf8(b"CodingGeoff_NFT"),
            description : 0x1::string::utf8(b"CodingGeoff_NFT is awesome"),
            image_url   : 0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/120384385?v=4"),
        };
        let v1 = Mint_NFT{
            object_id : 0x2::object::id<CODINGGEOFF_NFT>(&v0),
            creator   : 0x2::tx_context::sender(arg0),
            name      : v0.name,
        };
        0x2::event::emit<Mint_NFT>(v1);
        0x2::transfer::public_transfer<CODINGGEOFF_NFT>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun transfer_NFT(arg0: CODINGGEOFF_NFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<CODINGGEOFF_NFT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

