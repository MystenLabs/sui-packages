module 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::nft {
    struct ArticleAccessNft has store, key {
        id: 0x2::object::UID,
        article_id: 0x2::object::ID,
        minted_at: u64,
        title: 0x1::string::String,
        author: address,
    }

    struct MintKey has copy, drop, store {
        article_id: 0x2::object::ID,
        recipient: address,
    }

    struct MintRegistry has key {
        id: 0x2::object::UID,
        minted: 0x2::table::Table<MintKey, bool>,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"external_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Article Access: {title}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Permanent access NFT for gated article: {title}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://inkray.xyz/api/nft/{id}/image"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://inkray.xyz/article/{article_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{author}"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<ArticleAccessNft>(&v4, v0, v2, arg1);
        0x2::display::update_version<ArticleAccessNft>(&mut v5);
        let v6 = MintRegistry{
            id     : 0x2::object::new(arg1),
            minted : 0x2::table::new<MintKey, bool>(arg1),
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::display::Display<ArticleAccessNft>>(v5);
        0x2::transfer::share_object<MintRegistry>(v6);
    }

    public fun mint(arg0: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::GlobalConfig, arg1: address, arg2: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::articles::Article, arg3: &0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::Publication, arg4: &mut MintRegistry, arg5: &mut 0x2::tx_context::TxContext) : ArticleAccessNft {
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config::assert_version(arg0);
        let v0 = 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::articles::get_article_id(arg2);
        assert!(0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::articles::publication_id(arg2) == 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::publication::get_publication_object_id(arg3), 501);
        let v1 = MintKey{
            article_id : v0,
            recipient  : arg1,
        };
        assert!(!0x2::table::contains<MintKey, bool>(&arg4.minted, v1), 502);
        0x2::table::add<MintKey, bool>(&mut arg4.minted, v1, true);
        let (v2, _, _, _, v6, _) = 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::articles::get_article_info(arg2);
        let v8 = 0x2::object::new(arg5);
        let v9 = ArticleAccessNft{
            id         : v8,
            article_id : v0,
            minted_at  : 0x2::tx_context::epoch_timestamp_ms(arg5),
            title      : v2,
            author     : v6,
        };
        0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::inkray_events::emit_article_nft_minted(v0, 0x2::object::uid_to_address(&v8), arg1);
        v9
    }

    // decompiled from Move bytecode v7
}

