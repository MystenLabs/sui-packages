module 0x932b9a232361cd7c3aa79b92a97d39aa7e9dbebee22e154c8e1cd64f20745782::zq_nft {
    struct ZqNFT has store, key {
        id: 0x2::object::UID,
        token: address,
        amount: u64,
        url: 0x2::url::Url,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
    }

    public entry fun mint(arg0: address, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ZqNFT{
            id     : 0x2::object::new(arg3),
            token  : arg0,
            amount : arg1,
            url    : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v0.id),
            creator   : v1,
        };
        0x2::event::emit<MintNFTEvent>(v2);
        0x2::transfer::public_transfer<ZqNFT>(v0, v1);
    }

    // decompiled from Move bytecode v6
}

