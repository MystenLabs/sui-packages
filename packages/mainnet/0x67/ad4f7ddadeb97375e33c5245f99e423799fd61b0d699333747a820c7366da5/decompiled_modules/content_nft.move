module 0xad720678bb54777a2c21b4adb367167f717d10ed4533ceec97ad52d0f74218de::content_nft {
    struct EncryptedContentNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
        seal_encryption_id: 0x1::string::String,
        content_size: u64,
        created_at: u64,
        owner: address,
    }

    struct NFTMintedEvent has copy, drop {
        nft_id: 0x2::object::ID,
        name: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
        seal_encryption_id: 0x1::string::String,
        owner: address,
        created_at: u64,
    }

    struct NFTTransferredEvent has copy, drop {
        nft_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    public fun content_size(arg0: &EncryptedContentNFT) : u64 {
        arg0.content_size
    }

    public fun created_at(arg0: &EncryptedContentNFT) : u64 {
        arg0.created_at
    }

    public fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : EncryptedContentNFT {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = EncryptedContentNFT{
            id                 : 0x2::object::new(arg5),
            name               : arg0,
            walrus_blob_id     : arg1,
            seal_encryption_id : arg2,
            content_size       : arg3,
            created_at         : 0x2::clock::timestamp_ms(arg4),
            owner              : v0,
        };
        let v2 = NFTMintedEvent{
            nft_id             : 0x2::object::id<EncryptedContentNFT>(&v1),
            name               : arg0,
            walrus_blob_id     : arg1,
            seal_encryption_id : arg2,
            owner              : v0,
            created_at         : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<NFTMintedEvent>(v2);
        v1
    }

    public fun name(arg0: &EncryptedContentNFT) : 0x1::string::String {
        arg0.name
    }

    public fun owner(arg0: &EncryptedContentNFT) : address {
        arg0.owner
    }

    public fun seal_approve(arg0: vector<u8>, arg1: &0x2::tx_context::TxContext) : bool {
        0x2::tx_context::sender(arg1);
        true
    }

    public fun seal_encryption_id(arg0: &EncryptedContentNFT) : 0x1::string::String {
        arg0.seal_encryption_id
    }

    public fun transfer_nft(arg0: EncryptedContentNFT, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = NFTTransferredEvent{
            nft_id : 0x2::object::id<EncryptedContentNFT>(&arg0),
            from   : 0x2::tx_context::sender(arg2),
            to     : arg1,
        };
        0x2::event::emit<NFTTransferredEvent>(v0);
        0x2::transfer::public_transfer<EncryptedContentNFT>(arg0, arg1);
    }

    public fun walrus_blob_id(arg0: &EncryptedContentNFT) : 0x1::string::String {
        arg0.walrus_blob_id
    }

    // decompiled from Move bytecode v6
}

