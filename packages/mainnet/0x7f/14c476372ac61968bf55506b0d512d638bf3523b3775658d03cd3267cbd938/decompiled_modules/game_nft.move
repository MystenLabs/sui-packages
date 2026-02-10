module 0x7f14c476372ac61968bf55506b0d512d638bf3523b3775658d03cd3267cbd938::game_nft {
    struct GAME_NFT has drop {
        dummy_field: bool,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
    }

    struct BoomBoxGame has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        description: 0x1::string::String,
        genre: 0x1::string::String,
        engine_version: 0x1::string::String,
        walrus_site_object_id: 0x1::string::String,
        walrus_cart_blob_id: 0x1::string::String,
        thumbnail_blob_id: 0x1::string::String,
        game_id: 0x1::string::String,
        original_creator: address,
        minted_at: u64,
    }

    struct GameMinted has copy, drop {
        nft_id: 0x2::object::ID,
        game_id: 0x1::string::String,
        title: 0x1::string::String,
        original_creator: address,
    }

    fun init(arg0: GAME_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<GAME_NFT>(arg0, arg1);
        let v1 = 0x2::display::new<BoomBoxGame>(&v0, arg1);
        0x2::display::add<BoomBoxGame>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{title}"));
        0x2::display::add<BoomBoxGame>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<BoomBoxGame>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://aggregator.walrus.space/v1/blobs/{thumbnail_blob_id}"));
        0x2::display::add<BoomBoxGame>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://gamedev-pi.vercel.app/#/play/{game_id}"));
        0x2::display::add<BoomBoxGame>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Boom Arcade"));
        0x2::display::update_version<BoomBoxGame>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<BoomBoxGame>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<BoomBoxGame>>(v2);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<BoomBoxGame>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<BoomBoxGame>>(v1, 0x2::tx_context::sender(arg1));
        let v4 = MintCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<MintCap>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &MintCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: address, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : BoomBoxGame {
        let v0 = BoomBoxGame{
            id                    : 0x2::object::new(arg11),
            title                 : arg1,
            description           : arg2,
            genre                 : arg3,
            engine_version        : arg4,
            walrus_site_object_id : arg5,
            walrus_cart_blob_id   : arg6,
            thumbnail_blob_id     : arg7,
            game_id               : arg8,
            original_creator      : arg9,
            minted_at             : arg10,
        };
        let v1 = GameMinted{
            nft_id           : 0x2::object::id<BoomBoxGame>(&v0),
            game_id          : v0.game_id,
            title            : v0.title,
            original_creator : v0.original_creator,
        };
        0x2::event::emit<GameMinted>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

