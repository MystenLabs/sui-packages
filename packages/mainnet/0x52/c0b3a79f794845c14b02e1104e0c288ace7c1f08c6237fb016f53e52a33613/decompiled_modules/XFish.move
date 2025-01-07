module 0x52c0b3a79f794845c14b02e1104e0c288ace7c1f08c6237fb016f53e52a33613::XFish {
    struct Registry has key {
        id: 0x2::object::UID,
        metadata: 0x2::coin::CoinMetadata<XFISH>,
    }

    struct XFISH has drop {
        minting_disabled: bool,
    }

    struct XFish has store {
        start_date: u64,
        final_date: u64,
        original_balance: u64,
        balance: 0x2::balance::Balance<XFISH>,
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<XFISH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1 * 5 / 100;
        let v1 = arg1 - v0;
        let v2 = v1 * 30 / 100;
        let v3 = v1 - v2;
        let v4 = v3 * 60 / 100;
        assert!(v0 + v2 + v4 <= arg1, 0);
        let v5 = 0x2::tx_context::sender(arg3);
        0x2::coin::mint_and_transfer<XFISH>(arg0, v2, v5, arg3);
        0x2::coin::mint_and_transfer<XFISH>(arg0, v4, v5, arg3);
        0x2::coin::mint_and_transfer<XFISH>(arg0, v3 - v4, arg2, arg3);
    }

    fun init(arg0: XFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XFISH>(arg0, 9, b"XFISH", b"XFISH", b"XFish is in the game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://api.movepump.com/uploads/logo_cozcat_9c068db346.gif"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XFISH>>(v1);
        0x2::coin::mint_and_transfer<XFISH>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XFISH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

