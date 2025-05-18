module 0x220420718d6549acabc07fd536748823c1c91677fbc3ed440b681d74039061c::integration_nft {
    struct NFTLockKey has copy, drop, store {
        raffle_id: 0x2::object::ID,
    }

    struct NFTHolder<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        nft_type: vector<u8>,
        nft_id: 0x2::object::ID,
        raffle_id: 0x2::object::ID,
        nft_held: bool,
    }

    struct NFTRaffleCreated has copy, drop {
        raffle_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        nft_type: vector<u8>,
        creator: address,
        ticket_price: u64,
        max_tickets: u64,
        end_time: u64,
    }

    struct NFTLocked has copy, drop {
        nft_id: 0x2::object::ID,
        holder_id: 0x2::object::ID,
        raffle_id: 0x2::object::ID,
        locker: address,
    }

    struct NFTClaimed has copy, drop {
        nft_id: 0x2::object::ID,
        raffle_id: 0x2::object::ID,
        claimer: address,
    }

    public entry fun buy_raffle_tickets(arg0: &0x220420718d6549acabc07fd536748823c1c91677fbc3ed440b681d74039061c::raffle::RaffleManager, arg1: &mut 0x220420718d6549acabc07fd536748823c1c91677fbc3ed440b681d74039061c::raffle::Raffle, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x220420718d6549acabc07fd536748823c1c91677fbc3ed440b681d74039061c::raffle::buy_ticket(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun claim_nft<T0: store + key>(arg0: &0x220420718d6549acabc07fd536748823c1c91677fbc3ed440b681d74039061c::raffle::RaffleManager, arg1: &mut 0x220420718d6549acabc07fd536748823c1c91677fbc3ed440b681d74039061c::raffle::Raffle, arg2: &mut NFTHolder<T0>, arg3: 0x220420718d6549acabc07fd536748823c1c91677fbc3ed440b681d74039061c::raffle::WinnerCertificate, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.raffle_id == 0x2::object::id<0x220420718d6549acabc07fd536748823c1c91677fbc3ed440b681d74039061c::raffle::Raffle>(arg1), 2);
        assert!(arg2.nft_held, 1);
        let v0 = 0x2::tx_context::sender(arg4);
        0x220420718d6549acabc07fd536748823c1c91677fbc3ed440b681d74039061c::raffle::claim_prize(arg0, arg1, arg3, arg4);
        let v1 = NFTLockKey{raffle_id: arg2.raffle_id};
        arg2.nft_held = false;
        let v2 = NFTClaimed{
            nft_id    : arg2.nft_id,
            raffle_id : arg2.raffle_id,
            claimer   : v0,
        };
        0x2::event::emit<NFTClaimed>(v2);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<NFTLockKey, T0>(&mut arg2.id, v1), v0);
    }

    public entry fun claim_ticket_refund(arg0: &mut 0x220420718d6549acabc07fd536748823c1c91677fbc3ed440b681d74039061c::raffle::Raffle, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0x220420718d6549acabc07fd536748823c1c91677fbc3ed440b681d74039061c::raffle::claim_refund(arg0, arg1, arg2);
    }

    public entry fun create_nft_raffle<T0: store + key>(arg0: &mut 0x220420718d6549acabc07fd536748823c1c91677fbc3ed440b681d74039061c::raffle::RaffleManager, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: T0, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        create_nft_raffle_with_bytes<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun create_nft_raffle_with_bytes<T0: store + key>(arg0: &mut 0x220420718d6549acabc07fd536748823c1c91677fbc3ed440b681d74039061c::raffle::RaffleManager, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: T0, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::id<T0>(&arg2);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v2 = 0x2::bcs::to_bytes<0x1::ascii::String>(&v1);
        let v3 = 0x220420718d6549acabc07fd536748823c1c91677fbc3ed440b681d74039061c::raffle::create_raffle(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v2, arg10, arg11);
        let v4 = NFTHolder<T0>{
            id        : 0x2::object::new(arg11),
            nft_type  : v2,
            nft_id    : v0,
            raffle_id : v3,
            nft_held  : true,
        };
        let v5 = NFTLockKey{raffle_id: v3};
        0x2::dynamic_field::add<NFTLockKey, T0>(&mut v4.id, v5, arg2);
        let v6 = NFTRaffleCreated{
            raffle_id    : v3,
            nft_id       : v0,
            nft_type     : v2,
            creator      : 0x2::tx_context::sender(arg11),
            ticket_price : arg6,
            max_tickets  : arg7,
            end_time     : 0x2::clock::timestamp_ms(arg10) + arg9,
        };
        0x2::event::emit<NFTRaffleCreated>(v6);
        let v7 = NFTLocked{
            nft_id    : v0,
            holder_id : 0x2::object::id<NFTHolder<T0>>(&v4),
            raffle_id : v3,
            locker    : 0x2::tx_context::sender(arg11),
        };
        0x2::event::emit<NFTLocked>(v7);
        0x2::transfer::share_object<NFTHolder<T0>>(v4);
        v3
    }

    public fun get_holder_info<T0: store + key>(arg0: &NFTHolder<T0>) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID, bool) {
        (0x2::object::id<NFTHolder<T0>>(arg0), arg0.nft_id, arg0.raffle_id, arg0.nft_held)
    }

    public fun has_nft<T0: store + key>(arg0: &NFTHolder<T0>) : bool {
        arg0.nft_held
    }

    public entry fun reclaim_nft<T0: store + key>(arg0: &mut 0x220420718d6549acabc07fd536748823c1c91677fbc3ed440b681d74039061c::raffle::RaffleManager, arg1: &mut 0x220420718d6549acabc07fd536748823c1c91677fbc3ed440b681d74039061c::raffle::Raffle, arg2: &mut NFTHolder<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _, _, _, _, _, _, v8, v9, _) = 0x220420718d6549acabc07fd536748823c1c91677fbc3ed440b681d74039061c::raffle::get_raffle_info(arg1);
        assert!(0x2::clock::timestamp_ms(arg3) >= v8, 0);
        assert!(v9, 0);
        assert!(v1 == 0x2::tx_context::sender(arg4), 0);
        assert!(arg2.raffle_id == v0, 2);
        assert!(arg2.nft_held, 1);
        assert!(!0x220420718d6549acabc07fd536748823c1c91677fbc3ed440b681d74039061c::raffle::has_met_min_tickets(arg1), 0);
        let v11 = NFTLockKey{raffle_id: arg2.raffle_id};
        arg2.nft_held = false;
        0x220420718d6549acabc07fd536748823c1c91677fbc3ed440b681d74039061c::raffle::cancel_raffle(arg0, arg1, arg4);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<NFTLockKey, T0>(&mut arg2.id, v11), v1);
    }

    // decompiled from Move bytecode v6
}

