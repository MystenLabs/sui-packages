module 0xb8c681f9d2e0961726173f4dde1d692a9e67673c53359124fdba893bb51fa62c::nft_staking {
    struct NFT_STAKING has drop {
        dummy_field: bool,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        owner: address,
        tier: u8,
        donation_amount: u64,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct StakingTicket has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        owner: address,
    }

    struct NFTCollectionRegistry has key {
        id: 0x2::object::UID,
        nfts: 0x2::table::Table<0x2::object::ID, NFT>,
        tier_counts: vector<u64>,
        owner: address,
    }

    struct StakedNFT has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        owner: address,
    }

    struct StakingPool has key {
        id: 0x2::object::UID,
        staked_nfts: vector<StakedNFT>,
        total_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        user_balances: 0x2::table::Table<address, 0x2::balance::Balance<0x2::sui::SUI>>,
        user_total_payouts: 0x2::table::Table<address, u64>,
        donated_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        owner: address,
    }

    struct SponsorNFTCollection has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        total_minted: u64,
        minted_nfts: 0x2::table::Table<0x2::object::ID, bool>,
        owner_minted_nfts: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct NFTMintedEvent has copy, drop {
        nft_id: 0x2::object::ID,
        tier: u8,
        sender: address,
    }

    struct FeeWithdrawalEvent has copy, drop {
        user: address,
        amount: u64,
    }

    public entry fun add_to_user_balance(arg0: &mut StakingPool, arg1: address, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.user_balances, arg1)) {
            0x2::table::add<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.user_balances, arg1, 0x2::balance::zero<0x2::sui::SUI>());
        };
        0x2::balance::join<0x2::sui::SUI>(0x2::table::borrow_mut<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.user_balances, arg1), 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public fun calculate_nft_holder_percentage(arg0: &StakingPool) : u64 {
        let v0 = 0x1::vector::length<StakedNFT>(&arg0.staked_nfts);
        if (v0 == 0) {
            return 0
        };
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.donated_balance);
        if (v1 == 0) {
            return 0
        };
        v0 * 100 / v1
    }

    fun calculate_tier(arg0: u64) : u8 {
        if (arg0 >= 50000000000000) {
            1
        } else if (arg0 >= 5000000000000) {
            2
        } else if (arg0 >= 1000000000000) {
            3
        } else {
            4
        }
    }

    public entry fun edit_sponsor_nft(arg0: &mut SponsorNFTCollection, arg1: &mut NFTCollectionRegistry, arg2: &mut StakingPool, arg3: &mut NFT, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.owner == 0x2::tx_context::sender(arg5), 1);
        0x2::object::id<NFT>(arg3);
        let v0 = arg3.donation_amount + 0x2::coin::value<0x2::sui::SUI>(&arg4);
        assert!(v0 <= 50000000000000, 4);
        let v1 = calculate_tier(v0);
        if (v1 != arg3.tier) {
            let v2 = ((v1 - 1) as u64);
            let v3 = *0x1::vector::borrow<u64>(&arg1.tier_counts, v2);
            if (v1 == 1) {
                assert!(v3 < 10, 3);
            } else if (v1 == 2) {
                assert!(v3 < 100, 3);
            } else if (v1 == 3) {
                assert!(v3 < 1000, 3);
            } else {
                assert!(v3 < 10000, 3);
            };
            let v4 = ((arg3.tier - 1) as u64);
            *0x1::vector::borrow_mut<u64>(&mut arg1.tier_counts, v4) = *0x1::vector::borrow<u64>(&arg1.tier_counts, v4) - 1;
            *0x1::vector::borrow_mut<u64>(&mut arg1.tier_counts, v2) = v3 + 1;
            arg3.tier = v1;
            let v5 = 0x1::string::utf8(b"Sponsor NFT Tier ");
            0x1::string::append(&mut v5, to_string((v1 as u64)));
            arg3.name = v5;
            let v6 = if (v1 == 1) {
                b"https://bronze-quiet-cuckoo-704.mypinata.cloud/ipfs/bafybeie3tr2dlverq42uhyzce2zecqkndbwxa2pc5sz3yzy35qocwpmjfu"
            } else if (v1 == 2) {
                b"https://bronze-quiet-cuckoo-704.mypinata.cloud/ipfs/bafybeigsfggeajqsg7pzemunarwbw24rc32gijyohqrolofi4mmcgveaom"
            } else if (v1 == 3) {
                b"https://bronze-quiet-cuckoo-704.mypinata.cloud/ipfs/bafkreigpkeztxhquoiiocpf5l5gkkl376rdr3ttukabr7xueopvbh6lqfq"
            } else {
                b"https://bronze-quiet-cuckoo-704.mypinata.cloud/ipfs/bafkreia5jj6zff2simjagmimesoeljqzvma3hxfiu5lwunwbmqxjstps3y"
            };
            arg3.image_url = 0x1::string::utf8(v6);
            let v7 = 0x1::string::utf8(b"An NFT representing a sponsorship donation at tier ");
            0x1::string::append(&mut v7, to_string((v1 as u64)));
            arg3.description = v7;
        };
        arg3.donation_amount = v0;
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.donated_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg4));
    }

    public fun get_collection_total_minted(arg0: &SponsorNFTCollection) : u64 {
        arg0.total_minted
    }

    public fun get_owner(arg0: &StakedNFT) : address {
        arg0.owner
    }

    public fun get_staked_nfts(arg0: &StakingPool) : &vector<StakedNFT> {
        &arg0.staked_nfts
    }

    public fun get_tier(arg0: &StakedNFT, arg1: &NFTCollectionRegistry) : u8 {
        0x2::table::borrow<0x2::object::ID, NFT>(&arg1.nfts, arg0.nft_id).tier
    }

    public fun get_tier_1_percentage() : u64 {
        1000
    }

    public fun get_tier_2_percentage() : u64 {
        100
    }

    public fun get_tier_3_percentage() : u64 {
        10
    }

    public fun get_tier_4_percentage() : u64 {
        1
    }

    public fun get_tier_counts(arg0: &NFTCollectionRegistry) : &vector<u64> {
        &arg0.tier_counts
    }

    public fun get_user_balance(arg0: &StakingPool, arg1: address) : u64 {
        if (0x2::table::contains<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.user_balances, arg1)) {
            0x2::balance::value<0x2::sui::SUI>(0x2::table::borrow<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.user_balances, arg1))
        } else {
            0
        }
    }

    public fun get_user_total_payouts(arg0: &StakingPool, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.user_total_payouts, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.user_total_payouts, arg1)
        } else {
            0
        }
    }

    fun init(arg0: NFT_STAKING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = StakingPool{
            id                 : 0x2::object::new(arg1),
            staked_nfts        : 0x1::vector::empty<StakedNFT>(),
            total_fees         : 0x2::balance::zero<0x2::sui::SUI>(),
            user_balances      : 0x2::table::new<address, 0x2::balance::Balance<0x2::sui::SUI>>(arg1),
            user_total_payouts : 0x2::table::new<address, u64>(arg1),
            donated_balance    : 0x2::balance::zero<0x2::sui::SUI>(),
            owner              : v0,
        };
        0x2::transfer::share_object<StakingPool>(v1);
        let v2 = NFTCollectionRegistry{
            id          : 0x2::object::new(arg1),
            nfts        : 0x2::table::new<0x2::object::ID, NFT>(arg1),
            tier_counts : vector[0, 0, 0, 0],
            owner       : v0,
        };
        0x2::transfer::share_object<NFTCollectionRegistry>(v2);
        let v3 = SponsorNFTCollection{
            id                : 0x2::object::new(arg1),
            name              : 0x1::string::utf8(b"Sponsor NFT Collection"),
            description       : 0x1::string::utf8(b"A collection of NFTs representing sponsorship donations for SuiMail"),
            total_minted      : 0,
            minted_nfts       : 0x2::table::new<0x2::object::ID, bool>(arg1),
            owner_minted_nfts : 0x2::table::new<address, 0x2::object::ID>(arg1),
        };
        0x2::transfer::share_object<SponsorNFTCollection>(v3);
        let v4 = 0x2::package::claim<NFT_STAKING>(arg0, arg1);
        let v5 = 0x2::display::new<NFT>(&v4, arg1);
        0x2::display::add<NFT>(&mut v5, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<NFT>(&mut v5, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<NFT>(&mut v5, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<NFT>(&mut v5, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://suimail.xyz"));
        0x2::display::add<NFT>(&mut v5, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"SuiMail Team"));
        0x2::display::add<NFT>(&mut v5, 0x1::string::utf8(b"tier"), 0x1::string::utf8(b"{tier}"));
        0x2::display::add<NFT>(&mut v5, 0x1::string::utf8(b"donation_amount"), 0x1::string::utf8(b"{donation_amount}"));
        0x2::display::add<NFT>(&mut v5, 0x1::string::utf8(b"collection"), 0x1::string::utf8(b"Sponsor NFT Collection"));
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v0);
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, v0);
    }

    public fun is_nft_in_collection(arg0: &SponsorNFTCollection, arg1: &0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.minted_nfts, *arg1)
    }

    public fun is_valid_nft(arg0: &NFTCollectionRegistry, arg1: &0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, NFT>(&arg0.nfts, *arg1)
    }

    public entry fun mint_sponsor_nft(arg0: &mut SponsorNFTCollection, arg1: &mut NFTCollectionRegistry, arg2: &mut StakingPool, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.owner_minted_nfts, v0), 6);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v1 >= 10000000000, 4);
        assert!(v1 <= 50000000000000, 4);
        let v2 = calculate_tier(v1);
        let v3 = ((v2 - 1) as u64);
        let v4 = *0x1::vector::borrow<u64>(&arg1.tier_counts, v3);
        if (v2 == 1) {
            assert!(v4 < 10, 3);
        } else if (v2 == 2) {
            assert!(v4 < 100, 3);
        } else if (v2 == 3) {
            assert!(v4 < 1000, 3);
        } else {
            assert!(v4 < 10000, 3);
        };
        *0x1::vector::borrow_mut<u64>(&mut arg1.tier_counts, v3) = v4 + 1;
        let v5 = 0x1::string::utf8(b"Sponsor NFT Tier ");
        0x1::string::append(&mut v5, to_string((v2 as u64)));
        let v6 = if (v2 == 1) {
            b"https://bronze-quiet-cuckoo-704.mypinata.cloud/ipfs/bafybeie3tr2dlverq42uhyzce2zecqkndbwxa2pc5sz3yzy35qocwpmjfu"
        } else if (v2 == 2) {
            b"https://bronze-quiet-cuckoo-704.mypinata.cloud/ipfs/bafybeigsfggeajqsg7pzemunarwbw24rc32gijyohqrolofi4mmcgveaom"
        } else if (v2 == 3) {
            b"https://bronze-quiet-cuckoo-704.mypinata.cloud/ipfs/bafkreigpkeztxhquoiiocpf5l5gkkl376rdr3ttukabr7xueopvbh6lqfq"
        } else {
            b"https://bronze-quiet-cuckoo-704.mypinata.cloud/ipfs/bafkreia5jj6zff2simjagmimesoeljqzvma3hxfiu5lwunwbmqxjstps3y"
        };
        let v7 = 0x1::string::utf8(b"An NFT representing a sponsorship donation at tier ");
        0x1::string::append(&mut v7, to_string((v2 as u64)));
        let v8 = NFT{
            id              : 0x2::object::new(arg4),
            owner           : v0,
            tier            : v2,
            donation_amount : v1,
            name            : v5,
            image_url       : 0x1::string::utf8(v6),
            description     : v7,
        };
        let v9 = 0x2::object::id<NFT>(&v8);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.minted_nfts, v9, true);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.owner_minted_nfts, v0, v9);
        arg0.total_minted = arg0.total_minted + 1;
        let v10 = NFTMintedEvent{
            nft_id : v9,
            tier   : v2,
            sender : v0,
        };
        0x2::event::emit<NFTMintedEvent>(v10);
        0x2::transfer::public_transfer<NFT>(v8, v0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.donated_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
    }

    public entry fun stake_nft(arg0: &mut StakingPool, arg1: &mut NFTCollectionRegistry, arg2: NFT, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg2.owner == v0, 1);
        let v1 = 0x2::object::id<NFT>(&arg2);
        let v2 = arg2.tier;
        assert!(v2 >= 1 && v2 <= 4, 2);
        let v3 = StakedNFT{
            id     : 0x2::object::new(arg3),
            nft_id : v1,
            owner  : v0,
        };
        if (!0x2::table::contains<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.user_balances, v0)) {
            0x2::table::add<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.user_balances, v0, 0x2::balance::zero<0x2::sui::SUI>());
        };
        if (!0x2::table::contains<address, u64>(&arg0.user_total_payouts, v0)) {
            0x2::table::add<address, u64>(&mut arg0.user_total_payouts, v0, 0);
        };
        0x1::vector::push_back<StakedNFT>(&mut arg0.staked_nfts, v3);
        0x2::table::add<0x2::object::ID, NFT>(&mut arg1.nfts, v1, arg2);
        let v4 = StakingTicket{
            id     : 0x2::object::new(arg3),
            nft_id : v1,
            owner  : v0,
        };
        0x2::transfer::public_transfer<StakingTicket>(v4, v0);
    }

    fun to_string(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        if (arg0 == 0) {
            0x1::string::append(&mut v0, 0x1::string::utf8(b"0"));
            return v0
        };
        while (arg0 > 0) {
            0x1::string::append(&mut v0, 0x1::string::utf8(0x1::vector::singleton<u8>(((arg0 % 10 + 48) as u8))));
            arg0 = arg0 / 10;
        };
        let v1 = 0x1::string::utf8(b"");
        let v2 = 0x1::string::length(&v0);
        let v3 = 0;
        while (v3 < v2) {
            0x1::string::append(&mut v1, 0x1::string::sub_string(&v0, v2 - v3 - 1, v2 - v3));
            v3 = v3 + 1;
        };
        v1
    }

    public entry fun unstake_nft(arg0: &mut StakingPool, arg1: &mut NFTCollectionRegistry, arg2: StakingTicket, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg2.owner == v0, 1);
        let v1 = 0x1::option::none<u64>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<StakedNFT>(&arg0.staked_nfts)) {
            let v3 = 0x1::vector::borrow<StakedNFT>(&arg0.staked_nfts, v2);
            if (v3.nft_id == arg2.nft_id) {
                assert!(v3.owner == v0, 1);
                v1 = 0x1::option::some<u64>(v2);
                break
            };
            v2 = v2 + 1;
        };
        assert!(0x1::option::is_some<u64>(&v1), 5);
        let StakedNFT {
            id     : v4,
            nft_id : v5,
            owner  : _,
        } = 0x1::vector::remove<StakedNFT>(&mut arg0.staked_nfts, 0x1::option::extract<u64>(&mut v1));
        0x2::object::delete(v4);
        let v7 = 0x2::table::remove<0x2::object::ID, NFT>(&mut arg1.nfts, v5);
        v7.owner = v0;
        0x2::transfer::public_transfer<NFT>(v7, v0);
        let StakingTicket {
            id     : v8,
            nft_id : _,
            owner  : _,
        } = arg2;
        0x2::object::delete(v8);
    }

    public entry fun withdraw_funds(arg0: &mut StakingPool, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.owner, 1);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.donated_balance);
        assert!(v1 > 0, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.donated_balance, v1), arg1), v0);
    }

    public entry fun withdraw_share(arg0: &mut StakingPool, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.user_balances, v0), 1);
        let v1 = 0x2::table::borrow_mut<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.user_balances, v0);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(v1);
        assert!(v2 > 0, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v1, v2), arg1), v0);
        let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_total_payouts, v0);
        *v3 = *v3 + v2;
        let v4 = FeeWithdrawalEvent{
            user   : v0,
            amount : v2,
        };
        0x2::event::emit<FeeWithdrawalEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

