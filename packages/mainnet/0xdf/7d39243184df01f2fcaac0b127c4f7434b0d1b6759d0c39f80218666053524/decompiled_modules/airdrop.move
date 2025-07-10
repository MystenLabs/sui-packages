module 0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::airdrop {
    struct Airdrop has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>,
        is_enabled: bool,
        start_time: u64,
        duration: u64,
        admin_wallet: address,
        slash_percentage: u64,
        minimum_threshold: u64,
    }

    struct VendettaAirdropNFT has key {
        id: 0x2::object::UID,
        allocated_amount: u64,
        initial_token_release: u64,
        start: u64,
        claimed: u64,
        claimed_weeks: u64,
        game_stats: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        milestone_claimed: 0x2::vec_map::VecMap<0x1::string::String, 0x2::vec_map::VecMap<u64, bool>>,
        duration: u64,
    }

    struct GameStatsConfig has store, key {
        id: 0x2::object::UID,
        stats: 0x2::vec_map::VecMap<0x1::string::String, 0x2::vec_map::VecMap<u64, u64>>,
    }

    struct GameCap has store, key {
        id: 0x2::object::UID,
    }

    struct Allocation has store, key {
        id: 0x2::object::UID,
        holders: 0x2::table::Table<address, bool>,
        user_unlocked: 0x2::table::Table<address, u64>,
        total_allocation: u64,
        total_airdropped: u64,
        claimed_count: u64,
    }

    struct AirdropEnabled has copy, drop {
        is_enabled: bool,
    }

    struct FundsAdded has copy, drop {
        total_funds: u64,
    }

    struct NFTMinted has copy, drop {
        recipient: address,
        allocated_amount: u64,
    }

    struct AirdropClaimed has copy, drop {
        recipient: address,
        claimed_amount: u64,
    }

    struct AirdropUnlocked has copy, drop {
        recipient: address,
        unlocked_amount: u64,
    }

    struct MilestoneClaimed has copy, drop {
        recipient: address,
        milestone: 0x1::string::String,
        claimed_amount: u64,
        key: u64,
    }

    struct AIRDROP has drop {
        dummy_field: bool,
    }

    public fun claim(arg0: &mut Airdrop, arg1: &mut VendettaAirdropNFT, arg2: &mut Allocation, arg3: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA> {
        0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::validate_version(arg3, 1);
        assert!(arg0.is_enabled, 2);
        let v0 = arg1.allocated_amount - arg1.claimed;
        assert!(v0 > 0, 0);
        let v1 = if (v0 <= arg0.minimum_threshold) {
            v0
        } else {
            let v2 = claimable(arg1, arg4);
            if (v2 > 0) {
                arg1.claimed_weeks = get_elapsed_weeks(arg1, arg4);
            };
            v2
        };
        arg1.claimed = arg1.claimed + v1;
        arg2.claimed_count = arg2.claimed_count + v1;
        assert!(v1 > 0, 0);
        assert!(arg1.claimed <= arg1.allocated_amount, 0);
        let v3 = AirdropClaimed{
            recipient      : 0x2::tx_context::sender(arg5),
            claimed_amount : v1,
        };
        0x2::event::emit<AirdropClaimed>(v3);
        0x2::coin::from_balance<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(0x2::balance::split<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(&mut arg0.balance, v1), arg5)
    }

    public fun add_admin_wallet(arg0: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::role::AdminCap, arg1: &mut Airdrop, arg2: address, arg3: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::Version) {
        0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::validate_version(arg3, 1);
        assert!(arg2 != @0x0, 9);
        arg1.admin_wallet = arg2;
    }

    public fun add_funds_for_airdrop(arg0: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::role::AdminCap, arg1: &mut Airdrop, arg2: &mut Allocation, arg3: 0x2::coin::Coin<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>, arg4: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::Version) {
        0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::validate_version(arg4, 1);
        arg2.total_allocation = arg2.total_allocation + 0x2::coin::value<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(&arg3);
        0x2::balance::join<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(&mut arg1.balance, 0x2::coin::into_balance<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(arg3));
        let v0 = FundsAdded{total_funds: 0x2::balance::value<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(&arg1.balance)};
        0x2::event::emit<FundsAdded>(v0);
    }

    public fun add_game_stats(arg0: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::role::OperatorCap, arg1: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::role::OperatorCapsBag, arg2: &Airdrop, arg3: 0x1::string::String, arg4: vector<u64>, arg5: vector<u64>, arg6: &mut GameStatsConfig, arg7: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::Version) {
        0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::role::is_operator(arg0, arg1);
        0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::validate_version(arg7, 1);
        assert!(!0x2::vec_map::contains<0x1::string::String, 0x2::vec_map::VecMap<u64, u64>>(&arg6.stats, &arg3), 11);
        assert!(!arg2.is_enabled, 3);
        let v0 = 0x2::vec_map::empty<u64, u64>();
        let v1 = 0;
        let v2 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg4)) {
            assert!(*0x1::vector::borrow<u64>(&arg5, v1) >= 100 && *0x1::vector::borrow<u64>(&arg5, v1) <= 10000, 8);
            assert!(!0x2::vec_map::contains<u64, u64>(&v0, 0x1::vector::borrow<u64>(&arg4, v1)), 11);
            0x2::vec_map::insert<u64, u64>(&mut v0, *0x1::vector::borrow<u64>(&arg4, v1), *0x1::vector::borrow<u64>(&arg5, v1));
            v2 = v2 + *0x1::vector::borrow<u64>(&arg5, v1);
            v1 = v1 + 1;
        };
        0x2::vec_map::insert<0x1::string::String, 0x2::vec_map::VecMap<u64, u64>>(&mut arg6.stats, arg3, v0);
    }

    public fun add_vesting_time_for_airdrop(arg0: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::role::OperatorCap, arg1: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::role::OperatorCapsBag, arg2: &mut Airdrop, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::Version) {
        0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::role::is_operator(arg0, arg1);
        0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::validate_version(arg6, 1);
        assert!(arg4 > 0x2::clock::timestamp_ms(arg3), 6);
        arg2.start_time = arg4;
        arg2.duration = arg5;
    }

    public fun airdrop_nft(arg0: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::role::OperatorCap, arg1: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::role::OperatorCapsBag, arg2: &mut Airdrop, arg3: &GameStatsConfig, arg4: &mut Allocation, arg5: vector<address>, arg6: vector<u64>, arg7: vector<u64>, arg8: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::role::is_operator(arg0, arg1);
        0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::validate_version(arg8, 1);
        assert!(0x1::vector::length<address>(&arg5) == 0x1::vector::length<u64>(&arg6), 7);
        assert!(0x1::vector::length<u64>(&arg6) == 0x1::vector::length<u64>(&arg7), 7);
        assert!(!arg2.is_enabled, 3);
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<address>(&arg5)) {
            assert!(*0x1::vector::borrow<u64>(&arg6, v0) > 0, 0);
            assert!(!0x2::table::contains<address, bool>(&arg4.holders, *0x1::vector::borrow<address>(&arg5, v0)), 5);
            0x2::table::add<address, bool>(&mut arg4.holders, *0x1::vector::borrow<address>(&arg5, v0), true);
            let v2 = 0x2::vec_map::keys<0x1::string::String, 0x2::vec_map::VecMap<u64, u64>>(&arg3.stats);
            assert!(0x1::vector::length<0x1::string::String>(&v2) > 0, 12);
            let v3 = 0x2::vec_map::empty<0x1::string::String, 0x2::vec_map::VecMap<u64, bool>>();
            let v4 = 0x2::vec_map::empty<0x1::string::String, u64>();
            let v5 = 0;
            while (v5 < 0x1::vector::length<0x1::string::String>(&v2)) {
                0x2::vec_map::insert<0x1::string::String, 0x2::vec_map::VecMap<u64, bool>>(&mut v3, *0x1::vector::borrow<0x1::string::String>(&v2, v5), 0x2::vec_map::empty<u64, bool>());
                0x2::vec_map::insert<0x1::string::String, u64>(&mut v4, *0x1::vector::borrow<0x1::string::String>(&v2, v5), 0);
                v5 = v5 + 1;
            };
            let v6 = VendettaAirdropNFT{
                id                    : 0x2::object::new(arg9),
                allocated_amount      : *0x1::vector::borrow<u64>(&arg6, v0),
                initial_token_release : *0x1::vector::borrow<u64>(&arg7, v0),
                start                 : arg2.start_time,
                claimed               : 0,
                claimed_weeks         : 0,
                game_stats            : v4,
                milestone_claimed     : v3,
                duration              : arg2.duration,
            };
            0x2::transfer::transfer<VendettaAirdropNFT>(v6, *0x1::vector::borrow<address>(&arg5, v0));
            v1 = v1 + *0x1::vector::borrow<u64>(&arg6, v0);
            v0 = v0 + 1;
        };
        arg4.total_airdropped = arg4.total_airdropped + v1;
        assert!(v1 <= 0x2::balance::value<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(&arg2.balance), 4);
    }

    public fun amount_to_claim_from_game(arg0: &VendettaAirdropNFT, arg1: &GameStatsConfig, arg2: 0x1::string::String) : (u64, u64) {
        let v0 = 0x2::vec_map::keys<u64, u64>(0x2::vec_map::get<0x1::string::String, 0x2::vec_map::VecMap<u64, u64>>(&arg1.stats, &arg2));
        let v1 = 0x2::vec_map::get<0x1::string::String, u64>(&arg0.game_stats, &arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v0)) {
            let v3 = *0x1::vector::borrow<u64>(&v0, v2);
            if (!0x2::vec_map::contains<u64, bool>(0x2::vec_map::get<0x1::string::String, 0x2::vec_map::VecMap<u64, bool>>(&arg0.milestone_claimed, &arg2), &v3)) {
                if (*v1 >= *0x1::vector::borrow<u64>(&v0, v2)) {
                    return (v3, (percentage((*0x2::vec_map::get<u64, u64>(0x2::vec_map::get<0x1::string::String, 0x2::vec_map::VecMap<u64, u64>>(&arg1.stats, &arg2), &v3) as u128), ((arg0.allocated_amount - arg0.claimed) as u128)) as u64))
                };
                return (v3, 0)
            };
            v2 = v2 + 1;
        };
        (0, 0)
    }

    public fun claim_for_game(arg0: &mut Airdrop, arg1: &mut VendettaAirdropNFT, arg2: &mut Allocation, arg3: &GameStatsConfig, arg4: 0x1::string::String, arg5: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::Version, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA> {
        0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::validate_version(arg5, 1);
        assert!(arg0.is_enabled, 2);
        let v0 = arg1.allocated_amount - arg1.claimed;
        assert!(v0 > 0, 0);
        let v1 = arg1.allocated_amount - arg1.claimed;
        let v2 = v1;
        let v3 = 0;
        if (v1 <= arg0.minimum_threshold) {
            arg1.claimed = arg1.claimed + v1;
        } else {
            assert!(is_eligible_for_game_claim(arg1, arg3, arg4), 13);
            let (v4, v5) = amount_to_claim_from_game(arg1, arg3, arg4);
            v3 = v4;
            v2 = v5;
            0x2::vec_map::insert<u64, bool>(0x2::vec_map::get_mut<0x1::string::String, 0x2::vec_map::VecMap<u64, bool>>(&mut arg1.milestone_claimed, &arg4), v4, true);
            if (arg1.claimed == 0) {
                let v6 = v5 + arg1.initial_token_release;
                v2 = v6;
                arg1.claimed = v6;
            } else {
                arg1.claimed = arg1.claimed + v5;
            };
        };
        arg2.claimed_count = arg2.claimed_count + v2;
        if (v2 > v0) {
            v2 = v0;
        };
        assert!(v2 > 0, 0);
        assert!(arg1.claimed <= arg1.allocated_amount, 0);
        let v7 = MilestoneClaimed{
            recipient      : 0x2::tx_context::sender(arg6),
            milestone      : arg4,
            claimed_amount : v2,
            key            : v3,
        };
        0x2::event::emit<MilestoneClaimed>(v7);
        0x2::coin::from_balance<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(0x2::balance::split<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(&mut arg0.balance, v2), arg6)
    }

    public fun claimable(arg0: &VendettaAirdropNFT, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 < arg0.start) {
            return 0
        };
        let v1 = arg0.allocated_amount - arg0.claimed;
        if (v1 == 0) {
            return 0
        };
        if (v0 >= arg0.start + arg0.duration) {
            return v1
        };
        let v2 = get_elapsed_weeks(arg0, arg1) - arg0.claimed_weeks;
        if (v2 == 0) {
            return 0
        };
        let v3 = 50000000000;
        let v4 = (percentage((v1 as u128), (625 as u128)) as u64);
        let v5 = if (v3 > v4) {
            v3
        } else {
            v4
        };
        let v6 = v5 * v2;
        let v7 = v6;
        if (arg0.claimed == 0) {
            v7 = v6 + arg0.initial_token_release;
        };
        if (v7 > v1) {
            return v1
        };
        v7
    }

    public fun enable_airdrop(arg0: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::role::AdminCap, arg1: &mut Airdrop, arg2: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::Version) {
        0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::validate_version(arg2, 1);
        assert!(arg1.start_time != 0 && arg1.duration != 0, 1);
        arg1.is_enabled = !arg1.is_enabled;
        let v0 = AirdropEnabled{is_enabled: arg1.is_enabled};
        0x2::event::emit<AirdropEnabled>(v0);
    }

    public fun get_airdrop_balance(arg0: &Airdrop) : u64 {
        0x2::balance::value<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(&arg0.balance)
    }

    public fun get_elapsed_weeks(arg0: &VendettaAirdropNFT, arg1: &0x2::clock::Clock) : u64 {
        (0x2::clock::timestamp_ms(arg1) - arg0.start) / 604800000 + 1
    }

    public fun get_total_airdropped(arg0: &Allocation) : u64 {
        arg0.total_airdropped
    }

    public fun get_total_allocation(arg0: &Allocation) : u64 {
        arg0.total_allocation
    }

    public fun get_total_claimed_count(arg0: &Allocation) : u64 {
        arg0.claimed_count
    }

    public fun get_total_unlocked_by_user(arg0: &Allocation, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.user_unlocked, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.user_unlocked, arg1)
        } else {
            0
        }
    }

    fun init(arg0: AIRDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<AIRDROP>(arg0, arg1);
        let v1 = 0x2::display::new<VendettaAirdropNFT>(&v0, arg1);
        0x2::display::add<VendettaAirdropNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Vendetta Airdrop NFT"));
        0x2::display::add<VendettaAirdropNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"The Airdrop NFT for Vendetta"));
        0x2::display::add<VendettaAirdropNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://vendetta-assets.s3.eu-west-1.amazonaws.com/vTokenAssets/vTokenBag.png"));
        0x2::display::update_version<VendettaAirdropNFT>(&mut v1);
        let v2 = Airdrop{
            id                : 0x2::object::new(arg1),
            balance           : 0x2::balance::zero<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(),
            is_enabled        : false,
            start_time        : 0,
            duration          : 0,
            admin_wallet      : @0x0,
            slash_percentage  : 0,
            minimum_threshold : 0,
        };
        let v3 = Allocation{
            id               : 0x2::object::new(arg1),
            holders          : 0x2::table::new<address, bool>(arg1),
            user_unlocked    : 0x2::table::new<address, u64>(arg1),
            total_allocation : 0,
            total_airdropped : 0,
            claimed_count    : 0,
        };
        let v4 = GameStatsConfig{
            id    : 0x2::object::new(arg1),
            stats : 0x2::vec_map::empty<0x1::string::String, 0x2::vec_map::VecMap<u64, u64>>(),
        };
        let v5 = GameCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<GameCap>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Airdrop>(v2);
        0x2::transfer::share_object<GameStatsConfig>(v4);
        0x2::transfer::share_object<Allocation>(v3);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<VendettaAirdropNFT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun is_airdrop_enabled(arg0: &Airdrop) : bool {
        arg0.is_enabled
    }

    public fun is_eligible_for_game_claim(arg0: &VendettaAirdropNFT, arg1: &GameStatsConfig, arg2: 0x1::string::String) : bool {
        let v0 = 0x2::vec_map::keys<u64, u64>(0x2::vec_map::get<0x1::string::String, 0x2::vec_map::VecMap<u64, u64>>(&arg1.stats, &arg2));
        let v1 = 0x2::vec_map::get<0x1::string::String, u64>(&arg0.game_stats, &arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v0)) {
            let v3 = *0x1::vector::borrow<u64>(&v0, v2);
            if (!0x2::vec_map::contains<u64, bool>(0x2::vec_map::get<0x1::string::String, 0x2::vec_map::VecMap<u64, bool>>(&arg0.milestone_claimed, &arg2), &v3)) {
                if (*v1 >= *0x1::vector::borrow<u64>(&v0, v2)) {
                    return true
                };
                return false
            };
            v2 = v2 + 1;
        };
        false
    }

    public fun mint_nft(arg0: &mut Airdrop, arg1: &GameStatsConfig, arg2: &mut Allocation, arg3: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::validate_version(arg3, 1);
        assert!(arg0.is_enabled, 2);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!0x2::table::contains<address, bool>(&arg2.holders, v0), 5);
        0x2::table::add<address, bool>(&mut arg2.holders, v0, true);
        let v1 = 0x2::vec_map::keys<0x1::string::String, 0x2::vec_map::VecMap<u64, u64>>(&arg1.stats);
        assert!(0x1::vector::length<0x1::string::String>(&v1) > 0, 12);
        let v2 = 0x2::vec_map::empty<0x1::string::String, 0x2::vec_map::VecMap<u64, bool>>();
        let v3 = 0x2::vec_map::empty<0x1::string::String, u64>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x1::string::String>(&v1)) {
            0x2::vec_map::insert<0x1::string::String, 0x2::vec_map::VecMap<u64, bool>>(&mut v2, *0x1::vector::borrow<0x1::string::String>(&v1, v4), 0x2::vec_map::empty<u64, bool>());
            0x2::vec_map::insert<0x1::string::String, u64>(&mut v3, *0x1::vector::borrow<0x1::string::String>(&v1, v4), 0);
            v4 = v4 + 1;
        };
        let v5 = VendettaAirdropNFT{
            id                    : 0x2::object::new(arg4),
            allocated_amount      : 0,
            initial_token_release : 0,
            start                 : 0,
            claimed               : 0,
            claimed_weeks         : 0,
            game_stats            : v3,
            milestone_claimed     : v2,
            duration              : 0,
        };
        0x2::transfer::transfer<VendettaAirdropNFT>(v5, v0);
        let v6 = NFTMinted{
            recipient        : v0,
            allocated_amount : 0,
        };
        0x2::event::emit<NFTMinted>(v6);
    }

    fun percentage(arg0: u128, arg1: u128) : u128 {
        arg0 * arg1 / (10000 as u128)
    }

    public fun set_minimum_threshold(arg0: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::role::OperatorCap, arg1: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::role::OperatorCapsBag, arg2: &mut Airdrop, arg3: u64, arg4: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::Version) {
        0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::role::is_operator(arg0, arg1);
        0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::validate_version(arg4, 1);
        assert!(!arg2.is_enabled, 3);
        arg2.minimum_threshold = arg3;
    }

    public fun set_slash_percentage(arg0: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::role::OperatorCap, arg1: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::role::OperatorCapsBag, arg2: &mut Airdrop, arg3: u64, arg4: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::Version) {
        0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::role::is_operator(arg0, arg1);
        0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::validate_version(arg4, 1);
        assert!(arg3 >= 100 && arg3 <= 10000, 8);
        arg2.slash_percentage = arg3;
    }

    public fun unlock_v(arg0: &mut Airdrop, arg1: &mut VendettaAirdropNFT, arg2: &mut Allocation, arg3: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::Version, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA> {
        0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::validate_version(arg3, 1);
        assert!(arg0.is_enabled, 2);
        assert!(arg0.admin_wallet != @0x0, 9);
        assert!(arg0.slash_percentage != 0, 10);
        let v0 = arg1.allocated_amount - arg1.claimed;
        assert!(v0 > 0, 0);
        let v1 = if (v0 <= arg0.minimum_threshold) {
            v0
        } else {
            let v2 = (percentage((v0 as u128), (arg0.slash_percentage as u128)) as u64);
            let v3 = v0 - v2;
            0x2::table::add<address, u64>(&mut arg2.user_unlocked, 0x2::tx_context::sender(arg4), v3);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>>(0x2::coin::from_balance<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(0x2::balance::split<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(&mut arg0.balance, v2), arg4), arg0.admin_wallet);
            v3
        };
        arg1.claimed = arg1.claimed + v0;
        arg2.claimed_count = arg2.claimed_count + v1;
        assert!(arg1.claimed <= arg1.allocated_amount, 0);
        let v4 = AirdropUnlocked{
            recipient       : 0x2::tx_context::sender(arg4),
            unlocked_amount : v1,
        };
        0x2::event::emit<AirdropUnlocked>(v4);
        0x2::coin::from_balance<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(0x2::balance::split<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(&mut arg0.balance, v1), arg4)
    }

    public fun update_user_game_stats(arg0: &mut VendettaAirdropNFT, arg1: &GameCap, arg2: 0x1::string::String) {
        assert!(0x2::vec_map::contains<0x1::string::String, u64>(&arg0.game_stats, &arg2), 12);
        let v0 = 0x2::vec_map::get_mut<0x1::string::String, u64>(&mut arg0.game_stats, &arg2);
        *v0 = *v0 + 1;
    }

    public fun withdraw_airdrop_funds(arg0: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::role::AdminCap, arg1: &mut Airdrop, arg2: &0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin_wallet != @0x0, 9);
        assert!(0x2::balance::value<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(&arg1.balance) > 0, 0);
        assert!(!arg1.is_enabled, 2);
        0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta_version::validate_version(arg2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>>(0x2::coin::from_balance<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(0x2::balance::withdraw_all<0xdf7d39243184df01f2fcaac0b127c4f7434b0d1b6759d0c39f80218666053524::vendetta::VENDETTA>(&mut arg1.balance), arg3), arg1.admin_wallet);
    }

    // decompiled from Move bytecode v6
}

