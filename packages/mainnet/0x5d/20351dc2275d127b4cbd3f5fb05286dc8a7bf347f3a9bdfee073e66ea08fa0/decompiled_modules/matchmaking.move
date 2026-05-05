module 0x5d20351dc2275d127b4cbd3f5fb05286dc8a7bf347f3a9bdfee073e66ea08fa0::matchmaking {
    struct MatchmakingQueue has key {
        id: 0x2::object::UID,
        waiting: 0x1::option::Option<Pending>,
        bank: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Pending has copy, drop, store {
        player: address,
        entry_fee_snapshot: u64,
    }

    public fun cancel_queue(arg0: &mut MatchmakingQueue, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<Pending>(&arg0.waiting), 0x5d20351dc2275d127b4cbd3f5fb05286dc8a7bf347f3a9bdfee073e66ea08fa0::errors::e_no_pending_to_cancel());
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::option::borrow<Pending>(&arg0.waiting).player == v0, 0x5d20351dc2275d127b4cbd3f5fb05286dc8a7bf347f3a9bdfee073e66ea08fa0::errors::e_unauthorized_player());
        let v1 = 0x1::option::extract<Pending>(&mut arg0.waiting);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.bank, v1.entry_fee_snapshot), arg1), v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MatchmakingQueue{
            id      : 0x2::object::new(arg0),
            waiting : 0x1::option::none<Pending>(),
            bank    : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<MatchmakingQueue>(v0);
    }

    public fun join_queue<T0: store + key>(arg0: &0x5d20351dc2275d127b4cbd3f5fb05286dc8a7bf347f3a9bdfee073e66ea08fa0::config::Config, arg1: &mut MatchmakingQueue, arg2: &T0, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x5d20351dc2275d127b4cbd3f5fb05286dc8a7bf347f3a9bdfee073e66ea08fa0::config::paused(arg0), 0x5d20351dc2275d127b4cbd3f5fb05286dc8a7bf347f3a9bdfee073e66ea08fa0::errors::e_paused());
        assert!(0x5d20351dc2275d127b4cbd3f5fb05286dc8a7bf347f3a9bdfee073e66ea08fa0::config::is_collection_whitelisted<T0>(arg0), 0x5d20351dc2275d127b4cbd3f5fb05286dc8a7bf347f3a9bdfee073e66ea08fa0::errors::e_nft_not_whitelisted());
        let v0 = 0x5d20351dc2275d127b4cbd3f5fb05286dc8a7bf347f3a9bdfee073e66ea08fa0::config::entry_fee(arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == v0, 0x5d20351dc2275d127b4cbd3f5fb05286dc8a7bf347f3a9bdfee073e66ea08fa0::errors::e_insufficient_payment());
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.bank, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        if (0x1::option::is_some<Pending>(&arg1.waiting)) {
            let v1 = 0x1::option::extract<Pending>(&mut arg1.waiting);
            0x5d20351dc2275d127b4cbd3f5fb05286dc8a7bf347f3a9bdfee073e66ea08fa0::battle::create_battle(v1.player, 0x2::tx_context::sender(arg5), v0, arg0, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.bank, 2 * v0), arg4, arg5);
        } else {
            let v2 = Pending{
                player             : 0x2::tx_context::sender(arg5),
                entry_fee_snapshot : v0,
            };
            0x1::option::fill<Pending>(&mut arg1.waiting, v2);
        };
    }

    public fun join_queue_from_kiosk<T0: store + key>(arg0: &0x5d20351dc2275d127b4cbd3f5fb05286dc8a7bf347f3a9bdfee073e66ea08fa0::config::Config, arg1: &mut MatchmakingQueue, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!0x5d20351dc2275d127b4cbd3f5fb05286dc8a7bf347f3a9bdfee073e66ea08fa0::config::paused(arg0), 0x5d20351dc2275d127b4cbd3f5fb05286dc8a7bf347f3a9bdfee073e66ea08fa0::errors::e_paused());
        assert!(0x5d20351dc2275d127b4cbd3f5fb05286dc8a7bf347f3a9bdfee073e66ea08fa0::config::is_collection_whitelisted<T0>(arg0), 0x5d20351dc2275d127b4cbd3f5fb05286dc8a7bf347f3a9bdfee073e66ea08fa0::errors::e_nft_not_whitelisted());
        let v0 = 0x5d20351dc2275d127b4cbd3f5fb05286dc8a7bf347f3a9bdfee073e66ea08fa0::config::entry_fee(arg0);
        if (0x2::coin::value<0x2::sui::SUI>(&arg5) != v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, 0x2::tx_context::sender(arg7));
            abort 0x5d20351dc2275d127b4cbd3f5fb05286dc8a7bf347f3a9bdfee073e66ea08fa0::errors::e_insufficient_payment()
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.bank, 0x2::coin::into_balance<0x2::sui::SUI>(arg5));
        let (v1, v2) = 0x2::kiosk::borrow_val<T0>(arg2, arg3, arg4);
        0x2::kiosk::return_val<T0>(arg2, v1, v2);
        if (0x1::option::is_some<Pending>(&arg1.waiting)) {
            let v3 = 0x1::option::extract<Pending>(&mut arg1.waiting);
            0x5d20351dc2275d127b4cbd3f5fb05286dc8a7bf347f3a9bdfee073e66ea08fa0::battle::create_battle(v3.player, 0x2::tx_context::sender(arg7), v0, arg0, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.bank, 2 * v0), arg6, arg7);
        } else {
            let v4 = Pending{
                player             : 0x2::tx_context::sender(arg7),
                entry_fee_snapshot : v0,
            };
            0x1::option::fill<Pending>(&mut arg1.waiting, v4);
        };
    }

    public fun withdraw_bank(arg0: &0x5d20351dc2275d127b4cbd3f5fb05286dc8a7bf347f3a9bdfee073e66ea08fa0::config::Config, arg1: &mut MatchmakingQueue, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0x5d20351dc2275d127b4cbd3f5fb05286dc8a7bf347f3a9bdfee073e66ea08fa0::config::admin(arg0), 0x5d20351dc2275d127b4cbd3f5fb05286dc8a7bf347f3a9bdfee073e66ea08fa0::errors::e_admin_only());
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.bank);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.bank, v0), arg2), 0x5d20351dc2275d127b4cbd3f5fb05286dc8a7bf347f3a9bdfee073e66ea08fa0::config::treasury(arg0));
        };
    }

    // decompiled from Move bytecode v6
}

