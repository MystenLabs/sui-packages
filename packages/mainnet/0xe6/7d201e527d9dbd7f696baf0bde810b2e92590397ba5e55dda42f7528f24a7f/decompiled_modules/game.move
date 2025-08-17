module 0xe67d201e527d9dbd7f696baf0bde810b2e92590397ba5e55dda42f7528f24a7f::game {
    struct Game<phantom T0> has store, key {
        id: 0x2::object::UID,
        github_id: vector<u8>,
        min: u8,
        max: u8,
        payout_multiplier: u64,
        pot: 0x2::coin::Coin<T0>,
    }

    struct GameEvent has copy, drop {
        input_pick: u8,
        game_number: u64,
        won: bool,
        message: 0x1::string::String,
    }

    public entry fun create<T0: store>(arg0: vector<u8>, arg1: u8, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Game<T0>{
            id                : 0x2::object::new(arg4),
            github_id         : arg0,
            min               : arg1,
            max               : arg2,
            payout_multiplier : arg3,
            pot               : 0x2::coin::zero<T0>(arg4),
        };
        0x2::transfer::public_share_object<Game<T0>>(v0);
    }

    public entry fun deposit<T0: store>(arg0: &mut Game<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::join<T0>(&mut arg0.pot, arg1);
    }

    public entry fun play<T0: store>(arg0: &mut Game<T0>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<T0>(&mut arg0.pot, arg2);
        let v0 = (arg0.min as u64);
        let v1 = (arg0.max as u64);
        let v2 = (arg3 as u64);
        assert!(v2 >= v0 && v2 <= v1, 1);
        let v3 = 0x2::clock::timestamp_ms(arg1) % (v1 - v0 + 1) + v0;
        let v4 = v2 == v3;
        if (v4) {
            let v5 = 0x2::coin::value<T0>(&arg0.pot);
            let v6 = v5 / 10 * arg0.payout_multiplier;
            let v7 = if (v6 > v5) {
                v5
            } else {
                v6
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.pot, v7, arg4), 0x2::tx_context::sender(arg4));
            let v8 = GameEvent{
                input_pick  : arg3,
                game_number : v3,
                won         : v4,
                message     : 0x1::string::utf8(b"Good! You win!"),
            };
            0x2::event::emit<GameEvent>(v8);
            return
        };
        let v9 = GameEvent{
            input_pick  : arg3,
            game_number : v3,
            won         : v4,
            message     : 0x1::string::utf8(b"Emm, you lose..."),
        };
        0x2::event::emit<GameEvent>(v9);
    }

    public entry fun withdraw<T0: store>(arg0: &mut Game<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.pot, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

