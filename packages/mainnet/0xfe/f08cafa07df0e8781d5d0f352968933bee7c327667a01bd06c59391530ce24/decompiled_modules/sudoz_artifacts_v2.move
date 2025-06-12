module 0xfef08cafa07df0e8781d5d0f352968933bee7c327667a01bd06c59391530ce24::sudoz_artifacts_v2 {
    struct SudozArtifact has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        number: u64,
        level: u64,
        points: u64,
        path: 0x1::option::Option<u8>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalStats has key {
        id: 0x2::object::UID,
        artifacts_minted: u64,
        artifacts_burned: u64,
        founder_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        dev_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        level_10_burns: u64,
        burn_mechanisms_enabled: bool,
        burn_records: 0x2::table::Table<address, BurnRecord>,
        evolution_auth: 0x1::option::Option<0xfef08cafa07df0e8781d5d0f352968933bee7c327667a01bd06c59391530ce24::evolved_sudoz::EvolutionAuth>,
    }

    struct BurnRecord has store {
        refund_burns: u64,
        refund_amount_claimed: u64,
        reward_burns: u64,
        total_points_accumulated: u64,
        burned_nfts: vector<BurnedNFT>,
    }

    struct BurnedNFT has store {
        nft_number: u64,
        level: u64,
        points: u64,
        path: 0x1::option::Option<u8>,
        burn_type: u8,
        timestamp: u64,
    }

    struct SUDOZ_ARTIFACTS_V2 has drop {
        dummy_field: bool,
    }

    struct ArtifactMinted has copy, drop {
        object_id: 0x2::object::ID,
        recipient: address,
        number: u64,
    }

    struct ArtifactUpgraded has copy, drop {
        artifact_id: 0x2::object::ID,
        old_level: u64,
        new_level: u64,
        path_selected: 0x1::option::Option<u8>,
        upgrade_cost: u64,
    }

    struct PathSelected has copy, drop {
        artifact_id: 0x2::object::ID,
        path: u8,
        path_name: 0x1::string::String,
    }

    struct ArtifactBurned has copy, drop {
        artifact_id: 0x2::object::ID,
        artifact_number: u64,
        level: u64,
    }

    struct ArtifactBurnedForEvolved has copy, drop {
        artifact_id: 0x2::object::ID,
        evolved_id: 0x2::object::ID,
        artifact_number: u64,
        evolved_number: u64,
    }

    struct NFTBurnedForRefund has copy, drop {
        burner: address,
        nft_number: u64,
        level: u64,
        refund_amount: u64,
    }

    struct NFTBurnedForRewards has copy, drop {
        burner: address,
        nft_number: u64,
        level: u64,
        points: u64,
    }

    struct RevenueSplit has copy, drop {
        total_payment: u64,
        to_dev_pool: u64,
        to_founder_pool: u64,
    }

    struct RefundFromFounderPool has copy, drop {
        refund_amount: u64,
        remaining_founder_balance: u64,
        dev_pool_untouched: u64,
    }

    struct DevPoolWithdrawn has copy, drop {
        amount: u64,
        withdrawn_by: address,
        timestamp: u64,
    }

    struct FounderPoolWithdrawn has copy, drop {
        amount: u64,
        withdrawn_by: address,
        timestamp: u64,
    }

    public entry fun batch_mint_artifacts(arg0: &AdminCap, arg1: address, arg2: u64, arg3: &mut GlobalStats, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0 && arg2 <= 100, 6);
        let v0 = 0;
        while (v0 < arg2) {
            mint_artifact(arg0, arg1, arg3, arg4);
            v0 = v0 + 1;
        };
    }

    fun burn_artifact_internal(arg0: SudozArtifact, arg1: &mut GlobalStats) {
        let SudozArtifact {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            number      : _,
            level       : _,
            points      : _,
            path        : _,
        } = arg0;
        0x2::object::delete(v0);
        arg1.artifacts_burned = arg1.artifacts_burned + 1;
        let v8 = ArtifactBurned{
            artifact_id     : 0x2::object::uid_to_inner(&arg0.id),
            artifact_number : arg0.number,
            level           : arg0.level,
        };
        0x2::event::emit<ArtifactBurned>(v8);
    }

    public fun burn_for_refund(arg0: SudozArtifact, arg1: &mut GlobalStats, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg1.burn_mechanisms_enabled, 7);
        assert!(arg0.level >= 5, 9);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = arg0.number;
        let v2 = arg0.level;
        let v3 = v2 * 1000000000;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.founder_pool) >= v3, 20);
        if (!0x2::table::contains<address, BurnRecord>(&arg1.burn_records, v0)) {
            let v4 = BurnRecord{
                refund_burns             : 0,
                refund_amount_claimed    : 0,
                reward_burns             : 0,
                total_points_accumulated : 0,
                burned_nfts              : 0x1::vector::empty<BurnedNFT>(),
            };
            0x2::table::add<address, BurnRecord>(&mut arg1.burn_records, v0, v4);
        };
        let v5 = 0x2::table::borrow_mut<address, BurnRecord>(&mut arg1.burn_records, v0);
        v5.refund_burns = v5.refund_burns + 1;
        v5.refund_amount_claimed = v5.refund_amount_claimed + v3;
        let v6 = BurnedNFT{
            nft_number : v1,
            level      : v2,
            points     : arg0.points,
            path       : arg0.path,
            burn_type  : 0,
            timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x1::vector::push_back<BurnedNFT>(&mut v5.burned_nfts, v6);
        let v7 = NFTBurnedForRefund{
            burner        : v0,
            nft_number    : v1,
            level         : v2,
            refund_amount : v3,
        };
        0x2::event::emit<NFTBurnedForRefund>(v7);
        burn_artifact_internal(arg0, arg1);
        let v8 = RefundFromFounderPool{
            refund_amount             : v3,
            remaining_founder_balance : 0x2::balance::value<0x2::sui::SUI>(&arg1.founder_pool),
            dev_pool_untouched        : 0x2::balance::value<0x2::sui::SUI>(&arg1.dev_pool),
        };
        0x2::event::emit<RefundFromFounderPool>(v8);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.founder_pool, v3), arg2)
    }

    public fun burn_for_rewards(arg0: SudozArtifact, arg1: &mut GlobalStats, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.burn_mechanisms_enabled, 7);
        assert!(arg0.level >= 3, 10);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = arg0.number;
        let v2 = arg0.level;
        let v3 = arg0.points;
        if (!0x2::table::contains<address, BurnRecord>(&arg1.burn_records, v0)) {
            let v4 = BurnRecord{
                refund_burns             : 0,
                refund_amount_claimed    : 0,
                reward_burns             : 0,
                total_points_accumulated : 0,
                burned_nfts              : 0x1::vector::empty<BurnedNFT>(),
            };
            0x2::table::add<address, BurnRecord>(&mut arg1.burn_records, v0, v4);
        };
        let v5 = 0x2::table::borrow_mut<address, BurnRecord>(&mut arg1.burn_records, v0);
        v5.reward_burns = v5.reward_burns + 1;
        v5.total_points_accumulated = v5.total_points_accumulated + v3;
        let v6 = BurnedNFT{
            nft_number : v1,
            level      : v2,
            points     : v3,
            path       : arg0.path,
            burn_type  : 1,
            timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x1::vector::push_back<BurnedNFT>(&mut v5.burned_nfts, v6);
        let v7 = NFTBurnedForRewards{
            burner     : v0,
            nft_number : v1,
            level      : v2,
            points     : v3,
        };
        0x2::event::emit<NFTBurnedForRewards>(v7);
        burn_artifact_internal(arg0, arg1);
    }

    public entry fun create_admin_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<AdminCap>(v0, arg1);
    }

    public fun enable_burn_mechanisms(arg0: &AdminCap, arg1: &mut GlobalStats, arg2: &0xfef08cafa07df0e8781d5d0f352968933bee7c327667a01bd06c59391530ce24::evolved_sudoz::EvolvedStats) {
        assert!(0xfef08cafa07df0e8781d5d0f352968933bee7c327667a01bd06c59391530ce24::evolved_sudoz::get_evolved_minted(arg2) >= 5555, 7);
        arg1.burn_mechanisms_enabled = true;
    }

    public entry fun entry_evolve_artifact(arg0: SudozArtifact, arg1: &mut GlobalStats, arg2: &mut 0xfef08cafa07df0e8781d5d0f352968933bee7c327667a01bd06c59391530ce24::evolved_sudoz::EvolvedStats, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        evolve_artifact(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun entry_evolve_artifact_with_attributes(arg0: SudozArtifact, arg1: &mut GlobalStats, arg2: &mut 0xfef08cafa07df0e8781d5d0f352968933bee7c327667a01bd06c59391530ce24::evolved_sudoz::EvolvedStats, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        evolve_artifact_with_attributes(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun entry_upgrade_level(arg0: &mut SudozArtifact, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut GlobalStats, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        upgrade_level(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun entry_upgrade_to_level(arg0: &mut SudozArtifact, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut GlobalStats, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        upgrade_to_level(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun evolve_artifact(arg0: SudozArtifact, arg1: &mut GlobalStats, arg2: &mut 0xfef08cafa07df0e8781d5d0f352968933bee7c327667a01bd06c59391530ce24::evolved_sudoz::EvolvedStats, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.level == 10, 8);
        let v0 = arg0.number;
        let SudozArtifact {
            id          : v1,
            name        : _,
            description : _,
            image_url   : _,
            number      : _,
            level       : _,
            points      : _,
            path        : _,
        } = arg0;
        0x2::object::delete(v1);
        arg1.artifacts_burned = arg1.artifacts_burned + 1;
        arg1.level_10_burns = arg1.level_10_burns + 1;
        assert!(0x1::option::is_some<0xfef08cafa07df0e8781d5d0f352968933bee7c327667a01bd06c59391530ce24::evolved_sudoz::EvolutionAuth>(&arg1.evolution_auth), 7);
        let v9 = 0x1::vector::empty<0x1::string::String>();
        let v10 = &mut v9;
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"Background"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"Skin"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"Clothes"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"Hats"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"Eyewear"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"Mouth"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"Earrings"));
        let v11 = 0x1::vector::empty<0x1::string::String>();
        let v12 = &mut v11;
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"Unknown"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"Unknown"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"Unknown"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"Unknown"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"Unknown"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"Unknown"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"Unknown"));
        let v13 = 0xfef08cafa07df0e8781d5d0f352968933bee7c327667a01bd06c59391530ce24::evolved_sudoz::mint_evolved_for_evolution(0x1::option::borrow<0xfef08cafa07df0e8781d5d0f352968933bee7c327667a01bd06c59391530ce24::evolved_sudoz::EvolutionAuth>(&arg1.evolution_auth), v0, *0x1::option::borrow<u8>(&arg0.path), v9, v11, arg2, arg3, arg4);
        let v14 = ArtifactBurnedForEvolved{
            artifact_id     : 0x2::object::uid_to_inner(&arg0.id),
            evolved_id      : 0x2::object::id<0xfef08cafa07df0e8781d5d0f352968933bee7c327667a01bd06c59391530ce24::evolved_sudoz::EvolvedSudoz>(&v13),
            artifact_number : v0,
            evolved_number  : 0xfef08cafa07df0e8781d5d0f352968933bee7c327667a01bd06c59391530ce24::evolved_sudoz::get_evolved_number(&v13),
        };
        0x2::event::emit<ArtifactBurnedForEvolved>(v14);
        0x2::transfer::public_transfer<0xfef08cafa07df0e8781d5d0f352968933bee7c327667a01bd06c59391530ce24::evolved_sudoz::EvolvedSudoz>(v13, 0x2::tx_context::sender(arg4));
    }

    public fun evolve_artifact_with_attributes(arg0: SudozArtifact, arg1: &mut GlobalStats, arg2: &mut 0xfef08cafa07df0e8781d5d0f352968933bee7c327667a01bd06c59391530ce24::evolved_sudoz::EvolvedStats, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.level == 10, 8);
        let v0 = arg0.number;
        let SudozArtifact {
            id          : v1,
            name        : _,
            description : _,
            image_url   : _,
            number      : _,
            level       : _,
            points      : _,
            path        : _,
        } = arg0;
        0x2::object::delete(v1);
        arg1.artifacts_burned = arg1.artifacts_burned + 1;
        arg1.level_10_burns = arg1.level_10_burns + 1;
        assert!(0x1::option::is_some<0xfef08cafa07df0e8781d5d0f352968933bee7c327667a01bd06c59391530ce24::evolved_sudoz::EvolutionAuth>(&arg1.evolution_auth), 7);
        let v9 = 0xfef08cafa07df0e8781d5d0f352968933bee7c327667a01bd06c59391530ce24::evolved_sudoz::mint_evolved_for_evolution(0x1::option::borrow<0xfef08cafa07df0e8781d5d0f352968933bee7c327667a01bd06c59391530ce24::evolved_sudoz::EvolutionAuth>(&arg1.evolution_auth), v0, *0x1::option::borrow<u8>(&arg0.path), arg3, arg4, arg2, arg5, arg6);
        let v10 = ArtifactBurnedForEvolved{
            artifact_id     : 0x2::object::uid_to_inner(&arg0.id),
            evolved_id      : 0x2::object::id<0xfef08cafa07df0e8781d5d0f352968933bee7c327667a01bd06c59391530ce24::evolved_sudoz::EvolvedSudoz>(&v9),
            artifact_number : v0,
            evolved_number  : 0xfef08cafa07df0e8781d5d0f352968933bee7c327667a01bd06c59391530ce24::evolved_sudoz::get_evolved_number(&v9),
        };
        0x2::event::emit<ArtifactBurnedForEvolved>(v10);
        0x2::transfer::public_transfer<0xfef08cafa07df0e8781d5d0f352968933bee7c327667a01bd06c59391530ce24::evolved_sudoz::EvolvedSudoz>(v9, 0x2::tx_context::sender(arg6));
    }

    public fun get_artifacts_burned(arg0: &GlobalStats) : u64 {
        arg0.artifacts_burned
    }

    public fun get_artifacts_minted(arg0: &GlobalStats) : u64 {
        arg0.artifacts_minted
    }

    public fun get_burn_record(arg0: &GlobalStats, arg1: address) : (u64, u64, u64, u64) {
        if (!0x2::table::contains<address, BurnRecord>(&arg0.burn_records, arg1)) {
            return (0, 0, 0, 0)
        };
        let v0 = 0x2::table::borrow<address, BurnRecord>(&arg0.burn_records, arg1);
        (v0.refund_burns, v0.refund_amount_claimed, v0.reward_burns, v0.total_points_accumulated)
    }

    public fun get_dev_pool_balance(arg0: &GlobalStats) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.dev_pool)
    }

    public fun get_founder_pool_balance(arg0: &GlobalStats) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.founder_pool)
    }

    fun get_image_url(arg0: u64, arg1: 0x1::option::Option<u8>) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"https://walrus.tusky.io/tVHvHhsxTrqh4jMdJCkB8tlXy4IS0_I-onA7QKgIuH4")
        } else if (arg0 >= 8) {
            if (arg0 == 8) {
                0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/shared/level8.webp")
            } else if (arg0 == 9) {
                0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/shared/level9.webp")
            } else {
                0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/shared/level10.webp")
            }
        } else {
            let v1 = *0x1::option::borrow<u8>(&arg1);
            if (v1 == 0) {
                if (arg0 == 1) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/frostbark/level1.webp")
                } else if (arg0 == 2) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/frostbark/level2.webp")
                } else if (arg0 == 3) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/frostbark/level3.webp")
                } else if (arg0 == 4) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/frostbark/level4.webp")
                } else if (arg0 == 5) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/frostbark/level5.webp")
                } else if (arg0 == 6) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/frostbark/level6.webp")
                } else {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/frostbark/level7.webp")
                }
            } else if (v1 == 1) {
                if (arg0 == 1) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/toxinpup/level1.webp")
                } else if (arg0 == 2) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/toxinpup/level2.webp")
                } else if (arg0 == 3) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/toxinpup/level3.webp")
                } else if (arg0 == 4) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/toxinpup/level4.webp")
                } else if (arg0 == 5) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/toxinpup/level5.webp")
                } else if (arg0 == 6) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/toxinpup/level6.webp")
                } else {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/toxinpup/level7.webp")
                }
            } else if (v1 == 2) {
                if (arg0 == 1) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/cryoblink/level1.webp")
                } else if (arg0 == 2) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/cryoblink/level2.webp")
                } else if (arg0 == 3) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/cryoblink/level3.webp")
                } else if (arg0 == 4) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/cryoblink/level4.webp")
                } else if (arg0 == 5) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/cryoblink/level5.webp")
                } else if (arg0 == 6) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/cryoblink/level6.webp")
                } else {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/cryoblink/level7.webp")
                }
            } else if (v1 == 3) {
                if (arg0 == 1) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/emberfang/level1.webp")
                } else if (arg0 == 2) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/emberfang/level2.webp")
                } else if (arg0 == 3) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/emberfang/level3.webp")
                } else if (arg0 == 4) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/emberfang/level4.webp")
                } else if (arg0 == 5) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/emberfang/level5.webp")
                } else if (arg0 == 6) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/emberfang/level6.webp")
                } else {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/emberfang/level7.webp")
                }
            } else if (v1 == 4) {
                if (arg0 == 1) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/glitchtail/level1.webp")
                } else if (arg0 == 2) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/glitchtail/level2.webp")
                } else if (arg0 == 3) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/glitchtail/level3.webp")
                } else if (arg0 == 4) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/glitchtail/level4.webp")
                } else if (arg0 == 5) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/glitchtail/level5.webp")
                } else if (arg0 == 6) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/glitchtail/level6.webp")
                } else {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/glitchtail/level7.webp")
                }
            } else if (v1 == 5) {
                if (arg0 == 1) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/aurapup/level1.webp")
                } else if (arg0 == 2) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/aurapup/level2.webp")
                } else if (arg0 == 3) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/aurapup/level3.webp")
                } else if (arg0 == 4) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/aurapup/level4.webp")
                } else if (arg0 == 5) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/aurapup/level5.webp")
                } else if (arg0 == 6) {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/aurapup/level6.webp")
                } else {
                    0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/aurapup/level7.webp")
                }
            } else if (arg0 == 1) {
                0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/voidpaw/level1.webp")
            } else if (arg0 == 2) {
                0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/voidpaw/level2.webp")
            } else if (arg0 == 3) {
                0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/voidpaw/level3.webp")
            } else if (arg0 == 4) {
                0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/voidpaw/level4.webp")
            } else if (arg0 == 5) {
                0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/voidpaw/level5.webp")
            } else if (arg0 == 6) {
                0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/voidpaw/level6.webp")
            } else {
                0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiefcgd7fd63zjlmagfrr5nmf64s3vjr2m7sc7ocfnsn4nplmjvnt4/voidpaw/level7.webp")
            }
        }
    }

    public fun get_level(arg0: &SudozArtifact) : u64 {
        arg0.level
    }

    public fun get_level_10_burns(arg0: &GlobalStats) : u64 {
        arg0.level_10_burns
    }

    public fun get_name(arg0: &SudozArtifact) : 0x1::string::String {
        arg0.name
    }

    public fun get_number(arg0: &SudozArtifact) : u64 {
        arg0.number
    }

    public fun get_path(arg0: &SudozArtifact) : 0x1::option::Option<u8> {
        arg0.path
    }

    fun get_path_name(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"SUDO-A5 Frostbark")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"SUDO-E8 Toxinpup")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"SUDO-N0 Cryoblink")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"SUDO-V9 Emberfang")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"SUDO-X7 Glitchtail")
        } else if (arg0 == 5) {
            0x1::string::utf8(b"SUDO-Z1 Aurapup")
        } else {
            0x1::string::utf8(b"SUDO-Z3 Voidpaw")
        }
    }

    public fun get_points(arg0: &SudozArtifact) : u64 {
        arg0.points
    }

    public fun get_pool_balances(arg0: &GlobalStats) : (u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.dev_pool), 0x2::balance::value<0x2::sui::SUI>(&arg0.founder_pool))
    }

    fun init(arg0: SUDOZ_ARTIFACTS_V2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SUDOZ_ARTIFACTS_V2>(arg0, arg1);
        let v1 = 0x2::display::new<SudozArtifact>(&v0, arg1);
        0x2::display::add<SudozArtifact>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<SudozArtifact>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<SudozArtifact>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<SudozArtifact>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://sudoz.xyz"));
        0x2::display::add<SudozArtifact>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"SUDOZ"));
        0x2::display::add<SudozArtifact>(&mut v1, 0x1::string::utf8(b"number"), 0x1::string::utf8(b"#{number}"));
        0x2::display::add<SudozArtifact>(&mut v1, 0x1::string::utf8(b"level"), 0x1::string::utf8(b"{level}"));
        0x2::display::add<SudozArtifact>(&mut v1, 0x1::string::utf8(b"points"), 0x1::string::utf8(b"{points}"));
        0x2::display::add<SudozArtifact>(&mut v1, 0x1::string::utf8(b"path"), 0x1::string::utf8(b"{path}"));
        0x2::display::update_version<SudozArtifact>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SudozArtifact>>(v1, 0x2::tx_context::sender(arg1));
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v2, @0xf1df42d3b603f6d22fc276c25dd1eee4c3f767d7a7e7ec36bf9c3d416a74e228);
        0x2::transfer::transfer<AdminCap>(v3, @0x9a5b0ad3a18964ab7c0dbf9ab4cdecfd6b3899423b47313ae6e78f4b801022a3);
        let v4 = GlobalStats{
            id                      : 0x2::object::new(arg1),
            artifacts_minted        : 0,
            artifacts_burned        : 0,
            founder_pool            : 0x2::balance::zero<0x2::sui::SUI>(),
            dev_pool                : 0x2::balance::zero<0x2::sui::SUI>(),
            level_10_burns          : 0,
            burn_mechanisms_enabled : false,
            burn_records            : 0x2::table::new<address, BurnRecord>(arg1),
            evolution_auth          : 0x1::option::none<0xfef08cafa07df0e8781d5d0f352968933bee7c327667a01bd06c59391530ce24::evolved_sudoz::EvolutionAuth>(),
        };
        0x2::transfer::share_object<GlobalStats>(v4);
    }

    public fun is_burn_enabled(arg0: &GlobalStats) : bool {
        arg0.burn_mechanisms_enabled
    }

    public entry fun mint_artifact(arg0: &AdminCap, arg1: address, arg2: &mut GlobalStats, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.artifacts_minted < 13600, 2);
        let v0 = arg2.artifacts_minted + 1;
        let v1 = SudozArtifact{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(b"SUDOZ ARTIFACT"),
            description : 0x1::string::utf8(b"A mysterious artifact waiting to reveal its true form through upgrades"),
            image_url   : 0x2::url::new_unsafe(0x1::string::to_ascii(get_image_url(0, 0x1::option::none<u8>()))),
            number      : v0,
            level       : 0,
            points      : 2,
            path        : 0x1::option::none<u8>(),
        };
        arg2.artifacts_minted = arg2.artifacts_minted + 1;
        let v2 = ArtifactMinted{
            object_id : 0x2::object::id<SudozArtifact>(&v1),
            recipient : arg1,
            number    : v0,
        };
        0x2::event::emit<ArtifactMinted>(v2);
        0x2::transfer::public_transfer<SudozArtifact>(v1, arg1);
    }

    public entry fun store_evolution_auth(arg0: &AdminCap, arg1: &mut GlobalStats, arg2: 0xfef08cafa07df0e8781d5d0f352968933bee7c327667a01bd06c59391530ce24::evolved_sudoz::EvolutionAuth, arg3: &mut 0x2::tx_context::TxContext) {
        0x1::option::fill<0xfef08cafa07df0e8781d5d0f352968933bee7c327667a01bd06c59391530ce24::evolved_sudoz::EvolutionAuth>(&mut arg1.evolution_auth, arg2);
    }

    public fun upgrade_level(arg0: &mut SudozArtifact, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut GlobalStats, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.level < 10, 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 1000000000, 3);
        let v0 = arg0.level;
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&v1);
        let v3 = v2 * 15 / 100;
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.dev_pool, 0x2::balance::split<0x2::sui::SUI>(&mut v1, v3));
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.founder_pool, v1);
        if (v0 == 0) {
            let v4 = 0x2::random::new_generator(arg3, arg4);
            let v5 = 0x2::random::generate_u8_in_range(&mut v4, 0, 6);
            arg0.path = 0x1::option::some<u8>(v5);
            arg0.name = get_path_name(v5);
            let v6 = PathSelected{
                artifact_id : 0x2::object::uid_to_inner(&arg0.id),
                path        : v5,
                path_name   : get_path_name(v5),
            };
            0x2::event::emit<PathSelected>(v6);
        };
        let v7 = if (v0 == 0) {
            arg0.path
        } else {
            0x1::option::none<u8>()
        };
        let v8 = ArtifactUpgraded{
            artifact_id   : 0x2::object::uid_to_inner(&arg0.id),
            old_level     : v0,
            new_level     : v0 + 1,
            path_selected : v7,
            upgrade_cost  : 1000000000,
        };
        0x2::event::emit<ArtifactUpgraded>(v8);
        arg0.level = v0 + 1;
        arg0.points = arg0.points + 1;
        arg0.image_url = 0x2::url::new_unsafe(0x1::string::to_ascii(get_image_url(arg0.level, arg0.path)));
        let v9 = RevenueSplit{
            total_payment   : v2,
            to_dev_pool     : v3,
            to_founder_pool : v2 - v3,
        };
        0x2::event::emit<RevenueSplit>(v9);
    }

    public fun upgrade_to_level(arg0: &mut SudozArtifact, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut GlobalStats, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.level;
        assert!(arg1 > v0, 4);
        assert!(arg1 <= 10, 4);
        let v1 = (arg1 - v0) * 1000000000;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v1, 3);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&v2);
        let v4 = v3 * 15 / 100;
        0x2::balance::join<0x2::sui::SUI>(&mut arg3.dev_pool, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v4));
        0x2::balance::join<0x2::sui::SUI>(&mut arg3.founder_pool, v2);
        if (v0 == 0) {
            let v5 = 0x2::random::new_generator(arg4, arg5);
            let v6 = 0x2::random::generate_u8_in_range(&mut v5, 0, 6);
            arg0.path = 0x1::option::some<u8>(v6);
            arg0.name = get_path_name(v6);
            let v7 = PathSelected{
                artifact_id : 0x2::object::uid_to_inner(&arg0.id),
                path        : v6,
                path_name   : get_path_name(v6),
            };
            0x2::event::emit<PathSelected>(v7);
        };
        let v8 = if (v0 == 0) {
            arg0.path
        } else {
            0x1::option::none<u8>()
        };
        let v9 = ArtifactUpgraded{
            artifact_id   : 0x2::object::uid_to_inner(&arg0.id),
            old_level     : v0,
            new_level     : arg1,
            path_selected : v8,
            upgrade_cost  : v1,
        };
        0x2::event::emit<ArtifactUpgraded>(v9);
        arg0.level = arg1;
        arg0.points = 2 + arg1;
        arg0.image_url = 0x2::url::new_unsafe(0x1::string::to_ascii(get_image_url(arg1, arg0.path)));
        let v10 = RevenueSplit{
            total_payment   : v3,
            to_dev_pool     : v4,
            to_founder_pool : v3 - v4,
        };
        0x2::event::emit<RevenueSplit>(v10);
    }

    public fun upgrade_to_level_10(arg0: &mut SudozArtifact, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut GlobalStats, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        upgrade_to_level(arg0, 10, arg1, arg2, arg3, arg4);
    }

    public entry fun withdraw_dev_pool(arg0: &mut GlobalStats, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x9a5b0ad3a18964ab7c0dbf9ab4cdecfd6b3899423b47313ae6e78f4b801022a3, 21);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.dev_pool);
        assert!(v0 > 0, 22);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.dev_pool), arg1), @0x9a5b0ad3a18964ab7c0dbf9ab4cdecfd6b3899423b47313ae6e78f4b801022a3);
        let v1 = DevPoolWithdrawn{
            amount       : v0,
            withdrawn_by : 0x2::tx_context::sender(arg1),
            timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<DevPoolWithdrawn>(v1);
    }

    public entry fun withdraw_founder_pool(arg0: &mut GlobalStats, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0xf1df42d3b603f6d22fc276c25dd1eee4c3f767d7a7e7ec36bf9c3d416a74e228, 21);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.founder_pool);
        assert!(v0 > 0, 22);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.founder_pool), arg1), @0xf1df42d3b603f6d22fc276c25dd1eee4c3f767d7a7e7ec36bf9c3d416a74e228);
        let v1 = FounderPoolWithdrawn{
            amount       : v0,
            withdrawn_by : 0x2::tx_context::sender(arg1),
            timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<FounderPoolWithdrawn>(v1);
    }

    // decompiled from Move bytecode v6
}

