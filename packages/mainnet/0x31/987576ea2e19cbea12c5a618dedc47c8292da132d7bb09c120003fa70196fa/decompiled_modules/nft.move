module 0x31987576ea2e19cbea12c5a618dedc47c8292da132d7bb09c120003fa70196fa::nft {
    struct GiftdropNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        creator: address,
        receiver: address,
        created_at: u64,
    }

    struct GiftdropSoulboundNft has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        creator: address,
        receiver: address,
        created_at: u64,
    }

    struct MintNftEvent has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        created_at: u64,
        creator: address,
        receiver: address,
        minter: address,
    }

    struct MintSoulboundNftEvent has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        created_at: u64,
        creator: address,
        receiver: address,
        minter: address,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://giftdrop.io/nft/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://giftdrop.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v5);
        0x2::transfer::public_transfer<0x2::display::Display<GiftdropNft>>(0x2::display::new_with_fields<GiftdropNft>(&v4, v0, v2, arg1), v5);
        0x2::transfer::public_transfer<0x2::display::Display<GiftdropSoulboundNft>>(0x2::display::new_with_fields<GiftdropSoulboundNft>(&v4, v0, v2, arg1), v5);
    }

    public fun mint_nft(arg0: &0x31987576ea2e19cbea12c5a618dedc47c8292da132d7bb09c120003fa70196fa::manager::Manager, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x31987576ea2e19cbea12c5a618dedc47c8292da132d7bb09c120003fa70196fa::manager::assert_is_manager(arg0, 0x2::tx_context::sender(arg7));
        let v0 = GiftdropNft{
            id          : 0x2::object::new(arg7),
            name        : arg1,
            description : arg2,
            image_url   : arg3,
            creator     : arg4,
            receiver    : arg5,
            created_at  : 0x2::clock::timestamp_ms(arg6),
        };
        let v1 = MintNftEvent{
            id          : 0x2::object::id<GiftdropNft>(&v0),
            name        : arg1,
            description : arg2,
            image_url   : arg3,
            created_at  : 0x2::clock::timestamp_ms(arg6),
            creator     : arg4,
            receiver    : arg5,
            minter      : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<MintNftEvent>(v1);
        0x2::transfer::public_transfer<GiftdropNft>(v0, arg5);
    }

    public fun mint_soulbound_nft(arg0: &0x31987576ea2e19cbea12c5a618dedc47c8292da132d7bb09c120003fa70196fa::manager::Manager, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x31987576ea2e19cbea12c5a618dedc47c8292da132d7bb09c120003fa70196fa::manager::assert_is_manager(arg0, 0x2::tx_context::sender(arg7));
        let v0 = GiftdropSoulboundNft{
            id          : 0x2::object::new(arg7),
            name        : arg1,
            description : arg2,
            image_url   : arg3,
            creator     : arg4,
            receiver    : arg5,
            created_at  : 0x2::clock::timestamp_ms(arg6),
        };
        let v1 = MintSoulboundNftEvent{
            id          : 0x2::object::id<GiftdropSoulboundNft>(&v0),
            name        : arg1,
            description : arg2,
            image_url   : arg3,
            created_at  : 0x2::clock::timestamp_ms(arg6),
            creator     : arg4,
            receiver    : arg5,
            minter      : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<MintSoulboundNftEvent>(v1);
        0x2::transfer::transfer<GiftdropSoulboundNft>(v0, arg5);
    }

    // decompiled from Move bytecode v6
}

