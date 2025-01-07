module 0x2fd04200daa26953880bea43e140694fe02c030f9a44bc2f97b50ca3dde6ee8f::hstar_nft {
    struct HstarNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFTMintedEvent has copy, drop {
        object_id: 0x2::object::ID,
        recipient: address,
        name: 0x1::string::String,
    }

    struct NFTTransferEvent has copy, drop {
        object_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    public fun transfer(arg0: HstarNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTTransferEvent{
            object_id : 0x2::object::id<HstarNFT>(&arg0),
            from      : 0x2::tx_context::sender(arg2),
            to        : arg1,
        };
        0x2::event::emit<NFTTransferEvent>(v0);
        0x2::transfer::public_transfer<HstarNFT>(arg0, arg1);
    }

    public entry fun burn(arg0: HstarNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let HstarNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = HstarNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = NFTMintedEvent{
            object_id : 0x2::object::id<HstarNFT>(&v1),
            recipient : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMintedEvent>(v2);
        0x2::transfer::public_transfer<HstarNFT>(v1, v0);
    }

    public entry fun update_desc(arg0: &mut HstarNFT, arg1: vector<u8>) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

