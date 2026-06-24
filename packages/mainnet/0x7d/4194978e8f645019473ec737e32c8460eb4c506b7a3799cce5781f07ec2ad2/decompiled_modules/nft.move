module 0x7d4194978e8f645019473ec737e32c8460eb4c506b7a3799cce5781f07ec2ad2::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct SuiNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        blob_id: 0x1::string::String,
        number: u64,
        design: 0x1::string::String,
        rarity: 0x1::string::String,
        weight: u64,
        reward_debt: u128,
        title: 0x1::string::String,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        supply: u64,
        minted: u64,
        legendary_minted: u64,
        mint_price: u64,
        treasury: address,
        is_active: bool,
        walrus_aggregator: 0x1::string::String,
        design_blob_ids: vector<0x1::string::String>,
        design_names: vector<0x1::string::String>,
        design_rarities: vector<0x1::string::String>,
        design_queue: vector<u8>,
    }

    struct RewardPool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        reward_per_weight: u128,
        total_weight: u64,
        total_distributed: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintEvent has copy, drop {
        nft_id: 0x2::object::ID,
        minter: address,
        number: u64,
        design: 0x1::string::String,
        rarity: 0x1::string::String,
        weight: u64,
    }

    struct ClaimEvent has copy, drop {
        nft_id: 0x2::object::ID,
        claimer: address,
        amount: u64,
    }

    struct DistributeEvent has copy, drop {
        amount: u64,
        source: u8,
    }

    struct AscendEvent has copy, drop {
        nft_id: 0x2::object::ID,
        ascender: address,
        legendary_number: u64,
        title: 0x1::string::String,
        nfts_burned: u64,
        weight_burned: u64,
        rewards_settled: u64,
    }

    public fun ascend_to_legendary(arg0: &mut Collection, arg1: &mut RewardPool, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: vector<0x2::object::ID>, arg5: vector<0x2::object::ID>, arg6: vector<0x2::object::ID>, arg7: vector<0x2::object::ID>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg0.legendary_minted < 100, 8);
        assert!(!0x1::vector::is_empty<0x1::string::String>(&arg0.design_blob_ids), 5);
        let v0 = required_per_rarity(arg0.legendary_minted);
        assert!(0x1::vector::length<0x2::object::ID>(&arg4) == v0, 9);
        assert!(0x1::vector::length<0x2::object::ID>(&arg5) == v0, 9);
        assert!(0x1::vector::length<0x2::object::ID>(&arg6) == v0, 9);
        assert!(0x1::vector::length<0x2::object::ID>(&arg7) == v0, 9);
        let (v1, v2) = burn_vec(arg1, arg2, arg3, arg4, 0x1::string::utf8(b"Common"));
        let (v3, v4) = burn_vec(arg1, arg2, arg3, arg5, 0x1::string::utf8(b"Uncommon"));
        let (v5, v6) = burn_vec(arg1, arg2, arg3, arg6, 0x1::string::utf8(b"Rare"));
        let (v7, v8) = burn_vec(arg1, arg2, arg3, arg7, 0x1::string::utf8(b"Epic"));
        let v9 = v1 + v3 + v5 + v7;
        let v10 = v2 + v4 + v6 + v8;
        if (v9 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, v9, arg8), 0x2::tx_context::sender(arg8));
        };
        arg1.total_weight = arg1.total_weight - v10;
        arg0.legendary_minted = arg0.legendary_minted + 1;
        let v11 = arg0.legendary_minted;
        let v12 = 0x1::string::utf8(tier_title(arg0.legendary_minted - 1));
        let v13 = weight_for_design(9);
        let v14 = build_nft(arg0.walrus_aggregator, arg0.name, *0x1::vector::borrow<0x1::string::String>(&arg0.design_blob_ids, 9), *0x1::vector::borrow<0x1::string::String>(&arg0.design_names, 9), *0x1::vector::borrow<0x1::string::String>(&arg0.design_rarities, 9), v13, 9900 + v11, arg1.reward_per_weight, v12, 0x1::string::utf8(x"417363656e646564207468726f75676820746865207361637265642072697475616c20e2809420626f726e206f66207361637269666963652066726f6d20616c6c2034206d6f75736520636c616e732e"), arg8);
        arg1.total_weight = arg1.total_weight + v13;
        let v15 = 0x2::object::id<SuiNFT>(&v14);
        let v16 = AscendEvent{
            nft_id           : v15,
            ascender         : 0x2::tx_context::sender(arg8),
            legendary_number : v11,
            title            : v12,
            nfts_burned      : v0 * 4,
            weight_burned    : v10,
            rewards_settled  : v9,
        };
        0x2::event::emit<AscendEvent>(v16);
        0x2::kiosk::place<SuiNFT>(arg2, arg3, v14);
        v15
    }

    public fun bonus_distribute(arg0: &AdminCap, arg1: &mut RewardPool, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        deposit_to_pool(arg1, arg2, 2);
    }

    fun build_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u128, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: &mut 0x2::tx_context::TxContext) : SuiNFT {
        0x1::string::append(&mut arg0, 0x1::string::utf8(b"/"));
        0x1::string::append(&mut arg0, arg2);
        0x1::string::append(&mut arg1, 0x1::string::utf8(b" #"));
        0x1::string::append_utf8(&mut arg1, u64_to_bytes(arg6));
        SuiNFT{
            id          : 0x2::object::new(arg10),
            name        : arg1,
            description : arg9,
            image_url   : 0x2::url::new_unsafe_from_bytes(*0x1::string::as_bytes(&arg0)),
            blob_id     : arg2,
            number      : arg6,
            design      : arg3,
            rarity      : arg4,
            weight      : arg5,
            reward_debt : arg7,
            title       : arg8,
        }
    }

    fun burn_nft(arg0: SuiNFT) {
        let SuiNFT {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            blob_id     : _,
            number      : _,
            design      : _,
            rarity      : _,
            weight      : _,
            reward_debt : _,
            title       : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun burn_vec(arg0: &RewardPool, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: vector<0x2::object::ID>, arg4: 0x1::string::String) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&arg3)) {
            let v3 = 0x2::kiosk::take<SuiNFT>(arg1, arg2, *0x1::vector::borrow<0x2::object::ID>(&arg3, v2));
            assert!(v3.rarity == arg4, 10);
            v0 = v0 + compute_claimable(&v3, arg0);
            v1 = v1 + v3.weight;
            burn_nft(v3);
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun claim_rewards(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut RewardPool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::borrow_mut<SuiNFT>(arg1, arg2, arg0);
        let v1 = compute_claimable(v0, arg3);
        v0.reward_debt = arg3.reward_per_weight;
        assert!(v1 > 0, 7);
        let v2 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg3.balance, v1, arg4), v2);
        let v3 = ClaimEvent{
            nft_id  : arg0,
            claimer : v2,
            amount  : v1,
        };
        0x2::event::emit<ClaimEvent>(v3);
    }

    public fun claim_rewards_batch(arg0: vector<0x2::object::ID>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut RewardPool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg0)) {
            let v2 = 0x2::kiosk::borrow_mut<SuiNFT>(arg1, arg2, *0x1::vector::borrow<0x2::object::ID>(&arg0, v1));
            v2.reward_debt = arg3.reward_per_weight;
            v0 = v0 + compute_claimable(v2, arg3);
            v1 = v1 + 1;
        };
        assert!(v0 > 0, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg3.balance, v0, arg4), 0x2::tx_context::sender(arg4));
    }

    fun compute_claimable(arg0: &SuiNFT, arg1: &RewardPool) : u64 {
        if (arg1.reward_per_weight <= arg0.reward_debt) {
            return 0
        };
        (((arg1.reward_per_weight - arg0.reward_debt) * (arg0.weight as u128) / 1000000000000) as u64)
    }

    fun deposit_to_pool(arg0: &mut RewardPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u8) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        if (v0 == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
            return
        };
        if (arg0.total_weight > 0) {
            arg0.reward_per_weight = arg0.reward_per_weight + (v0 as u128) * 1000000000000 / (arg0.total_weight as u128);
        };
        arg0.total_distributed = arg0.total_distributed + v0;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = DistributeEvent{
            amount : v0,
            source : arg2,
        };
        0x2::event::emit<DistributeEvent>(v1);
    }

    public fun designs_loaded(arg0: &Collection) : u64 {
        0x1::vector::length<0x1::string::String>(&arg0.design_blob_ids)
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = 0x2::display::new<SuiNFT>(&v0, arg1);
        0x2::display::add<SuiNFT>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<SuiNFT>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<SuiNFT>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<SuiNFT>(&mut v2, 0x1::string::utf8(b"number"), 0x1::string::utf8(b"{number}"));
        0x2::display::add<SuiNFT>(&mut v2, 0x1::string::utf8(b"design"), 0x1::string::utf8(b"{design}"));
        0x2::display::add<SuiNFT>(&mut v2, 0x1::string::utf8(b"rarity"), 0x1::string::utf8(b"{rarity}"));
        0x2::display::add<SuiNFT>(&mut v2, 0x1::string::utf8(b"weight"), 0x1::string::utf8(b"{weight}"));
        0x2::display::add<SuiNFT>(&mut v2, 0x1::string::utf8(b"title"), 0x1::string::utf8(b"{title}"));
        0x2::display::add<SuiNFT>(&mut v2, 0x1::string::utf8(b"blob_id"), 0x1::string::utf8(b"{blob_id}"));
        0x2::display::add<SuiNFT>(&mut v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://spacemouseonsui.xyz/"));
        0x2::display::add<SuiNFT>(&mut v2, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://spacemouseonsui.xyz/"));
        0x2::display::add<SuiNFT>(&mut v2, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Space Mouse SUI"));
        0x2::display::add<SuiNFT>(&mut v2, 0x1::string::utf8(b"twitter"), 0x1::string::utf8(b"https://x.com/SpaceMouseSui"));
        0x2::display::update_version<SuiNFT>(&mut v2);
        let (v3, v4) = 0x2::transfer_policy::new<SuiNFT>(&v0, arg1);
        let v5 = v4;
        let v6 = v3;
        0x7d4194978e8f645019473ec737e32c8460eb4c506b7a3799cce5781f07ec2ad2::royalty_rule::add<SuiNFT>(&mut v6, &v5, 200, 0);
        let v7 = Collection{
            id                : 0x2::object::new(arg1),
            name              : 0x1::string::utf8(b"Space Mouse SUI"),
            supply            : 10000,
            minted            : 0,
            legendary_minted  : 0,
            mint_price        : 10000000000,
            treasury          : @0x72fb6101d12f0c4f35374b50d939f836f2878e695bb559679c823a9ae7fc25d5,
            is_active         : false,
            walrus_aggregator : 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs"),
            design_blob_ids   : 0x1::vector::empty<0x1::string::String>(),
            design_names      : 0x1::vector::empty<0x1::string::String>(),
            design_rarities   : 0x1::vector::empty<0x1::string::String>(),
            design_queue      : b"",
        };
        let v8 = RewardPool{
            id                : 0x2::object::new(arg1),
            balance           : 0x2::balance::zero<0x2::sui::SUI>(),
            reward_per_weight : 0,
            total_weight      : 0,
            total_distributed : 0,
        };
        0x2::transfer::share_object<Collection>(v7);
        0x2::transfer::share_object<RewardPool>(v8);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<SuiNFT>>(v6);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<SuiNFT>>(v5, v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v1);
        0x2::transfer::public_transfer<0x2::display::Display<SuiNFT>>(v2, v1);
        let v9 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v9, v1);
    }

    public fun is_active(arg0: &Collection) : bool {
        arg0.is_active
    }

    public fun legendary_minted(arg0: &Collection) : u64 {
        arg0.legendary_minted
    }

    public fun load_design_queue(arg0: &AdminCap, arg1: &mut Collection, arg2: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1.design_queue) + 0x1::vector::length<u8>(&arg2) <= 9900, 4);
        0x1::vector::append<u8>(&mut arg1.design_queue, arg2);
    }

    public fun load_designs(arg0: &AdminCap, arg1: &mut Collection, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>) {
        arg1.design_blob_ids = arg2;
        arg1.design_names = arg3;
        arg1.design_rarities = arg4;
    }

    public fun mint(arg0: &mut Collection, arg1: &mut RewardPool, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg0.is_active, 2);
        assert!(arg0.minted < 9900, 0);
        assert!(!0x1::vector::is_empty<u8>(&arg0.design_queue), 3);
        assert!(!0x1::vector::is_empty<0x1::string::String>(&arg0.design_blob_ids), 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= arg0.mint_price, 1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        if (v0 > arg0.mint_price) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v0 - arg0.mint_price, arg5), 0x2::tx_context::sender(arg5));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, arg0.mint_price * 10 / 100, arg5), arg0.treasury);
        deposit_to_pool(arg1, arg4, 0);
        arg0.minted = arg0.minted + 1;
        let v1 = arg0.minted;
        let v2 = (0x1::vector::pop_back<u8>(&mut arg0.design_queue) as u64);
        assert!(v2 < 0x1::vector::length<0x1::string::String>(&arg0.design_blob_ids), 6);
        let v3 = *0x1::vector::borrow<0x1::string::String>(&arg0.design_names, v2);
        let v4 = *0x1::vector::borrow<0x1::string::String>(&arg0.design_rarities, v2);
        let v5 = weight_for_design(v2);
        let v6 = build_nft(arg0.walrus_aggregator, arg0.name, *0x1::vector::borrow<0x1::string::String>(&arg0.design_blob_ids, v2), v3, v4, v5, v1, arg1.reward_per_weight, 0x1::string::utf8(b""), 0x1::string::utf8(b"Space Mouse SUI is a collection of 10,000 mice exploring the Sui ecosystem."), arg5);
        arg1.total_weight = arg1.total_weight + v5;
        let v7 = 0x2::object::id<SuiNFT>(&v6);
        let v8 = MintEvent{
            nft_id : v7,
            minter : 0x2::tx_context::sender(arg5),
            number : v1,
            design : v3,
            rarity : v4,
            weight : v5,
        };
        0x2::event::emit<MintEvent>(v8);
        0x2::kiosk::place<SuiNFT>(arg2, arg3, v6);
        v7
    }

    public fun mint_price(arg0: &Collection) : u64 {
        arg0.mint_price
    }

    public fun mint_with_new_kiosk(arg0: &mut Collection, arg1: &mut RewardPool, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg3);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        mint(arg0, arg1, v4, &v2, arg2, arg3);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, 0x2::tx_context::sender(arg3));
    }

    public fun minted(arg0: &Collection) : u64 {
        arg0.minted
    }

    public fun next_ascension_tier(arg0: &Collection) : (u64, u64, 0x1::string::String) {
        let v0 = required_per_rarity(arg0.legendary_minted);
        (v0, v0 * 4, 0x1::string::utf8(tier_title(arg0.legendary_minted)))
    }

    public fun nft_rarity(arg0: &SuiNFT) : 0x1::string::String {
        arg0.rarity
    }

    public fun nft_title(arg0: &SuiNFT) : 0x1::string::String {
        arg0.title
    }

    public fun nft_weight(arg0: &SuiNFT) : u64 {
        arg0.weight
    }

    public fun pending_rewards(arg0: &SuiNFT, arg1: &RewardPool) : u64 {
        compute_claimable(arg0, arg1)
    }

    public fun pool_balance(arg0: &RewardPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun pool_total_distributed(arg0: &RewardPool) : u64 {
        arg0.total_distributed
    }

    public fun pool_total_weight(arg0: &RewardPool) : u64 {
        arg0.total_weight
    }

    public fun queue_remaining(arg0: &Collection) : u64 {
        0x1::vector::length<u8>(&arg0.design_queue)
    }

    fun required_per_rarity(arg0: u64) : u64 {
        if (arg0 < 25) {
            1
        } else if (arg0 < 50) {
            2
        } else if (arg0 < 75) {
            3
        } else {
            4
        }
    }

    public fun set_active(arg0: &AdminCap, arg1: &mut Collection, arg2: bool) {
        arg1.is_active = arg2;
    }

    public fun set_name(arg0: &AdminCap, arg1: &mut Collection, arg2: 0x1::string::String) {
        arg1.name = arg2;
    }

    public fun set_walrus_aggregator(arg0: &AdminCap, arg1: &mut Collection, arg2: 0x1::string::String) {
        arg1.walrus_aggregator = arg2;
    }

    public fun supply(arg0: &Collection) : u64 {
        arg0.supply
    }

    fun tier_title(arg0: u64) : vector<u8> {
        if (arg0 < 25) {
            b"First Ascender"
        } else if (arg0 < 50) {
            b"Elder"
        } else if (arg0 < 75) {
            b"Architect"
        } else {
            b"Eternal Council"
        }
    }

    fun u64_to_bytes(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = b"";
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    fun weight_for_design(arg0: u64) : u64 {
        if (arg0 <= 3) {
            1
        } else if (arg0 <= 5) {
            3
        } else if (arg0 <= 7) {
            8
        } else if (arg0 == 8) {
            20
        } else {
            50
        }
    }

    public fun withdraw_royalties(arg0: &AdminCap, arg1: &mut 0x2::transfer_policy::TransferPolicy<SuiNFT>, arg2: &0x2::transfer_policy::TransferPolicyCap<SuiNFT>, arg3: &mut RewardPool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7d4194978e8f645019473ec737e32c8460eb4c506b7a3799cce5781f07ec2ad2::royalty_rule::withdraw_royalties<SuiNFT>(arg1, arg2, arg4);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        if (v1 == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v0, v1 * 10 / 100, arg4), @0x72fb6101d12f0c4f35374b50d939f836f2878e695bb559679c823a9ae7fc25d5);
        deposit_to_pool(arg3, v0, 1);
    }

    // decompiled from Move bytecode v7
}

