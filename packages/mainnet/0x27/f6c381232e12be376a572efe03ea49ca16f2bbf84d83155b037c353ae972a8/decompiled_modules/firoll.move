module 0x27f6c381232e12be376a572efe03ea49ca16f2bbf84d83155b037c353ae972a8::firoll {
    struct Registry has key {
        id: 0x2::object::UID,
        metadata: 0x2::coin::CoinMetadata<FIROLL>,
    }

    struct FIROLL has drop {
        dummy_field: bool,
    }

    struct Firoll has store {
        start_date: u64,
        final_date: u64,
        original_balance: u64,
        balance: 0x2::balance::Balance<FIROLL>,
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<FIROLL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1 * 40 / 100;
        let v1 = arg1 - v0;
        let v2 = v1 * 30 / 100;
        assert!(v0 + v2 <= arg1, 0);
        0x2::coin::mint_and_transfer<FIROLL>(arg0, v1 - v2, arg2, arg3);
    }

    fun init(arg0: FIROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIROLL>(arg0, 9, b"FRO", b"FIROLL", b"FiRoll Coin its a betting gaming protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://api.movepump.com/uploads/logo_cozcat_9c068db346.gif"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIROLL>>(v1);
        0x2::coin::mint_and_transfer<FIROLL>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIROLL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

