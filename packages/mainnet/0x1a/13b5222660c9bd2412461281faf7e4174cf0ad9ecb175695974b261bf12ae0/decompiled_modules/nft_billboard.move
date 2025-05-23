module 0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::nft_billboard {
    struct NFT_BILLBOARD has drop {
        dummy_field: bool,
    }

    struct SystemInitialized has copy, drop {
        admin: address,
    }

    struct GameDevRegistered has copy, drop {
        game_dev: address,
    }

    struct GameDevRemoved has copy, drop {
        game_dev: address,
    }

    struct AdSpacePurchased has copy, drop {
        ad_space_id: address,
        buyer: address,
        brand_name: 0x1::string::String,
        content_url: 0x1::string::String,
        lease_days: u64,
    }

    struct LeaseRenewed has copy, drop {
        ad_space_id: address,
        nft_id: address,
        lease_days: u64,
    }

    public entry fun calculate_lease_price(arg0: &0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::ad_space::AdSpace, arg1: u64) : u64 {
        0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::ad_space::calculate_lease_price(arg0, arg1)
    }

    public entry fun create_ad_space(arg0: &mut 0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::factory::Factory, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::factory::is_game_dev(arg0, 0x2::tx_context::sender(arg6)), 8);
        let v0 = 0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::ad_space::create_ad_space(arg1, arg2, arg3, arg4, 0x2::tx_context::sender(arg6), arg5, arg6);
        0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::factory::register_ad_space(arg0, 0x2::object::id<0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::ad_space::AdSpace>(&v0), 0x2::tx_context::sender(arg6));
        0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::ad_space::share_ad_space(v0);
    }

    public entry fun delete_ad_space(arg0: &mut 0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::factory::Factory, arg1: 0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::ad_space::AdSpace, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::ad_space::get_creator(&arg1);
        assert!(v0 == 0x2::tx_context::sender(arg2), 9);
        0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::factory::remove_ad_space(arg0, 0x2::object::id<0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::ad_space::AdSpace>(&arg1), v0, arg2);
        0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::ad_space::delete_ad_space(arg1, arg2);
    }

    public entry fun register_game_dev(arg0: &mut 0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::factory::Factory, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::factory::get_admin(arg0) == 0x2::tx_context::sender(arg2), 7);
        0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::factory::register_game_dev(arg0, arg1, arg2);
        let v0 = GameDevRegistered{game_dev: arg1};
        0x2::event::emit<GameDevRegistered>(v0);
    }

    public entry fun remove_game_dev(arg0: &mut 0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::factory::Factory, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::factory::get_admin(arg0) == 0x2::tx_context::sender(arg2), 7);
        0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::factory::remove_game_dev(arg0, arg1, arg2);
        let v0 = GameDevRemoved{game_dev: arg1};
        0x2::event::emit<GameDevRemoved>(v0);
    }

    public entry fun renew_lease(arg0: &mut 0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::factory::Factory, arg1: &mut 0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::ad_space::AdSpace, arg2: &mut 0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::nft::AdBoardNFT, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::nft::get_lease_status(arg2, arg5), 12);
        let v0 = 0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::ad_space::calculate_lease_price(arg1, arg4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v0, 5);
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, 0x2::coin::value<0x2::sui::SUI>(&arg3) - v0, arg6), 0x2::tx_context::sender(arg6));
        };
        let v1 = v0 * (0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::factory::get_platform_ratio(arg0) as u64) / 100;
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v1, arg6), 0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::factory::get_admin(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v0 - v1, arg6), 0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::ad_space::get_creator(arg1));
        0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::nft::renew_lease(arg2, arg4, arg5, arg6);
        let v2 = LeaseRenewed{
            ad_space_id : 0x2::object::id_address<0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::ad_space::AdSpace>(arg1),
            nft_id      : 0x2::object::id_address<0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::nft::AdBoardNFT>(arg2),
            lease_days  : arg4,
        };
        0x2::event::emit<LeaseRenewed>(v2);
    }

    fun init(arg0: NFT_BILLBOARD, arg1: &mut 0x2::tx_context::TxContext) {
        0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::factory::init_factory(arg1);
        let v0 = SystemInitialized{admin: 0x2::tx_context::sender(arg1)};
        0x2::event::emit<SystemInitialized>(v0);
    }

    public entry fun purchase_ad_space(arg0: &mut 0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::factory::Factory, arg1: &mut 0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::ad_space::AdSpace, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: &0x2::clock::Clock, arg8: u64, arg9: vector<u8>, arg10: 0x1::string::String, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::ad_space::is_available(arg1), 4);
        let v0 = 0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::ad_space::calculate_lease_price(arg1, arg6);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v0, 5);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, 0x2::coin::value<0x2::sui::SUI>(&arg2) - v0, arg11), 0x2::tx_context::sender(arg11));
        };
        let v1 = v0 * (0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::factory::get_platform_ratio(arg0) as u64) / 100;
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v1, arg11), 0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::factory::get_admin(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v0 - v1, arg11), 0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::ad_space::get_creator(arg1));
        let v2 = if (0x1::vector::is_empty<u8>(&arg9)) {
            0x1::option::none<0x1::string::String>()
        } else {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(arg9))
        };
        let v3 = 0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::nft::create_nft(arg1, arg3, arg4, arg5, arg6, arg8, v2, arg10, arg7, arg11);
        0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::factory::add_nft_to_ad_space(arg0, 0x2::object::id<0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::ad_space::AdSpace>(arg1), 0x2::object::id<0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::nft::AdBoardNFT>(&v3));
        let v4 = AdSpacePurchased{
            ad_space_id : 0x2::object::id_address<0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::ad_space::AdSpace>(arg1),
            buyer       : 0x2::tx_context::sender(arg11),
            brand_name  : arg3,
            content_url : arg4,
            lease_days  : arg6,
        };
        0x2::event::emit<AdSpacePurchased>(v4);
        0x2::transfer::public_transfer<0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::nft::AdBoardNFT>(v3, 0x2::tx_context::sender(arg11));
    }

    public entry fun update_ad_content(arg0: &mut 0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::nft::AdBoardNFT, arg1: 0x1::string::String, arg2: vector<u8>, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x1::vector::is_empty<u8>(&arg2)) {
            0x1::option::none<0x1::string::String>()
        } else {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(arg2))
        };
        0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::nft::update_content(arg0, arg1, v0, arg3, arg4, arg5);
    }

    public entry fun update_ad_space_price(arg0: &mut 0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::ad_space::AdSpace, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::ad_space::get_creator(arg0) == 0x2::tx_context::sender(arg2), 9);
        0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::ad_space::update_price(arg0, arg1, arg2);
    }

    public entry fun update_platform_ratio(arg0: &mut 0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::factory::Factory, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::factory::get_admin(arg0) == 0x2::tx_context::sender(arg2), 7);
        0x1a13b5222660c9bd2412461281faf7e4174cf0ad9ecb175695974b261bf12ae0::factory::update_ratios(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

