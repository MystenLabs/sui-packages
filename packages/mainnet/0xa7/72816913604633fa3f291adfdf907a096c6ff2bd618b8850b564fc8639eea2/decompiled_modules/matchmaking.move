module 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::matchmaking {
    struct MatchmakingQueue has key {
        id: 0x2::object::UID,
        waiting: 0x1::option::Option<Pending>,
        bank: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct MatchmakingQueueV2 has key {
        id: 0x2::object::UID,
        waiting: 0x1::option::Option<Pending>,
        bank: 0x2::balance::Balance<0x2::sui::SUI>,
        target_growth: u64,
    }

    struct Pending has copy, drop, store {
        player: address,
        entry_fee_snapshot: u64,
    }

    struct MatchmakingQueueV3 has key {
        id: 0x2::object::UID,
        waiting: 0x1::option::Option<PendingV3>,
        bank: 0x2::balance::Balance<0x2::sui::SUI>,
        target_growth: u64,
    }

    struct PendingV3 has copy, drop, store {
        player: address,
        entry_fee_snapshot: u64,
        fifth_move_entitled: bool,
        verified_underlying_tree_raw: u64,
        source_bitmap: u8,
        eligibility_config_version: u64,
        attestation_digest: vector<u8>,
    }

    public fun cancel_queue(arg0: &mut MatchmakingQueue, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<Pending>(&arg0.waiting), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_no_pending_to_cancel());
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::option::borrow<Pending>(&arg0.waiting).player == v0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
        let v1 = 0x1::option::extract<Pending>(&mut arg0.waiting);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.bank, v1.entry_fee_snapshot), arg1), v0);
    }

    public fun cancel_queue_v2(arg0: &mut MatchmakingQueueV2, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<Pending>(&arg0.waiting), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_no_pending_to_cancel());
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::option::borrow<Pending>(&arg0.waiting).player == v0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
        let v1 = 0x1::option::extract<Pending>(&mut arg0.waiting);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.bank, v1.entry_fee_snapshot), arg1), v0);
    }

    public fun cancel_queue_v3(arg0: &mut MatchmakingQueueV3, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<PendingV3>(&arg0.waiting), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_no_pending_to_cancel());
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::option::borrow<PendingV3>(&arg0.waiting).player == v0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
        let v1 = 0x1::option::extract<PendingV3>(&mut arg0.waiting);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.bank, v1.entry_fee_snapshot), arg1), v0);
    }

    public entry fun create_queue_v2(arg0: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::admin(arg0), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_admin_only());
        assert!(0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::battle::is_valid_pvp_v2_target(arg1), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_invalid_target_growth());
        let v0 = MatchmakingQueueV2{
            id            : 0x2::object::new(arg2),
            waiting       : 0x1::option::none<Pending>(),
            bank          : 0x2::balance::zero<0x2::sui::SUI>(),
            target_growth : arg1,
        };
        0x2::transfer::share_object<MatchmakingQueueV2>(v0);
    }

    public entry fun create_queue_v3(arg0: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::admin(arg0), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_admin_only());
        assert!(0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::battle::is_valid_pvp_v2_target(arg1), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_invalid_target_growth());
        let v0 = MatchmakingQueueV3{
            id            : 0x2::object::new(arg2),
            waiting       : 0x1::option::none<PendingV3>(),
            bank          : 0x2::balance::zero<0x2::sui::SUI>(),
            target_growth : arg1,
        };
        0x2::transfer::share_object<MatchmakingQueueV3>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MatchmakingQueue{
            id      : 0x2::object::new(arg0),
            waiting : 0x1::option::none<Pending>(),
            bank    : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<MatchmakingQueue>(v0);
    }

    public fun join_queue<T0: store + key>(arg0: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg1: &mut MatchmakingQueue, arg2: &T0, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::paused(arg0), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_paused());
        assert!(0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::is_collection_whitelisted<T0>(arg0), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_nft_not_whitelisted());
        let v0 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::entry_fee(arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == v0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_insufficient_payment());
        let v1 = 0x2::tx_context::sender(arg5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.bank, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        if (0x1::option::is_some<Pending>(&arg1.waiting)) {
            let v2 = 0x1::option::extract<Pending>(&mut arg1.waiting);
            assert!(v2.player != v1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
            assert!(v2.entry_fee_snapshot == v0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_entry_fee_changed());
            0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::battle::create_battle(v2.player, v1, v0, arg0, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.bank, v2.entry_fee_snapshot + v0), arg4, arg5);
        } else {
            let v3 = Pending{
                player             : v1,
                entry_fee_snapshot : v0,
            };
            0x1::option::fill<Pending>(&mut arg1.waiting, v3);
        };
    }

    public fun join_queue_from_kiosk<T0: store + key>(arg0: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg1: &mut MatchmakingQueue, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::paused(arg0), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_paused());
        assert!(0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::is_collection_whitelisted<T0>(arg0), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_nft_not_whitelisted());
        let v0 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::entry_fee(arg0);
        let v1 = 0x2::tx_context::sender(arg7);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) == v0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_insufficient_payment());
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.bank, 0x2::coin::into_balance<0x2::sui::SUI>(arg5));
        let (v2, v3) = 0x2::kiosk::borrow_val<T0>(arg2, arg3, arg4);
        0x2::kiosk::return_val<T0>(arg2, v2, v3);
        if (0x1::option::is_some<Pending>(&arg1.waiting)) {
            let v4 = 0x1::option::extract<Pending>(&mut arg1.waiting);
            assert!(v4.player != v1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
            assert!(v4.entry_fee_snapshot == v0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_entry_fee_changed());
            0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::battle::create_battle(v4.player, v1, v0, arg0, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.bank, v4.entry_fee_snapshot + v0), arg6, arg7);
        } else {
            let v5 = Pending{
                player             : v1,
                entry_fee_snapshot : v0,
            };
            0x1::option::fill<Pending>(&mut arg1.waiting, v5);
        };
    }

    public fun join_queue_v2<T0: store + key>(arg0: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg1: &mut MatchmakingQueueV2, arg2: &T0, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::paused(arg0), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_paused());
        assert!(0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::is_collection_whitelisted<T0>(arg0), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_nft_not_whitelisted());
        assert!(0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::battle::is_valid_pvp_v2_target(arg1.target_growth), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_invalid_target_growth());
        let v0 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::entry_fee(arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == v0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_insufficient_payment());
        let v1 = 0x2::tx_context::sender(arg5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.bank, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        if (0x1::option::is_some<Pending>(&arg1.waiting)) {
            let v2 = 0x1::option::extract<Pending>(&mut arg1.waiting);
            assert!(v2.player != v1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
            assert!(v2.entry_fee_snapshot == v0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_entry_fee_changed());
            0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::battle::create_pvp_battle_v2(v2.player, v1, v0, arg0, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.bank, v2.entry_fee_snapshot + v0), arg1.target_growth, arg4, arg5);
        } else {
            let v3 = Pending{
                player             : v1,
                entry_fee_snapshot : v0,
            };
            0x1::option::fill<Pending>(&mut arg1.waiting, v3);
        };
    }

    public fun join_queue_v2_from_kiosk<T0: store + key>(arg0: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg1: &mut MatchmakingQueueV2, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::paused(arg0), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_paused());
        assert!(0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::is_collection_whitelisted<T0>(arg0), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_nft_not_whitelisted());
        assert!(0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::battle::is_valid_pvp_v2_target(arg1.target_growth), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_invalid_target_growth());
        let v0 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::entry_fee(arg0);
        let v1 = 0x2::tx_context::sender(arg7);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) == v0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_insufficient_payment());
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.bank, 0x2::coin::into_balance<0x2::sui::SUI>(arg5));
        let (v2, v3) = 0x2::kiosk::borrow_val<T0>(arg2, arg3, arg4);
        0x2::kiosk::return_val<T0>(arg2, v2, v3);
        if (0x1::option::is_some<Pending>(&arg1.waiting)) {
            let v4 = 0x1::option::extract<Pending>(&mut arg1.waiting);
            assert!(v4.player != v1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
            assert!(v4.entry_fee_snapshot == v0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_entry_fee_changed());
            0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::battle::create_pvp_battle_v2(v4.player, v1, v0, arg0, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.bank, v4.entry_fee_snapshot + v0), arg1.target_growth, arg6, arg7);
        } else {
            let v5 = Pending{
                player             : v1,
                entry_fee_snapshot : v0,
            };
            0x1::option::fill<Pending>(&mut arg1.waiting, v5);
        };
    }

    public fun join_queue_v3<T0: store + key>(arg0: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg1: &mut MatchmakingQueueV3, arg2: &T0, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        join_queue_v3_with_eligibility<T0>(arg0, arg1, arg2, arg3, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::fifth_move::standard_eligibility(), arg4, arg5);
    }

    public fun join_queue_v3_from_kiosk<T0: store + key>(arg0: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg1: &mut MatchmakingQueueV3, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::paused(arg0), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_paused());
        assert!(0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::is_collection_whitelisted<T0>(arg0), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_nft_not_whitelisted());
        let (v0, v1) = 0x2::kiosk::borrow_val<T0>(arg2, arg3, arg4);
        let v2 = v0;
        join_queue_v3_with_eligibility<T0>(arg0, arg1, &v2, arg5, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::fifth_move::standard_eligibility(), arg6, arg7);
        0x2::kiosk::return_val<T0>(arg2, v2, v1);
    }

    fun join_queue_v3_with_eligibility<T0: store + key>(arg0: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg1: &mut MatchmakingQueueV3, arg2: &T0, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::fifth_move::FifthMoveEligibility, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::paused(arg0), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_paused());
        assert!(0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::is_collection_whitelisted<T0>(arg0), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_nft_not_whitelisted());
        assert!(0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::battle::is_valid_pvp_v2_target(arg1.target_growth), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_invalid_target_growth());
        let v0 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::entry_fee(arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == v0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_insufficient_payment());
        let v1 = 0x2::tx_context::sender(arg6);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.bank, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        if (0x1::option::is_some<PendingV3>(&arg1.waiting)) {
            let v2 = 0x1::option::extract<PendingV3>(&mut arg1.waiting);
            assert!(v2.player != v1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
            assert!(v2.entry_fee_snapshot == v0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_entry_fee_changed());
            0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::battle::create_pvp_battle_v3(v2.player, v1, v0, arg0, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.bank, v2.entry_fee_snapshot + v0), arg1.target_growth, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::fifth_move::snapshot_eligibility(v2.fifth_move_entitled, v2.verified_underlying_tree_raw, v2.source_bitmap, v2.eligibility_config_version, v2.attestation_digest), arg4, arg5, arg6);
        } else {
            let v3 = PendingV3{
                player                       : v1,
                entry_fee_snapshot           : v0,
                fifth_move_entitled          : 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::fifth_move::entitled(&arg4),
                verified_underlying_tree_raw : 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::fifth_move::verified_underlying_tree_raw(&arg4),
                source_bitmap                : 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::fifth_move::source_bitmap(&arg4),
                eligibility_config_version   : 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::fifth_move::eligibility_config_version(&arg4),
                attestation_digest           : 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::fifth_move::attestation_digest(&arg4),
            };
            0x1::option::fill<PendingV3>(&mut arg1.waiting, v3);
        };
    }

    public fun join_queue_v3_with_fifth_move<T0: store + key>(arg0: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg1: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::fifth_move::FifthMoveConfig, arg2: &mut MatchmakingQueueV3, arg3: &T0, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: vector<u8>, arg6: bool, arg7: u64, arg8: u64, arg9: u8, arg10: u64, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &0x2::random::Random, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::fifth_move::verify_attestation(arg1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::fifth_move::payload(0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::fifth_move::config_id(arg1), 0x2::tx_context::sender(arg15), arg6, arg7, arg8, arg9, arg10, arg11, arg12), arg5, arg13, arg15);
        join_queue_v3_with_eligibility<T0>(arg0, arg2, arg3, arg4, v0, arg14, arg15);
    }

    public fun join_queue_v3_with_fifth_move_from_kiosk<T0: store + key>(arg0: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg1: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::fifth_move::FifthMoveConfig, arg2: &mut MatchmakingQueueV3, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: vector<u8>, arg8: bool, arg9: u64, arg10: u64, arg11: u8, arg12: u64, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &0x2::random::Random, arg17: &mut 0x2::tx_context::TxContext) {
        assert!(!0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::paused(arg0), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_paused());
        assert!(0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::is_collection_whitelisted<T0>(arg0), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_nft_not_whitelisted());
        let (v0, v1) = 0x2::kiosk::borrow_val<T0>(arg3, arg4, arg5);
        let v2 = v0;
        join_queue_v3_with_fifth_move<T0>(arg0, arg1, arg2, &v2, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
        0x2::kiosk::return_val<T0>(arg3, v2, v1);
    }

    public fun target_growth_v2(arg0: &MatchmakingQueueV2) : u64 {
        arg0.target_growth
    }

    public fun target_growth_v3(arg0: &MatchmakingQueueV3) : u64 {
        arg0.target_growth
    }

    public fun withdraw_bank(arg0: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg1: &mut MatchmakingQueue, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::admin(arg0), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_admin_only());
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.bank);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.bank, v0), arg2), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::treasury(arg0));
        };
    }

    public fun withdraw_bank_v2(arg0: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg1: &mut MatchmakingQueueV2, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::admin(arg0), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_admin_only());
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.bank);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.bank, v0), arg2), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::treasury(arg0));
        };
    }

    public fun withdraw_bank_v3(arg0: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg1: &mut MatchmakingQueueV3, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::admin(arg0), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_admin_only());
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.bank);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.bank, v0), arg2), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::treasury(arg0));
        };
    }

    // decompiled from Move bytecode v7
}

