module 0x2719d6955e893427bae11cd2c0af5874d237c1545377c3be224227d4c5ec293a::integration_nft {
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

    public entry fun buy_raffle_tickets(arg0: &0x2719d6955e893427bae11cd2c0af5874d237c1545377c3be224227d4c5ec293a::raffle::RaffleManager, arg1: &mut 0x2719d6955e893427bae11cd2c0af5874d237c1545377c3be224227d4c5ec293a::raffle::Raffle, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x2719d6955e893427bae11cd2c0af5874d237c1545377c3be224227d4c5ec293a::raffle::buy_ticket(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun claim_nft<T0: store + key>(arg0: &mut 0x2719d6955e893427bae11cd2c0af5874d237c1545377c3be224227d4c5ec293a::raffle::Raffle, arg1: &mut NFTHolder<T0>, arg2: 0x2719d6955e893427bae11cd2c0af5874d237c1545377c3be224227d4c5ec293a::raffle::WinnerCertificate, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.raffle_id == 0x2::object::id<0x2719d6955e893427bae11cd2c0af5874d237c1545377c3be224227d4c5ec293a::raffle::Raffle>(arg0), 2);
        assert!(arg1.nft_held, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        0x2719d6955e893427bae11cd2c0af5874d237c1545377c3be224227d4c5ec293a::raffle::claim_prize(arg0, arg2, arg3);
        let v1 = NFTLockKey{raffle_id: arg1.raffle_id};
        arg1.nft_held = false;
        let v2 = NFTClaimed{
            nft_id    : arg1.nft_id,
            raffle_id : arg1.raffle_id,
            claimer   : v0,
        };
        0x2::event::emit<NFTClaimed>(v2);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<NFTLockKey, T0>(&mut arg1.id, v1), v0);
    }

    public entry fun create_nft_raffle<T0: store + key>(arg0: &mut 0x2719d6955e893427bae11cd2c0af5874d237c1545377c3be224227d4c5ec293a::raffle::RaffleManager, arg1: T0, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        create_nft_raffle_with_bytes<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun create_nft_raffle_with_bytes<T0: store + key>(arg0: &mut 0x2719d6955e893427bae11cd2c0af5874d237c1545377c3be224227d4c5ec293a::raffle::RaffleManager, arg1: T0, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::id<T0>(&arg1);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v2 = 0x2::bcs::to_bytes<0x1::ascii::String>(&v1);
        let v3 = 0x2719d6955e893427bae11cd2c0af5874d237c1545377c3be224227d4c5ec293a::raffle::create_raffle(arg0, arg2, arg3, arg4, arg5, arg6, arg7, v2, arg8, arg9);
        let v4 = NFTHolder<T0>{
            id        : 0x2::object::new(arg9),
            nft_type  : v2,
            nft_id    : v0,
            raffle_id : v3,
            nft_held  : true,
        };
        let v5 = NFTLockKey{raffle_id: v3};
        0x2::dynamic_field::add<NFTLockKey, T0>(&mut v4.id, v5, arg1);
        let v6 = NFTRaffleCreated{
            raffle_id    : v3,
            nft_id       : v0,
            nft_type     : v2,
            creator      : 0x2::tx_context::sender(arg9),
            ticket_price : arg5,
            max_tickets  : arg6,
            end_time     : 0x2::clock::timestamp_ms(arg8) + arg7,
        };
        0x2::event::emit<NFTRaffleCreated>(v6);
        let v7 = NFTLocked{
            nft_id    : v0,
            holder_id : 0x2::object::id<NFTHolder<T0>>(&v4),
            raffle_id : v3,
            locker    : 0x2::tx_context::sender(arg9),
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

    // decompiled from Move bytecode v6
}

