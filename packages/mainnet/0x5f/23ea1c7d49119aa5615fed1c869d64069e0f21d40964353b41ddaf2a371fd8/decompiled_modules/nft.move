module 0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct NftConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        tge_time: u64,
        unlock_time: u64,
        end_lock_time: u64,
        cro_per_points: u64,
        total_mint_nfts: u64,
        total_staked_points: u64,
        user_to_nft: 0x2::table::Table<address, 0x2::object::ID>,
        nft_to_user: 0x2::table::Table<0x2::object::ID, address>,
        nft_price: u64,
        referral_nft_price: u64,
    }

    struct CroNft has store, key {
        id: 0x2::object::UID,
        staked_points: 0x2::balance::Balance<0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::points::POINTS>,
        staked_cro: 0x2::balance::Balance<0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::cro::CRO>,
        unlock_time: u64,
        owner: address,
    }

    struct MintNftEvent has copy, drop {
        nft_id: address,
        owner: address,
    }

    struct MintReferralNftEvent has copy, drop {
        nft_id: address,
        owner: address,
        referral: address,
    }

    public fun add_points(arg0: &mut NftConfig, arg1: &mut CroNft, arg2: 0x2::coin::Coin<0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::points::POINTS>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(check_before_tge(arg0, arg3), 1);
        check_version(arg0);
        let v0 = 0x2::coin::value<0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::points::POINTS>(&arg2);
        arg0.total_staked_points = v0 + arg0.total_staked_points;
        0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::events::emit_add_points_event(v0, arg4);
        0x2::balance::join<0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::points::POINTS>(&mut arg1.staked_points, 0x2::coin::into_balance<0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::points::POINTS>(arg2));
    }

    public fun change_nft_config(arg0: &0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::admin::AdminCap, arg1: &mut NftConfig, arg2: &mut 0x1::option::Option<u64>, arg3: &mut 0x1::option::Option<u64>, arg4: &mut 0x1::option::Option<u64>, arg5: &mut 0x1::option::Option<u64>, arg6: &mut 0x1::option::Option<u64>) {
        if (0x1::option::is_some<u64>(arg2)) {
            arg1.version = 0x1::option::extract<u64>(arg2);
        };
        if (0x1::option::is_some<u64>(arg3)) {
            arg1.tge_time = 0x1::option::extract<u64>(arg3);
        };
        if (0x1::option::is_some<u64>(arg5)) {
            arg1.end_lock_time = 0x1::option::extract<u64>(arg5);
        };
        if (0x1::option::is_some<u64>(arg4)) {
            arg1.unlock_time = 0x1::option::extract<u64>(arg4);
        };
        if (0x1::option::is_some<u64>(arg6)) {
            arg1.cro_per_points = 0x1::option::extract<u64>(arg6);
        };
    }

    public(friend) fun check_before_tge(arg0: &NftConfig, arg1: &0x2::clock::Clock) : bool {
        arg0.tge_time == 0 || 0x2::clock::timestamp_ms(arg1) < arg0.tge_time
    }

    public(friend) fun check_unlock_time_not_zero(arg0: &CroNft) {
        assert!(arg0.unlock_time != 0, 0);
    }

    public(friend) fun check_unlock_time_valid(arg0: &CroNft, arg1: &0x2::clock::Clock) {
        assert!(arg0.unlock_time <= 0x2::clock::timestamp_ms(arg1), 1);
    }

    public(friend) fun check_unlock_time_zero(arg0: &CroNft) {
        assert!(arg0.unlock_time == 0, 0);
    }

    fun check_version(arg0: &NftConfig) {
        0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::version::check_version(arg0.version);
    }

    public fun claim_cro(arg0: &NftConfig, arg1: &mut CroNft, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::cro::CRO> {
        assert!(0x2::balance::value<0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::cro::CRO>(&arg1.staked_cro) > 0, 0);
        assert!(arg0.tge_time != 0, 0);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.tge_time, 1);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.unlock_time, 2);
        if (0x2::clock::timestamp_ms(arg2) >= arg0.end_lock_time) {
            let v1 = 0x2::balance::value<0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::cro::CRO>(&arg1.staked_cro);
            assert!(v1 > 0, 0);
            0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::events::emit_claim_cro_event(v1, arg3);
            0x2::coin::from_balance<0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::cro::CRO>(0x2::balance::split<0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::cro::CRO>(&mut arg1.staked_cro, v1), arg3)
        } else {
            check_unlock_time_not_zero(arg1);
            check_unlock_time_valid(arg1, arg2);
            let v2 = (0x2::clock::timestamp_ms(arg2) - arg1.unlock_time) * 0x2::balance::value<0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::cro::CRO>(&arg1.staked_cro) / (arg0.end_lock_time - arg0.unlock_time);
            assert!(v2 > 0, 0);
            let v3 = 0x2::balance::split<0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::cro::CRO>(&mut arg1.staked_cro, v2);
            update_prev_unlock_time(arg1, arg2);
            0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::events::emit_claim_cro_event(v2, arg3);
            0x2::coin::from_balance<0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::cro::CRO>(v3, arg3)
        }
    }

    public fun claim_init(arg0: &NftConfig, arg1: &mut 0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::treasury::Treasury, arg2: &mut CroNft, arg3: &0x2::clock::Clock) {
        assert!(arg0.tge_time != 0, 0);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.tge_time, 1);
        update_unlock_time_init(arg2);
        0x2::balance::join<0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::cro::CRO>(&mut arg2.staked_cro, 0x2::balance::split<0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::cro::CRO>(0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::treasury::borrow_from_treasury<0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::cro::CRO>(arg1), 0x2::balance::value<0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::points::POINTS>(&arg2.staked_points) * arg0.cro_per_points));
    }

    public(friend) fun create_config<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : NftConfig {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 1);
        NftConfig{
            id                  : 0x2::object::new(arg1),
            version             : 0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::version::current_version(),
            tge_time            : 1746057600000,
            unlock_time         : 1840752000000,
            end_lock_time       : 1903824000000,
            cro_per_points      : 0,
            total_mint_nfts     : 0,
            total_staked_points : 0,
            user_to_nft         : 0x2::table::new<address, 0x2::object::ID>(arg1),
            nft_to_user         : 0x2::table::new<0x2::object::ID, address>(arg1),
            nft_price           : 10000000000,
            referral_nft_price  : 2500000000,
        }
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        let v1 = 0x2::display::new<CroNft>(&v0, arg1);
        0x2::display::add<CroNft>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"CroNft #{number}"));
        0x2::display::add<CroNft>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"CroNft #{number}"));
        0x2::display::add<CroNft>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://cro-ag.pages.dev/cronft.png"));
        0x2::display::add<CroNft>(&mut v1, 0x1::string::utf8(b"minted_by"), 0x1::string::utf8(b"{minted_by}"));
        0x2::display::update_version<CroNft>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<CroNft>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<CroNft>>(v2);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<CroNft>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CroNft>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun mint_nft(arg0: &mut NftConfig, arg1: &mut 0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::treasury::Treasury, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg0.nft_price, 0);
        arg0.total_mint_nfts = 1 + arg0.total_mint_nfts;
        0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::treasury::deposit<0x2::sui::SUI>(arg1, arg2);
        let v1 = CroNft{
            id            : 0x2::object::new(arg3),
            staked_points : 0x2::balance::zero<0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::points::POINTS>(),
            staked_cro    : 0x2::balance::zero<0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::cro::CRO>(),
            unlock_time   : 0,
            owner         : v0,
        };
        let v2 = MintNftEvent{
            nft_id : 0x2::object::uid_to_address(&v1.id),
            owner  : v1.owner,
        };
        0x2::event::emit<MintNftEvent>(v2);
        register(arg0, &v1, v0);
        0x2::transfer::public_transfer<CroNft>(v1, v0);
    }

    public fun referral_mint(arg0: &mut NftConfig, arg1: &mut 0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::treasury::Treasury, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg0.referral_nft_price, 0);
        arg0.total_mint_nfts = 1 + arg0.total_mint_nfts;
        0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::treasury::deposit<0x2::sui::SUI>(arg1, arg2);
        let v1 = CroNft{
            id            : 0x2::object::new(arg5),
            staked_points : 0x2::balance::zero<0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::points::POINTS>(),
            staked_cro    : 0x2::balance::zero<0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::cro::CRO>(),
            unlock_time   : 0,
            owner         : v0,
        };
        let v2 = MintReferralNftEvent{
            nft_id   : 0x2::object::uid_to_address(&v1.id),
            owner    : v1.owner,
            referral : arg3,
        };
        0x2::event::emit<MintReferralNftEvent>(v2);
        register(arg0, &v1, v0);
        0x2::transfer::public_transfer<CroNft>(v1, v0);
        let v3 = 0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::treasury::borrow_from_treasury<0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::points::POINTS>(arg1);
        if (check_before_tge(arg0, arg4)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::points::POINTS>>(0x2::coin::from_balance<0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::points::POINTS>(0x2::balance::split<0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::points::POINTS>(v3, 50), arg5), arg3);
        };
    }

    public(friend) fun register(arg0: &mut NftConfig, arg1: &CroNft, arg2: address) {
        let v0 = 0x2::object::id<CroNft>(arg1);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.user_to_nft, arg2), 3);
        assert!(!0x2::table::contains<0x2::object::ID, address>(&arg0.nft_to_user, v0), 2);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.user_to_nft, arg2, v0);
        0x2::table::add<0x2::object::ID, address>(&mut arg0.nft_to_user, v0, arg2);
    }

    public fun remove_points(arg0: &mut NftConfig, arg1: &mut CroNft, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::points::POINTS> {
        assert!(check_before_tge(arg0, arg3), 1);
        check_version(arg0);
        arg0.total_staked_points = arg0.total_staked_points - arg2;
        0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::events::emit_remove_points_event(arg2, arg4);
        0x2::coin::from_balance<0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::points::POINTS>(0x2::balance::split<0x5f23ea1c7d49119aa5615fed1c869d64069e0f21d40964353b41ddaf2a371fd8::points::POINTS>(&mut arg1.staked_points, arg2), arg4)
    }

    public(friend) fun update_prev_unlock_time(arg0: &mut CroNft, arg1: &0x2::clock::Clock) {
        arg0.unlock_time = 0x2::clock::timestamp_ms(arg1);
    }

    public(friend) fun update_unlock_time_init(arg0: &mut CroNft) {
        check_unlock_time_zero(arg0);
        arg0.unlock_time = 1840752000000;
    }

    // decompiled from Move bytecode v6
}

