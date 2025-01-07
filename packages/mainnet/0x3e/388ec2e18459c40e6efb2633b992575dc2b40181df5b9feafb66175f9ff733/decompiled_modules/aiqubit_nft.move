module 0x3e388ec2e18459c40e6efb2633b992575dc2b40181df5b9feafb66175f9ff733::aiqubit_nft {
    struct AiqubitNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct AiqubitNFTMintEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct AiqubitNFTTransferEvent has copy, drop {
        object_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct AiqubitNFTBurnEvent has copy, drop {
        object_id: 0x2::object::ID,
    }

    public fun url(arg0: &AiqubitNFT) : 0x2::url::Url {
        arg0.url
    }

    public entry fun burn(arg0: AiqubitNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let AiqubitNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        let v4 = v0;
        let v5 = AiqubitNFTBurnEvent{object_id: 0x2::object::uid_to_inner(&v4)};
        0x2::event::emit<AiqubitNFTBurnEvent>(v5);
        0x2::object::delete(v4);
    }

    public fun description(arg0: &AiqubitNFT) : 0x1::string::String {
        arg0.description
    }

    public entry fun mint_nft(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = AiqubitNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = AiqubitNFTMintEvent{
            object_id : 0x2::object::id<AiqubitNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<AiqubitNFTMintEvent>(v2);
        0x2::transfer::public_transfer<AiqubitNFT>(v1, v0);
    }

    public fun name(arg0: &AiqubitNFT) : 0x1::string::String {
        arg0.name
    }

    public entry fun transfer_nft(arg0: AiqubitNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AiqubitNFTTransferEvent{
            object_id : 0x2::object::id<AiqubitNFT>(&arg0),
            from      : 0x2::tx_context::sender(arg2),
            to        : arg1,
        };
        0x2::event::emit<AiqubitNFTTransferEvent>(v0);
        0x2::transfer::public_transfer<AiqubitNFT>(arg0, arg1);
    }

    public entry fun update_description(arg0: &mut AiqubitNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

