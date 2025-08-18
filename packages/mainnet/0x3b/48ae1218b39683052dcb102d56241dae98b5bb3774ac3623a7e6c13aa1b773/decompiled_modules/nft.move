module 0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::nft {
    struct ArticleAccessNft has store, key {
        id: 0x2::object::UID,
        article: address,
        title: 0x1::string::String,
        author: address,
        minted_at: u64,
    }

    struct MintConfig has store, key {
        id: 0x2::object::UID,
        base_price: u64,
        platform_fee_percent: u8,
        admin: address,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    public fun get_article_address(arg0: &ArticleAccessNft) : address {
        arg0.article
    }

    public fun get_mint_config(arg0: &MintConfig) : (u64, u8, address) {
        (arg0.base_price, arg0.platform_fee_percent, arg0.admin)
    }

    public fun get_nft_info(arg0: &ArticleAccessNft) : (address, 0x1::string::String, address, u64) {
        (arg0.article, arg0.title, arg0.author, arg0.minted_at)
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"external_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"attributes"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Article Access: {title}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Permanent access NFT for gated article: {title}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://inkray.app/api/nft/{id}/image"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://inkray.app/article/{article}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{author}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"[{\"trait_type\": \"Article\", \"value\": \"{article}\"}, {\"trait_type\": \"Type\", \"value\": \"Access NFT\"}]"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<ArticleAccessNft>(&v4, v0, v2, arg1);
        0x2::display::update_version<ArticleAccessNft>(&mut v5);
        let v6 = MintConfig{
            id                   : 0x2::object::new(arg1),
            base_price           : 10000000000,
            platform_fee_percent : 10,
            admin                : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<ArticleAccessNft>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<MintConfig>(v6);
    }

    public fun mint(arg0: address, arg1: &0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::articles::Article, arg2: &MintConfig, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : ArticleAccessNft {
        assert!(0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::articles::is_gated_content(arg1), 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= arg2.base_price, 1);
        let v0 = 0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::articles::get_article_address(arg1);
        let (v1, _, _, v4, _, _, _) = 0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::articles::get_article_info(arg1);
        let v8 = 0x2::object::new(arg4);
        let v9 = ArticleAccessNft{
            id        : v8,
            article   : v0,
            title     : v1,
            author    : v4,
            minted_at : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        let v10 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        let v11 = v10 * (arg2.platform_fee_percent as u64) / 100;
        if (v11 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v11, arg4), arg2.admin);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v4);
        0x3b48ae1218b39683052dcb102d56241dae98b5bb3774ac3623a7e6c13aa1b773::inkray_events::emit_article_nft_minted(v0, 0x2::object::uid_to_address(&v8), arg0, v10);
        v9
    }

    public fun nft_matches_article(arg0: &ArticleAccessNft, arg1: address) : bool {
        arg0.article == arg1
    }

    public fun transfer_nft(arg0: ArticleAccessNft, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<ArticleAccessNft>(arg0, arg1);
    }

    public fun update_mint_config(arg0: &mut MintConfig, arg1: u64, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 2);
        assert!(arg2 <= 100, 3);
        arg0.base_price = arg1;
        arg0.platform_fee_percent = arg2;
    }

    // decompiled from Move bytecode v6
}

