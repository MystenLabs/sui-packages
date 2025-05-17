module 0x94d6de7da2047f32de1a0fdc22074fe5258b0fd355a84a57bc40feffbf9ee8cf::integration_nft {
    struct NFTRaffleCreated has copy, drop {
        raffle_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        creator: address,
        ticket_price: u64,
        max_tickets: u64,
        end_time: u64,
    }

    public entry fun buy_raffle_tickets(arg0: &mut 0x94d6de7da2047f32de1a0fdc22074fe5258b0fd355a84a57bc40feffbf9ee8cf::raffle::Raffle, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x94d6de7da2047f32de1a0fdc22074fe5258b0fd355a84a57bc40feffbf9ee8cf::raffle::buy_ticket(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun create_nft_raffle<T0: store + key>(arg0: &mut 0x94d6de7da2047f32de1a0fdc22074fe5258b0fd355a84a57bc40feffbf9ee8cf::raffle::RaffleManager, arg1: T0, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<T0>(&arg1);
        0x2::transfer::public_transfer<T0>(arg1, 0x2::tx_context::sender(arg9));
        0x94d6de7da2047f32de1a0fdc22074fe5258b0fd355a84a57bc40feffbf9ee8cf::raffle::create_raffle(arg0, arg2, arg3, arg4, arg5, arg6, arg7, 0x2::bcs::to_bytes<T0>(&arg1), arg8, arg9);
        let v1 = NFTRaffleCreated{
            raffle_id    : v0,
            nft_id       : v0,
            creator      : 0x2::tx_context::sender(arg9),
            ticket_price : arg5,
            max_tickets  : arg6,
            end_time     : 0x2::clock::timestamp_ms(arg8) + arg7,
        };
        0x2::event::emit<NFTRaffleCreated>(v1);
    }

    // decompiled from Move bytecode v6
}

