module 0x4a58713ecf8ca4652267adf82311c4f15cc1fa51f38cfaf88fa76c075dff9817::pomerene {
    struct PomeNFT has store, key {
        id: 0x2::object::UID,
        url: 0x2::url::Url,
        scannerAddress: address,
        itemAddress: address,
        message: 0x1::string::String,
        combinedSignature: 0x1::string::String,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        scannerAddress: address,
        itemAddress: address,
        message: 0x1::string::String,
        combinedSignature: 0x1::string::String,
    }

    struct ItemNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        itemAddress: address,
        qr: 0x1::string::String,
        blob_id: 0x1::string::String,
    }

    public fun transfer(arg0: PomeNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<PomeNFT>(arg0, arg1);
    }

    public fun burn(arg0: PomeNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let PomeNFT {
            id                : v0,
            url               : _,
            scannerAddress    : _,
            itemAddress       : _,
            message           : _,
            combinedSignature : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun scan(arg0: vector<u8>, arg1: address, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = PomeNFT{
            id                : 0x2::object::new(arg5),
            url               : 0x2::url::new_unsafe_from_bytes(arg0),
            scannerAddress    : arg1,
            itemAddress       : arg2,
            message           : 0x1::string::utf8(arg3),
            combinedSignature : 0x1::string::utf8(arg4),
        };
        let v1 = NFTMinted{
            object_id         : 0x2::object::id<PomeNFT>(&v0),
            creator           : arg1,
            scannerAddress    : v0.scannerAddress,
            itemAddress       : v0.itemAddress,
            message           : v0.message,
            combinedSignature : v0.combinedSignature,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::public_transfer<PomeNFT>(v0, arg1);
        let v2 = PomeNFT{
            id                : 0x2::object::new(arg5),
            url               : 0x2::url::new_unsafe_from_bytes(arg0),
            scannerAddress    : arg1,
            itemAddress       : arg2,
            message           : 0x1::string::utf8(arg3),
            combinedSignature : 0x1::string::utf8(arg4),
        };
        let v3 = NFTMinted{
            object_id         : 0x2::object::id<PomeNFT>(&v2),
            creator           : arg2,
            scannerAddress    : v2.scannerAddress,
            itemAddress       : v2.itemAddress,
            message           : v2.message,
            combinedSignature : v2.combinedSignature,
        };
        0x2::event::emit<NFTMinted>(v3);
        0x2::transfer::public_transfer<PomeNFT>(v2, arg2);
        let v4 = 0x2::tx_context::sender(arg5);
        let v5 = PomeNFT{
            id                : 0x2::object::new(arg5),
            url               : 0x2::url::new_unsafe_from_bytes(arg0),
            scannerAddress    : arg1,
            itemAddress       : arg2,
            message           : 0x1::string::utf8(arg3),
            combinedSignature : 0x1::string::utf8(arg4),
        };
        let v6 = NFTMinted{
            object_id         : 0x2::object::id<PomeNFT>(&v5),
            creator           : v4,
            scannerAddress    : v5.scannerAddress,
            itemAddress       : v5.itemAddress,
            message           : v5.message,
            combinedSignature : v5.combinedSignature,
        };
        0x2::event::emit<NFTMinted>(v6);
        0x2::transfer::public_transfer<PomeNFT>(v5, v4);
    }

    // decompiled from Move bytecode v6
}

