module 0x2c6bda444ed347f4fe7cc42421a209974b07bb5591da363e61cc05eb3d3c4b33::nft_imdia {
    struct ImdiaNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct ImdiaNFTTransferEvent has copy, drop {
        object_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct ImdiaNFTMintEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct ImdiaNFTBurnEvent has copy, drop {
        object_id: 0x2::object::ID,
    }

    public fun url(arg0: &ImdiaNFT) : 0x2::url::Url {
        arg0.url
    }

    public entry fun burn(arg0: ImdiaNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let ImdiaNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        let v4 = v0;
        let v5 = ImdiaNFTBurnEvent{object_id: 0x2::object::uid_to_inner(&v4)};
        0x2::event::emit<ImdiaNFTBurnEvent>(v5);
        0x2::object::delete(v4);
    }

    public fun description(arg0: &ImdiaNFT) : 0x1::string::String {
        arg0.description
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = ImdiaNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = ImdiaNFTMintEvent{
            object_id : 0x2::object::id<ImdiaNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<ImdiaNFTMintEvent>(v2);
        0x2::transfer::public_transfer<ImdiaNFT>(v1, v0);
    }

    public fun name(arg0: &ImdiaNFT) : 0x1::string::String {
        arg0.name
    }

    public entry fun transfer_nft(arg0: ImdiaNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ImdiaNFTTransferEvent{
            object_id : 0x2::object::id<ImdiaNFT>(&arg0),
            from      : 0x2::tx_context::sender(arg2),
            to        : arg1,
        };
        0x2::event::emit<ImdiaNFTTransferEvent>(v0);
        0x2::transfer::public_transfer<ImdiaNFT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

