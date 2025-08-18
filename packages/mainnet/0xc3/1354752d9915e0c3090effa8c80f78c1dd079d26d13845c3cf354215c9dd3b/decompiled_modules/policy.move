module 0xc31354752d9915e0c3090effa8c80f78c1dd079d26d13845c3cf354215c9dd3b::policy {
    struct IdV1 has drop, store {
        tag: u8,
        version: u16,
        publication: address,
        article: address,
        nonce: u64,
    }

    public fun get_constants() : (u8, u16) {
        (0, 1)
    }

    public fun get_id_v1_fields(arg0: &IdV1) : (u8, u16, address, address, u64) {
        (arg0.tag, arg0.version, arg0.publication, arg0.article, arg0.nonce)
    }

    public fun get_id_version_v1() : u16 {
        1
    }

    public fun get_tag_article_content() : u8 {
        0
    }

    public fun parse_id_v1(arg0: &vector<u8>) : IdV1 {
        let v0 = 0x2::bcs::new(*arg0);
        let v1 = 0x2::bcs::peel_u8(&mut v0);
        let v2 = 0x2::bcs::peel_u16(&mut v0);
        let v3 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v3) == 0, 11);
        assert!(v1 == 0, 12);
        assert!(v2 == 1, 13);
        IdV1{
            tag         : v1,
            version     : v2,
            publication : 0x2::bcs::peel_address(&mut v0),
            article     : 0x2::bcs::peel_address(&mut v0),
            nonce       : 0x2::bcs::peel_u64(&mut v0),
        }
    }

    public entry fun seal_approve_any(arg0: vector<u8>, arg1: &0xc31354752d9915e0c3090effa8c80f78c1dd079d26d13845c3cf354215c9dd3b::publication::Publication, arg2: &0xc31354752d9915e0c3090effa8c80f78c1dd079d26d13845c3cf354215c9dd3b::articles::Article, arg3: &0x2::tx_context::TxContext) {
        let v0 = parse_id_v1(&arg0);
        assert!(v0.publication == 0xc31354752d9915e0c3090effa8c80f78c1dd079d26d13845c3cf354215c9dd3b::publication::get_publication_address(arg1), 10);
        assert!(v0.article == 0xc31354752d9915e0c3090effa8c80f78c1dd079d26d13845c3cf354215c9dd3b::articles::get_article_address(arg2), 10);
        if (0xc31354752d9915e0c3090effa8c80f78c1dd079d26d13845c3cf354215c9dd3b::articles::is_free_content(arg2)) {
            return
        };
        let v1 = 0x2::tx_context::sender(arg3);
        if (0xc31354752d9915e0c3090effa8c80f78c1dd079d26d13845c3cf354215c9dd3b::publication::is_owner(arg1, v1)) {
            return
        };
        assert!(0xc31354752d9915e0c3090effa8c80f78c1dd079d26d13845c3cf354215c9dd3b::publication::is_contributor(arg1, v1), 14);
    }

    public entry fun seal_approve_free(arg0: vector<u8>, arg1: &0xc31354752d9915e0c3090effa8c80f78c1dd079d26d13845c3cf354215c9dd3b::articles::Article) {
        let v0 = parse_id_v1(&arg0);
        assert!(v0.article == 0xc31354752d9915e0c3090effa8c80f78c1dd079d26d13845c3cf354215c9dd3b::articles::get_article_address(arg1), 10);
        assert!(0xc31354752d9915e0c3090effa8c80f78c1dd079d26d13845c3cf354215c9dd3b::articles::is_free_content(arg1), 14);
    }

    public entry fun seal_approve_nft(arg0: vector<u8>, arg1: &0xc31354752d9915e0c3090effa8c80f78c1dd079d26d13845c3cf354215c9dd3b::nft::ArticleAccessNft) {
        let v0 = parse_id_v1(&arg0);
        assert!(0xc31354752d9915e0c3090effa8c80f78c1dd079d26d13845c3cf354215c9dd3b::nft::nft_matches_article(arg1, v0.article), 14);
    }

    public entry fun seal_approve_roles(arg0: vector<u8>, arg1: &0xc31354752d9915e0c3090effa8c80f78c1dd079d26d13845c3cf354215c9dd3b::publication::Publication, arg2: &0x2::tx_context::TxContext) {
        let v0 = parse_id_v1(&arg0);
        assert!(v0.publication == 0xc31354752d9915e0c3090effa8c80f78c1dd079d26d13845c3cf354215c9dd3b::publication::get_publication_address(arg1), 10);
        let v1 = 0x2::tx_context::sender(arg2);
        if (0xc31354752d9915e0c3090effa8c80f78c1dd079d26d13845c3cf354215c9dd3b::publication::is_owner(arg1, v1)) {
            return
        };
        assert!(0xc31354752d9915e0c3090effa8c80f78c1dd079d26d13845c3cf354215c9dd3b::publication::is_contributor(arg1, v1), 14);
    }

    public entry fun seal_approve_subscription(arg0: vector<u8>, arg1: &0xc31354752d9915e0c3090effa8c80f78c1dd079d26d13845c3cf354215c9dd3b::subscription::Subscription, arg2: &0x2::clock::Clock) {
        parse_id_v1(&arg0);
        assert!(0xc31354752d9915e0c3090effa8c80f78c1dd079d26d13845c3cf354215c9dd3b::subscription::is_valid(arg1, arg2), 14);
    }

    public fun validate_id_format(arg0: &vector<u8>) : bool {
        if (0x1::vector::length<u8>(arg0) < 75) {
            return false
        };
        true
    }

    // decompiled from Move bytecode v6
}

