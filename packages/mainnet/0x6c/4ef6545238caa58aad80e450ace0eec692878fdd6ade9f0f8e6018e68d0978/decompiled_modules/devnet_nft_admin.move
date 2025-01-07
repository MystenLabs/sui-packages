module 0x6c4ef6545238caa58aad80e450ace0eec692878fdd6ade9f0f8e6018e68d0978::devnet_nft_admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct DevNetNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: &AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = DevNetNFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg3),
        };
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v0.id),
            creator   : v1,
            name      : v0.name,
        };
        0x2::event::emit<MintNFTEvent>(v2);
        0x2::transfer::public_transfer<DevNetNFT>(v0, v1);
    }

    // decompiled from Move bytecode v6
}

