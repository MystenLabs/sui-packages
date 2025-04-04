module 0xbed1f77238648e670f9e4c2ead857a8fbcfb6bf4e7fc086ecf7436371b24e4ae::aifrens_footie_superstar {
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

    struct BullsharkMinted has key {
        id: 0x2::object::UID,
        minted: 0x2::table::Table<0x2::object::ID, bool>,
        start_time_ms: u64,
        expired_time_ms: u64,
    }

    struct AuthorizedMinted has key {
        id: 0x2::object::UID,
        minted: 0x2::table::Table<u64, address>,
        authorize_pk: vector<u8>,
    }

    struct PackageMinted<phantom T0> has key {
        id: 0x2::object::UID,
        minted: 0x2::table::Table<address, u64>,
        rates: vector<vector<u64>>,
        price: u64,
        start_time_ms: u64,
        expired_time_ms: u64,
    }

    struct ReferralSystem has key {
        id: 0x2::object::UID,
        invitees: 0x2::table::Table<address, u64>,
        tier_thres: vector<u64>,
        shares: vector<u64>,
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

    struct AuthorizedMintEvent has copy, drop {
        id: 0x2::object::ID,
        nonce: u64,
        creator: address,
    }

    struct ReferralEvent has copy, drop {
        amount: u64,
        referrer: address,
    }

    public entry fun withdraw_all<T0>(arg0: &mut PriceGlobal<T0>, arg1: address, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance), arg3), arg1);
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

    public fun birthdate(arg0: &AifrensFootieSuperstar) : u64 {
        arg0.birthdate
    }

    public fun genes(arg0: &AifrensFootieSuperstar) : vector<u8> {
        arg0.genes
    }

    public entry fun authorized_mint(arg0: &AifrensSuperstarGlobal, arg1: &AifrensSeason, arg2: &mut AuthorizedMinted, arg3: u64, arg4: vector<u64>, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 3);
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(!0x2::table::contains<u64, address>(&arg2.minted, arg3), 8);
        0x2::table::add<u64, address>(&mut arg2.minted, arg3, v0);
        let v1 = 0x1::bcs::to_bytes<address>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<vector<u64>>(&arg4));
        0x1::vector::append<u8>(&mut v1, arg5);
        assert!(0x2::ed25519::ed25519_verify(&arg6, &arg2.authorize_pk, &v1), 9);
        let v2 = mint_token(arg1, arg7, 0x2::clock::timestamp_ms(arg7), get_random_vector(arg7, v0, v1), 0x1::string::utf8(arg8), arg4, arg9);
        let v3 = AuthorizedMintEvent{
            id      : 0x2::object::uid_to_inner(&v2.id),
            nonce   : arg3,
            creator : v0,
        };
        0x2::event::emit<AuthorizedMintEvent>(v3);
        0x2::transfer::public_transfer<AifrensFootieSuperstar>(v2, 0x2::tx_context::sender(arg9));
    }

    public entry fun bullshark_mint(arg0: &AifrensSuperstarGlobal, arg1: &AifrensSeason, arg2: &mut BullsharkMinted, arg3: &0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 3);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(v0 > arg2.start_time_ms, 1);
        assert!(v0 < arg2.expired_time_ms, 2);
        0x2::kiosk::borrow<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::bullshark::Bullshark>>(arg3, arg4, arg5);
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg2.minted, arg5), 7);
        0x2::table::add<0x2::object::ID, bool>(&mut arg2.minted, arg5, true);
        let v1 = get_random_vector(arg6, 0x2::tx_context::sender(arg8), b"bullshark");
        let v2 = mint_token(arg1, arg6, v0, v1, 0x1::string::utf8(arg7), vector[99, 1, 0, 0], arg8);
        0x2::transfer::public_transfer<AifrensFootieSuperstar>(v2, 0x2::tx_context::sender(arg8));
    }

    public fun create_authorized_minted(arg0: &AdminCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AuthorizedMinted{
            id           : 0x2::object::new(arg2),
            minted       : 0x2::table::new<u64, address>(arg2),
            authorize_pk : arg1,
        };
        0x2::transfer::share_object<AuthorizedMinted>(v0);
    }

    public fun create_mint_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : MintCap {
        MintCap{id: 0x2::object::new(arg1)}
    }

    public fun create_package_minted<T0>(arg0: &AdminCap, arg1: vector<vector<u64>>, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = PackageMinted<T0>{
            id              : 0x2::object::new(arg5),
            minted          : 0x2::table::new<address, u64>(arg5),
            rates           : arg1,
            price           : arg2,
            start_time_ms   : arg3,
            expired_time_ms : arg4,
        };
        0x2::transfer::share_object<PackageMinted<T0>>(v0);
    }

    public entry fun fusion<T0>(arg0: &mut AifrensSuperstarGlobal, arg1: &mut PriceGlobal<T0>, arg2: &AifrensSeason, arg3: &0x2::clock::Clock, arg4: &mut 0x2::coin::Coin<T0>, arg5: u64, arg6: 0x6c830e5e4d2a083c77a0020c12b645b1647d2835170f9eab422e5ffb5cad6d44::aifrens_footie_legends::AifrensGenesis, arg7: 0x6c830e5e4d2a083c77a0020c12b645b1647d2835170f9eab422e5ffb5cad6d44::aifrens_footie_legends::AifrensGenesis, arg8: vector<0x5609295085042153b81e7453ee0eba7f173cc66d05d388e636e03a7d927b7368::aifrens_lol::AifrensLol>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 3);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 > arg0.start_time_ms, 1);
        assert!(v0 < arg0.expired_time_ms, 2);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg4, get_final_price<T0>(arg1.fusion_price, arg1) + arg5, arg9)));
        let v1 = 0x1::vector::length<0x5609295085042153b81e7453ee0eba7f173cc66d05d388e636e03a7d927b7368::aifrens_lol::AifrensLol>(&arg8);
        let v2 = 0;
        while (v2 < v1) {
            0x5609295085042153b81e7453ee0eba7f173cc66d05d388e636e03a7d927b7368::aifrens_lol::burn_token(0x1::vector::pop_back<0x5609295085042153b81e7453ee0eba7f173cc66d05d388e636e03a7d927b7368::aifrens_lol::AifrensLol>(&mut arg8));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x5609295085042153b81e7453ee0eba7f173cc66d05d388e636e03a7d927b7368::aifrens_lol::AifrensLol>(arg8);
        0x6c830e5e4d2a083c77a0020c12b645b1647d2835170f9eab422e5ffb5cad6d44::aifrens_footie_legends::burn_token(arg6);
        0x6c830e5e4d2a083c77a0020c12b645b1647d2835170f9eab422e5ffb5cad6d44::aifrens_footie_legends::burn_token(arg7);
        let v3 = mint_token(arg2, arg3, 0x6c830e5e4d2a083c77a0020c12b645b1647d2835170f9eab422e5ffb5cad6d44::aifrens_footie_legends::birthdate(&arg6), 0x6c830e5e4d2a083c77a0020c12b645b1647d2835170f9eab422e5ffb5cad6d44::aifrens_footie_legends::genes(&arg6), 0x6c830e5e4d2a083c77a0020c12b645b1647d2835170f9eab422e5ffb5cad6d44::aifrens_footie_legends::birth_location(&arg6), get_rate(arg0, arg5, v1), arg9);
        0x2::transfer::public_transfer<AifrensFootieSuperstar>(v3, 0x2::tx_context::sender(arg9));
    }

    public fun fusion_ref<T0>(arg0: &mut AifrensSuperstarGlobal, arg1: &mut PriceGlobal<T0>, arg2: &AifrensSeason, arg3: &0x2::clock::Clock, arg4: &mut 0x2::coin::Coin<T0>, arg5: u64, arg6: 0x6c830e5e4d2a083c77a0020c12b645b1647d2835170f9eab422e5ffb5cad6d44::aifrens_footie_legends::AifrensGenesis, arg7: 0x6c830e5e4d2a083c77a0020c12b645b1647d2835170f9eab422e5ffb5cad6d44::aifrens_footie_legends::AifrensGenesis, arg8: vector<0x5609295085042153b81e7453ee0eba7f173cc66d05d388e636e03a7d927b7368::aifrens_lol::AifrensLol>, arg9: address, arg10: &mut ReferralSystem, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 3);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 > arg0.start_time_ms, 1);
        assert!(v0 < arg0.expired_time_ms, 2);
        let v1 = get_final_price<T0>(arg1.fusion_price, arg1);
        let v2 = v1 * get_ref_share(arg10) / 100;
        if (!0x2::table::contains<address, u64>(&arg10.invitees, arg9)) {
            0x2::table::add<address, u64>(&mut arg10.invitees, arg9, 1);
        } else {
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg10.invitees, arg9);
            *v3 = *v3 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg4, v2, arg11), arg9);
        let v4 = ReferralEvent{
            amount   : v2,
            referrer : arg9,
        };
        0x2::event::emit<ReferralEvent>(v4);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg4, v1 - v2, arg11)));
        let v5 = 0x1::vector::length<0x5609295085042153b81e7453ee0eba7f173cc66d05d388e636e03a7d927b7368::aifrens_lol::AifrensLol>(&arg8);
        let v6 = 0;
        while (v6 < v5) {
            0x5609295085042153b81e7453ee0eba7f173cc66d05d388e636e03a7d927b7368::aifrens_lol::burn_token(0x1::vector::pop_back<0x5609295085042153b81e7453ee0eba7f173cc66d05d388e636e03a7d927b7368::aifrens_lol::AifrensLol>(&mut arg8));
            v6 = v6 + 1;
        };
        0x1::vector::destroy_empty<0x5609295085042153b81e7453ee0eba7f173cc66d05d388e636e03a7d927b7368::aifrens_lol::AifrensLol>(arg8);
        0x6c830e5e4d2a083c77a0020c12b645b1647d2835170f9eab422e5ffb5cad6d44::aifrens_footie_legends::burn_token(arg6);
        0x6c830e5e4d2a083c77a0020c12b645b1647d2835170f9eab422e5ffb5cad6d44::aifrens_footie_legends::burn_token(arg7);
        let v7 = mint_token(arg2, arg3, 0x6c830e5e4d2a083c77a0020c12b645b1647d2835170f9eab422e5ffb5cad6d44::aifrens_footie_legends::birthdate(&arg6), 0x6c830e5e4d2a083c77a0020c12b645b1647d2835170f9eab422e5ffb5cad6d44::aifrens_footie_legends::genes(&arg6), 0x6c830e5e4d2a083c77a0020c12b645b1647d2835170f9eab422e5ffb5cad6d44::aifrens_footie_legends::birth_location(&arg6), get_rate(arg0, arg5, v5), arg11);
        0x2::transfer::public_transfer<AifrensFootieSuperstar>(v7, 0x2::tx_context::sender(arg11));
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

    fun get_ref_share(arg0: &ReferralSystem) : u64 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.tier_thres) && 0x2::table::length<address, u64>(&arg0.invitees) >= v1) {
            v1 = *0x1::vector::borrow<u64>(&arg0.tier_thres, v0);
            v2 = *0x1::vector::borrow<u64>(&arg0.shares, v0);
            v0 = v0 + 1;
        };
        v2
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

    public fun init_bullshark_mint(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BullsharkMinted{
            id              : 0x2::object::new(arg1),
            minted          : 0x2::table::new<0x2::object::ID, bool>(arg1),
            start_time_ms   : 0,
            expired_time_ms : 18446744073709551615,
        };
        0x2::transfer::share_object<BullsharkMinted>(v0);
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

    public fun new_referral_system(arg0: vector<u64>, arg1: vector<u64>, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg0) == 0x1::vector::length<u64>(&arg1), 10);
        let v0 = ReferralSystem{
            id         : 0x2::object::new(arg3),
            invitees   : 0x2::table::new<address, u64>(arg3),
            tier_thres : arg0,
            shares     : arg1,
        };
        0x2::transfer::share_object<ReferralSystem>(v0);
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

    public entry fun package_mint<T0>(arg0: &AifrensSuperstarGlobal, arg1: &mut PriceGlobal<T0>, arg2: &AifrensSeason, arg3: &mut PackageMinted<T0>, arg4: &mut 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 3);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(v0 > arg3.start_time_ms, 1);
        assert!(v0 < arg3.expired_time_ms, 2);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg4, get_final_price<T0>(arg3.price, arg1), arg7)));
        let v1 = 0x2::tx_context::sender(arg7);
        if (!0x2::table::contains<address, u64>(&arg3.minted, v1)) {
            0x2::table::add<address, u64>(&mut arg3.minted, v1, 1);
        } else {
            let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg3.minted, v1);
            *v2 = *v2 + 1;
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<vector<u64>>(&arg3.rates)) {
            let v4 = mint_token(arg2, arg5, v0, get_random_vector(arg5, v1, 0x1::bcs::to_bytes<u64>(&v3)), 0x1::string::utf8(arg6), *0x1::vector::borrow<vector<u64>>(&arg3.rates, v3), arg7);
            0x2::transfer::public_transfer<AifrensFootieSuperstar>(v4, 0x2::tx_context::sender(arg7));
            v3 = v3 + 1;
        };
    }

    public fun package_mint_ref<T0>(arg0: &AifrensSuperstarGlobal, arg1: &mut PriceGlobal<T0>, arg2: &AifrensSeason, arg3: &mut PackageMinted<T0>, arg4: &mut 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: vector<u8>, arg7: address, arg8: &mut ReferralSystem, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 3);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(v0 > arg3.start_time_ms, 1);
        assert!(v0 < arg3.expired_time_ms, 2);
        let v1 = get_final_price<T0>(arg3.price, arg1);
        let v2 = v1 * get_ref_share(arg8) / 100;
        if (!0x2::table::contains<address, u64>(&arg8.invitees, arg7)) {
            0x2::table::add<address, u64>(&mut arg8.invitees, arg7, 1);
        } else {
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg8.invitees, arg7);
            *v3 = *v3 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg4, v2, arg9), arg7);
        let v4 = ReferralEvent{
            amount   : v2,
            referrer : arg7,
        };
        0x2::event::emit<ReferralEvent>(v4);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg4, v1 - v2, arg9)));
        let v5 = 0x2::tx_context::sender(arg9);
        if (!0x2::table::contains<address, u64>(&arg3.minted, v5)) {
            0x2::table::add<address, u64>(&mut arg3.minted, v5, 1);
        } else {
            let v6 = 0x2::table::borrow_mut<address, u64>(&mut arg3.minted, v5);
            *v6 = *v6 + 1;
        };
        let v7 = 0;
        while (v7 < 0x1::vector::length<vector<u64>>(&arg3.rates)) {
            let v8 = mint_token(arg2, arg5, v0, get_random_vector(arg5, v5, 0x1::bcs::to_bytes<u64>(&v7)), 0x1::string::utf8(arg6), *0x1::vector::borrow<vector<u64>>(&arg3.rates, v7), arg9);
            0x2::transfer::public_transfer<AifrensFootieSuperstar>(v8, 0x2::tx_context::sender(arg9));
            v7 = v7 + 1;
        };
    }

    public fun position(arg0: &AifrensFootieSuperstar) : 0x1::string::String {
        arg0.position
    }

    public fun rarity(arg0: &AifrensFootieSuperstar) : 0x1::string::String {
        arg0.rarity
    }

    public entry fun recruit<T0>(arg0: &mut AifrensSuperstarGlobal, arg1: &mut PriceGlobal<T0>, arg2: &AifrensSeason, arg3: &0x2::clock::Clock, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::coin::Coin<T0>, arg7: u64, arg8: vector<0x5609295085042153b81e7453ee0eba7f173cc66d05d388e636e03a7d927b7368::aifrens_lol::AifrensLol>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 3);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 > arg0.start_time_ms, 1);
        assert!(v0 < arg0.expired_time_ms, 2);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg6, get_final_price<T0>(arg1.recruit_price, arg1), arg9)));
        let v1 = get_random_vector(arg3, 0x2::tx_context::sender(arg9), arg4);
        let v2 = 0x1::vector::length<0x5609295085042153b81e7453ee0eba7f173cc66d05d388e636e03a7d927b7368::aifrens_lol::AifrensLol>(&arg8);
        let v3 = 0;
        while (v3 < v2) {
            0x5609295085042153b81e7453ee0eba7f173cc66d05d388e636e03a7d927b7368::aifrens_lol::burn_token(0x1::vector::pop_back<0x5609295085042153b81e7453ee0eba7f173cc66d05d388e636e03a7d927b7368::aifrens_lol::AifrensLol>(&mut arg8));
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0x5609295085042153b81e7453ee0eba7f173cc66d05d388e636e03a7d927b7368::aifrens_lol::AifrensLol>(arg8);
        let v4 = mint_token(arg2, arg3, v0, v1, 0x1::string::utf8(arg5), get_rate(arg0, arg7, v2), arg9);
        0x2::transfer::public_transfer<AifrensFootieSuperstar>(v4, 0x2::tx_context::sender(arg9));
    }

    public fun recruit_ref<T0>(arg0: &mut AifrensSuperstarGlobal, arg1: &mut PriceGlobal<T0>, arg2: &AifrensSeason, arg3: &0x2::clock::Clock, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::coin::Coin<T0>, arg7: u64, arg8: vector<0x5609295085042153b81e7453ee0eba7f173cc66d05d388e636e03a7d927b7368::aifrens_lol::AifrensLol>, arg9: address, arg10: &mut ReferralSystem, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 3);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 > arg0.start_time_ms, 1);
        assert!(v0 < arg0.expired_time_ms, 2);
        let v1 = get_final_price<T0>(arg1.recruit_price, arg1);
        let v2 = v1 * get_ref_share(arg10) / 100;
        if (!0x2::table::contains<address, u64>(&arg10.invitees, arg9)) {
            0x2::table::add<address, u64>(&mut arg10.invitees, arg9, 1);
        } else {
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg10.invitees, arg9);
            *v3 = *v3 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg6, v2, arg11), arg9);
        let v4 = ReferralEvent{
            amount   : v2,
            referrer : arg9,
        };
        0x2::event::emit<ReferralEvent>(v4);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg6, v1 - v2, arg11)));
        let v5 = get_random_vector(arg3, 0x2::tx_context::sender(arg11), arg4);
        let v6 = 0x1::vector::length<0x5609295085042153b81e7453ee0eba7f173cc66d05d388e636e03a7d927b7368::aifrens_lol::AifrensLol>(&arg8);
        let v7 = 0;
        while (v7 < v6) {
            0x5609295085042153b81e7453ee0eba7f173cc66d05d388e636e03a7d927b7368::aifrens_lol::burn_token(0x1::vector::pop_back<0x5609295085042153b81e7453ee0eba7f173cc66d05d388e636e03a7d927b7368::aifrens_lol::AifrensLol>(&mut arg8));
            v7 = v7 + 1;
        };
        0x1::vector::destroy_empty<0x5609295085042153b81e7453ee0eba7f173cc66d05d388e636e03a7d927b7368::aifrens_lol::AifrensLol>(arg8);
        let v8 = mint_token(arg2, arg3, v0, v5, 0x1::string::utf8(arg5), get_rate(arg0, arg7, v6), arg11);
        0x2::transfer::public_transfer<AifrensFootieSuperstar>(v8, 0x2::tx_context::sender(arg11));
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

    public fun update_authorize_pk(arg0: &mut AuthorizedMinted, arg1: &AdminCap, arg2: vector<u8>) {
        arg0.authorize_pk = arg2;
    }

    public fun update_bullshark_conf(arg0: &mut BullsharkMinted, arg1: u64, arg2: u64, arg3: &AdminCap) {
        arg0.start_time_ms = arg1;
        arg0.expired_time_ms = arg2;
    }

    public fun update_conf(arg0: &mut AifrensSuperstarGlobal, arg1: u64, arg2: u64, arg3: vector<u64>, arg4: bool, arg5: &AdminCap) {
        arg0.start_time_ms = arg1;
        arg0.expired_time_ms = arg2;
        arg0.paused = arg4;
        arg0.rarity_rate = arg3;
    }

    public fun update_latest_price_feed<T0>(arg0: &mut PriceGlobal<T0>, arg1: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator) {
        let v0 = 0xbed1f77238648e670f9e4c2ead857a8fbcfb6bf4e7fc086ecf7436371b24e4ae::comparator::compare_u8_vector(arg0.feed_id_bytes, 0x2::object::id_bytes<0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator>(arg1));
        assert!(0xbed1f77238648e670f9e4c2ead857a8fbcfb6bf4e7fc086ecf7436371b24e4ae::comparator::is_equal(&v0), 6);
        arg0.sui_price = get_price_from_feed(arg1);
    }

    public fun update_package_minted<T0>(arg0: &mut PackageMinted<T0>, arg1: &AdminCap, arg2: vector<vector<u64>>, arg3: u64, arg4: u64, arg5: u64) {
        arg0.rates = arg2;
        arg0.price = arg3;
        arg0.start_time_ms = arg4;
        arg0.expired_time_ms = arg5;
    }

    public fun update_price<T0>(arg0: &mut PriceGlobal<T0>, arg1: u64, arg2: u64, arg3: &AdminCap) {
        arg0.fusion_price = arg1;
        arg0.recruit_price = arg2;
        arg0.feed_id_bytes = 0x1::vector::empty<u8>();
        arg0.sui_price = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::zero();
    }

    public fun update_referral_share(arg0: &mut ReferralSystem, arg1: vector<u64>, arg2: vector<u64>, arg3: &AdminCap) {
        arg0.tier_thres = arg1;
        arg0.shares = arg2;
    }

    public fun update_usd_price<T0>(arg0: &mut PriceGlobal<T0>, arg1: u64, arg2: u64, arg3: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg4: &AdminCap) {
        arg0.fusion_price = arg1;
        arg0.recruit_price = arg2;
        arg0.feed_id_bytes = 0x2::object::id_bytes<0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator>(arg3);
        arg0.sui_price = get_price_from_feed(arg3);
    }

    // decompiled from Move bytecode v6
}

