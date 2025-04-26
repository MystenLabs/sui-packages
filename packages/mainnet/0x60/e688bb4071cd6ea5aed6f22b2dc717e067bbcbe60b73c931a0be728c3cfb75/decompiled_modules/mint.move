module 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::mint {
    struct ItemMintedEvent has copy, drop {
        launch_id: 0x2::object::ID,
        phase_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        item_type: 0x1::type_name::TypeName,
        minted_by: address,
        payment_type: 0x1::type_name::TypeName,
        payment_value: u64,
    }

    entry fun mint<T0: store + key, T1>(arg0: &mut 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::Launch<T0>, arg1: &mut 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::Phase<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::assert_kiosk_requirement_none<T0>(arg0);
        0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::assert_is_public<T0>(arg1);
        let v0 = internal_mint<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v1 = 0;
        while (v1 < 0x1::vector::length<T0>(&v0)) {
            0x2::transfer::public_transfer<T0>(0x1::vector::pop_back<T0>(&mut v0), 0x2::tx_context::sender(arg6));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<T0>(v0);
    }

    fun internal_mint<T0: store + key, T1>(arg0: &mut 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::Launch<T0>, arg1: &mut 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::Phase<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : vector<T0> {
        0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::assert_is_mintable<T0>(arg0);
        0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::assert_is_mintable<T0>(arg1, arg5);
        if (!0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::is_allow_bulk_mint<T0>(arg1)) {
            assert!(arg2 == 1, 30005);
        };
        assert!(arg2 <= 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::max_mint_count_addr<T0>(arg1) - 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::participant_mint_count<T0>(arg1, 0x2::tx_context::sender(arg6)), 30006);
        assert!(arg2 <= 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::remaining_mint_count<T0>(arg1), 30004);
        let v0 = 0x1::type_name::get<T1>();
        let v1 = *0x2::vec_map::get<0x1::type_name::TypeName, u64>(0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::payment_types<T0>(arg1), &v0);
        assert!(0x2::coin::value<T1>(&arg3) == v1 * arg2, 30001);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(0x2::coin::into_balance<T1>(arg3));
        } else {
            0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::deposit_revenue<T0, T1>(arg0, 0x2::coin::into_balance<T1>(arg3));
        };
        let v2 = 0x1::vector::empty<T0>();
        let v3 = 0x2::random::new_generator(arg4, arg6);
        let v4 = 0;
        let v5 = 0x2::table_vec::length<T0>(0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::items<T0>(arg0));
        while (v4 < arg2) {
            let v6 = 0x2::table_vec::swap_remove<T0>(0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::items_mut<T0>(arg0), 0x2::random::generate_u64_in_range(&mut v3, 0, v5 - 1));
            let v7 = ItemMintedEvent{
                launch_id     : 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::id<T0>(arg0),
                phase_id      : 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::id<T0>(arg1),
                item_id       : 0x2::object::id<T0>(&v6),
                item_type     : 0x1::type_name::get<T0>(),
                minted_by     : 0x2::tx_context::sender(arg6),
                payment_type  : 0x1::type_name::get<T1>(),
                payment_value : v1,
            };
            0x2::event::emit<ItemMintedEvent>(v7);
            0x1::vector::push_back<T0>(&mut v2, v6);
            0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::increment_minted_supply<T0>(arg0);
            0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::increment_mint_count<T0>(arg1, arg6);
            v5 = v5 - 1;
            v4 = v4 + 1;
        };
        v2
    }

    fun internal_process_whitelists<T0: store + key>(arg0: vector<0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::whitelist::Whitelist>, arg1: &0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::Phase<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::whitelist::Whitelist>(&arg0) >= arg2, 30002);
        let v0 = &arg0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::whitelist::Whitelist>(v0)) {
            assert!(0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::whitelist::phase_id(0x1::vector::borrow<0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::whitelist::Whitelist>(v0, v1)) == 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::id<T0>(arg1), 30003);
            v1 = v1 + 1;
        };
        let v2 = 0;
        while (v2 < arg2) {
            0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::whitelist::destroy(0x1::vector::pop_back<0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::whitelist::Whitelist>(&mut arg0));
            v2 = v2 + 1;
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::whitelist::Whitelist>(&arg0)) {
            0x2::transfer::public_transfer<0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::whitelist::Whitelist>(0x1::vector::pop_back<0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::whitelist::Whitelist>(&mut arg0), 0x2::tx_context::sender(arg3));
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::whitelist::Whitelist>(arg0);
    }

    entry fun mint_and_lock<T0: store + key, T1>(arg0: &mut 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::Launch<T0>, arg1: &mut 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::Phase<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &0x2::transfer_policy::TransferPolicy<T0>, arg7: &0x2::random::Random, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::assert_kiosk_requirement_lock<T0>(arg0);
        0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::assert_is_public<T0>(arg1);
        let v0 = internal_mint<T0, T1>(arg0, arg1, arg2, arg3, arg7, arg8, arg9);
        let v1 = 0;
        while (v1 < 0x1::vector::length<T0>(&v0)) {
            0x2::kiosk::lock<T0>(arg4, arg5, arg6, 0x1::vector::pop_back<T0>(&mut v0));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<T0>(v0);
    }

    entry fun mint_and_lock_in_new_kiosk<T0: store + key, T1>(arg0: &mut 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::Launch<T0>, arg1: &mut 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::Phase<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &0x2::random::Random, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::assert_kiosk_requirement_lock<T0>(arg0);
        0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::assert_is_public<T0>(arg1);
        let (v0, v1) = 0x2::kiosk::new(arg7);
        let v2 = v1;
        let v3 = v0;
        let v4 = internal_mint<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7);
        let v5 = 0;
        while (v5 < 0x1::vector::length<T0>(&v4)) {
            0x2::kiosk::lock<T0>(&mut v3, &v2, arg4, 0x1::vector::pop_back<T0>(&mut v4));
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<T0>(v4);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, 0x2::tx_context::sender(arg7));
    }

    entry fun mint_and_place<T0: store + key, T1>(arg0: &mut 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::Launch<T0>, arg1: &mut 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::Phase<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &0x2::random::Random, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::assert_kiosk_requirement_place<T0>(arg0);
        0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::assert_is_public<T0>(arg1);
        let v0 = internal_mint<T0, T1>(arg0, arg1, arg2, arg3, arg6, arg7, arg8);
        let v1 = 0;
        while (v1 < 0x1::vector::length<T0>(&v0)) {
            0x2::kiosk::place<T0>(arg4, arg5, 0x1::vector::pop_back<T0>(&mut v0));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<T0>(v0);
    }

    entry fun mint_and_place_in_new_kiosk<T0: store + key, T1>(arg0: &mut 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::Launch<T0>, arg1: &mut 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::Phase<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::assert_kiosk_requirement_place<T0>(arg0);
        0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::assert_is_public<T0>(arg1);
        let (v0, v1) = 0x2::kiosk::new(arg6);
        let v2 = v1;
        let v3 = v0;
        let v4 = internal_mint<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v5 = 0;
        while (v5 < 0x1::vector::length<T0>(&v4)) {
            0x2::kiosk::place<T0>(&mut v3, &v2, 0x1::vector::pop_back<T0>(&mut v4));
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<T0>(v4);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, 0x2::tx_context::sender(arg6));
    }

    entry fun wl_mint<T0: store + key, T1>(arg0: &mut 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::Launch<T0>, arg1: &mut 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::Phase<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: vector<0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::whitelist::Whitelist>, arg5: &0x2::random::Random, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::assert_kiosk_requirement_none<T0>(arg0);
        0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::assert_is_whitelist<T0>(arg1);
        let v0 = internal_mint<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7);
        internal_process_whitelists<T0>(arg4, arg1, 0x1::vector::length<T0>(&v0), arg7);
        let v1 = 0;
        while (v1 < 0x1::vector::length<T0>(&v0)) {
            0x2::transfer::public_transfer<T0>(0x1::vector::pop_back<T0>(&mut v0), 0x2::tx_context::sender(arg7));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<T0>(v0);
    }

    entry fun wl_mint_and_lock<T0: store + key, T1>(arg0: &mut 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::Launch<T0>, arg1: &mut 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::Phase<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: vector<0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::whitelist::Whitelist>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &0x2::transfer_policy::TransferPolicy<T0>, arg8: &0x2::random::Random, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::assert_kiosk_requirement_lock<T0>(arg0);
        0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::assert_is_whitelist<T0>(arg1);
        let v0 = internal_mint<T0, T1>(arg0, arg1, arg2, arg3, arg8, arg9, arg10);
        internal_process_whitelists<T0>(arg4, arg1, 0x1::vector::length<T0>(&v0), arg10);
        let v1 = 0;
        while (v1 < 0x1::vector::length<T0>(&v0)) {
            0x2::kiosk::lock<T0>(arg5, arg6, arg7, 0x1::vector::pop_back<T0>(&mut v0));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<T0>(v0);
    }

    entry fun wl_mint_and_lock_in_new_kiosk<T0: store + key, T1>(arg0: &mut 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::Launch<T0>, arg1: &mut 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::Phase<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: vector<0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::whitelist::Whitelist>, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: &0x2::random::Random, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::assert_kiosk_requirement_lock<T0>(arg0);
        0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::assert_is_whitelist<T0>(arg1);
        let (v0, v1) = 0x2::kiosk::new(arg8);
        let v2 = v1;
        let v3 = v0;
        let v4 = internal_mint<T0, T1>(arg0, arg1, arg2, arg3, arg6, arg7, arg8);
        internal_process_whitelists<T0>(arg4, arg1, 0x1::vector::length<T0>(&v4), arg8);
        let v5 = 0;
        while (v5 < 0x1::vector::length<T0>(&v4)) {
            0x2::kiosk::lock<T0>(&mut v3, &v2, arg5, 0x1::vector::pop_back<T0>(&mut v4));
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<T0>(v4);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, 0x2::tx_context::sender(arg8));
    }

    entry fun wl_mint_and_place<T0: store + key, T1>(arg0: &mut 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::Launch<T0>, arg1: &mut 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::Phase<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: vector<0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::whitelist::Whitelist>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &0x2::random::Random, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::assert_is_whitelist<T0>(arg1);
        0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::assert_kiosk_requirement_place<T0>(arg0);
        let v0 = internal_mint<T0, T1>(arg0, arg1, arg2, arg3, arg7, arg8, arg9);
        internal_process_whitelists<T0>(arg4, arg1, 0x1::vector::length<T0>(&v0), arg9);
        let v1 = 0;
        while (v1 < 0x1::vector::length<T0>(&v0)) {
            0x2::kiosk::place<T0>(arg5, arg6, 0x1::vector::pop_back<T0>(&mut v0));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<T0>(v0);
    }

    entry fun wl_mint_and_place_in_new_kiosk<T0: store + key, T1>(arg0: &mut 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::Launch<T0>, arg1: &mut 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::Phase<T0>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: vector<0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::whitelist::Whitelist>, arg5: &0x2::random::Random, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::assert_is_whitelist<T0>(arg1);
        0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::assert_kiosk_requirement_place<T0>(arg0);
        let (v0, v1) = 0x2::kiosk::new(arg7);
        let v2 = v1;
        let v3 = v0;
        let v4 = internal_mint<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7);
        internal_process_whitelists<T0>(arg4, arg1, 0x1::vector::length<T0>(&v4), arg7);
        let v5 = 0;
        while (v5 < 0x1::vector::length<T0>(&v4)) {
            0x2::kiosk::place<T0>(&mut v3, &v2, 0x1::vector::pop_back<T0>(&mut v4));
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<T0>(v4);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

