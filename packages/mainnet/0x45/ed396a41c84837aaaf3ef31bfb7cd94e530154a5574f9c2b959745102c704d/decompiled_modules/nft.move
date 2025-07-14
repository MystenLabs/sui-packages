module 0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct OGNFTPreSale has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        project_url: 0x1::string::String,
        description: 0x1::string::String,
        creator: 0x1::string::String,
        price_info: PriceInfo,
        lockup_period: 0x1::option::Option<u64>,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct NFTInfo has key {
        id: 0x2::object::UID,
        nfts_of_user: 0x2::table::Table<address, vector<address>>,
        is_sox_claimed: 0x2::table::Table<address, bool>,
        user_tier_counts: 0x2::table::Table<address, 0x2::table::Table<0x1::string::String, u64>>,
        total_tier_counts: 0x2::table::Table<0x1::string::String, u64>,
    }

    struct TierInfo has key {
        id: 0x2::object::UID,
        tier_list: 0x2::table::Table<0x1::string::String, Tier>,
    }

    struct Tier has drop, store {
        tier_name: 0x1::string::String,
        nft_name: 0x1::string::String,
        nft_description: 0x1::string::String,
        nft_image_url: 0x1::string::String,
        price_info: PriceInfo,
        user_limit: 0x1::option::Option<u64>,
        total_limit: 0x1::option::Option<u64>,
        lockup_period: 0x1::option::Option<u64>,
        current_number: u64,
    }

    struct PriceInfo has copy, drop, store {
        price: u64,
        sox_provide_amount: u64,
        drachma_provide_amount: u64,
    }

    struct TierCreated has copy, drop {
        tier_name: 0x1::string::String,
        price_info: PriceInfo,
        user_limit: 0x1::option::Option<u64>,
        total_limit: 0x1::option::Option<u64>,
    }

    struct NFTMinted has copy, drop {
        nft_id: address,
        recipient: address,
        tier: 0x1::string::String,
    }

    struct NFTBurned has copy, drop {
        nft_id: address,
        owner: address,
        tier: 0x1::string::String,
    }

    public fun attribute_keys(arg0: &OGNFTPreSale) : vector<0x1::string::String> {
        0x2::vec_map::keys<0x1::string::String, 0x1::string::String>(&arg0.attributes)
    }

    public fun attribute_value(arg0: &OGNFTPreSale, arg1: 0x1::string::String) : 0x1::string::String {
        *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg0.attributes, &arg1)
    }

    public fun attributes(arg0: &OGNFTPreSale) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    public fun burn(arg0: OGNFTPreSale, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"tier");
        let OGNFTPreSale {
            id            : v1,
            name          : _,
            image_url     : _,
            project_url   : _,
            description   : _,
            creator       : _,
            price_info    : _,
            lockup_period : _,
            attributes    : _,
        } = arg0;
        let v10 = v1;
        let v11 = NFTBurned{
            nft_id : 0x2::object::uid_to_address(&v10),
            owner  : 0x2::tx_context::sender(arg1),
            tier   : *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0),
        };
        0x2::object::delete(v10);
        0x2::event::emit<NFTBurned>(v11);
    }

    public fun check_tier_exists(arg0: &TierInfo, arg1: 0x1::string::String) {
        assert!(is_tier_exists(arg0, arg1), 204);
    }

    public entry fun claim_sox(arg0: &mut OGNFTPreSale, arg1: &mut NFTInfo) {
        let v0 = 0x2::table::borrow_mut<address, bool>(&mut arg1.is_sox_claimed, 0x2::object::uid_to_address(&arg0.id));
        assert!(!*v0, 200);
        *v0 = true;
    }

    public fun creator(arg0: &OGNFTPreSale) : 0x1::string::String {
        arg0.creator
    }

    public fun description(arg0: &OGNFTPreSale) : 0x1::string::String {
        arg0.description
    }

    public fun drachma_provide_amount(arg0: &OGNFTPreSale) : u64 {
        arg0.price_info.drachma_provide_amount
    }

    public fun drachma_provide_amount_of_tier(arg0: &TierInfo, arg1: 0x1::string::String) : u64 {
        check_tier_exists(arg0, arg1);
        0x2::table::borrow<0x1::string::String, Tier>(&arg0.tier_list, arg1).price_info.drachma_provide_amount
    }

    public fun get_remaining_tier_count(arg0: &TierInfo, arg1: 0x1::string::String, arg2: &NFTInfo) : 0x1::option::Option<u64> {
        check_tier_exists(arg0, arg1);
        let v0 = 0x2::table::borrow<0x1::string::String, Tier>(&arg0.tier_list, arg1);
        if (0x1::option::is_some<u64>(&v0.total_limit)) {
            0x1::option::some<u64>(*0x1::option::borrow<u64>(&v0.total_limit) - get_total_tier_count(arg2, arg1))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun get_remaining_user_tier_count(arg0: &TierInfo, arg1: 0x1::string::String, arg2: &NFTInfo, arg3: address) : 0x1::option::Option<u64> {
        check_tier_exists(arg0, arg1);
        let v0 = 0x2::table::borrow<0x1::string::String, Tier>(&arg0.tier_list, arg1);
        if (0x1::option::is_some<u64>(&v0.user_limit)) {
            0x1::option::some<u64>(*0x1::option::borrow<u64>(&v0.user_limit) - get_user_tier_count(arg2, arg3, arg1))
        } else {
            get_remaining_tier_count(arg0, arg1, arg2)
        }
    }

    public fun get_tier_info(arg0: &TierInfo, arg1: 0x1::string::String, arg2: &NFTInfo) : (u64, 0x1::option::Option<u64>, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, u64, u64, u64, u64) {
        (price_of_tier(arg0, arg1), get_remaining_tier_count(arg0, arg1, arg2), name_of_tier(arg0, arg1), nft_name_of_tier(arg0, arg1), nft_description_of_tier(arg0, arg1), nft_image_url_of_tier(arg0, arg1), sox_provide_amount_of_tier(arg0, arg1), drachma_provide_amount_of_tier(arg0, arg1), user_limit_of_tier(arg0, arg1), total_limit_of_tier(arg0, arg1))
    }

    public fun get_total_tier_count(arg0: &NFTInfo, arg1: 0x1::string::String) : u64 {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.total_tier_counts, arg1)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.total_tier_counts, arg1)
        } else {
            0
        }
    }

    public fun get_user_tier_count(arg0: &NFTInfo, arg1: address, arg2: 0x1::string::String) : u64 {
        if (0x2::table::contains<address, 0x2::table::Table<0x1::string::String, u64>>(&arg0.user_tier_counts, arg1)) {
            let v1 = 0x2::table::borrow<address, 0x2::table::Table<0x1::string::String, u64>>(&arg0.user_tier_counts, arg1);
            if (0x2::table::contains<0x1::string::String, u64>(v1, arg2)) {
                *0x2::table::borrow<0x1::string::String, u64>(v1, arg2)
            } else {
                0
            }
        } else {
            0
        }
    }

    public fun get_user_tier_info(arg0: &TierInfo, arg1: 0x1::string::String, arg2: &NFTInfo, arg3: address) : (0x1::option::Option<u64>, u64) {
        (get_remaining_user_tier_count(arg0, arg1, arg2, arg3), get_user_tier_count(arg2, arg3, arg1))
    }

    public fun id(arg0: &OGNFTPreSale) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun image_url(arg0: &OGNFTPreSale) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{project_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Olympian Games"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<OGNFTPreSale>(&v4, v0, v2, arg1);
        0x2::display::update_version<OGNFTPreSale>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<OGNFTPreSale>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = NFTInfo{
            id                : 0x2::object::new(arg1),
            nfts_of_user      : 0x2::table::new<address, vector<address>>(arg1),
            is_sox_claimed    : 0x2::table::new<address, bool>(arg1),
            user_tier_counts  : 0x2::table::new<address, 0x2::table::Table<0x1::string::String, u64>>(arg1),
            total_tier_counts : 0x2::table::new<0x1::string::String, u64>(arg1),
        };
        let v7 = TierInfo{
            id        : 0x2::object::new(arg1),
            tier_list : 0x2::table::new<0x1::string::String, Tier>(arg1),
        };
        let v8 = 0x1::string::utf8(x"5374657020696e746f20746865204f6c796d7069616e2047616d657320756e6976657273652c20776865726520746865206f6666696369616c204e465420697320796f7572206b657920746f206578636c757369766520616476616e74616765732e205468726f756768207468657365204e4654732c20796f75e280997265206e6f74206a75737420616371756972696e672061206469676974616c20636f6c6c65637469626c65e28094796f75e280997265207365637572696e6720612067756172616e7465656420616c6c6f636174696f6e206f6620534f5820746f6b656e732c20736574206173696465206a75737420666f7220796f75206265666f72652074686520546f6b656e2047656e65726174696f6e204576656e742e2054686973206561726c79207265736572766174696f6e20656e737572657320796f75e28099726520706f736974696f6e6564206168656164206f66207468652063726f77642061732074686520706c6174666f726de28099732065636f6e6f6d7920636f6d657320746f206c6966652e");
        let v9 = &mut v7;
        new_tier_internal(v9, 0x1::string::utf8(b"Mythical"), 0x1::string::utf8(b"Apex Predator Jason"), v8, 0x1::string::utf8(b"https://walrus.tusky.io/-pwIgd8baXt-S0j-ryMyTZH8t0TNpuIRtyAnO1QG2Lg"), 5000 * 1000000, 10000 * 1000000000, 1000000 * 1000000000, 0x1::option::none<u64>(), 0x1::option::some<u64>(75), 0x1::option::some<u64>(31536000000));
        let v10 = &mut v7;
        new_tier_internal(v10, 0x1::string::utf8(b"Legendary"), 0x1::string::utf8(b"Savage Jason"), v8, 0x1::string::utf8(b"https://walrus.tusky.io/M-yLlpK352j9t7patI_ejiRhF2hgNgM53WRWpmumTOU"), 1000 * 1000000, 2000 * 1000000000, 180000 * 1000000000, 0x1::option::none<u64>(), 0x1::option::some<u64>(250), 0x1::option::some<u64>(31536000000));
        let v11 = &mut v7;
        new_tier_internal(v11, 0x1::string::utf8(b"Epic"), 0x1::string::utf8(b"Awakened Jason"), v8, 0x1::string::utf8(b"https://walrus.tusky.io/qRpYuFvIkHtdIjxZT93qDDQeVL9XiMOesU3Q7EwkxbI"), 500 * 1000000, 1000 * 1000000000, 80000 * 1000000000, 0x1::option::none<u64>(), 0x1::option::some<u64>(500), 0x1::option::some<u64>(31536000000));
        let v12 = &mut v7;
        new_tier_internal(v12, 0x1::string::utf8(b"Rare"), 0x1::string::utf8(b"Dormant Jason"), v8, 0x1::string::utf8(b"https://walrus.tusky.io/QXa7ruMv6iw8GPbJG7a27hrgGzPPxL5KNegCXtSraDs"), 100 * 1000000, 200 * 1000000000, 14000 * 1000000000, 0x1::option::none<u64>(), 0x1::option::some<u64>(625), 0x1::option::some<u64>(31536000000));
        let v13 = &mut v7;
        new_tier_internal(v13, 0x1::string::utf8(b"Collection"), 0x1::string::utf8(b"OG NFT Pre-Sale"), v8, 0x1::string::utf8(b"https://walrus.tusky.io/f9eh07DY8hkw0tcH6KuNIpZcYhHvDgfqcBceq53sx30"), 0, 0, 0, 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>());
        let v14 = &mut v6;
        let v15 = &mut v7;
        let v16 = 0x2::tx_context::sender(arg1);
        mint(v14, v15, 0x1::string::utf8(b"Collection"), v16, arg1);
        0x2::transfer::share_object<NFTInfo>(v6);
        0x2::transfer::share_object<TierInfo>(v7);
    }

    public fun is_sox_claimed(arg0: &NFTInfo, arg1: address) : bool {
        *0x2::table::borrow<address, bool>(&arg0.is_sox_claimed, arg1)
    }

    public fun is_tier_exists(arg0: &TierInfo, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, Tier>(&arg0.tier_list, arg1)
    }

    public fun lockup_period(arg0: &OGNFTPreSale) : u64 {
        if (0x1::option::is_some<u64>(&arg0.lockup_period)) {
            *0x1::option::borrow<u64>(&arg0.lockup_period)
        } else {
            0
        }
    }

    public fun lockup_period_of_tier(arg0: &TierInfo, arg1: 0x1::string::String) : u64 {
        check_tier_exists(arg0, arg1);
        let v0 = 0x2::table::borrow<0x1::string::String, Tier>(&arg0.tier_list, arg1);
        if (0x1::option::is_some<u64>(&v0.lockup_period)) {
            *0x1::option::borrow<u64>(&v0.lockup_period)
        } else {
            0
        }
    }

    public(friend) fun mint(arg0: &mut NFTInfo, arg1: &mut TierInfo, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : address {
        check_tier_exists(arg1, arg2);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, Tier>(&mut arg1.tier_list, arg2);
        update_user_tier_count(arg0, arg3, v0.tier_name, arg4);
        update_total_tier_count(arg0, v0.tier_name);
        if (0x1::option::is_some<u64>(&v0.user_limit)) {
            assert!(get_user_tier_count(arg0, arg3, v0.tier_name) <= *0x1::option::borrow<u64>(&v0.user_limit), 201);
        };
        if (0x1::option::is_some<u64>(&v0.total_limit)) {
            assert!(get_total_tier_count(arg0, v0.tier_name) <= *0x1::option::borrow<u64>(&v0.total_limit), 202);
        };
        let v1 = 0x2::object::new(arg4);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x2::object::id_to_address(&v2);
        if (0x2::table::contains<address, vector<address>>(&arg0.nfts_of_user, arg3)) {
            0x1::vector::push_back<address>(0x2::table::borrow_mut<address, vector<address>>(&mut arg0.nfts_of_user, arg3), v3);
        } else {
            let v4 = 0x1::vector::empty<address>();
            0x1::vector::push_back<address>(&mut v4, v3);
            0x2::table::add<address, vector<address>>(&mut arg0.nfts_of_user, arg3, v4);
        };
        0x2::table::add<address, bool>(&mut arg0.is_sox_claimed, v3, false);
        let v5 = v0.nft_name;
        if (v5 != 0x1::string::utf8(b"OG NFT Pre-Sale")) {
            0x1::string::append(&mut v5, 0x1::string::utf8(b" #"));
            0x1::string::append(&mut v5, u64_to_string(v0.current_number));
        };
        let v6 = OGNFTPreSale{
            id            : v1,
            name          : v5,
            image_url     : v0.nft_image_url,
            project_url   : 0x1::string::utf8(b"https://olympiangames.com"),
            description   : v0.nft_description,
            creator       : 0x1::string::utf8(b"Olympian Games"),
            price_info    : v0.price_info,
            lockup_period : v0.lockup_period,
            attributes    : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        };
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v6.attributes, 0x1::string::utf8(b"tier"), v0.tier_name);
        0x2::transfer::transfer<OGNFTPreSale>(v6, arg3);
        v0.current_number = v0.current_number + 1;
        let v7 = NFTMinted{
            nft_id    : v3,
            recipient : arg3,
            tier      : v0.tier_name,
        };
        0x2::event::emit<NFTMinted>(v7);
        v3
    }

    entry fun mint_for_admin(arg0: &0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::role_manager::RoleManager, arg1: &mut NFTInfo, arg2: &mut TierInfo, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : address {
        0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::role_manager::check_role(arg0, 0x1::string::utf8(b"ug_nft_admin"), arg5);
        mint(arg1, arg2, arg3, arg4, arg5)
    }

    public fun name(arg0: &OGNFTPreSale) : 0x1::string::String {
        arg0.name
    }

    public fun name_of_tier(arg0: &TierInfo, arg1: 0x1::string::String) : 0x1::string::String {
        check_tier_exists(arg0, arg1);
        0x2::table::borrow<0x1::string::String, Tier>(&arg0.tier_list, arg1).tier_name
    }

    entry fun new_tier(arg0: &0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::role_manager::RoleManager, arg1: &mut TierInfo, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: u64, arg9: 0x1::option::Option<u64>, arg10: 0x1::option::Option<u64>, arg11: 0x1::option::Option<u64>, arg12: &mut 0x2::tx_context::TxContext) {
        0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::role_manager::check_role(arg0, 0x1::string::utf8(b"ug_nft_admin"), arg12);
        new_tier_internal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    fun new_tier_internal(arg0: &mut TierInfo, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<u64>, arg10: 0x1::option::Option<u64>) {
        if (0x2::table::contains<0x1::string::String, Tier>(&arg0.tier_list, arg1)) {
            abort 203
        };
        let v0 = PriceInfo{
            price                  : arg5,
            sox_provide_amount     : arg6,
            drachma_provide_amount : arg7,
        };
        let v1 = Tier{
            tier_name       : arg1,
            nft_name        : arg2,
            nft_description : arg3,
            nft_image_url   : arg4,
            price_info      : v0,
            user_limit      : arg8,
            total_limit     : arg9,
            lockup_period   : arg10,
            current_number  : 1,
        };
        0x2::table::add<0x1::string::String, Tier>(&mut arg0.tier_list, arg1, v1);
        let v2 = TierCreated{
            tier_name   : arg1,
            price_info  : v0,
            user_limit  : arg8,
            total_limit : arg9,
        };
        0x2::event::emit<TierCreated>(v2);
    }

    public fun nft_description_of_tier(arg0: &TierInfo, arg1: 0x1::string::String) : 0x1::string::String {
        check_tier_exists(arg0, arg1);
        0x2::table::borrow<0x1::string::String, Tier>(&arg0.tier_list, arg1).nft_description
    }

    public fun nft_image_url_of_tier(arg0: &TierInfo, arg1: 0x1::string::String) : 0x1::string::String {
        check_tier_exists(arg0, arg1);
        0x2::table::borrow<0x1::string::String, Tier>(&arg0.tier_list, arg1).nft_image_url
    }

    public fun nft_name_of_tier(arg0: &TierInfo, arg1: 0x1::string::String) : 0x1::string::String {
        check_tier_exists(arg0, arg1);
        0x2::table::borrow<0x1::string::String, Tier>(&arg0.tier_list, arg1).nft_name
    }

    public fun price(arg0: &OGNFTPreSale) : u64 {
        arg0.price_info.price
    }

    public fun price_info(arg0: &OGNFTPreSale) : PriceInfo {
        arg0.price_info
    }

    public fun price_of_tier(arg0: &TierInfo, arg1: 0x1::string::String) : u64 {
        check_tier_exists(arg0, arg1);
        0x2::table::borrow<0x1::string::String, Tier>(&arg0.tier_list, arg1).price_info.price
    }

    entry fun remove_tier(arg0: &0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::role_manager::RoleManager, arg1: &mut TierInfo, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        check_tier_exists(arg1, arg2);
        0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::role_manager::check_role(arg0, 0x1::string::utf8(b"ug_nft_admin"), arg3);
        0x2::table::remove<0x1::string::String, Tier>(&mut arg1.tier_list, arg2);
    }

    entry fun set_tier_drachma_provide_amount(arg0: &0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::role_manager::RoleManager, arg1: &mut TierInfo, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::role_manager::check_role(arg0, 0x1::string::utf8(b"ug_nft_admin"), arg4);
        assert!(0x2::table::contains<0x1::string::String, Tier>(&arg1.tier_list, arg2), 204);
        0x2::table::borrow_mut<0x1::string::String, Tier>(&mut arg1.tier_list, arg2).price_info.drachma_provide_amount = arg3;
    }

    entry fun set_tier_lockup_period(arg0: &0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::role_manager::RoleManager, arg1: &mut TierInfo, arg2: 0x1::string::String, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::role_manager::check_role(arg0, 0x1::string::utf8(b"ug_nft_admin"), arg4);
        assert!(0x2::table::contains<0x1::string::String, Tier>(&arg1.tier_list, arg2), 204);
        0x2::table::borrow_mut<0x1::string::String, Tier>(&mut arg1.tier_list, arg2).lockup_period = arg3;
    }

    entry fun set_tier_nft_image_url(arg0: &0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::role_manager::RoleManager, arg1: &mut TierInfo, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::role_manager::check_role(arg0, 0x1::string::utf8(b"ug_nft_admin"), arg4);
        assert!(0x2::table::contains<0x1::string::String, Tier>(&arg1.tier_list, arg2), 204);
        0x2::table::borrow_mut<0x1::string::String, Tier>(&mut arg1.tier_list, arg2).nft_image_url = arg3;
    }

    entry fun set_tier_nft_name(arg0: &0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::role_manager::RoleManager, arg1: &mut TierInfo, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::role_manager::check_role(arg0, 0x1::string::utf8(b"ug_nft_admin"), arg4);
        assert!(0x2::table::contains<0x1::string::String, Tier>(&arg1.tier_list, arg2), 204);
        0x2::table::borrow_mut<0x1::string::String, Tier>(&mut arg1.tier_list, arg2).nft_name = arg3;
    }

    entry fun set_tier_price(arg0: &0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::role_manager::RoleManager, arg1: &mut TierInfo, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::role_manager::check_role(arg0, 0x1::string::utf8(b"ug_nft_admin"), arg4);
        assert!(0x2::table::contains<0x1::string::String, Tier>(&arg1.tier_list, arg2), 204);
        0x2::table::borrow_mut<0x1::string::String, Tier>(&mut arg1.tier_list, arg2).price_info.price = arg3;
    }

    entry fun set_tier_sox_provide_amount(arg0: &0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::role_manager::RoleManager, arg1: &mut TierInfo, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::role_manager::check_role(arg0, 0x1::string::utf8(b"ug_nft_admin"), arg4);
        assert!(0x2::table::contains<0x1::string::String, Tier>(&arg1.tier_list, arg2), 204);
        0x2::table::borrow_mut<0x1::string::String, Tier>(&mut arg1.tier_list, arg2).price_info.sox_provide_amount = arg3;
    }

    entry fun set_tier_total_limit(arg0: &0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::role_manager::RoleManager, arg1: &mut TierInfo, arg2: 0x1::string::String, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::role_manager::check_role(arg0, 0x1::string::utf8(b"ug_nft_admin"), arg4);
        assert!(0x2::table::contains<0x1::string::String, Tier>(&arg1.tier_list, arg2), 204);
        0x2::table::borrow_mut<0x1::string::String, Tier>(&mut arg1.tier_list, arg2).total_limit = arg3;
    }

    entry fun set_tier_user_limit(arg0: &0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::role_manager::RoleManager, arg1: &mut TierInfo, arg2: 0x1::string::String, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        0x45ed396a41c84837aaaf3ef31bfb7cd94e530154a5574f9c2b959745102c704d::role_manager::check_role(arg0, 0x1::string::utf8(b"ug_nft_admin"), arg4);
        assert!(0x2::table::contains<0x1::string::String, Tier>(&arg1.tier_list, arg2), 204);
        0x2::table::borrow_mut<0x1::string::String, Tier>(&mut arg1.tier_list, arg2).user_limit = arg3;
    }

    public fun sox_provide_amount(arg0: &OGNFTPreSale) : u64 {
        arg0.price_info.sox_provide_amount
    }

    public fun sox_provide_amount_of_tier(arg0: &TierInfo, arg1: 0x1::string::String) : u64 {
        check_tier_exists(arg0, arg1);
        0x2::table::borrow<0x1::string::String, Tier>(&arg0.tier_list, arg1).price_info.sox_provide_amount
    }

    public fun tier(arg0: &OGNFTPreSale) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"tier");
        *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0)
    }

    public fun total_limit(arg0: &TierInfo, arg1: 0x1::string::String) : u64 {
        check_tier_exists(arg0, arg1);
        let v0 = 0x2::table::borrow<0x1::string::String, Tier>(&arg0.tier_list, arg1);
        if (0x1::option::is_some<u64>(&v0.total_limit)) {
            *0x1::option::borrow<u64>(&v0.total_limit)
        } else {
            0
        }
    }

    public fun total_limit_of_tier(arg0: &TierInfo, arg1: 0x1::string::String) : u64 {
        check_tier_exists(arg0, arg1);
        let v0 = 0x2::table::borrow<0x1::string::String, Tier>(&arg0.tier_list, arg1);
        if (0x1::option::is_some<u64>(&v0.total_limit)) {
            *0x1::option::borrow<u64>(&v0.total_limit)
        } else {
            0
        }
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    fun update_total_tier_count(arg0: &mut NFTInfo, arg1: 0x1::string::String) {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.total_tier_counts, arg1)) {
            let v0 = 0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg0.total_tier_counts, arg1);
            *v0 = *v0 + 1;
        } else {
            0x2::table::add<0x1::string::String, u64>(&mut arg0.total_tier_counts, arg1, 1);
        };
    }

    fun update_user_tier_count(arg0: &mut NFTInfo, arg1: address, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<address, 0x2::table::Table<0x1::string::String, u64>>(&arg0.user_tier_counts, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, 0x2::table::Table<0x1::string::String, u64>>(&mut arg0.user_tier_counts, arg1);
            if (0x2::table::contains<0x1::string::String, u64>(v0, arg2)) {
                let v1 = 0x2::table::borrow_mut<0x1::string::String, u64>(v0, arg2);
                *v1 = *v1 + 1;
            } else {
                0x2::table::add<0x1::string::String, u64>(v0, arg2, 1);
            };
        } else {
            let v2 = 0x2::table::new<0x1::string::String, u64>(arg3);
            0x2::table::add<0x1::string::String, u64>(&mut v2, arg2, 1);
            0x2::table::add<address, 0x2::table::Table<0x1::string::String, u64>>(&mut arg0.user_tier_counts, arg1, v2);
        };
    }

    public fun user_limit(arg0: &TierInfo, arg1: 0x1::string::String) : u64 {
        check_tier_exists(arg0, arg1);
        let v0 = 0x2::table::borrow<0x1::string::String, Tier>(&arg0.tier_list, arg1);
        if (0x1::option::is_some<u64>(&v0.user_limit)) {
            *0x1::option::borrow<u64>(&v0.user_limit)
        } else {
            0
        }
    }

    public fun user_limit_of_tier(arg0: &TierInfo, arg1: 0x1::string::String) : u64 {
        check_tier_exists(arg0, arg1);
        let v0 = 0x2::table::borrow<0x1::string::String, Tier>(&arg0.tier_list, arg1);
        if (0x1::option::is_some<u64>(&v0.user_limit)) {
            *0x1::option::borrow<u64>(&v0.user_limit)
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

