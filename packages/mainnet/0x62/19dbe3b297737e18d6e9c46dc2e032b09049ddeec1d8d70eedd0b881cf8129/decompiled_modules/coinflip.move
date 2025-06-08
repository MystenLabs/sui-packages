module 0x6219dbe3b297737e18d6e9c46dc2e032b09049ddeec1d8d70eedd0b881cf8129::coinflip {
    struct CoinFlipGame<phantom T0> has key {
        id: 0x2::object::UID,
        max_bet: u64,
        threshold: u64,
        bets: 0x2::vec_map::VecMap<0x2::object::ID, Bet<T0>>,
    }

    struct Bet<phantom T0> has store, key {
        id: 0x2::object::UID,
        gambler: address,
        fund: 0x2::balance::Balance<T0>,
    }

    public fun bet<T0>(arg0: &mut CoinFlipGame<T0>, arg1: &mut 0x6219dbe3b297737e18d6e9c46dc2e032b09049ddeec1d8d70eedd0b881cf8129::vault::Vault<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 <= arg0.max_bet, 4);
        0x6219dbe3b297737e18d6e9c46dc2e032b09049ddeec1d8d70eedd0b881cf8129::vault::deposit<T0>(arg1, arg2);
        let v1 = Bet<T0>{
            id      : 0x2::object::new(arg3),
            gambler : 0x2::tx_context::sender(arg3),
            fund    : 0x6219dbe3b297737e18d6e9c46dc2e032b09049ddeec1d8d70eedd0b881cf8129::vault::take_fund_balance<T0>(arg1, v0 * 2),
        };
        0x6219dbe3b297737e18d6e9c46dc2e032b09049ddeec1d8d70eedd0b881cf8129::vault::distribute_referral_rewards<T0>(arg1, v0, 0x2::tx_context::sender(arg3));
        0x6219dbe3b297737e18d6e9c46dc2e032b09049ddeec1d8d70eedd0b881cf8129::events::emit_bet_event(0x2::object::uid_to_inner(&v1.id), v0, 0x2::tx_context::sender(arg3), 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x2::vec_map::insert<0x2::object::ID, Bet<T0>>(&mut arg0.bets, 0x2::object::uid_to_inner(&v1.id), v1);
    }

    public fun create_coinflip_game<T0>(arg0: &0x6219dbe3b297737e18d6e9c46dc2e032b09049ddeec1d8d70eedd0b881cf8129::vault::AdminCap, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinFlipGame<T0>{
            id        : 0x2::object::new(arg3),
            max_bet   : arg1,
            threshold : arg2,
            bets      : 0x2::vec_map::empty<0x2::object::ID, Bet<T0>>(),
        };
        0x2::transfer::share_object<CoinFlipGame<T0>>(v0);
    }

    public fun edit_coinflip_game<T0>(arg0: &0x6219dbe3b297737e18d6e9c46dc2e032b09049ddeec1d8d70eedd0b881cf8129::vault::AdminCap, arg1: &mut CoinFlipGame<T0>, arg2: u64, arg3: u64) {
        arg1.max_bet = arg2;
        arg1.threshold = arg3;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinFlipGame<0x2::sui::SUI>{
            id        : 0x2::object::new(arg0),
            max_bet   : 51000000000,
            threshold : 53000000,
            bets      : 0x2::vec_map::empty<0x2::object::ID, Bet<0x2::sui::SUI>>(),
        };
        0x2::transfer::share_object<CoinFlipGame<0x2::sui::SUI>>(v0);
    }

    entry fun place_bet_and_reveal_onchain_randomness<T0, T1>(arg0: &CoinFlipGame<T1>, arg1: &mut 0x6219dbe3b297737e18d6e9c46dc2e032b09049ddeec1d8d70eedd0b881cf8129::vault::Vault<T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::random::Random, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x2::coin::value<T1>(&arg2);
        0x2::tx_context::sender(arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x6219dbe3b297737e18d6e9c46dc2e032b09049ddeec1d8d70eedd0b881cf8129::cetus::swap_b2a<T0, T1>(arg4, arg5, arg6, arg2, arg7, arg8), 0x2::tx_context::sender(arg8));
    }

    entry fun reveal_bet_onchain_randomness<T0>(arg0: &mut CoinFlipGame<T0>, arg1: &mut 0x6219dbe3b297737e18d6e9c46dc2e032b09049ddeec1d8d70eedd0b881cf8129::vault::Vault<T0>, arg2: 0x2::object::ID, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<0x2::object::ID, Bet<T0>>(&arg0.bets, &arg2), 5);
        let (_, v1) = 0x2::vec_map::remove<0x2::object::ID, Bet<T0>>(&mut arg0.bets, &arg2);
        let Bet {
            id      : v2,
            gambler : v3,
            fund    : v4,
        } = v1;
        let v5 = v4;
        let v6 = 0x2::random::new_generator(arg3, arg4);
        let (v7, v8) = if (0x2::random::generate_u64_in_range(&mut v6, 0, 100000000) > arg0.threshold) {
            (0x2::balance::value<T0>(&v5), true)
        } else {
            (0, false)
        };
        if (v8) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg4), v3);
            0x6219dbe3b297737e18d6e9c46dc2e032b09049ddeec1d8d70eedd0b881cf8129::vault::join_balance<T0>(arg1, 0x2::balance::zero<T0>());
        } else {
            0x6219dbe3b297737e18d6e9c46dc2e032b09049ddeec1d8d70eedd0b881cf8129::vault::join_balance<T0>(arg1, v5);
        };
        0x6219dbe3b297737e18d6e9c46dc2e032b09049ddeec1d8d70eedd0b881cf8129::events::emit_revealed_bet_event(arg2, v8, v7, v3, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x2::object::delete(v2);
    }

    // decompiled from Move bytecode v6
}

