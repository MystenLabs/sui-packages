module 0x48ca080b87109467e625ceb4e436dd0b6f6a8b0cd6cca8e7dcb1a95e5cf55644::aurayale {
    struct AURAYALE has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MetadataRegistry has store, key {
        id: 0x2::object::UID,
        asset_cap: 0x48ca080b87109467e625ceb4e436dd0b6f6a8b0cd6cca8e7dcb1a95e5cf55644::tokenized_asset::AssetCap<AURAYALE>,
        gems: 0x2::vec_map::VecMap<0x1::ascii::String, GemInfo>,
    }

    struct GemInfo has copy, drop, store {
        metadatas: 0x2::vec_map::VecMap<0x1::ascii::String, NFTMetadata>,
        start_level: u8,
        whitelist: 0x2::vec_set::VecSet<address>,
    }

    struct NFTMetadata has copy, drop, store {
        img_url: 0x1::ascii::String,
        description: 0x1::ascii::String,
    }

    struct Dice has drop {
        value: u8,
    }

    public fun add_nft_metadata(arg0: &mut MetadataRegistry, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String) {
        let v0 = NFTMetadata{
            img_url     : arg3,
            description : arg4,
        };
        0x2::vec_map::insert<0x1::ascii::String, NFTMetadata>(&mut 0x2::vec_map::get_mut<0x1::ascii::String, GemInfo>(&mut arg0.gems, &arg1).metadatas, arg2, v0);
    }

    public fun add_whitelist(arg0: &mut MetadataRegistry, arg1: 0x1::ascii::String, arg2: address) {
        0x2::vec_set::insert<address>(&mut 0x2::vec_map::get_mut<0x1::ascii::String, GemInfo>(&mut arg0.gems, &arg1).whitelist, arg2);
    }

    public fun admin_burn(arg0: &mut MetadataRegistry, arg1: &AdminCap, arg2: 0x48ca080b87109467e625ceb4e436dd0b6f6a8b0cd6cca8e7dcb1a95e5cf55644::tokenized_asset::TokenizedAsset<AURAYALE>) : 0x2::object::ID {
        0x48ca080b87109467e625ceb4e436dd0b6f6a8b0cd6cca8e7dcb1a95e5cf55644::tokenized_asset::burn<AURAYALE>(&mut arg0.asset_cap, arg2);
        0x2::object::id<0x48ca080b87109467e625ceb4e436dd0b6f6a8b0cd6cca8e7dcb1a95e5cf55644::tokenized_asset::TokenizedAsset<AURAYALE>>(&arg2)
    }

    public fun admin_mint(arg0: &mut MetadataRegistry, arg1: &AdminCap, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: &mut 0x2::tx_context::TxContext) : 0x48ca080b87109467e625ceb4e436dd0b6f6a8b0cd6cca8e7dcb1a95e5cf55644::tokenized_asset::TokenizedAsset<AURAYALE> {
        mint_(arg0, arg2, arg3, arg4)
    }

    public fun burn(arg0: &mut MetadataRegistry, arg1: &AdminCap, arg2: 0x48ca080b87109467e625ceb4e436dd0b6f6a8b0cd6cca8e7dcb1a95e5cf55644::tokenized_asset::TokenizedAsset<AURAYALE>, arg3: &0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x48ca080b87109467e625ceb4e436dd0b6f6a8b0cd6cca8e7dcb1a95e5cf55644::tokenized_asset::metadata<AURAYALE>(&arg2);
        let v1 = 0x1::ascii::string(b"name");
        let v2 = *0x2::vec_map::get<0x1::ascii::String, 0x1::ascii::String>(&v0, &v1);
        let v3 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_set::contains<address>(&0x2::vec_map::get<0x1::ascii::String, GemInfo>(&arg0.gems, &v2).whitelist, &v3), 102);
        0x48ca080b87109467e625ceb4e436dd0b6f6a8b0cd6cca8e7dcb1a95e5cf55644::tokenized_asset::burn<AURAYALE>(&mut arg0.asset_cap, arg2);
        0x2::object::id<0x48ca080b87109467e625ceb4e436dd0b6f6a8b0cd6cca8e7dcb1a95e5cf55644::tokenized_asset::TokenizedAsset<AURAYALE>>(&arg2)
    }

    fun init(arg0: AURAYALE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x48ca080b87109467e625ceb4e436dd0b6f6a8b0cd6cca8e7dcb1a95e5cf55644::tokenized_asset::new_asset<AURAYALE>(arg0, 1000, 0x1::ascii::string(b"AUR"), 0x1::ascii::string(b"Aurayale"), 0x1::ascii::string(b"Aurayale is a gemstone-themed collectible card battle game"), 0x1::option::none<0x2::url::Url>(), true, arg1);
        0x2::transfer::public_transfer<0x48ca080b87109467e625ceb4e436dd0b6f6a8b0cd6cca8e7dcb1a95e5cf55644::tokenized_asset::AssetMetadata<AURAYALE>>(v2, 0x2::tx_context::sender(arg1));
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = MetadataRegistry{
            id        : 0x2::object::new(arg1),
            asset_cap : v1,
            gems      : 0x2::vec_map::empty<0x1::ascii::String, GemInfo>(),
        };
        let v5 = GemInfo{
            metadatas   : 0x2::vec_map::empty<0x1::ascii::String, NFTMetadata>(),
            start_level : 0,
            whitelist   : 0x2::vec_set::singleton<address>(v0),
        };
        0x2::vec_map::insert<0x1::ascii::String, GemInfo>(&mut v4.gems, 0x1::ascii::string(b"red"), v5);
        let v6 = GemInfo{
            metadatas   : 0x2::vec_map::empty<0x1::ascii::String, NFTMetadata>(),
            start_level : 0,
            whitelist   : 0x2::vec_set::singleton<address>(v0),
        };
        0x2::vec_map::insert<0x1::ascii::String, GemInfo>(&mut v4.gems, 0x1::ascii::string(b"blue"), v6);
        let v7 = GemInfo{
            metadatas   : 0x2::vec_map::empty<0x1::ascii::String, NFTMetadata>(),
            start_level : 1,
            whitelist   : 0x2::vec_set::singleton<address>(v0),
        };
        0x2::vec_map::insert<0x1::ascii::String, GemInfo>(&mut v4.gems, 0x1::ascii::string(b"yellow"), v7);
        let v8 = GemInfo{
            metadatas   : 0x2::vec_map::empty<0x1::ascii::String, NFTMetadata>(),
            start_level : 1,
            whitelist   : 0x2::vec_set::singleton<address>(v0),
        };
        0x2::vec_map::insert<0x1::ascii::String, GemInfo>(&mut v4.gems, 0x1::ascii::string(b"green"), v8);
        0x2::transfer::public_share_object<MetadataRegistry>(v4);
    }

    public fun merge(arg0: &mut MetadataRegistry, arg1: 0x48ca080b87109467e625ceb4e436dd0b6f6a8b0cd6cca8e7dcb1a95e5cf55644::tokenized_asset::TokenizedAsset<AURAYALE>, arg2: 0x48ca080b87109467e625ceb4e436dd0b6f6a8b0cd6cca8e7dcb1a95e5cf55644::tokenized_asset::TokenizedAsset<AURAYALE>, arg3: Dice, arg4: &mut 0x2::tx_context::TxContext) : 0x48ca080b87109467e625ceb4e436dd0b6f6a8b0cd6cca8e7dcb1a95e5cf55644::tokenized_asset::TokenizedAsset<AURAYALE> {
        abort 0
    }

    public fun merge_v1(arg0: &mut MetadataRegistry, arg1: &0x2::random::Random, arg2: 0x48ca080b87109467e625ceb4e436dd0b6f6a8b0cd6cca8e7dcb1a95e5cf55644::tokenized_asset::TokenizedAsset<AURAYALE>, arg3: 0x48ca080b87109467e625ceb4e436dd0b6f6a8b0cd6cca8e7dcb1a95e5cf55644::tokenized_asset::TokenizedAsset<AURAYALE>, arg4: &mut 0x2::tx_context::TxContext) : 0x48ca080b87109467e625ceb4e436dd0b6f6a8b0cd6cca8e7dcb1a95e5cf55644::tokenized_asset::TokenizedAsset<AURAYALE> {
        abort 0
    }

    public fun merge_v2(arg0: &mut MetadataRegistry, arg1: &0x2::random::Random, arg2: 0x48ca080b87109467e625ceb4e436dd0b6f6a8b0cd6cca8e7dcb1a95e5cf55644::tokenized_asset::TokenizedAsset<AURAYALE>, arg3: 0x48ca080b87109467e625ceb4e436dd0b6f6a8b0cd6cca8e7dcb1a95e5cf55644::tokenized_asset::TokenizedAsset<AURAYALE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg1, arg4);
        let v1 = 0x2::random::generate_u8(&mut v0);
        let v2 = 0x48ca080b87109467e625ceb4e436dd0b6f6a8b0cd6cca8e7dcb1a95e5cf55644::tokenized_asset::metadata<AURAYALE>(&arg2);
        let v3 = 0x1::ascii::string(b"level");
        let v4 = 0x48ca080b87109467e625ceb4e436dd0b6f6a8b0cd6cca8e7dcb1a95e5cf55644::tokenized_asset::metadata<AURAYALE>(&arg3);
        let v5 = 0x1::ascii::string(b"level");
        assert!(parse_u8_from_bytes(0x1::ascii::as_bytes(0x2::vec_map::get<0x1::ascii::String, 0x1::ascii::String>(&v4, &v5))) == parse_u8_from_bytes(0x1::ascii::as_bytes(0x2::vec_map::get<0x1::ascii::String, 0x1::ascii::String>(&v2, &v3))), 101);
        let v6 = if (v1 % 2 == 0) {
            0x1::ascii::string(b"yellow")
        } else {
            0x1::ascii::string(b"green")
        };
        let v7 = v6;
        let v8 = *0x2::vec_map::get<0x1::ascii::String, GemInfo>(&arg0.gems, &v7);
        let v9 = 0x2::vec_map::keys<0x1::ascii::String, NFTMetadata>(&v8.metadatas);
        let v10 = *0x1::vector::borrow<0x1::ascii::String>(&v9, ((v1 % (0x1::vector::length<0x1::ascii::String>(&v9) as u8)) as u64));
        0x48ca080b87109467e625ceb4e436dd0b6f6a8b0cd6cca8e7dcb1a95e5cf55644::tokenized_asset::burn<AURAYALE>(&mut arg0.asset_cap, arg2);
        0x48ca080b87109467e625ceb4e436dd0b6f6a8b0cd6cca8e7dcb1a95e5cf55644::tokenized_asset::burn<AURAYALE>(&mut arg0.asset_cap, arg3);
        let v11 = 0x1::vector::empty<0x1::ascii::String>();
        let v12 = &mut v11;
        0x1::vector::push_back<0x1::ascii::String>(v12, 0x1::ascii::string(b"gem"));
        0x1::vector::push_back<0x1::ascii::String>(v12, 0x1::ascii::string(b"name"));
        0x1::vector::push_back<0x1::ascii::String>(v12, 0x1::ascii::string(b"level"));
        0x1::vector::push_back<0x1::ascii::String>(v12, 0x1::ascii::string(b"description"));
        let v13 = *0x2::vec_map::get<0x1::ascii::String, NFTMetadata>(&v8.metadatas, &v10);
        let v14 = 0x1::vector::empty<0x1::ascii::String>();
        let v15 = &mut v14;
        0x1::vector::push_back<0x1::ascii::String>(v15, v7);
        0x1::vector::push_back<0x1::ascii::String>(v15, v10);
        0x1::vector::push_back<0x1::ascii::String>(v15, 0x1::string::to_ascii(0x1::u8::to_string(v8.start_level)));
        0x1::vector::push_back<0x1::ascii::String>(v15, v13.description);
        0x2::transfer::public_transfer<0x48ca080b87109467e625ceb4e436dd0b6f6a8b0cd6cca8e7dcb1a95e5cf55644::tokenized_asset::TokenizedAsset<AURAYALE>>(0x48ca080b87109467e625ceb4e436dd0b6f6a8b0cd6cca8e7dcb1a95e5cf55644::tokenized_asset::mint<AURAYALE>(&mut arg0.asset_cap, v11, v14, 1, 0x1::option::some<0x1::ascii::String>(v13.img_url), arg4), 0x2::tx_context::sender(arg4));
    }

    public fun mint(arg0: &mut MetadataRegistry, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) : 0x48ca080b87109467e625ceb4e436dd0b6f6a8b0cd6cca8e7dcb1a95e5cf55644::tokenized_asset::TokenizedAsset<AURAYALE> {
        let v0 = *0x2::vec_map::get<0x1::ascii::String, GemInfo>(&arg0.gems, &arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_set::contains<address>(&v0.whitelist, &v1), 102);
        mint_(arg0, arg1, arg2, arg3)
    }

    fun mint_(arg0: &mut MetadataRegistry, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) : 0x48ca080b87109467e625ceb4e436dd0b6f6a8b0cd6cca8e7dcb1a95e5cf55644::tokenized_asset::TokenizedAsset<AURAYALE> {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::ascii::String>(v1, 0x1::ascii::string(b"gem"));
        0x1::vector::push_back<0x1::ascii::String>(v1, 0x1::ascii::string(b"name"));
        0x1::vector::push_back<0x1::ascii::String>(v1, 0x1::ascii::string(b"level"));
        0x1::vector::push_back<0x1::ascii::String>(v1, 0x1::ascii::string(b"description"));
        let v2 = *0x2::vec_map::get<0x1::ascii::String, GemInfo>(&arg0.gems, &arg1);
        let v3 = *0x2::vec_map::get<0x1::ascii::String, NFTMetadata>(&v2.metadatas, &arg2);
        let v4 = 0x1::vector::empty<0x1::ascii::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::ascii::String>(v5, arg1);
        0x1::vector::push_back<0x1::ascii::String>(v5, arg2);
        0x1::vector::push_back<0x1::ascii::String>(v5, 0x1::string::to_ascii(0x1::u8::to_string(v2.start_level)));
        0x1::vector::push_back<0x1::ascii::String>(v5, v3.description);
        0x48ca080b87109467e625ceb4e436dd0b6f6a8b0cd6cca8e7dcb1a95e5cf55644::tokenized_asset::mint<AURAYALE>(&mut arg0.asset_cap, v0, v4, 1, 0x1::option::some<0x1::ascii::String>(v3.img_url), arg3)
    }

    fun parse_u8_from_bytes(arg0: &vector<u8>) : u8 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            let v2 = *0x1::vector::borrow<u8>(arg0, v1);
            assert!(v2 >= 48 && v2 <= 57, 0);
            let v3 = v0 * 10;
            v0 = v3 + v2 - 48;
            v1 = v1 + 1;
        };
        v0
    }

    public fun remove_img_url(arg0: &mut MetadataRegistry, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String) {
        let (_, _) = 0x2::vec_map::remove<0x1::ascii::String, NFTMetadata>(&mut 0x2::vec_map::get_mut<0x1::ascii::String, GemInfo>(&mut arg0.gems, &arg1).metadatas, &arg2);
    }

    public fun remove_whitelist(arg0: &mut MetadataRegistry, arg1: 0x1::ascii::String, arg2: address) {
        0x2::vec_set::remove<address>(&mut 0x2::vec_map::get_mut<0x1::ascii::String, GemInfo>(&mut arg0.gems, &arg1).whitelist, &arg2);
    }

    entry fun roll_dice(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : Dice {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        Dice{value: 0x2::random::generate_u8(&mut v0)}
    }

    public fun update_metadata(arg0: &mut MetadataRegistry, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String) {
        let v0 = NFTMetadata{
            img_url     : arg3,
            description : arg4,
        };
        *0x2::vec_map::get_mut<0x1::ascii::String, NFTMetadata>(&mut 0x2::vec_map::get_mut<0x1::ascii::String, GemInfo>(&mut arg0.gems, &arg1).metadatas, &arg2) = v0;
    }

    // decompiled from Move bytecode v6
}

