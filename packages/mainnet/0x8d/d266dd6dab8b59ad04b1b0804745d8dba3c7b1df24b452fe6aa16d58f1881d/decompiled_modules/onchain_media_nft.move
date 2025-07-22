module 0x8dd266dd6dab8b59ad04b1b0804745d8dba3c7b1df24b452fe6aa16d58f1881d::onchain_media_nft {
    struct NFTCard has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        character: 0x1::string::String,
        magic: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
        walrus_sui_object: 0x1::string::String,
    }

    struct ONCHAIN_MEDIA_NFT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: NFTCard, arg1: &mut 0x2::tx_context::TxContext) {
        let NFTCard {
            id                : v0,
            name              : _,
            description       : _,
            character         : _,
            magic             : _,
            walrus_blob_id    : _,
            walrus_sui_object : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_character(arg0: &NFTCard) : &0x1::string::String {
        &arg0.character
    }

    public fun get_description(arg0: &NFTCard) : &0x1::string::String {
        &arg0.description
    }

    public fun get_name(arg0: &NFTCard) : &0x1::string::String {
        &arg0.name
    }

    public fun get_walrus_blob_id(arg0: &NFTCard) : &0x1::string::String {
        &arg0.walrus_blob_id
    }

    public fun get_walrus_sui_object(arg0: &NFTCard) : &0x1::string::String {
        &arg0.walrus_sui_object
    }

    fun init(arg0: ONCHAIN_MEDIA_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/{walrus_blob_id}"));
        let v4 = 0x2::package::claim<ONCHAIN_MEDIA_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NFTCard>(&v4, v0, v2, arg1);
        0x2::display::update_version<NFTCard>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v6);
        0x2::transfer::public_transfer<0x2::display::Display<NFTCard>>(v5, v6);
    }

    public fun magic(arg0: &NFTCard) : &0x1::string::String {
        &arg0.magic
    }

    public entry fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::string::is_empty(&arg0), 0);
        assert!(!0x1::string::is_empty(&arg4), 1);
        let v0 = NFTCard{
            id                : 0x2::object::new(arg6),
            name              : arg0,
            description       : arg1,
            character         : arg2,
            magic             : arg3,
            walrus_blob_id    : arg4,
            walrus_sui_object : arg5,
        };
        0x2::transfer::transfer<NFTCard>(v0, 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v6
}

