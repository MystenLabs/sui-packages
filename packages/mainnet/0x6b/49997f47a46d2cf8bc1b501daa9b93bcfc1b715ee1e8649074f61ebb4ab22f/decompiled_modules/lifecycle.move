module 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::lifecycle {
    struct Round has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        registration_id: 0x2::object::ID,
        game_type_id: u64,
        player: address,
        player_pot: u64,
        reservation: u64,
    }

    public fun add_to_pot<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun bump_reservation<T0>(arg0: &mut 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::Vault<T0>, arg1: &0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::GameRegistration, arg2: &mut Round, arg3: u64) {
        assert!(arg2.vault_id == 0x2::object::id<0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::Vault<T0>>(arg0), 300);
        assert!(arg2.registration_id == 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::id_of(arg1), 304);
        let v0 = arg2.reservation + arg3;
        assert!(v0 <= 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::max_payout_per_round(arg1), 303);
        0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::reserve_for_game<T0>(arg0, arg3);
        arg2.reservation = v0;
    }

    public fun bump_reservation_with_lp<T0>(arg0: &mut 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::Vault<T0>, arg1: &0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::GameRegistration, arg2: &0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::house_lp::HouseLP<T0>, arg3: &mut Round, arg4: u64) {
        0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::house_lp::assert_within_exposure<T0>(arg2, arg0, arg3.reservation + arg4);
        bump_reservation<T0>(arg0, arg1, arg3, arg4);
    }

    public fun game_type_id(arg0: &Round) : u64 {
        arg0.game_type_id
    }

    public fun open_round<T0>(arg0: &mut 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::Vault<T0>, arg1: &0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::GameRegistration, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : (Round, 0x2::balance::Balance<T0>) {
        assert!(arg3 <= 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::max_payout_per_round(arg1), 303);
        let v0 = 0x2::coin::value<T0>(&arg2);
        0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::reserve_for_game<T0>(arg0, arg3);
        let v1 = 0x2::object::new(arg5);
        let v2 = 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::game_type_id(arg1);
        0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::events::emit_round_opened(0x2::object::uid_to_inner(&v1), 0x2::object::id<0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::Vault<T0>>(arg0), 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::id_of(arg1), v2, arg4, v0, arg3);
        let v3 = Round{
            id              : v1,
            vault_id        : 0x2::object::id<0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::Vault<T0>>(arg0),
            registration_id : 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::id_of(arg1),
            game_type_id    : v2,
            player          : arg4,
            player_pot      : v0,
            reservation     : arg3,
        };
        (v3, 0x2::coin::into_balance<T0>(arg2))
    }

    public fun open_round_with_lp<T0>(arg0: &mut 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::Vault<T0>, arg1: &0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::GameRegistration, arg2: &0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::house_lp::HouseLP<T0>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : (Round, 0x2::balance::Balance<T0>) {
        0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::house_lp::assert_within_exposure<T0>(arg2, arg0, arg4);
        open_round<T0>(arg0, arg1, arg3, arg4, arg5, arg6)
    }

    public fun player(arg0: &Round) : address {
        arg0.player
    }

    public fun player_pot(arg0: &Round) : u64 {
        arg0.player_pot
    }

    public fun registration_id(arg0: &Round) : 0x2::object::ID {
        arg0.registration_id
    }

    public fun release_round<T0>(arg0: &mut 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::Vault<T0>, arg1: &0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::GameRegistration, arg2: Round, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.vault_id == 0x2::object::id<0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::Vault<T0>>(arg0), 300);
        assert!(arg2.registration_id == 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::id_of(arg1), 304);
        let Round {
            id              : v0,
            vault_id        : _,
            registration_id : _,
            game_type_id    : _,
            player          : v4,
            player_pot      : _,
            reservation     : v6,
        } = arg2;
        let v7 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg3, arg4), v4);
        0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::release_for_game<T0>(arg0, v6);
        0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::events::emit_round_released(0x2::object::uid_to_inner(&v7), 0x2::object::id<0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::Vault<T0>>(arg0), v6);
        0x2::object::delete(v7);
    }

    public fun reservation(arg0: &Round) : u64 {
        arg0.reservation
    }

    public fun settle_round<T0>(arg0: &mut 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::Vault<T0>, arg1: &0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::GameRegistration, arg2: Round, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.vault_id == 0x2::object::id<0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::Vault<T0>>(arg0), 300);
        assert!(arg2.registration_id == 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::id_of(arg1), 304);
        let Round {
            id              : v0,
            vault_id        : _,
            registration_id : _,
            game_type_id    : v3,
            player          : v4,
            player_pot      : _,
            reservation     : v6,
        } = arg2;
        let v7 = v0;
        let v8 = 0x2::balance::value<T0>(&arg3);
        if (arg4 == 0) {
            0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::absorb_pot<T0>(arg0, 0x2::coin::from_balance<T0>(arg3, arg5));
            0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::release_for_game<T0>(arg0, v6);
            0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::events::emit_round_settled(0x2::object::uid_to_inner(&v7), 0x2::object::id<0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::Vault<T0>>(arg0), 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::id_of(arg1), v3, v4, 0, v6);
        } else {
            assert!(arg4 <= v8 + v6, 302);
            let v9 = if (arg4 > v8) {
                arg4 - v8
            } else {
                0
            };
            let v10 = 0x2::coin::from_balance<T0>(arg3, arg5);
            if (v9 > 0) {
                0x2::coin::join<T0>(&mut v10, 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::take_for_payout<T0>(arg0, v9, arg5));
            };
            if (arg4 < v8) {
                0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::absorb_pot<T0>(arg0, 0x2::coin::split<T0>(&mut v10, v8 - arg4, arg5));
            };
            0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::release_for_game<T0>(arg0, v6);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v10, v4);
            0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::events::emit_round_settled(0x2::object::uid_to_inner(&v7), 0x2::object::id<0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::Vault<T0>>(arg0), 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::id_of(arg1), v3, v4, arg4, v6);
        };
        0x2::object::delete(v7);
    }

    public fun vault_id(arg0: &Round) : 0x2::object::ID {
        arg0.vault_id
    }

    // decompiled from Move bytecode v7
}

