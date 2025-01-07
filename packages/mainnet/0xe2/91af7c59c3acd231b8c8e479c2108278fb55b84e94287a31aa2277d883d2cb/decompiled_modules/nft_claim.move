module 0xe291af7c59c3acd231b8c8e479c2108278fb55b84e94287a31aa2277d883d2cb::nft_claim {
    struct DEEPClaimNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct ClaimCap has store, key {
        id: 0x2::object::UID,
        claimed: 0x2::vec_set::VecSet<address>,
    }

    struct NFT_CLAIM has drop {
        dummy_field: bool,
    }

    public fun get_description(arg0: &DEEPClaimNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun get_id(arg0: &DEEPClaimNFT) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun get_image_url(arg0: &DEEPClaimNFT) : &0x1::string::String {
        &arg0.image_url
    }

    public fun get_name(arg0: &DEEPClaimNFT) : &0x1::string::String {
        &arg0.name
    }

    fun init(arg0: NFT_CLAIM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"DEEP Claim NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Thank you for being a Sui user. This exclusive NFT is your claim to DEEP tokens."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://i.imgur.com/ZAdqeZK.png"));
        let v4 = 0x2::package::claim<NFT_CLAIM>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<DEEPClaimNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<DEEPClaimNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<DEEPClaimNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = ClaimCap{
            id      : 0x2::object::new(arg1),
            claimed : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::transfer<ClaimCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_batch(arg0: &mut ClaimCap, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            if (!0x2::vec_set::contains<address>(&arg0.claimed, &v1)) {
                mint_single(arg0, v1, arg2);
            };
            v0 = v0 + 1;
        };
    }

    public fun mint_single(arg0: &mut ClaimCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::vec_set::contains<address>(&arg0.claimed, &arg1), 0);
        let v0 = DEEPClaimNFT{
            id          : 0x2::object::new(arg2),
            name        : 0x1::string::utf8(b"DEEP Claim NFT"),
            description : 0x1::string::utf8(b"Thank you for being a Sui user. This exclusive NFT is your claim to DEEP tokens."),
            image_url   : 0x1::string::utf8(b"https://i.imgur.com/ZAdqeZK.png"),
        };
        0x2::vec_set::insert<address>(&mut arg0.claimed, arg1);
        0x2::transfer::transfer<DEEPClaimNFT>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

