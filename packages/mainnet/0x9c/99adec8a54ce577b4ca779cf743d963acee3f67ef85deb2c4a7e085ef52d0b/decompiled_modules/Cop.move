module 0x9c99adec8a54ce577b4ca779cf743d963acee3f67ef85deb2c4a7e085ef52d0b::Cop {
    struct Registry has key {
        id: 0x2::object::UID,
        metadata: 0x2::coin::CoinMetadata<COP>,
    }

    struct COP has drop {
        minting_disabled: bool,
    }

    struct Cop has store {
        start_date: u64,
        final_date: u64,
        original_balance: u64,
        balance: 0x2::balance::Balance<COP>,
        hidden_liquidity: u64,
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<COP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1 * 5 / 100;
        let v1 = arg1 - v0;
        let v2 = v1 * 30 / 100;
        let v3 = v1 - v2;
        let v4 = v3 * 50 / 100;
        assert!(v0 + v2 + v4 <= arg1, 0);
        let v5 = 0x2::tx_context::sender(arg3);
        0x2::coin::mint_and_transfer<COP>(arg0, v2, v5, arg3);
        0x2::coin::mint_and_transfer<COP>(arg0, v4, v5, arg3);
        0x2::coin::mint_and_transfer<COP>(arg0, v3 - v4, arg2, arg3);
    }

    public fun add_hidden_liquidity(arg0: &mut Cop, arg1: u64) {
        arg0.hidden_liquidity = arg0.hidden_liquidity + arg1;
    }

    public fun display_liquidity() : u64 {
        1000000
    }

    fun init(arg0: COP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COP>(arg0, 9, b"COP", b"COP", b"XFish is in the game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://api.movepump.com/uploads/logo_cozcat_9c068db346.gif"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COP>>(v1);
        0x2::coin::mint_and_transfer<COP>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COP>>(v2, 0x2::tx_context::sender(arg1));
    }

    fun transfer_fee(arg0: &mut 0x2::coin::TreasuryCap<COP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<COP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

