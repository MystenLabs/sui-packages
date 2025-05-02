module 0x10f9a0b5737fca70df14a9ef4753eec1129e97f9e8ee240828642ab9d3327f1e::not_for_sale {
    struct NotForSaleNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        status: 0x1::string::String,
        value: 0x1::string::String,
        transferable: 0x1::string::String,
        link: 0x1::string::String,
        creator_url: 0x1::string::String,
        creator_x: 0x1::string::String,
    }

    struct NOT_FOR_SALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOT_FOR_SALE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NOT_FOR_SALE>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"status"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"value"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"transferable"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator_x"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"This NFT Is Priceless"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"A digital relic of immeasurable worth. Not for sale. Not for trade. Not for you. A sacred holding of Moral Capital."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://artisdead.club/vault/self-portrait.png"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"locked"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"immeasurable"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"false"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://artisdead.club/"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://moral.capital"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://x.com/moral_capital"));
        let v5 = 0x2::display::new_with_fields<NotForSaleNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<NotForSaleNFT>(&mut v5);
        let v6 = NotForSaleNFT{
            id           : 0x2::object::new(arg1),
            name         : 0x1::string::utf8(b"This NFT Is Priceless"),
            description  : 0x1::string::utf8(b"A digital relic of immeasurable worth. Not for sale. Not for trade. Not for you. A sacred holding of Moral Capital."),
            image_url    : 0x1::string::utf8(b"https://artisdead.club/vault/self-portrait.png"),
            status       : 0x1::string::utf8(b"locked"),
            value        : 0x1::string::utf8(b"immeasurable"),
            transferable : 0x1::string::utf8(b"false"),
            link         : 0x1::string::utf8(b"https://artisdead.club/"),
            creator_url  : 0x1::string::utf8(b"https://moral.capital"),
            creator_x    : 0x1::string::utf8(b"https://x.com/moral_capital"),
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, @0x63180848bfc1156b113880f0d3ee3feb9e2b137b1ef0c80670f850f70c4783ad);
        0x2::transfer::public_transfer<0x2::display::Display<NotForSaleNFT>>(v5, @0x63180848bfc1156b113880f0d3ee3feb9e2b137b1ef0c80670f850f70c4783ad);
        0x2::transfer::public_transfer<NotForSaleNFT>(v6, @0x63180848bfc1156b113880f0d3ee3feb9e2b137b1ef0c80670f850f70c4783ad);
    }

    // decompiled from Move bytecode v6
}

