module 0x3cc7625c27e774e35d81139400340f159ebd1bf35b99c616e5d9d97b73727689::wyzzheNft {
    struct WyzzheNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct WyzzheNftMintEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct WyzzheNftTransferEvent has copy, drop {
        object_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct WyzzheNftBurnEvent has copy, drop {
        object_id: 0x2::object::ID,
    }

    public fun url(arg0: &WyzzheNFT) : 0x2::url::Url {
        arg0.url
    }

    public entry fun burn(arg0: WyzzheNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let WyzzheNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        let v4 = v0;
        let v5 = WyzzheNftBurnEvent{object_id: 0x2::object::uid_to_inner(&v4)};
        0x2::event::emit<WyzzheNftBurnEvent>(v5);
        0x2::object::delete(v4);
    }

    public fun description(arg0: &WyzzheNFT) : 0x1::string::String {
        arg0.description
    }

    public entry fun mint_nft(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = WyzzheNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = WyzzheNftMintEvent{
            object_id : 0x2::object::id<WyzzheNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<WyzzheNftMintEvent>(v2);
        0x2::transfer::public_transfer<WyzzheNFT>(v1, v0);
    }

    public fun name(arg0: &WyzzheNFT) : 0x1::string::String {
        arg0.name
    }

    public entry fun transfer_nft(arg0: WyzzheNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = WyzzheNftTransferEvent{
            object_id : 0x2::object::id<WyzzheNFT>(&arg0),
            from      : 0x2::tx_context::sender(arg2),
            to        : arg1,
        };
        0x2::event::emit<WyzzheNftTransferEvent>(v0);
        0x2::transfer::public_transfer<WyzzheNFT>(arg0, arg1);
    }

    public entry fun update_description(arg0: &mut WyzzheNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

