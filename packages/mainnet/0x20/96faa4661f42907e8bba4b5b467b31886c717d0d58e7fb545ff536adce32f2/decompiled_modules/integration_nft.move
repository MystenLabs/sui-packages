module 0x2096faa4661f42907e8bba4b5b467b31886c717d0d58e7fb545ff536adce32f2::integration_nft {
    struct NFTHolder<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        nft_type: vector<u8>,
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
        raffle_id: 0x2::object::ID,
        locker: address,
    }

    struct NFTClaimed has copy, drop {
        nft_id: 0x2::object::ID,
        raffle_id: 0x2::object::ID,
        claimer: address,
    }

    public entry fun buy_raffle_tickets(arg0: &mut 0x2096faa4661f42907e8bba4b5b467b31886c717d0d58e7fb545ff536adce32f2::raffle::Raffle, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun claim_nft<T0: store + key>(arg0: &mut 0x2096faa4661f42907e8bba4b5b467b31886c717d0d58e7fb545ff536adce32f2::raffle::Raffle, arg1: &mut NFTHolder<T0>, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1.nft_held, 1);
        let v1 = 0x2::dynamic_field::remove<vector<u8>, T0>(&mut arg1.id, b"nft_lock");
        arg1.nft_held = false;
        let v2 = NFTClaimed{
            nft_id    : 0x2::object::id<T0>(&v1),
            raffle_id : 0x2::object::id<0x2096faa4661f42907e8bba4b5b467b31886c717d0d58e7fb545ff536adce32f2::raffle::Raffle>(arg0),
            claimer   : v0,
        };
        0x2::event::emit<NFTClaimed>(v2);
        0x2::transfer::public_transfer<T0>(v1, v0);
    }

    public entry fun create_nft_raffle<T0: store + key>(arg0: &mut 0x2096faa4661f42907e8bba4b5b467b31886c717d0d58e7fb545ff536adce32f2::raffle::RaffleManager, arg1: T0, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<T0>(&arg1);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v2 = 0x2::bcs::to_bytes<0x1::ascii::String>(&v1);
        let v3 = NFTHolder<T0>{
            id       : 0x2::object::new(arg9),
            nft_type : v2,
            nft_held : true,
        };
        0x2::dynamic_field::add<vector<u8>, T0>(&mut v3.id, b"nft_lock", arg1);
        let v4 = 0x2096faa4661f42907e8bba4b5b467b31886c717d0d58e7fb545ff536adce32f2::raffle::create_raffle(arg0, arg2, arg3, arg4, arg5, arg6, arg7, v2, arg8, arg9);
        let v5 = NFTRaffleCreated{
            raffle_id    : v4,
            nft_id       : v0,
            nft_type     : v2,
            creator      : 0x2::tx_context::sender(arg9),
            ticket_price : arg5,
            max_tickets  : arg6,
            end_time     : 0x2::clock::timestamp_ms(arg8) + arg7,
        };
        0x2::event::emit<NFTRaffleCreated>(v5);
        let v6 = NFTLocked{
            nft_id    : v0,
            raffle_id : v4,
            locker    : 0x2::tx_context::sender(arg9),
        };
        0x2::event::emit<NFTLocked>(v6);
        0x2::transfer::share_object<NFTHolder<T0>>(v3);
    }

    // decompiled from Move bytecode v6
}

