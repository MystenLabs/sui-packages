module 0xd691896f2ff416a8fa4792ee30895b28d71cf8bb8291f6f222a66d3e47b2c1c7::collection {
    struct COLLECTION has drop {
        dummy_field: bool,
    }

    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        not_transferable: bool,
    }

    struct CollectionInfo has copy, drop, store {
        creator: address,
        mint_price: u64,
        whitelist_mint_price: u64,
        is_sui: bool,
        transferable: bool,
        royalty_receiver: address,
        collection_expires: u64,
    }

    struct Collection<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        symbol: 0x1::string::String,
        image_url: 0x2::url::Url,
        supply: u64,
        total_supply: u64,
        policy: address,
        policy_cap: 0x2::transfer_policy::TransferPolicyCap<BelongNFT<T0>>,
        royalty: u16,
        referral: 0x1::option::Option<0xd691896f2ff416a8fa4792ee30895b28d71cf8bb8291f6f222a66d3e47b2c1c7::referrals::Referral>,
        info: CollectionInfo,
    }

    struct CreatorCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct BelongNFT<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        link: 0x2::url::Url,
        image_url: 0x2::url::Url,
    }

    struct PublisherWrapper has store, key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
    }

    struct CollectionCreated has copy, drop {
        collection_address: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
    }

    struct Mint has copy, drop {
        collection: 0x1::string::String,
        nft_address: address,
    }

    struct MintPriceUpdated has copy, drop {
        collection: address,
        mint_price: u64,
        whitelist_mint_price: u64,
    }

    fun add_collection_display<T0: drop>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"symbol"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{symbol}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{info.creator}"));
        let v4 = 0x2::display::new_with_fields<Collection<T0>>(arg0, v0, v2, arg1);
        0x2::display::update_version<Collection<T0>>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<Collection<T0>>>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun create<T0: drop>(arg0: T0, arg1: 0xd691896f2ff416a8fa4792ee30895b28d71cf8bb8291f6f222a66d3e47b2c1c7::factory::CollectionCap, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: &PublisherWrapper, arg9: 0x1::option::Option<vector<u8>>, arg10: &mut 0xd691896f2ff416a8fa4792ee30895b28d71cf8bb8291f6f222a66d3e47b2c1c7::referrals::ReferralTable, arg11: &mut 0xd691896f2ff416a8fa4792ee30895b28d71cf8bb8291f6f222a66d3e47b2c1c7::collection_storage::State, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg12);
        let (v1, v2, v3, v4, v5, v6) = 0xd691896f2ff416a8fa4792ee30895b28d71cf8bb8291f6f222a66d3e47b2c1c7::factory::destroy_collection_cap(arg1);
        let (v7, v8) = 0x2::transfer_policy::new<BelongNFT<T0>>(&arg8.publisher, arg12);
        let v9 = v8;
        let v10 = v7;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<BelongNFT<T0>>(&mut v10, &v9, v5, 0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<BelongNFT<T0>>(&mut v10, &v9);
        if (!arg5) {
            let v11 = Rule{dummy_field: false};
            let v12 = Config{not_transferable: true};
            0x2::transfer_policy::add_rule<BelongNFT<T0>, Rule, Config>(v11, &mut v10, &v9, v12);
        };
        let v13 = 0x1::option::none<0xd691896f2ff416a8fa4792ee30895b28d71cf8bb8291f6f222a66d3e47b2c1c7::referrals::Referral>();
        if (0x1::option::is_some<vector<u8>>(&arg9)) {
            0x1::option::fill<0xd691896f2ff416a8fa4792ee30895b28d71cf8bb8291f6f222a66d3e47b2c1c7::referrals::Referral>(&mut v13, 0xd691896f2ff416a8fa4792ee30895b28d71cf8bb8291f6f222a66d3e47b2c1c7::referrals::use_referral(arg10, 0x1::option::destroy_some<vector<u8>>(arg9)));
        };
        add_collection_display<T0>(&arg8.publisher, arg12);
        let v14 = CollectionInfo{
            creator              : v0,
            mint_price           : arg2,
            whitelist_mint_price : arg3,
            is_sui               : arg4,
            transferable         : arg5,
            royalty_receiver     : v6,
            collection_expires   : arg7,
        };
        let v15 = Collection<T0>{
            id           : 0x2::object::new(arg12),
            name         : v1,
            description  : v2,
            symbol       : v3,
            image_url    : v4,
            supply       : 0,
            total_supply : arg6,
            policy       : 0x2::object::id_address<0x2::transfer_policy::TransferPolicy<BelongNFT<T0>>>(&v10),
            policy_cap   : v9,
            royalty      : v5,
            referral     : v13,
            info         : v14,
        };
        0xd691896f2ff416a8fa4792ee30895b28d71cf8bb8291f6f222a66d3e47b2c1c7::collection_storage::add(0x2::object::id_address<Collection<T0>>(&v15), v1, v3, v0, arg11);
        let v16 = CollectionCreated{
            collection_address : 0x2::object::id_address<Collection<T0>>(&v15),
            name               : v1,
            symbol             : v3,
        };
        0x2::event::emit<CollectionCreated>(v16);
        0x2::transfer::share_object<Collection<T0>>(v15);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<BelongNFT<T0>>>(v10);
        let v17 = CreatorCap<T0>{id: 0x2::object::new(arg12)};
        0x2::transfer::public_transfer<CreatorCap<T0>>(v17, 0x2::tx_context::sender(arg12));
    }

    public(friend) fun get_mint_price<T0: drop>(arg0: &Collection<T0>, arg1: bool) : u64 {
        if (arg1) {
            return arg0.info.whitelist_mint_price
        };
        arg0.info.mint_price
    }

    public(friend) fun get_policy_cap<T0: drop>(arg0: &Collection<T0>) : &0x2::transfer_policy::TransferPolicyCap<BelongNFT<T0>> {
        &arg0.policy_cap
    }

    public(friend) fun get_royalty_receiver<T0: drop>(arg0: &Collection<T0>) : address {
        arg0.info.royalty_receiver
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PublisherWrapper{
            id        : 0x2::object::new(arg1),
            publisher : 0x2::package::claim<COLLECTION>(arg0, arg1),
        };
        0x2::transfer::share_object<PublisherWrapper>(v0);
    }

    public entry fun mint_nft<T0: drop, T1: drop>(arg0: 0xd691896f2ff416a8fa4792ee30895b28d71cf8bb8291f6f222a66d3e47b2c1c7::factory::MintCap<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &mut Collection<T0>, arg5: &0x2::transfer_policy::TransferPolicy<BelongNFT<T0>>, arg6: &0xd691896f2ff416a8fa4792ee30895b28d71cf8bb8291f6f222a66d3e47b2c1c7::factory::State, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg4.info.is_sui) {
            assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())) == 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<0x2::sui::SUI>())), 2);
        } else {
            assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())) == b"a1ec7fc00a6f40db9693ad1415d0c193ad3906494428cf252621037bd7117e29::usdc::USDC", 2);
        };
        assert!(arg4.total_supply >= arg4.supply + 1, 0);
        let (v0, v1, v2, v3, v4) = 0xd691896f2ff416a8fa4792ee30895b28d71cf8bb8291f6f222a66d3e47b2c1c7::factory::use_mint_cap<T0>(arg0, arg7);
        let v5 = get_mint_price<T0>(arg4, v4);
        let v6 = (((v5 as u128) * (0xd691896f2ff416a8fa4792ee30895b28d71cf8bb8291f6f222a66d3e47b2c1c7::factory::get_platform_commission(arg6) as u128) / 10000) as u64);
        assert!(0x2::coin::value<T1>(&arg1) == v5 + v6, 1);
        let (v7, v8) = 0xd691896f2ff416a8fa4792ee30895b28d71cf8bb8291f6f222a66d3e47b2c1c7::referrals::calculate_referrals(arg4.referral, v6);
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg1, v7, arg7), v8);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg1, v5, arg7), arg4.info.creator);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, 0xd691896f2ff416a8fa4792ee30895b28d71cf8bb8291f6f222a66d3e47b2c1c7::factory::get_platform_address(arg6));
        arg4.supply = arg4.supply + 1;
        let v9 = BelongNFT<T0>{
            id          : 0x2::object::new(arg7),
            name        : v0,
            description : v1,
            link        : v2,
            image_url   : v3,
        };
        let v10 = Mint{
            collection  : arg4.name,
            nft_address : 0x2::object::id_address<BelongNFT<T0>>(&v9),
        };
        0x2::event::emit<Mint>(v10);
        0x2::kiosk::lock<BelongNFT<T0>>(arg2, arg3, arg5, v9);
    }

    public entry fun update_mint_price<T0: drop>(arg0: &CreatorCap<T0>, arg1: &mut Collection<T0>, arg2: u64, arg3: u64) {
        arg1.info.mint_price = arg2;
        arg1.info.whitelist_mint_price = arg3;
        let v0 = MintPriceUpdated{
            collection           : 0x2::object::id_address<Collection<T0>>(arg1),
            mint_price           : arg2,
            whitelist_mint_price : arg3,
        };
        0x2::event::emit<MintPriceUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

