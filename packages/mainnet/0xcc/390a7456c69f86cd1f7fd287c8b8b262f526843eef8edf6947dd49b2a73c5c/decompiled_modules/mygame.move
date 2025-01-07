module 0xcc390a7456c69f86cd1f7fd287c8b8b262f526843eef8edf6947dd49b2a73c5c::mygame {
    struct Mora has drop {
        num: u8,
        symbol: 0x1::string::String,
    }

    struct MYGAME has drop {
        dummy_field: bool,
    }

    struct GamePool has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<MYGAME>,
    }

    public entry fun battle(arg0: &mut GamePool, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"");
        let v1 = arg1 % 3;
        if (v1 == 0) {
            v0 = 0x1::string::utf8(b"Rock");
        } else if (v1 == 1) {
            v0 = 0x1::string::utf8(b"Scissors");
        } else if (v1 == 2) {
            v0 = 0x1::string::utf8(b"Paper");
        };
        let v2 = Mora{
            num    : v1,
            symbol : v0,
        };
        let v3 = 0x1::string::utf8(b"");
        let v4 = 0x2::bcs::new(*0x2::tx_context::digest(arg2));
        let v5 = ((0x2::bcs::peel_u64(&mut v4) % 3) as u8);
        if (v5 == 0) {
            v3 = 0x1::string::utf8(b"Rock");
        } else if (v5 == 1) {
            v3 = 0x1::string::utf8(b"Scissors");
        } else if (v5 == 2) {
            v3 = 0x1::string::utf8(b"Paper");
        };
        let v6 = Mora{
            num    : v5,
            symbol : v3,
        };
        if ((v6.num - v2.num) % 3 == 1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<MYGAME>>(0x2::coin::from_balance<MYGAME>(0x2::balance::split<MYGAME>(&mut arg0.balance, 1000000), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    fun init(arg0: MYGAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYGAME>(arg0, 6, b"LingLingcc", b"LingLingcc Coin", b"Game award coin", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYGAME>>(v1);
        let v3 = GamePool{
            id      : 0x2::object::new(arg1),
            balance : 0x2::coin::mint_balance<MYGAME>(&mut v2, 10000000),
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYGAME>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<GamePool>(v3);
    }

    // decompiled from Move bytecode v6
}

