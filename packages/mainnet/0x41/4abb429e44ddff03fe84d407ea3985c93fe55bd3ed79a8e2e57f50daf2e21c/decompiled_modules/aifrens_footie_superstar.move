module 0x414abb429e44ddff03fe84d407ea3985c93fe55bd3ed79a8e2e57f50daf2e21c::aifrens_footie_superstar {
    struct AIFRENS_FOOTIE_SUPERSTAR has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
    }

    struct TokenMetadata has copy, drop, store {
        id: u64,
        name: 0x1::string::String,
        rating: u64,
        position: 0x1::string::String,
        nation: 0x1::string::String,
    }

    struct AifrensFootieSuperstar has store, key {
        id: 0x2::object::UID,
        generation: u64,
        birthdate: u64,
        genes: vector<u8>,
        birth_location: 0x1::string::String,
        level: u64,
        meta_id: u64,
        name: 0x1::string::String,
        rating: u64,
        position: 0x1::string::String,
        nation: 0x1::string::String,
        rarity: 0x1::string::String,
    }

    struct AifrensSeason has key {
        id: 0x2::object::UID,
        season: u64,
        tier_list: vector<0x2::table::Table<u64, TokenMetadata>>,
    }

    struct PriceGlobal<phantom T0> has key {
        id: 0x2::object::UID,
        fusion_price: u64,
        recruit_price: u64,
        balance: 0x2::balance::Balance<T0>,
        feed_id_bytes: vector<u8>,
        sui_price: 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::SwitchboardDecimal,
    }

    struct AifrensSuperstarGlobal has key {
        id: 0x2::object::UID,
        start_time_ms: u64,
        expired_time_ms: u64,
        paused: bool,
        rarity_rate: vector<u64>,
    }

    struct MintEvent has copy, drop {
        id: 0x2::object::ID,
        creator: address,
        generation: u64,
        birthdate: u64,
        genes: vector<u8>,
        season: u64,
        birth_location: 0x1::string::String,
        meta_id: u64,
        name: 0x1::string::String,
        rating: u64,
        position: 0x1::string::String,
        rarity: 0x1::string::String,
        nation: 0x1::string::String,
    }

    public entry fun withdraw_all<T0>(arg0: &mut PriceGlobal<T0>, arg1: address, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance), arg3), arg1);
    }

    public fun birthdate(arg0: &AifrensFootieSuperstar) : u64 {
        arg0.birthdate
    }

    public fun burn_token(arg0: AifrensFootieSuperstar) {
        let AifrensFootieSuperstar {
            id             : v0,
            generation     : _,
            birthdate      : _,
            genes          : _,
            birth_location : _,
            level          : _,
            meta_id        : _,
            name           : _,
            rating         : _,
            position       : _,
            nation         : _,
            rarity         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun genes(arg0: &AifrensFootieSuperstar) : vector<u8> {
        arg0.genes
    }

    public fun create_mint_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : MintCap {
        MintCap{id: 0x2::object::new(arg1)}
    }

    public entry fun fusion<T0>(arg0: &mut AifrensSuperstarGlobal, arg1: &mut PriceGlobal<T0>, arg2: &AifrensSeason, arg3: &0x2::clock::Clock, arg4: &mut 0x2::coin::Coin<T0>, arg5: u64, arg6: 0x17c1d7520b731e59c665962aba86f84827f8d6812f839d126d3426caa29777cc::aifrens_footie_legends::AifrensGenesis, arg7: 0x17c1d7520b731e59c665962aba86f84827f8d6812f839d126d3426caa29777cc::aifrens_footie_legends::AifrensGenesis, arg8: vector<0xcf82c1ad5faa30acb2f18394f7cfaf5e5c0c2416d68ebcf01a78c83c385a682c::aifrens_lol::AifrensLol>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 > arg0.start_time_ms, 1);
        assert!(v0 < arg0.expired_time_ms, 2);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg4, get_final_price<T0>(arg1.fusion_price, arg1) + arg5, arg9)));
        let v1 = 0x1::vector::length<0xcf82c1ad5faa30acb2f18394f7cfaf5e5c0c2416d68ebcf01a78c83c385a682c::aifrens_lol::AifrensLol>(&arg8);
        let v2 = 0;
        while (v2 < v1) {
            0xcf82c1ad5faa30acb2f18394f7cfaf5e5c0c2416d68ebcf01a78c83c385a682c::aifrens_lol::burn_token(0x1::vector::pop_back<0xcf82c1ad5faa30acb2f18394f7cfaf5e5c0c2416d68ebcf01a78c83c385a682c::aifrens_lol::AifrensLol>(&mut arg8));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0xcf82c1ad5faa30acb2f18394f7cfaf5e5c0c2416d68ebcf01a78c83c385a682c::aifrens_lol::AifrensLol>(arg8);
        0x17c1d7520b731e59c665962aba86f84827f8d6812f839d126d3426caa29777cc::aifrens_footie_legends::burn_token(arg6);
        0x17c1d7520b731e59c665962aba86f84827f8d6812f839d126d3426caa29777cc::aifrens_footie_legends::burn_token(arg7);
        let v3 = mint_token(arg2, arg3, 0x17c1d7520b731e59c665962aba86f84827f8d6812f839d126d3426caa29777cc::aifrens_footie_legends::birthdate(&arg6), 0x17c1d7520b731e59c665962aba86f84827f8d6812f839d126d3426caa29777cc::aifrens_footie_legends::genes(&arg6), 0x17c1d7520b731e59c665962aba86f84827f8d6812f839d126d3426caa29777cc::aifrens_footie_legends::birth_location(&arg6), get_rate(arg0, arg5, v1), arg9);
        0x2::transfer::public_transfer<AifrensFootieSuperstar>(v3, 0x2::tx_context::sender(arg9));
    }

    fun get_final_price<T0>(arg0: u64, arg1: &PriceGlobal<T0>) : u64 {
        if (0x1::vector::is_empty<u8>(&arg1.feed_id_bytes)) {
            arg0
        } else {
            let (v1, v2, _) = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::unpack(arg1.sui_price);
            (((arg0 as u128) * (0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::pow(10, v2) as u128) / v1) as u64)
        }
    }

    fun get_price_from_feed(arg0: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator) : 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::SwitchboardDecimal {
        let (v0, _) = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::latest_value(arg0);
        v0
    }

    fun get_random(arg0: &0x2::clock::Clock, arg1: address, arg2: vector<u8>, arg3: u64) : u64 {
        let v0 = get_random_vector(arg0, arg1, arg2);
        let v1 = &mut v0;
        to_u64(v1) % arg3
    }

    fun get_random_vector(arg0: &0x2::clock::Clock, arg1: address, arg2: vector<u8>) : vector<u8> {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&v0));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v1, arg2);
        0x2::hash::keccak256(&v1)
    }

    fun get_rarity_str(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"N"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"R"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"SR"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"SSR"));
        *0x1::vector::borrow<0x1::string::String>(&v0, arg0)
    }

    public fun get_rate(arg0: &AifrensSuperstarGlobal, arg1: u64, arg2: u64) : vector<u64> {
        let v0 = arg0.rarity_rate;
        let v1 = 0x1::vector::borrow_mut<u64>(&mut v0, 0);
        let v2 = arg1 / 1000000000;
        let v3 = if (*v1 - 20 < v2) {
            20
        } else {
            *v1 - v2
        };
        *v1 = v3;
        let v4 = 0;
        while (v4 < arg2) {
            *v1 = *v1 - 2;
            v4 = v4 + 1;
        };
        v0
    }

    fun init(arg0: AIFRENS_FOOTIE_SUPERSTAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"metadata"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"AIFRENS Footie SuperStar"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://explorer.sui.io/object/{id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://api.suifrens.ai/nft/aifrens-footie-superstar.png?id={id}&rarity={rarity}&&level={level}&rating={rating}&position={position}&meta={meta_id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"AIFRENS Footie SuperStar NFT is a limited edition digital collectible that grants holders access to exclusive rewards and benefits within the AIFRENS ecosystem, including eligibility for airdrops, access to AIFRENS Fi protocols, AIFRENS GameFi verse, AIFRENS private communities and Legend Fusion to unlock unique abilities."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://suifrens.ai/"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://api.suifrens.ai/nft-metadata/id={id}"));
        let v5 = 0x2::package::claim<AIFRENS_FOOTIE_SUPERSTAR>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<AifrensFootieSuperstar>(&v5, v1, v3, arg1);
        0x2::display::update_version<AifrensFootieSuperstar>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, v0);
        0x2::transfer::public_transfer<0x2::display::Display<AifrensFootieSuperstar>>(v6, v0);
        let v7 = 0x1::vector::empty<0x2::table::Table<u64, TokenMetadata>>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x2::table::Table<u64, TokenMetadata>>(v8, 0x2::table::new<u64, TokenMetadata>(arg1));
        0x1::vector::push_back<0x2::table::Table<u64, TokenMetadata>>(v8, 0x2::table::new<u64, TokenMetadata>(arg1));
        0x1::vector::push_back<0x2::table::Table<u64, TokenMetadata>>(v8, 0x2::table::new<u64, TokenMetadata>(arg1));
        0x1::vector::push_back<0x2::table::Table<u64, TokenMetadata>>(v8, 0x2::table::new<u64, TokenMetadata>(arg1));
        let v9 = AifrensSeason{
            id        : 0x2::object::new(arg1),
            season    : 1,
            tier_list : v7,
        };
        0x2::transfer::share_object<AifrensSeason>(v9);
        let v10 = AifrensSuperstarGlobal{
            id              : 0x2::object::new(arg1),
            start_time_ms   : 1686394800000,
            expired_time_ms : 96839828000000,
            paused          : false,
            rarity_rate     : vector[80, 12, 6, 2],
        };
        0x2::transfer::share_object<AifrensSuperstarGlobal>(v10);
        let v11 = PriceGlobal<0x2::sui::SUI>{
            id            : 0x2::object::new(arg1),
            fusion_price  : 100000000,
            recruit_price : 5000000000,
            balance       : 0x2::balance::zero<0x2::sui::SUI>(),
            feed_id_bytes : 0x1::vector::empty<u8>(),
            sui_price     : 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::zero(),
        };
        0x2::transfer::share_object<PriceGlobal<0x2::sui::SUI>>(v11);
        let v12 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v12, v0);
    }

    public fun insert_multiple_token_metadata(arg0: &mut AifrensSeason, arg1: u64, arg2: vector<TokenMetadata>, arg3: &AdminCap) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<TokenMetadata>(&arg2)) {
            0x2::table::add<u64, TokenMetadata>(0x1::vector::borrow_mut<0x2::table::Table<u64, TokenMetadata>>(&mut arg0.tier_list, arg1), 0x2::table::length<u64, TokenMetadata>(0x1::vector::borrow<0x2::table::Table<u64, TokenMetadata>>(&arg0.tier_list, arg1)) + v0, *0x1::vector::borrow<TokenMetadata>(&arg2, v0));
            v0 = v0 + 1;
        };
    }

    public fun insert_token_metadata(arg0: &mut AifrensSeason, arg1: u64, arg2: TokenMetadata, arg3: &AdminCap) {
        let v0 = 0x1::vector::borrow_mut<0x2::table::Table<u64, TokenMetadata>>(&mut arg0.tier_list, arg1 - 1);
        0x2::table::add<u64, TokenMetadata>(v0, 0x2::table::length<u64, TokenMetadata>(v0), arg2);
    }

    public fun level(arg0: &AifrensFootieSuperstar) : u64 {
        arg0.level
    }

    fun mint_token(arg0: &AifrensSeason, arg1: &0x2::clock::Clock, arg2: u64, arg3: vector<u8>, arg4: 0x1::string::String, arg5: vector<u64>, arg6: &mut 0x2::tx_context::TxContext) : AifrensFootieSuperstar {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg5)) {
            v1 = v1 + *0x1::vector::borrow<u64>(&arg5, v2);
            v2 = v2 + 1;
        };
        let v3 = get_random(arg1, v0, arg3, v1);
        let v4 = 0;
        while (v3 > 0) {
            let v5 = *0x1::vector::borrow<u64>(&arg5, v4);
            let v6 = if (v3 >= v5) {
                v4 = v4 + 1;
                v3 - v5
            } else {
                0
            };
            v3 = v6;
        };
        let v7 = get_rarity_str(v4);
        let v8 = 0x1::vector::borrow<0x2::table::Table<u64, TokenMetadata>>(&arg0.tier_list, v4);
        let v9 = 0x2::table::borrow<u64, TokenMetadata>(v8, get_random(arg1, v0, arg3, 0x2::table::length<u64, TokenMetadata>(v8)));
        let v10 = &v9.id;
        let v11 = &v9.name;
        let v12 = &v9.rating;
        let v13 = &v9.position;
        let v14 = &v9.nation;
        let v15 = AifrensFootieSuperstar{
            id             : 0x2::object::new(arg6),
            generation     : 1,
            birthdate      : arg2,
            genes          : arg3,
            birth_location : arg4,
            level          : 1,
            meta_id        : *v10,
            name           : *v11,
            rating         : *v12,
            position       : *v13,
            nation         : *v14,
            rarity         : v7,
        };
        let v16 = MintEvent{
            id             : 0x2::object::uid_to_inner(&v15.id),
            creator        : v0,
            generation     : 1,
            birthdate      : arg2,
            genes          : arg3,
            season         : arg0.season,
            birth_location : arg4,
            meta_id        : *v10,
            name           : *v11,
            rating         : *v12,
            position       : *v13,
            rarity         : v7,
            nation         : *v14,
        };
        0x2::event::emit<MintEvent>(v16);
        v15
    }

    public fun mint_token_by_cap(arg0: TokenMetadata, arg1: u64, arg2: vector<u8>, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: &MintCap, arg8: &mut 0x2::tx_context::TxContext) : AifrensFootieSuperstar {
        let TokenMetadata {
            id       : v0,
            name     : v1,
            rating   : v2,
            position : v3,
            nation   : v4,
        } = arg0;
        AifrensFootieSuperstar{
            id             : 0x2::object::new(arg8),
            generation     : arg4,
            birthdate      : arg1,
            genes          : arg2,
            birth_location : arg3,
            level          : arg5,
            meta_id        : v0,
            name           : v1,
            rating         : v2,
            position       : v3,
            nation         : v4,
            rarity         : arg6,
        }
    }

    public fun nation(arg0: &AifrensFootieSuperstar) : 0x1::string::String {
        arg0.nation
    }

    public entry fun new_price<T0>(arg0: u64, arg1: u64, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceGlobal<T0>{
            id            : 0x2::object::new(arg3),
            fusion_price  : arg0,
            recruit_price : arg1,
            balance       : 0x2::balance::zero<T0>(),
            feed_id_bytes : 0x1::vector::empty<u8>(),
            sui_price     : 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::zero(),
        };
        0x2::transfer::share_object<PriceGlobal<T0>>(v0);
    }

    public entry fun new_season<T0>(arg0: u64, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::table::Table<u64, TokenMetadata>>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x2::table::Table<u64, TokenMetadata>>(v1, 0x2::table::new<u64, TokenMetadata>(arg2));
        0x1::vector::push_back<0x2::table::Table<u64, TokenMetadata>>(v1, 0x2::table::new<u64, TokenMetadata>(arg2));
        0x1::vector::push_back<0x2::table::Table<u64, TokenMetadata>>(v1, 0x2::table::new<u64, TokenMetadata>(arg2));
        0x1::vector::push_back<0x2::table::Table<u64, TokenMetadata>>(v1, 0x2::table::new<u64, TokenMetadata>(arg2));
        let v2 = AifrensSeason{
            id        : 0x2::object::new(arg2),
            season    : arg0,
            tier_list : v0,
        };
        0x2::transfer::share_object<AifrensSeason>(v2);
    }

    public entry fun new_usd_price<T0>(arg0: u64, arg1: u64, arg2: &AdminCap, arg3: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceGlobal<T0>{
            id            : 0x2::object::new(arg4),
            fusion_price  : arg0,
            recruit_price : arg1,
            balance       : 0x2::balance::zero<T0>(),
            feed_id_bytes : 0x2::object::id_bytes<0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator>(arg3),
            sui_price     : get_price_from_feed(arg3),
        };
        0x2::transfer::share_object<PriceGlobal<T0>>(v0);
    }

    public fun position(arg0: &AifrensFootieSuperstar) : 0x1::string::String {
        arg0.position
    }

    public fun rarity(arg0: &AifrensFootieSuperstar) : 0x1::string::String {
        arg0.rarity
    }

    public entry fun recruit<T0>(arg0: &mut AifrensSuperstarGlobal, arg1: &mut PriceGlobal<T0>, arg2: &AifrensSeason, arg3: &0x2::clock::Clock, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::coin::Coin<T0>, arg7: u64, arg8: vector<0xcf82c1ad5faa30acb2f18394f7cfaf5e5c0c2416d68ebcf01a78c83c385a682c::aifrens_lol::AifrensLol>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 > arg0.start_time_ms, 1);
        assert!(v0 < arg0.expired_time_ms, 2);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg6, get_final_price<T0>(arg1.recruit_price, arg1), arg9)));
        let v1 = get_random_vector(arg3, 0x2::tx_context::sender(arg9), arg4);
        let v2 = 0x1::vector::length<0xcf82c1ad5faa30acb2f18394f7cfaf5e5c0c2416d68ebcf01a78c83c385a682c::aifrens_lol::AifrensLol>(&arg8);
        let v3 = 0;
        while (v3 < v2) {
            0xcf82c1ad5faa30acb2f18394f7cfaf5e5c0c2416d68ebcf01a78c83c385a682c::aifrens_lol::burn_token(0x1::vector::pop_back<0xcf82c1ad5faa30acb2f18394f7cfaf5e5c0c2416d68ebcf01a78c83c385a682c::aifrens_lol::AifrensLol>(&mut arg8));
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0xcf82c1ad5faa30acb2f18394f7cfaf5e5c0c2416d68ebcf01a78c83c385a682c::aifrens_lol::AifrensLol>(arg8);
        let v4 = mint_token(arg2, arg3, v0, v1, 0x1::string::utf8(arg5), get_rate(arg0, arg7, v2), arg9);
        0x2::transfer::public_transfer<AifrensFootieSuperstar>(v4, 0x2::tx_context::sender(arg9));
    }

    fun to_u64(arg0: &mut vector<u8>) : u64 {
        assert!(0x1::vector::length<u8>(arg0) >= 8, 5);
        let v0 = 0;
        let v1 = 1;
        let v2 = 0;
        while (v0 < 8) {
            v2 = v2 + (0x1::vector::pop_back<u8>(arg0) as u64) * v1;
            v0 = v0 + 1;
            v1 = v1 * 255;
        };
        v2
    }

    public fun token_metadata(arg0: u64, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String) : TokenMetadata {
        TokenMetadata{
            id       : arg0,
            name     : arg1,
            rating   : arg2,
            position : arg3,
            nation   : arg4,
        }
    }

    public fun update_conf(arg0: &mut AifrensSuperstarGlobal, arg1: u64, arg2: u64, arg3: vector<u64>, arg4: bool, arg5: &AdminCap) {
        arg0.start_time_ms = arg1;
        arg0.expired_time_ms = arg2;
        arg0.paused = arg4;
        arg0.rarity_rate = arg3;
    }

    public fun update_latest_price_feed<T0>(arg0: &mut PriceGlobal<T0>, arg1: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator) {
        let v0 = 0x414abb429e44ddff03fe84d407ea3985c93fe55bd3ed79a8e2e57f50daf2e21c::comparator::compare_u8_vector(arg0.feed_id_bytes, 0x2::object::id_bytes<0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator>(arg1));
        assert!(0x414abb429e44ddff03fe84d407ea3985c93fe55bd3ed79a8e2e57f50daf2e21c::comparator::is_equal(&v0), 6);
        arg0.sui_price = get_price_from_feed(arg1);
    }

    public fun update_price<T0>(arg0: &mut PriceGlobal<T0>, arg1: u64, arg2: u64, arg3: &AdminCap) {
        arg0.fusion_price = arg1;
        arg0.recruit_price = arg2;
        arg0.feed_id_bytes = 0x1::vector::empty<u8>();
        arg0.sui_price = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::zero();
    }

    public fun update_usd_price<T0>(arg0: &mut PriceGlobal<T0>, arg1: u64, arg2: u64, arg3: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg4: &AdminCap) {
        arg0.fusion_price = arg1;
        arg0.recruit_price = arg2;
        arg0.feed_id_bytes = 0x2::object::id_bytes<0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator>(arg3);
        arg0.sui_price = get_price_from_feed(arg3);
    }

    // decompiled from Move bytecode v6
}

