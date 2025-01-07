module 0x15520f0e1d7b1890c97dbb77e57164da404850669cad6ff2e543039250a94edf::mynft {
    struct XU8117Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct XU8117NftMintEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct XU8117NftTransferEvent has copy, drop {
        object_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct XU8117NftBurnEvent has copy, drop {
        object_id: 0x2::object::ID,
    }

    public fun url(arg0: &XU8117Nft) : 0x2::url::Url {
        arg0.url
    }

    public entry fun burn(arg0: XU8117Nft, arg1: &mut 0x2::tx_context::TxContext) {
        let XU8117Nft {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        let v4 = v0;
        let v5 = XU8117NftBurnEvent{object_id: 0x2::object::uid_to_inner(&v4)};
        0x2::event::emit<XU8117NftBurnEvent>(v5);
        0x2::object::delete(v4);
    }

    public fun description(arg0: &XU8117Nft) : 0x1::string::String {
        arg0.description
    }

    public entry fun mint_nft(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = XU8117Nft{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = XU8117NftMintEvent{
            object_id : 0x2::object::id<XU8117Nft>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<XU8117NftMintEvent>(v2);
        0x2::transfer::public_transfer<XU8117Nft>(v1, v0);
    }

    public fun name(arg0: &XU8117Nft) : 0x1::string::String {
        arg0.name
    }

    public entry fun transfer_nft(arg0: XU8117Nft, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = XU8117NftTransferEvent{
            object_id : 0x2::object::id<XU8117Nft>(&arg0),
            from      : 0x2::tx_context::sender(arg2),
            to        : arg1,
        };
        0x2::event::emit<XU8117NftTransferEvent>(v0);
        0x2::transfer::public_transfer<XU8117Nft>(arg0, arg1);
    }

    public entry fun update_description(arg0: &mut XU8117Nft, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

