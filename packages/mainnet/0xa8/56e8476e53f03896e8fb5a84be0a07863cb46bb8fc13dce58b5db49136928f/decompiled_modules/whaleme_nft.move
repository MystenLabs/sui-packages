module 0xa856e8476e53f03896e8fb5a84be0a07863cb46bb8fc13dce58b5db49136928f::whaleme_nft {
    struct WHALEME_NFT has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct WhalemeOwnerCap has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct WhalemeNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        attributes: 0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::attributes::Attributes,
        tier: u64,
        stakedAt: u64,
        point: u64,
        supply: u64,
    }

    struct WhalemeStorage has store, key {
        id: 0x2::object::UID,
        staked: 0x2::vec_map::VecMap<address, WhalemeNFT>,
        minted: 0x2::vec_map::VecMap<address, bool>,
        claimed: 0x2::vec_map::VecMap<address, u64>,
        refMapping: 0x2::vec_map::VecMap<address, address>,
        commission: 0x2::vec_map::VecMap<address, u64>,
        budgetCommission: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        isMint: bool,
    }

    struct Attr has store, key {
        id: 0x2::object::UID,
        attributes: 0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::attributes::Attributes,
    }

    struct MintWhalemeNFT has copy, drop {
        minter: address,
        referrer: address,
        tier: u64,
        attribute_keys: vector<0x1::ascii::String>,
        attribute_values: vector<0x1::ascii::String>,
        id: 0x2::object::ID,
    }

    struct StakeWhalemeNFT has copy, drop {
        owner: address,
        id: 0x2::object::ID,
        tier: u64,
        point: u64,
    }

    struct Msg has copy, drop {
        i: u64,
        x: vector<0x1::ascii::String>,
        y: vector<0x1::ascii::String>,
    }

    struct UnStakeWhalemeNFT has copy, drop {
        owner: address,
        id: 0x2::object::ID,
        tier: u64,
        point: u64,
    }

    struct UpgradeWhalemeNFT has copy, drop {
        tier: u64,
        id: 0x2::object::ID,
        owner: address,
    }

    struct WhalemeClaimCommission has copy, drop {
        user: address,
        amount: u64,
    }

    public fun adminUpdateConfig(arg0: &mut WhalemeOwnerCap, arg1: &mut WhalemeStorage, arg2: bool) {
        arg1.isMint = arg2;
    }

    public fun claim_commission(arg0: &mut WhalemeStorage, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) > 0, 8);
        let v0 = get_commission(arg0.commission, 0x2::tx_context::sender(arg1));
        assert!(v0 > 0, 9);
        let v1 = v0 - get_commission(arg0.claimed, 0x2::tx_context::sender(arg1));
        assert!(v1 > 0, 10);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) > v1, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v1), arg1), 0x2::tx_context::sender(arg1));
        update_claimed(0x2::tx_context::sender(arg1), v1, arg0);
        let v2 = WhalemeClaimCommission{
            user   : 0x2::tx_context::sender(arg1),
            amount : v1,
        };
        0x2::event::emit<WhalemeClaimCommission>(v2);
        v1
    }

    public entry fun depositSui(arg0: &mut WhalemeStorage, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun get_commission(arg0: 0x2::vec_map::VecMap<address, u64>, arg1: address) : u64 {
        if (0x2::vec_map::contains<address, u64>(&arg0, &arg1)) {
            *0x2::vec_map::get<address, u64>(&arg0, &arg1)
        } else {
            0
        }
    }

    fun handle_commission(arg0: address, arg1: u64, arg2: &mut WhalemeStorage) {
        if (arg2.budgetCommission < 1000 * 1000000000) {
            let v0 = @0xc5d4bad4a3f9e50583a062101119de63d9e4d497ca72398e90c7c626ecaa52b5;
            if (0x2::vec_map::contains<address, address>(&arg2.refMapping, &arg0)) {
                v0 = *0x2::vec_map::get<address, address>(&arg2.refMapping, &arg0);
            };
            arg2.budgetCommission = arg2.budgetCommission + 0xa856e8476e53f03896e8fb5a84be0a07863cb46bb8fc13dce58b5db49136928f::utils::estimate_commission_ref(arg1);
            0xa856e8476e53f03896e8fb5a84be0a07863cb46bb8fc13dce58b5db49136928f::utils::insert_or_update(&mut arg2.commission, v0, get_commission(arg2.commission, v0) + 0xa856e8476e53f03896e8fb5a84be0a07863cb46bb8fc13dce58b5db49136928f::utils::estimate_commission_ref(arg1));
        };
    }

    fun init(arg0: WHALEME_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::collection::create_with_mint_cap<WHALEME_NFT, WhalemeNFT>(&arg0, 0x1::option::none<u64>(), arg1);
        let v3 = v1;
        let v4 = 0x2::package::claim<WHALEME_NFT>(arg0, arg1);
        let v5 = Witness{dummy_field: false};
        let v6 = 0xa248e4ac36f2907a18843c68809fae46139e3cf3a8898d2459809088b5a91150::witness::from_witness<WhalemeNFT, Witness>(v5);
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::tags::art());
        0x1::vector::push_back<0x1::string::String>(v8, 0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::tags::game_asset());
        let v9 = 0x2::display::new<WhalemeNFT>(&v4, arg1);
        0x2::display::add<WhalemeNFT>(&mut v9, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name} #{supply}"));
        0x2::display::add<WhalemeNFT>(&mut v9, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Whaleme makes a dream come true!"));
        0x2::display::add<WhalemeNFT>(&mut v9, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<WhalemeNFT>(&mut v9, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<WhalemeNFT>(&mut v9, 0x1::string::utf8(b"tags"), 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::display::from_vec(v7));
        0x2::display::add<WhalemeNFT>(&mut v9, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://whaleme.me/"));
        0x2::display::add<WhalemeNFT>(&mut v9, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://app.whaleme.me/"));
        0x2::display::update_version<WhalemeNFT>(&mut v9);
        0x2::transfer::public_transfer<0x2::display::Display<WhalemeNFT>>(v9, 0x2::tx_context::sender(arg1));
        0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::collection::add_domain<WhalemeNFT, 0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::display_info::DisplayInfo>(v6, &mut v3, 0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::display_info::new(0x1::string::utf8(b"WhalemeNFT"), 0x1::string::utf8(b"A unique NFT collection of Whaleme on Sui")));
        let v10 = vector[@0xc5d4bad4a3f9e50583a062101119de63d9e4d497ca72398e90c7c626ecaa52b5];
        0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::collection::add_domain<WhalemeNFT, 0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::creators::Creators>(v6, &mut v3, 0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::creators::new(0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::vec_set_from_vec<address>(&v10)));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
        0x2::transfer::public_transfer<0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::mint_cap::MintCap<WhalemeNFT>>(v2, v0);
        0x2::transfer::public_share_object<0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::collection::Collection<WhalemeNFT>>(v3);
        let v11 = WhalemeOwnerCap{
            id    : 0x2::object::new(arg1),
            owner : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::transfer<WhalemeOwnerCap>(v11, 0x2::tx_context::sender(arg1));
        let v12 = WhalemeStorage{
            id               : 0x2::object::new(arg1),
            staked           : 0x2::vec_map::empty<address, WhalemeNFT>(),
            minted           : 0x2::vec_map::empty<address, bool>(),
            claimed          : 0x2::vec_map::empty<address, u64>(),
            refMapping       : 0x2::vec_map::empty<address, address>(),
            commission       : 0x2::vec_map::empty<address, u64>(),
            budgetCommission : 0,
            balance          : 0x2::balance::zero<0x2::sui::SUI>(),
            isMint           : true,
        };
        0x2::transfer::public_share_object<WhalemeStorage>(v12);
    }

    public entry fun mint(arg0: address, arg1: vector<u8>, arg2: vector<0x1::ascii::String>, arg3: vector<0x1::ascii::String>, arg4: &mut WhalemeStorage, arg5: vector<u8>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0xa856e8476e53f03896e8fb5a84be0a07863cb46bb8fc13dce58b5db49136928f::signature::verify_signature(arg5, 0x2::address::to_bytes(@0xcc349ea552908f6c06d1c267fed922fcfa5506424dc8c6fb49ca589cec077a1a), 0xa856e8476e53f03896e8fb5a84be0a07863cb46bb8fc13dce58b5db49136928f::signature::get_message(0x2::tx_context::sender(arg7), arg6)), 4);
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(!0x2::vec_map::contains<address, bool>(&arg4.minted, &v0), 5);
        assert!(arg4.isMint || 0x2::tx_context::sender(arg7) == @0xc5d4bad4a3f9e50583a062101119de63d9e4d497ca72398e90c7c626ecaa52b5, 11);
        let v1 = WhalemeNFT{
            id          : 0x2::object::new(arg7),
            name        : 0x1::string::utf8(b"Whaleme"),
            description : 0x1::string::utf8(b"Whaleme makes a dream come true!"),
            url         : 0x2::url::new_unsafe_from_bytes(arg1),
            attributes  : 0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::attributes::from_vec(arg2, arg3),
            tier        : arg6,
            stakedAt    : 0,
            point       : 0,
            supply      : 0x2::vec_map::size<address, bool>(&arg4.minted) + 1,
        };
        let v2 = MintWhalemeNFT{
            minter           : 0x2::tx_context::sender(arg7),
            referrer         : arg0,
            tier             : arg6,
            attribute_keys   : arg2,
            attribute_values : arg3,
            id               : 0x2::object::uid_to_inner(&v1.id),
        };
        0x2::event::emit<MintWhalemeNFT>(v2);
        0x2::transfer::public_transfer<WhalemeNFT>(v1, 0x2::tx_context::sender(arg7));
        if (!(0x2::tx_context::sender(arg7) == @0xc5d4bad4a3f9e50583a062101119de63d9e4d497ca72398e90c7c626ecaa52b5)) {
            0x2::vec_map::insert<address, bool>(&mut arg4.minted, 0x2::tx_context::sender(arg7), true);
        };
        storage_ref(arg0, 0x2::tx_context::sender(arg7), arg4);
        handle_commission(0x2::tx_context::sender(arg7), arg6, arg4);
    }

    public entry fun stake(arg0: WhalemeNFT, arg1: &0x2::clock::Clock, arg2: &mut WhalemeStorage, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::vec_map::contains<address, WhalemeNFT>(&arg2.staked, &v0), 6);
        let v1 = &mut arg0;
        v1.stakedAt = 0xa856e8476e53f03896e8fb5a84be0a07863cb46bb8fc13dce58b5db49136928f::utils::currentTime(arg1);
        let v2 = StakeWhalemeNFT{
            owner : 0x2::tx_context::sender(arg3),
            id    : 0x2::object::uid_to_inner(&v1.id),
            tier  : v1.tier,
            point : v1.point,
        };
        0x2::event::emit<StakeWhalemeNFT>(v2);
        0x2::vec_map::insert<address, WhalemeNFT>(&mut arg2.staked, 0x2::tx_context::sender(arg3), arg0);
    }

    fun storage_ref(arg0: address, arg1: address, arg2: &mut WhalemeStorage) {
        if (!0x2::vec_map::contains<address, address>(&arg2.refMapping, &arg1)) {
            0x2::vec_map::insert<address, address>(&mut arg2.refMapping, arg1, arg0);
        };
    }

    public fun un_stake(arg0: &0x2::clock::Clock, arg1: &mut WhalemeStorage, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_map::contains<address, WhalemeNFT>(&arg1.staked, &v0), 2);
        let v1 = 0x2::tx_context::sender(arg2);
        let (v2, v3) = 0x2::vec_map::remove<address, WhalemeNFT>(&mut arg1.staked, &v1);
        let v4 = v3;
        assert!(v2 == 0x2::tx_context::sender(arg2), 7);
        let v5 = &mut v4;
        let v6 = v5.point + 0xa856e8476e53f03896e8fb5a84be0a07863cb46bb8fc13dce58b5db49136928f::utils::estPoint(arg0, v4.stakedAt, v4.tier);
        v5.point = v6;
        v5.stakedAt = 0;
        let v7 = UnStakeWhalemeNFT{
            owner : 0x2::tx_context::sender(arg2),
            id    : 0x2::object::uid_to_inner(&v5.id),
            tier  : v4.tier,
            point : v6,
        };
        0x2::event::emit<UnStakeWhalemeNFT>(v7);
        0x2::transfer::public_transfer<WhalemeNFT>(v4, 0x2::tx_context::sender(arg2));
        v6
    }

    fun update_claimed(arg0: address, arg1: u64, arg2: &mut WhalemeStorage) {
        let v0 = arg1;
        if (0x2::vec_map::contains<address, u64>(&arg2.claimed, &arg0)) {
            v0 = *0x2::vec_map::get<address, u64>(&arg2.claimed, &arg0) + arg1;
        };
        0xa856e8476e53f03896e8fb5a84be0a07863cb46bb8fc13dce58b5db49136928f::utils::insert_or_update(&mut arg2.claimed, arg0, v0);
    }

    public entry fun upgrade<T0>(arg0: &mut WhalemeNFT, arg1: vector<u8>, arg2: &mut WhalemeStorage, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg3) >= 0xa856e8476e53f03896e8fb5a84be0a07863cb46bb8fc13dce58b5db49136928f::utils::estimateUpgradeFee(arg0.tier + 1), 0);
        assert!(arg0.tier <= 9, 1);
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        assert!(0x2::balance::value<T0>(&v0) >= 0xa856e8476e53f03896e8fb5a84be0a07863cb46bb8fc13dce58b5db49136928f::utils::estimateUpgradeFee(arg0.tier + 1), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg4), @0xc5d4bad4a3f9e50583a062101119de63d9e4d497ca72398e90c7c626ecaa52b5);
        arg0.tier = arg0.tier + 1;
        arg0.url = 0x2::url::new_unsafe_from_bytes(arg1);
        let v1 = UpgradeWhalemeNFT{
            tier  : arg0.tier,
            id    : 0x2::object::uid_to_inner(&arg0.id),
            owner : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<UpgradeWhalemeNFT>(v1);
    }

    public fun view_commission(arg0: address, arg1: &WhalemeStorage) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        if (!0x2::vec_map::contains<address, u64>(&arg1.commission, &arg0)) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            0x1::vector::push_back<u64>(&mut v0, 0);
        } else {
            0x1::vector::push_back<u64>(&mut v0, *0x2::vec_map::get<address, u64>(&arg1.commission, &arg0));
        };
        if (0x2::vec_map::contains<address, u64>(&arg1.claimed, &arg0)) {
            0x1::vector::push_back<u64>(&mut v0, *0x2::vec_map::get<address, u64>(&arg1.claimed, &arg0));
        };
        v0
    }

    public fun view_commission_mapping(arg0: &WhalemeStorage) : 0x2::vec_map::VecMap<address, u64> {
        arg0.commission
    }

    public fun view_minted(arg0: &WhalemeStorage) : 0x2::vec_map::VecMap<address, bool> {
        arg0.minted
    }

    public fun view_nft(arg0: &WhalemeNFT, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : vector<u64> {
        0xa856e8476e53f03896e8fb5a84be0a07863cb46bb8fc13dce58b5db49136928f::utils::currentTime(arg1);
        let v0 = 0;
        if (arg0.stakedAt > 0) {
            v0 = 0xa856e8476e53f03896e8fb5a84be0a07863cb46bb8fc13dce58b5db49136928f::utils::estPoint(arg1, arg0.stakedAt, arg0.tier);
        };
        let v1 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v1, arg0.point + v0);
        v1
    }

    public fun view_nft_staked(arg0: &WhalemeStorage, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : vector<u64> {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::vec_map::get<address, WhalemeNFT>(&arg0.staked, &v0);
        0xa856e8476e53f03896e8fb5a84be0a07863cb46bb8fc13dce58b5db49136928f::utils::currentTime(arg1);
        let v2 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v2, v1.point + 0xa856e8476e53f03896e8fb5a84be0a07863cb46bb8fc13dce58b5db49136928f::utils::estPoint(arg1, v1.stakedAt, v1.tier));
        v2
    }

    public fun view_tier(arg0: &WhalemeNFT) : u64 {
        arg0.tier
    }

    // decompiled from Move bytecode v6
}

