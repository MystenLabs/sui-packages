module 0x4a58713ecf8ca4652267adf82311c4f15cc1fa51f38cfaf88fa76c075dff9817::scanner {
    struct ScannerNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        scannerAddress: address,
        secret: 0x1::string::String,
        blob_id: 0x1::string::String,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        scannerAddress: address,
        secret: 0x1::string::String,
        blob_id: 0x1::string::String,
    }

    public fun burn(arg0: ScannerNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let ScannerNFT {
            id             : v0,
            name           : _,
            description    : _,
            url            : _,
            scannerAddress : _,
            secret         : _,
            blob_id        : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = ScannerNFT{
            id             : 0x2::object::new(arg6),
            name           : 0x1::string::utf8(arg0),
            description    : 0x1::string::utf8(arg1),
            url            : 0x2::url::new_unsafe_from_bytes(arg2),
            scannerAddress : arg3,
            secret         : 0x1::string::utf8(arg4),
            blob_id        : 0x1::string::utf8(arg5),
        };
        let v2 = NFTMinted{
            object_id      : 0x2::object::id<ScannerNFT>(&v1),
            creator        : v0,
            name           : v1.name,
            scannerAddress : v1.scannerAddress,
            secret         : v1.secret,
            blob_id        : v1.blob_id,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<ScannerNFT>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

