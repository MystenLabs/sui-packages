module 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::matchmaking {
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
        assert!(0x1::option::is_some<Pending>(&arg0.waiting), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_no_pending_to_cancel());
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::option::borrow<Pending>(&arg0.waiting).player == v0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_unauthorized_player());
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

    public fun withdraw_bank(arg0: &0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::Config, arg1: &mut MatchmakingQueue, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::admin(arg0), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_admin_only());
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.bank);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.bank, v0), arg2), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::config::treasury(arg0));
        };
    }

    // decompiled from Move bytecode v7
}

