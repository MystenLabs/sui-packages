module 0xc01cb83e55eddadb5115185079b45cfd1fbe9c65845d62ff2967aef986df4a9a::distributor {
    struct DISTRIBUTOR has drop {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        recipient: address,
        is_og: bool,
    }

    struct DistributorCap has key {
        id: 0x2::object::UID,
    }

    fun display_fields() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        v0
    }

    fun init(arg0: DISTRIBUTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<DISTRIBUTOR>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Jackson Sharkz Egg"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"A mysterious egg within the Jackson.io ecosystem. Holders will unlock future rewards, exclusive perks, and upcoming Sharkz evolutions."));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"https://spimage.s3.ap-northeast-1.amazonaws.com/sp/2026-05-30/17801381355068282.jpg?versionId=Bribksnft3gK4V5mRHgvN2QpjBAgM7eu"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"https://spimage.s3.ap-northeast-1.amazonaws.com/sp/2026-05-30/17801381355068282.jpg?versionId=Bribksnft3gK4V5mRHgvN2QpjBAgM7eu"));
        let v3 = 0x2::display::new_with_fields<0xc01cb83e55eddadb5115185079b45cfd1fbe9c65845d62ff2967aef986df4a9a::jackson_sharkz::JacksonSharkzEgg>(&v0, display_fields(), v1, arg1);
        0x2::display::update_version<0xc01cb83e55eddadb5115185079b45cfd1fbe9c65845d62ff2967aef986df4a9a::jackson_sharkz::JacksonSharkzEgg>(&mut v3);
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"OG Jackson Sharkz Egg"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"A limited egg reserved for original Jackson Sharkz supporters. Unlock exclusive OG rewards, special status, and future ecosystem benefits."));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://spimage.s3.ap-northeast-1.amazonaws.com/sp/2026-05-30/17801381354493427.jpg?versionId=OqjLEr4a6N.A6cfrz0Bft7.8YYyP8U7z"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://spimage.s3.ap-northeast-1.amazonaws.com/sp/2026-05-30/17801381354493427.jpg?versionId=OqjLEr4a6N.A6cfrz0Bft7.8YYyP8U7z"));
        let v6 = 0x2::display::new_with_fields<0xc01cb83e55eddadb5115185079b45cfd1fbe9c65845d62ff2967aef986df4a9a::jackson_sharkz::OGJacksonSharkzEgg>(&v0, display_fields(), v4, arg1);
        0x2::display::update_version<0xc01cb83e55eddadb5115185079b45cfd1fbe9c65845d62ff2967aef986df4a9a::jackson_sharkz::OGJacksonSharkzEgg>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0xc01cb83e55eddadb5115185079b45cfd1fbe9c65845d62ff2967aef986df4a9a::jackson_sharkz::JacksonSharkzEgg>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0xc01cb83e55eddadb5115185079b45cfd1fbe9c65845d62ff2967aef986df4a9a::jackson_sharkz::OGJacksonSharkzEgg>>(v6, 0x2::tx_context::sender(arg1));
        let v7 = DistributorCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<DistributorCap>(v7, 0x2::tx_context::sender(arg1));
    }

    entry fun mint_egg(arg0: &DistributorCap, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        let v0 = 0;
        while (v0 < arg2) {
            let v1 = 0xc01cb83e55eddadb5115185079b45cfd1fbe9c65845d62ff2967aef986df4a9a::jackson_sharkz::new_egg(arg3);
            let v2 = NFTMinted{
                nft_id    : 0x2::object::id<0xc01cb83e55eddadb5115185079b45cfd1fbe9c65845d62ff2967aef986df4a9a::jackson_sharkz::JacksonSharkzEgg>(&v1),
                recipient : arg1,
                is_og     : false,
            };
            0x2::event::emit<NFTMinted>(v2);
            0x2::transfer::public_transfer<0xc01cb83e55eddadb5115185079b45cfd1fbe9c65845d62ff2967aef986df4a9a::jackson_sharkz::JacksonSharkzEgg>(v1, arg1);
            v0 = v0 + 1;
        };
    }

    entry fun mint_og_egg(arg0: &DistributorCap, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        let v0 = 0;
        while (v0 < arg2) {
            let v1 = 0xc01cb83e55eddadb5115185079b45cfd1fbe9c65845d62ff2967aef986df4a9a::jackson_sharkz::new_og_egg(arg3);
            let v2 = NFTMinted{
                nft_id    : 0x2::object::id<0xc01cb83e55eddadb5115185079b45cfd1fbe9c65845d62ff2967aef986df4a9a::jackson_sharkz::OGJacksonSharkzEgg>(&v1),
                recipient : arg1,
                is_og     : true,
            };
            0x2::event::emit<NFTMinted>(v2);
            0x2::transfer::public_transfer<0xc01cb83e55eddadb5115185079b45cfd1fbe9c65845d62ff2967aef986df4a9a::jackson_sharkz::OGJacksonSharkzEgg>(v1, arg1);
            v0 = v0 + 1;
        };
    }

    entry fun set_egg_image(arg0: &DistributorCap, arg1: &mut 0x2::display::Display<0xc01cb83e55eddadb5115185079b45cfd1fbe9c65845d62ff2967aef986df4a9a::jackson_sharkz::JacksonSharkzEgg>, arg2: 0x1::string::String) {
        0x2::display::edit<0xc01cb83e55eddadb5115185079b45cfd1fbe9c65845d62ff2967aef986df4a9a::jackson_sharkz::JacksonSharkzEgg>(arg1, 0x1::string::utf8(b"image"), arg2);
        0x2::display::edit<0xc01cb83e55eddadb5115185079b45cfd1fbe9c65845d62ff2967aef986df4a9a::jackson_sharkz::JacksonSharkzEgg>(arg1, 0x1::string::utf8(b"image_url"), arg2);
        0x2::display::update_version<0xc01cb83e55eddadb5115185079b45cfd1fbe9c65845d62ff2967aef986df4a9a::jackson_sharkz::JacksonSharkzEgg>(arg1);
    }

    entry fun set_og_egg_image(arg0: &DistributorCap, arg1: &mut 0x2::display::Display<0xc01cb83e55eddadb5115185079b45cfd1fbe9c65845d62ff2967aef986df4a9a::jackson_sharkz::OGJacksonSharkzEgg>, arg2: 0x1::string::String) {
        0x2::display::edit<0xc01cb83e55eddadb5115185079b45cfd1fbe9c65845d62ff2967aef986df4a9a::jackson_sharkz::OGJacksonSharkzEgg>(arg1, 0x1::string::utf8(b"image"), arg2);
        0x2::display::edit<0xc01cb83e55eddadb5115185079b45cfd1fbe9c65845d62ff2967aef986df4a9a::jackson_sharkz::OGJacksonSharkzEgg>(arg1, 0x1::string::utf8(b"image_url"), arg2);
        0x2::display::update_version<0xc01cb83e55eddadb5115185079b45cfd1fbe9c65845d62ff2967aef986df4a9a::jackson_sharkz::OGJacksonSharkzEgg>(arg1);
    }

    // decompiled from Move bytecode v7
}

