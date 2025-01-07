module 0x544e1da73e8cfdc732786f3a403f7e8052d242996de14b53c6a0845bd6cf3b7e::jeasonnow_game {
    struct JEASONNOW_GAME has drop {
        dummy_field: bool,
    }

    struct BONUS_POOL has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<JEASONNOW_GAME>,
    }

    struct GamingResultEvent has copy, drop {
        is_win: bool,
        your_choice: u64,
        banker_choice: u64,
        result: 0x1::string::String,
    }

    fun init(arg0: JEASONNOW_GAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEASONNOW_GAME>(arg0, 8, b"JGC", b"JeasonnowGameCoin", b"Jeasonnow Game Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = BONUS_POOL{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<JEASONNOW_GAME>(),
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JEASONNOW_GAME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEASONNOW_GAME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<BONUS_POOL>(v2);
    }

    public entry fun play(arg0: u64, arg1: &mut BONUS_POOL, arg2: &mut 0x2::coin::TreasuryCap<JEASONNOW_GAME>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x544e1da73e8cfdc732786f3a403f7e8052d242996de14b53c6a0845bd6cf3b7e::utils::rand_u64_range(1, 10, arg3);
        let (v1, v2) = if (v0 == arg0) {
            (b"Win", true)
        } else {
            (b"Lose", true)
        };
        let v3 = GamingResultEvent{
            is_win        : v2,
            your_choice   : arg0,
            banker_choice : v0,
            result        : 0x1::string::utf8(v1),
        };
        0x2::event::emit<GamingResultEvent>(v3);
        if (v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<JEASONNOW_GAME>>(0x2::coin::from_balance<JEASONNOW_GAME>(0x2::balance::withdraw_all<JEASONNOW_GAME>(&mut arg1.balance), arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::join<JEASONNOW_GAME>(&mut arg1.balance, 0x2::coin::into_balance<JEASONNOW_GAME>(0x2::coin::mint<JEASONNOW_GAME>(arg2, 1, arg3)));
        };
    }

    // decompiled from Move bytecode v6
}

