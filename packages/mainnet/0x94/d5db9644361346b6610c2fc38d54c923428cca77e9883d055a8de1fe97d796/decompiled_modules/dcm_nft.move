module 0x94d5db9644361346b6610c2fc38d54c923428cca77e9883d055a8de1fe97d796::dcm_nft {
    struct DcmNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct DcmNFTMintEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct DcmNFTTransferEvent has copy, drop {
        object_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct DcmNFTBurnEvent has copy, drop {
        object_id: 0x2::object::ID,
    }

    public fun url(arg0: &DcmNFT) : 0x2::url::Url {
        arg0.url
    }

    public entry fun burn(arg0: DcmNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let DcmNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        let v4 = v0;
        let v5 = DcmNFTBurnEvent{object_id: 0x2::object::uid_to_inner(&v4)};
        0x2::event::emit<DcmNFTBurnEvent>(v5);
        0x2::object::delete(v4);
    }

    public fun description(arg0: &DcmNFT) : 0x1::string::String {
        arg0.description
    }

    public entry fun mint_nft(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = DcmNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = DcmNFTMintEvent{
            object_id : 0x2::object::id<DcmNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<DcmNFTMintEvent>(v2);
        0x2::transfer::public_transfer<DcmNFT>(v1, v0);
    }

    public fun name(arg0: &DcmNFT) : 0x1::string::String {
        arg0.name
    }

    public entry fun transfer_nft(arg0: DcmNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = DcmNFTTransferEvent{
            object_id : 0x2::object::id<DcmNFT>(&arg0),
            from      : 0x2::tx_context::sender(arg2),
            to        : arg1,
        };
        0x2::event::emit<DcmNFTTransferEvent>(v0);
        0x2::transfer::public_transfer<DcmNFT>(arg0, arg1);
    }

    public entry fun update_description(arg0: &mut DcmNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

