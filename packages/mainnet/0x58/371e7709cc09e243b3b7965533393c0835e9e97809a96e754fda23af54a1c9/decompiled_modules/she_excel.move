module 0x58371e7709cc09e243b3b7965533393c0835e9e97809a96e754fda23af54a1c9::she_excel {
    struct SheExcelsNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        event_date: 0x1::string::String,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        recipient: address,
        event_name: 0x1::string::String,
    }

    fun create_ipfs_url(arg0: vector<u8>) : 0x2::url::Url {
        let v0 = 0x1::string::utf8(b"https://ipfs.io/ipfs/");
        0x1::string::append(&mut v0, 0x1::string::utf8(arg0));
        0x2::url::new_unsafe_from_bytes(*0x1::string::as_bytes(&v0))
    }

    public fun description(arg0: &SheExcelsNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun event_date(arg0: &SheExcelsNFT) : &0x1::string::String {
        &arg0.event_date
    }

    public fun image_url(arg0: &SheExcelsNFT) : &0x2::url::Url {
        &arg0.image_url
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint_nft(arg0: &AdminCap, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = SheExcelsNFT{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg2),
            description : 0x1::string::utf8(arg3),
            image_url   : create_ipfs_url(b"bafybeihigtndth4zrl3hakmnvy23s6ahxb4hg237fzp7j7e73kw7sokare"),
            event_date  : 0x1::string::utf8(arg4),
        };
        let v1 = NFTMinted{
            nft_id     : 0x2::object::id<SheExcelsNFT>(&v0),
            recipient  : arg1,
            event_name : v0.name,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::transfer<SheExcelsNFT>(v0, arg1);
    }

    public fun name(arg0: &SheExcelsNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun self_mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = SheExcelsNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : create_ipfs_url(b"bafybeihigtndth4zrl3hakmnvy23s6ahxb4hg237fzp7j7e73kw7sokare"),
            event_date  : 0x1::string::utf8(arg2),
        };
        let v2 = NFTMinted{
            nft_id     : 0x2::object::id<SheExcelsNFT>(&v1),
            recipient  : v0,
            event_name : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::transfer<SheExcelsNFT>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

