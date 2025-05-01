module 0xf2fd87ff99ccf8a29f4563d4ef9508ae1ddef2710518c13c4d575b6cd46431b7::confess {
    struct CONFESS has drop {
        dummy_field: bool,
    }

    struct TokenMinted has copy, drop {
        number: u64,
        price: u64,
        minter: address,
    }

    struct SupplyCheck has copy, drop {
        total_supply: u64,
        amount: u64,
        max_supply: u64,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CONFESS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::total_supply<CONFESS>(arg0);
        let v1 = arg1 * 1000000000;
        let v2 = SupplyCheck{
            total_supply : v0,
            amount       : v1,
            max_supply   : 10000000000000000000,
        };
        0x2::event::emit<SupplyCheck>(v2);
        assert!(v0 + v1 <= 10000000000000000000, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<CONFESS>>(0x2::coin::mint<CONFESS>(arg0, v1, arg3), arg2);
    }

    fun init(arg0: CONFESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONFESS>(arg0, 9, b"BURDEN", b"Burden", b"A good coin for bad people.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://confess.market/coin-icon.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CONFESS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<CONFESS>>(0x2::coin::mint<CONFESS>(&mut v2, 4000000000000000000, arg1), @0x63180848bfc1156b113880f0d3ee3feb9e2b137b1ef0c80670f850f70c4783ad);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CONFESS>>(v2, @0x9b64873f7e7b85b39886ed190040c31b345c9af4eb3ec95cb165222045815943);
        let v3 = TokenMinted{
            number : 4000000000000000000,
            price  : 0,
            minter : @0x63180848bfc1156b113880f0d3ee3feb9e2b137b1ef0c80670f850f70c4783ad,
        };
        0x2::event::emit<TokenMinted>(v3);
    }

    // decompiled from Move bytecode v6
}

