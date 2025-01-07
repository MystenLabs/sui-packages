module 0xf4ac8ea2c9d8ab58e47cd70e1f1ef095de5a61444ef676c0627055afe48b5262::raffle {
    struct CoinRaffleCreated has copy, drop {
        raffle_id: 0x2::object::ID,
        raffle_name: 0x1::string::String,
        creator: address,
        round: u64,
        participants_count: u64,
        winnerCount: u64,
        prizeAmount: u64,
        prizeType: 0x1::ascii::String,
    }

    struct CoinRaffleSettled has copy, drop {
        raffle_id: 0x2::object::ID,
        settler: address,
    }

    struct Raffle<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        round: u64,
        status: u8,
        creator: address,
        settler: address,
        participants: vector<address>,
        winnerCount: u64,
        winners: vector<address>,
        balance: 0x2::balance::Balance<T0>,
    }

    public entry fun create_coin_raffle<T0>(arg0: vector<u8>, arg1: u64, arg2: vector<address>, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 <= 0x1::vector::length<address>(&arg2), 0);
        let v0 = Raffle<T0>{
            id           : 0x2::object::new(arg5),
            name         : 0x1::string::utf8(arg0),
            round        : arg1,
            status       : 0,
            creator      : 0x2::tx_context::sender(arg5),
            settler      : @0x0,
            participants : arg2,
            winnerCount  : arg3,
            winners      : 0x1::vector::empty<address>(),
            balance      : 0x2::coin::into_balance<T0>(arg4),
        };
        emit_coin_raffle_created<T0>(&v0);
        0x2::transfer::public_share_object<Raffle<T0>>(v0);
    }

    public fun emit_coin_raffle_created<T0>(arg0: &Raffle<T0>) {
        let v0 = CoinRaffleCreated{
            raffle_id          : *0x2::object::borrow_id<Raffle<T0>>(arg0),
            raffle_name        : arg0.name,
            creator            : arg0.creator,
            round              : arg0.round,
            participants_count : 0x1::vector::length<address>(&arg0.participants),
            winnerCount        : arg0.winnerCount,
            prizeAmount        : 0x2::balance::value<T0>(&arg0.balance),
            prizeType          : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
        };
        0x2::event::emit<CoinRaffleCreated>(v0);
    }

    public fun emit_coin_raffle_settled<T0>(arg0: &Raffle<T0>) {
        let v0 = CoinRaffleSettled{
            raffle_id : *0x2::object::borrow_id<Raffle<T0>>(arg0),
            settler   : arg0.settler,
        };
        0x2::event::emit<CoinRaffleSettled>(v0);
    }

    fun getWinners<T0>(arg0: &Raffle<T0>) : vector<address> {
        arg0.winners
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun settle_coin_raffle<T0>(arg0: &mut Raffle<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status != 1, 0);
        0xf4ac8ea2c9d8ab58e47cd70e1f1ef095de5a61444ef676c0627055afe48b5262::drand_lib::verify_drand_signature(arg1, arg2, arg0.round);
        arg0.status = 1;
        arg0.settler = 0x2::tx_context::sender(arg3);
        let v0 = 0xf4ac8ea2c9d8ab58e47cd70e1f1ef095de5a61444ef676c0627055afe48b5262::drand_lib::derive_randomness(arg1);
        let v1 = 0;
        v1 = v1 + 1;
        let v2 = 0x1::vector::length<address>(&arg0.participants);
        0x1::vector::swap<address>(&mut arg0.participants, 0xf4ac8ea2c9d8ab58e47cd70e1f1ef095de5a61444ef676c0627055afe48b5262::drand_lib::safe_selection(v2, &v0, 0), v2 - 1);
        let v3 = 0x1::vector::pop_back<address>(&mut arg0.participants);
        0x1::vector::push_back<address>(&mut arg0.winners, v3);
        while (v1 < arg0.winnerCount) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, 0x2::balance::value<T0>(&arg0.balance) / arg0.winnerCount, arg3), v3);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, 0x2::balance::value<T0>(&arg0.balance), arg3), v3);
        emit_coin_raffle_settled<T0>(arg0);
    }

    // decompiled from Move bytecode v6
}

