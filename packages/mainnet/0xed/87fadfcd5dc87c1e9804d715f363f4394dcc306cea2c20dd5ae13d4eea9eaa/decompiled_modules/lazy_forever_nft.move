module 0xed87fadfcd5dc87c1e9804d715f363f4394dcc306cea2c20dd5ae13d4eea9eaa::lazy_forever_nft {
    struct LazyforeverNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct LazyforeverNftMintEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct LazyforeverNftTransferEvent has copy, drop {
        object_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct LazyforeverNftBurnEvent has copy, drop {
        object_id: 0x2::object::ID,
    }

    public fun url(arg0: &LazyforeverNFT) : 0x2::url::Url {
        arg0.url
    }

    public entry fun burn(arg0: LazyforeverNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let LazyforeverNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        let v4 = v0;
        let v5 = LazyforeverNftBurnEvent{object_id: 0x2::object::uid_to_inner(&v4)};
        0x2::event::emit<LazyforeverNftBurnEvent>(v5);
        0x2::object::delete(v4);
    }

    public fun description(arg0: &LazyforeverNFT) : 0x1::string::String {
        arg0.description
    }

    public entry fun mint_nft(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = LazyforeverNFT{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"lazy_forever"),
            description : 0x1::string::utf8(b"lazy_forever's NFT"),
            url         : 0x2::url::new_unsafe_from_bytes(b"https://blog.lazyforever.top/img/favicon.png"),
        };
        let v1 = LazyforeverNftMintEvent{
            object_id : 0x2::object::id<LazyforeverNFT>(&v0),
            creator   : 0x2::tx_context::sender(arg1),
            name      : v0.name,
        };
        0x2::event::emit<LazyforeverNftMintEvent>(v1);
        0x2::transfer::public_transfer<LazyforeverNFT>(v0, arg0);
    }

    public fun name(arg0: &LazyforeverNFT) : 0x1::string::String {
        arg0.name
    }

    public entry fun transfer_nft(arg0: LazyforeverNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = LazyforeverNftTransferEvent{
            object_id : 0x2::object::id<LazyforeverNFT>(&arg0),
            from      : 0x2::tx_context::sender(arg2),
            to        : arg1,
        };
        0x2::event::emit<LazyforeverNftTransferEvent>(v0);
        0x2::transfer::public_transfer<LazyforeverNFT>(arg0, arg1);
    }

    public entry fun update_description(arg0: &mut LazyforeverNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

