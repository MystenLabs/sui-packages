module 0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::battle {
    struct Battle has key {
        id: 0x2::object::UID,
        vault_name: 0x1::string::String,
        pack_count: u64,
        max_participants: u64,
        price: u64,
        participants: vector<address>,
        cards: vector<vector<0x2::object::ID>>,
        kiosk_owner_cap: 0x2::kiosk::KioskOwnerCap,
    }

    struct BattleCreatedEvent has copy, drop {
        battle_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        vault_name: 0x1::string::String,
        price: u64,
        participant: address,
        order_id: u128,
    }

    struct BattleJoinedEvent has copy, drop {
        battle_id: 0x2::object::ID,
        vault_name: 0x1::string::String,
        price: u64,
        participant: address,
        order_id: u128,
    }

    struct BattleSettledEvent has copy, drop {
        battle_id: 0x2::object::ID,
        participants: vector<address>,
        card_ids: vector<vector<0x2::object::ID>>,
    }

    struct BattleFinalizedEvent has copy, drop {
        battle_id: 0x2::object::ID,
        card_id: 0x1::option::Option<0x2::object::ID>,
        winner: 0x1::option::Option<address>,
    }

    entry fun create_battle(arg0: &0x2::clock::Clock, arg1: &mut 0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::rip_station::Store, arg2: address, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg8: u128, arg9: u64, arg10: vector<u8>, arg11: &mut 0x2::tx_context::TxContext) {
        0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::rip_station::verify_version(arg1);
        0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::rip_station::verify_vault(arg1, arg3);
        assert!(0x2::clock::timestamp_ms(arg0) < arg9, 1);
        let v0 = b"battle:create";
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg6));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u128>(&arg8));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg9));
        0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::rip_station::verify_signature(arg1, v0, arg10);
        0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::rip_station::verify_order(arg1, arg8);
        pay(arg1, arg2, arg4 * arg6, arg7, arg11);
        let (v1, v2) = 0x2::kiosk::new(arg11);
        let v3 = v1;
        let v4 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v4, arg2);
        let v5 = Battle{
            id               : 0x2::object::new(arg11),
            vault_name       : arg3,
            pack_count       : arg4,
            max_participants : arg5,
            price            : arg6,
            participants     : v4,
            cards            : 0x1::vector::empty<vector<0x2::object::ID>>(),
            kiosk_owner_cap  : v2,
        };
        let v6 = BattleCreatedEvent{
            battle_id   : 0x2::object::id<Battle>(&v5),
            kiosk_id    : 0x2::object::id<0x2::kiosk::Kiosk>(&v3),
            vault_name  : arg3,
            price       : arg6,
            participant : arg2,
            order_id    : arg8,
        };
        0x2::event::emit<BattleCreatedEvent>(v6);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::share_object<Battle>(v5);
    }

    entry fun finalize<T0>(arg0: &0x2::clock::Clock, arg1: &0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::rip_station::Store, arg2: Battle, arg3: &mut 0x2::kiosk::Kiosk, arg4: 0x1::option::Option<0x2::object::ID>, arg5: u64, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::rip_station::verify_version(arg1);
        0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::rip_station::verify_operator(arg1, arg7);
        assert!(0x2::clock::timestamp_ms(arg0) < arg5, 1);
        let v0 = b"battle:finalize";
        let v1 = 0x2::tx_context::sender(arg7);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&v1));
        let v2 = 0x2::object::id<Battle>(&arg2);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::option::Option<0x2::object::ID>>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg5));
        0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::rip_station::verify_signature(arg1, v0, arg6);
        let Battle {
            id               : v3,
            vault_name       : _,
            pack_count       : _,
            max_participants : _,
            price            : _,
            participants     : v8,
            cards            : v9,
            kiosk_owner_cap  : v10,
        } = arg2;
        let v11 = v10;
        let v12 = v9;
        let v13 = v8;
        let v14 = v3;
        assert!(0x2::kiosk::has_access(arg3, &v11), 6);
        assert!(!0x1::vector::is_empty<vector<0x2::object::ID>>(&v12), 8);
        if (0x1::option::is_some<0x2::object::ID>(&arg4)) {
            let v15 = &v12;
            let v16 = 0;
            let v17;
            while (v16 < 0x1::vector::length<vector<0x2::object::ID>>(v15)) {
                if (0x1::vector::contains<0x2::object::ID>(0x1::vector::borrow<vector<0x2::object::ID>>(v15, v16), 0x1::option::borrow<0x2::object::ID>(&arg4))) {
                    v17 = 0x1::option::some<u64>(v16);
                    /* label 16 */
                    assert!(0x1::option::is_some<u64>(&v17), 7);
                    let v18 = *0x1::vector::borrow<address>(&v13, 0x1::option::destroy_some<u64>(v17));
                    /* label 20 */
                    0x2::object::delete(v14);
                    0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::create_for(arg3, v11, v18, arg7);
                    let v19 = BattleFinalizedEvent{
                        battle_id : 0x2::object::uid_to_inner(&v14),
                        card_id   : arg4,
                        winner    : 0x1::option::some<address>(v18),
                    };
                    0x2::event::emit<BattleFinalizedEvent>(v19);
                    return
                };
                v16 = v16 + 1;
            };
            v17 = 0x1::option::none<u64>();
            /* goto 16 */
        } else {
            return_cards<T0>(arg1, arg3, &v11, &v13, &v12, arg7);
            /* goto 20 */
        };
    }

    entry fun join_battle(arg0: &0x2::clock::Clock, arg1: &mut 0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::rip_station::Store, arg2: &mut Battle, arg3: address, arg4: u64, arg5: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: u128, arg7: u64, arg8: vector<u8>, arg9: &0x2::tx_context::TxContext) {
        0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::rip_station::verify_version(arg1);
        assert!(0x2::clock::timestamp_ms(arg0) < arg7, 1);
        assert!(0x1::vector::is_empty<vector<0x2::object::ID>>(&arg2.cards), 3);
        assert!(0x1::vector::length<address>(&arg2.participants) < arg2.max_participants, 4);
        assert!(!0x1::vector::contains<address>(&arg2.participants, &arg3), 5);
        assert!(arg4 == arg2.price, 9);
        let v0 = b"battle:join";
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg3));
        let v1 = 0x2::object::id<Battle>(arg2);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u128>(&arg6));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg7));
        0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::rip_station::verify_signature(arg1, v0, arg8);
        0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::rip_station::verify_order(arg1, arg6);
        pay(arg1, arg3, arg2.pack_count * arg4, arg5, arg9);
        0x1::vector::push_back<address>(&mut arg2.participants, arg3);
        let v2 = BattleJoinedEvent{
            battle_id   : 0x2::object::id<Battle>(arg2),
            vault_name  : arg2.vault_name,
            price       : arg4,
            participant : arg3,
            order_id    : arg6,
        };
        0x2::event::emit<BattleJoinedEvent>(v2);
    }

    fun pay(arg0: &mut 0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::rip_station::Store, arg1: address, arg2: u64, arg3: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x2::tx_context::TxContext) {
        if (0x2::tx_context::sender(arg4) == arg1) {
            assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg3) == arg2, 2);
        } else {
            0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::rip_station::verify_operator(arg0, arg4);
        };
        0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::rip_station::deposit_balance(arg0, arg3);
    }

    fun return_cards<T0>(arg0: &0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::rip_station::Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &vector<address>, arg4: &vector<vector<0x2::object::ID>>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::rip_station::get_transfer_policy<T0>(arg0);
        let v1 = 1;
        while (v1 < 0x1::vector::length<address>(arg3)) {
            let (v2, v3) = 0x2::kiosk::new(arg5);
            let v4 = v3;
            let v5 = v2;
            let v6 = 0x1::vector::borrow<vector<0x2::object::ID>>(arg4, v1);
            let v7 = 0;
            while (v7 < 0x1::vector::length<0x2::object::ID>(v6)) {
                0x2::kiosk::lock<0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>>(&mut v5, &v4, v0, 0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::rip_station::remove_card_from_kiosk<T0>(arg0, arg1, arg2, *0x1::vector::borrow<0x2::object::ID>(v6, v7), arg5));
                v7 = v7 + 1;
            };
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::create_for(&mut v5, v4, *0x1::vector::borrow<address>(arg3, v1), arg5);
            0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v5);
            v1 = v1 + 1;
        };
    }

    entry fun settle<T0>(arg0: &0x2::clock::Clock, arg1: &0x2::random::Random, arg2: &mut 0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::rip_station::Store, arg3: &mut Battle, arg4: &mut 0x2::kiosk::Kiosk, arg5: u64, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::rip_station::verify_version(arg2);
        0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::rip_station::verify_operator(arg2, arg7);
        assert!(0x2::clock::timestamp_ms(arg0) < arg5, 1);
        assert!(0x1::vector::is_empty<vector<0x2::object::ID>>(&arg3.cards), 3);
        assert!(0x2::kiosk::has_access(arg4, &arg3.kiosk_owner_cap), 6);
        let v0 = b"battle:settle";
        let v1 = 0x2::tx_context::sender(arg7);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&v1));
        let v2 = 0x2::object::id<Battle>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg5));
        0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::rip_station::verify_signature(arg2, v0, arg6);
        let v3 = &arg3.participants;
        let v4 = 0x1::vector::empty<vector<0x2::object::ID>>();
        let v5 = 0;
        while (v5 < 0x1::vector::length<address>(v3)) {
            0x1::vector::push_back<vector<0x2::object::ID>>(&mut v4, 0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::rip_station::buy_packs_into_kiosk<T0>(arg1, arg2, arg3.vault_name, arg3.pack_count, 0, 0x2::coin::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg7), arg4, &arg3.kiosk_owner_cap, true, arg7));
            v5 = v5 + 1;
        };
        arg3.cards = v4;
        let v6 = BattleSettledEvent{
            battle_id    : 0x2::object::id<Battle>(arg3),
            participants : arg3.participants,
            card_ids     : v4,
        };
        0x2::event::emit<BattleSettledEvent>(v6);
    }

    // decompiled from Move bytecode v7
}

