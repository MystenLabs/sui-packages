module 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::mint {
    struct Sale has copy, drop {
        phase: 0x1::option::Option<u64>,
        price: u64,
        coin: 0x1::option::Option<0x1::type_name::TypeName>,
    }

    public fun mint<T0, T1>(arg0: &mut 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::Collection<T0>, arg1: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::Config, arg2: &0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>, arg3: u64, arg4: u64, arg5: u64, arg6: vector<vector<u8>>, arg7: &mut 0x2::coin::Coin<T1>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : vector<0x2::object::ID> {
        let v0 = paid<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, &arg6, arg7, arg8, arg9, arg10);
        let v1 = in_order<T0>(arg0, arg4, arg10);
        to_wallet<T0>(arg0, arg2, v1, 0x2::tx_context::sender(arg10), v0);
        ids_of<T0>(&v1)
    }

    public fun airdrop<T0>(arg0: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::CreatorCap<T0>, arg1: &mut 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::Collection<T0>, arg2: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::Config, arg3: &0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>, arg4: vector<address>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg4);
        assert!(v0 > 0, 251);
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::admit_reserve<T0>(arg0, arg1, arg2, arg3, v0, arg5);
        let v1 = in_order<T0>(arg1, v0, arg6);
        drop_to<T0>(arg1, arg3, v1, arg4, arg6);
    }

    entry fun airdrop_random<T0>(arg0: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::CreatorCap<T0>, arg1: &mut 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::Collection<T0>, arg2: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::Config, arg3: &0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>, arg4: vector<address>, arg5: &0x2::random::Random, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg5, arg7);
        let v1 = &mut v0;
        random_airdrop<T0>(arg0, arg1, arg2, arg3, arg4, v1, arg6, arg7);
    }

    fun at_random<T0>(arg0: &mut 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::Collection<T0>, arg1: &mut 0x2::random::RandomGenerator, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : vector<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>> {
        let v0 = 0x1::vector::empty<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>();
        let v1 = 0;
        while (v1 < arg2) {
            0x1::vector::push_back<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(&mut v0, 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::new<T0>(0x2::object::id<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::Collection<T0>>(arg0), 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::next_at_random<T0>(arg0, arg1), arg3));
            v1 = v1 + 1;
        };
        v0
    }

    fun drop_to<T0>(arg0: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::Collection<T0>, arg1: &0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>, arg2: vector<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        0x1::vector::reverse<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(&mut arg2);
        0x1::vector::reverse<address>(&mut arg3);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg3)) {
            if (needs_lock<T0>(arg1)) {
                let v1 = 0x1::vector::empty<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>();
                0x1::vector::push_back<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(&mut v1, 0x1::vector::pop_back<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(&mut arg2));
                to_fresh<T0>(arg0, arg1, v1, 0x1::vector::pop_back<address>(&mut arg3), reserve_sale(), arg4);
            } else {
                let v2 = 0x1::vector::empty<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>();
                0x1::vector::push_back<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(&mut v2, 0x1::vector::pop_back<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(&mut arg2));
                to_wallet<T0>(arg0, arg1, v2, 0x1::vector::pop_back<address>(&mut arg3), reserve_sale());
            };
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg3);
        0x1::vector::destroy_empty<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(arg2);
    }

    fun emit_minted<T0>(arg0: 0x2::object::ID, arg1: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>, arg2: address, arg3: 0x1::option::Option<0x2::object::ID>, arg4: Sale) {
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::events::minted(arg0, 0x2::object::id<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(arg1), 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::n<T0>(arg1), arg2, arg3, arg4.phase, arg4.price, arg4.coin);
    }

    fun ids_of<T0>(arg0: &vector<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(arg0)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::id<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(0x1::vector::borrow<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(arg0, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    fun in_order<T0>(arg0: &mut 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::Collection<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : vector<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>> {
        let v0 = 0x1::vector::empty<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>();
        let v1 = 0;
        while (v1 < arg1) {
            0x1::vector::push_back<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(&mut v0, 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::new<T0>(0x2::object::id<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::Collection<T0>>(arg0), 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::next_in_order<T0>(arg0), arg2));
            v1 = v1 + 1;
        };
        v0
    }

    public fun mint_fresh<T0, T1>(arg0: &mut 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::Collection<T0>, arg1: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::Config, arg2: &0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>, arg3: u64, arg4: u64, arg5: u64, arg6: vector<vector<u8>>, arg7: &mut 0x2::coin::Coin<T1>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = paid<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, &arg6, arg7, arg8, arg9, arg10);
        let v1 = in_order<T0>(arg0, arg4, arg10);
        let v2 = 0x2::tx_context::sender(arg10);
        to_fresh<T0>(arg0, arg2, v1, v2, v0, arg10)
    }

    public fun mint_into<T0, T1>(arg0: &mut 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::Collection<T0>, arg1: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::Config, arg2: &0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: u64, arg6: u64, arg7: u64, arg8: vector<vector<u8>>, arg9: &mut 0x2::coin::Coin<T1>, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : vector<0x2::object::ID> {
        let v0 = paid<T0, T1>(arg0, arg1, arg2, arg5, arg6, arg7, &arg8, arg9, arg10, arg11, arg12);
        let v1 = in_order<T0>(arg0, arg6, arg12);
        to_kiosk<T0>(arg0, arg2, v1, arg3, arg4, 0x2::tx_context::sender(arg12), v0);
        ids_of<T0>(&v1)
    }

    entry fun mint_random<T0, T1>(arg0: &mut 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::Collection<T0>, arg1: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::Config, arg2: &0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>, arg3: u64, arg4: u64, arg5: u64, arg6: vector<vector<u8>>, arg7: &mut 0x2::coin::Coin<T1>, arg8: u64, arg9: &0x2::random::Random, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg9, arg11);
        let v1 = &mut v0;
        random_to_wallet<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, &arg6, arg7, arg8, v1, arg10, arg11);
    }

    entry fun mint_random_fresh<T0, T1>(arg0: &mut 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::Collection<T0>, arg1: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::Config, arg2: &0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>, arg3: u64, arg4: u64, arg5: u64, arg6: vector<vector<u8>>, arg7: &mut 0x2::coin::Coin<T1>, arg8: u64, arg9: &0x2::random::Random, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg9, arg11);
        let v1 = &mut v0;
        random_to_fresh<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, &arg6, arg7, arg8, v1, arg10, arg11);
    }

    entry fun mint_random_into<T0, T1>(arg0: &mut 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::Collection<T0>, arg1: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::Config, arg2: &0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: u64, arg6: u64, arg7: u64, arg8: vector<vector<u8>>, arg9: &mut 0x2::coin::Coin<T1>, arg10: u64, arg11: &0x2::random::Random, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg11, arg13);
        let v1 = &mut v0;
        random_to_kiosk<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, &arg8, arg9, arg10, v1, arg12, arg13);
    }

    fun needs_lock<T0>(arg0: &0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>) : bool {
        0x2::transfer_policy::has_rule<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg0)
    }

    fun needs_personal<T0>(arg0: &0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>) : bool {
        0x2::transfer_policy::has_rule<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::Rule>(arg0)
    }

    fun paid<T0, T1>(arg0: &mut 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::Collection<T0>, arg1: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::Config, arg2: &0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>, arg3: u64, arg4: u64, arg5: u64, arg6: &vector<vector<u8>>, arg7: &mut 0x2::coin::Coin<T1>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) : Sale {
        Sale{
            phase : 0x1::option::some<u64>(arg3),
            price : 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::admit<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10),
            coin  : 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_original_ids<T1>()),
        }
    }

    fun random_airdrop<T0>(arg0: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::CreatorCap<T0>, arg1: &mut 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::Collection<T0>, arg2: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::Config, arg3: &0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>, arg4: vector<address>, arg5: &mut 0x2::random::RandomGenerator, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg4);
        assert!(v0 > 0, 251);
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::admit_reserve<T0>(arg0, arg1, arg2, arg3, v0, arg6);
        let v1 = at_random<T0>(arg1, arg5, v0, arg7);
        drop_to<T0>(arg1, arg3, v1, arg4, arg7);
    }

    fun random_reserve_into<T0>(arg0: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::CreatorCap<T0>, arg1: &mut 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::Collection<T0>, arg2: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::Config, arg3: &0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: u64, arg7: &mut 0x2::random::RandomGenerator, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg4, arg5), 252);
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::admit_reserve<T0>(arg0, arg1, arg2, arg3, arg6, arg8);
        let v0 = at_random<T0>(arg1, arg7, arg6, arg9);
        to_kiosk<T0>(arg1, arg3, v0, arg4, arg5, 0x2::tx_context::sender(arg9), reserve_sale());
    }

    fun random_to_fresh<T0, T1>(arg0: &mut 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::Collection<T0>, arg1: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::Config, arg2: &0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>, arg3: u64, arg4: u64, arg5: u64, arg6: &vector<vector<u8>>, arg7: &mut 0x2::coin::Coin<T1>, arg8: u64, arg9: &mut 0x2::random::RandomGenerator, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = paid<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg10, arg11);
        let v1 = at_random<T0>(arg0, arg9, arg4, arg11);
        let v2 = 0x2::tx_context::sender(arg11);
        to_fresh<T0>(arg0, arg2, v1, v2, v0, arg11);
    }

    fun random_to_kiosk<T0, T1>(arg0: &mut 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::Collection<T0>, arg1: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::Config, arg2: &0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: u64, arg6: u64, arg7: u64, arg8: &vector<vector<u8>>, arg9: &mut 0x2::coin::Coin<T1>, arg10: u64, arg11: &mut 0x2::random::RandomGenerator, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg3, arg4), 252);
        let v0 = paid<T0, T1>(arg0, arg1, arg2, arg5, arg6, arg7, arg8, arg9, arg10, arg12, arg13);
        let v1 = at_random<T0>(arg0, arg11, arg6, arg13);
        to_kiosk<T0>(arg0, arg2, v1, arg3, arg4, 0x2::tx_context::sender(arg13), v0);
    }

    fun random_to_wallet<T0, T1>(arg0: &mut 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::Collection<T0>, arg1: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::Config, arg2: &0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>, arg3: u64, arg4: u64, arg5: u64, arg6: &vector<vector<u8>>, arg7: &mut 0x2::coin::Coin<T1>, arg8: u64, arg9: &mut 0x2::random::RandomGenerator, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(!needs_lock<T0>(arg2), 250);
        let v0 = paid<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg10, arg11);
        let v1 = at_random<T0>(arg0, arg9, arg4, arg11);
        to_wallet<T0>(arg0, arg2, v1, 0x2::tx_context::sender(arg11), v0);
    }

    public fun reserve_into<T0>(arg0: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::CreatorCap<T0>, arg1: &mut 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::Collection<T0>, arg2: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::Config, arg3: &0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::admit_reserve<T0>(arg0, arg1, arg2, arg3, arg6, arg7);
        let v0 = in_order<T0>(arg1, arg6, arg8);
        to_kiosk<T0>(arg1, arg3, v0, arg4, arg5, 0x2::tx_context::sender(arg8), reserve_sale());
    }

    entry fun reserve_random_into<T0>(arg0: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::CreatorCap<T0>, arg1: &mut 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::Collection<T0>, arg2: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::Config, arg3: &0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: u64, arg7: &0x2::random::Random, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg7, arg9);
        let v1 = &mut v0;
        random_reserve_into<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v1, arg8, arg9);
    }

    fun reserve_sale() : Sale {
        Sale{
            phase : 0x1::option::none<u64>(),
            price : 0,
            coin  : 0x1::option::none<0x1::type_name::TypeName>(),
        }
    }

    fun to_fresh<T0>(arg0: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::Collection<T0>, arg1: &0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>, arg2: vector<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>, arg3: address, arg4: Sale, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1) = 0x2::kiosk::new(arg5);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        to_kiosk<T0>(arg0, arg1, arg2, v4, &v2, arg3, arg4);
        if (needs_personal<T0>(arg1)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::create_for(&mut v3, v2, arg3, arg5);
        } else {
            0x2::kiosk::set_owner_custom(&mut v3, &v2, arg3);
            0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, arg3);
        };
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::object::id<0x2::kiosk::Kiosk>(&v3)
    }

    fun to_kiosk<T0>(arg0: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::Collection<T0>, arg1: &0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>, arg2: vector<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: address, arg6: Sale) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(&arg2)) {
            let v1 = 0x1::vector::pop_back<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(&mut arg2);
            emit_minted<T0>(0x2::object::id<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::Collection<T0>>(arg0), &v1, arg5, 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::kiosk::Kiosk>(arg3)), arg6);
            if (needs_lock<T0>(arg1)) {
                0x2::kiosk::lock<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(arg3, arg4, arg1, v1);
            } else {
                0x2::kiosk::place<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(arg3, arg4, v1);
            };
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(arg2);
    }

    fun to_wallet<T0>(arg0: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::Collection<T0>, arg1: &0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>, arg2: vector<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>, arg3: address, arg4: Sale) {
        assert!(!needs_lock<T0>(arg1), 250);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(&arg2)) {
            let v1 = 0x1::vector::pop_back<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(&mut arg2);
            emit_minted<T0>(0x2::object::id<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection::Collection<T0>>(arg0), &v1, arg3, 0x1::option::none<0x2::object::ID>(), arg4);
            0x2::transfer::public_transfer<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(v1, arg3);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(arg2);
    }

    // decompiled from Move bytecode v7
}

